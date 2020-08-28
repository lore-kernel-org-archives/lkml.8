Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1585C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85988206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgH1Pzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1Pzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:55:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C67C06121B;
        Fri, 28 Aug 2020 08:55:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBgix-006DmM-Ca; Fri, 28 Aug 2020 15:55:31 +0000
Date:   Fri, 28 Aug 2020 16:55:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com
Subject: Re: [PATCH v3 04/10] fs/ntfs3: Add file operations and implementation
Message-ID: <20200828155531.GK1236603@ZenIV.linux.org.uk>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:39:32AM -0700, Konstantin Komarov wrote:

> +static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
> +			    struct file *file, u32 flags, umode_t mode)
> +{
> +	int err;
> +	bool excl = !!(flags & O_EXCL);
> +	struct inode *inode;
> +	struct ntfs_fnd *fnd = NULL;
> +	struct ntfs_inode *ni = ntfs_i(dir);
> +
> +	ni_lock(ni);
> +
> +	if (d_in_lookup(dentry)) {
> +		struct dentry *d;
> +
> +		fnd = fnd_get(&ntfs_i(dir)->dir);
> +		if (!fnd) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +
> +		d = __ntfs_lookup(dir, dentry, fnd);
> +		if (IS_ERR(d)) {
> +			err = PTR_ERR(d);
> +			d = NULL;
> +			goto out1;
> +		}
> +
> +		if (d)
> +			dentry = d;
> +
> +		if (d_really_is_positive(dentry)) {
> +			if (file->f_mode & FMODE_OPENED) {

	How do we get FMODE_OPENED here?

> +				dput(d);
> +				err = 0;
> +			} else
> +				err = finish_no_open(file, d);
> +			goto out1;
> +		}
> +		WARN_ON(d);
> +	}
> +
> +	if (!(flags & O_CREAT)) {
> +		err = -ENOENT;
> +		goto out1;
> +	}

	Just return finish_no_open() in that case.  And let the caller handle
that.

> +	err = ntfs_create_inode(dir, dentry, file, mode, 0, NULL, 0, excl, fnd,
> +				&inode);
> +
> +out1:
> +	fnd_put(fnd);
> +out:
> +	ni_unlock(ni);
> +
> +	return err;
> +}

BTW, what's the point of that ni_lock() here?  d_in_lookup() is stable
regardless of that and any attempts to create something in the parent
are serialized by ->i_rwsem.  If you want it around the actual file
creation, why not take it just there, and replace the open-coded
ntfs_lookup() with the call of the real thing?  As in
	if (d_in_lookup(dentry)) {
		d = ntfs_lookup(....);
		if (IS_ERR(d))
			return d;
		if (d)
			dentry = d;
	}
        if (!(flags & O_CREAT) || d_really_is_positive(dentry))
		return finish_no_open(file, d);
	/* deal with creation of file */
	ni_lock(...);
	....
