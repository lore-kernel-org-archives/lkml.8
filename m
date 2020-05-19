Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5875C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CB820758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r3DKwbpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgESSqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESSqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:46:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9908C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TfqaqqY6RfR3+DZfCY7Gxv00z/xXVrR5qOfi/Vh95qU=; b=r3DKwbpaQwnjfQhWDApMKJ7zGt
        SA+i7OcPGQV30E+o+F/T750UNlEqYtmxTmwUKsYvoS7fo4xwD6gRgXHGRdQuGyFYgcxajcuYB7uA1
        fJJXeX7RF9mfjvSLkbxMevTeV84sJRPWBuvdqwqGmOVPu9g/+aFFi0K10sy+nd2/0ZgZxOu+kBDZl
        xeByOPe8bOBhBZf7FCBkNJVH7Cd+r0I834GPLh5BP+NfAgFQT4zSSvlU3S3WuBB7PL+SeMIGOQWZO
        TE3A5TPXhg9NtpzqVWglD5eRKy9qMTocOuFedoqF8Io2HkXO/UDUw7b902wE0xUjh94BI2G2lbCLA
        yk/dDfaA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb7G6-0004Rz-7u; Tue, 19 May 2020 18:46:34 +0000
Date:   Tue, 19 May 2020 11:46:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20200519184634.GZ16070@bombadil.infradead.org>
References: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:03:06AM -0700, Dan Williams wrote:
> +void revoke_devmem(struct resource *res)
> +{
> +	struct inode *inode = READ_ONCE(devmem_inode);
> +
> +	/*
> +	 * Check that the initialization has completed. Losing the race
> +	 * is ok because it means drivers are claiming resources before
> +	 * the fs_initcall level of init and prevent /dev/mem from
> +	 * establishing mappings.
> +	 */
> +	smp_rmb();
> +	if (!inode)
> +		return;

Which wmb() is this pairing with?

> +static int devmem_init_inode(void)
> +{
> +	static struct vfsmount *devmem_vfs_mount;
> +	static int devmem_fs_cnt;
> +	struct inode *inode;
> +	int rc;
> +
> +	rc = simple_pin_fs(&devmem_fs_type, &devmem_vfs_mount, &devmem_fs_cnt);
> +	if (rc < 0) {
> +		pr_err("Cannot mount /dev/mem pseudo filesystem: %d\n", rc);
> +		return rc;
> +	}
> +
> +	inode = alloc_anon_inode(devmem_vfs_mount->mnt_sb);
> +	if (IS_ERR(inode)) {
> +		rc = PTR_ERR(inode);
> +		pr_err("Cannot allocate inode for /dev/mem: %d\n", rc);
> +		simple_release_fs(&devmem_vfs_mount, &devmem_fs_cnt);
> +		return rc;
> +	}
> +
> +	/* publish /dev/mem initialized */
> +	WRITE_ONCE(devmem_inode, inode);
> +	smp_wmb();
> +
> +	return 0;

... is that this one?  I don't see what it's guarding against.  Surely if
it's needed to ensure that the writes to 'inode' have happened before
the write of the inode pointer, the smp_wmb() needs to be before the
WRITE_ONCE, not after it?
