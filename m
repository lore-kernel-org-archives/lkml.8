Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0320E20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589458213;
	bh=zZrhSfAlm531Od9eVUfmWK9vqXkQ/owf9bFjsI4khKU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=oSvwrEQ9Ii0iqovrVWdeeAsvlJMpjGkzzQZFhMLYLNdMQGFRFYZflGVV385ILgSUz
	 MRqWnYRV3BpCs6WiYkNcgxIefuM3QSshmv1xMxFRZIyRR2Cm5v1HQ82aBtW3VITOQ6
	 yUD1ng1h2gI6lhWXFvRfQzXzuceQ2NGlCnoRRl+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgENMKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENMKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:10:11 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB47820722;
        Thu, 14 May 2020 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589458211;
        bh=zZrhSfAlm531Od9eVUfmWK9vqXkQ/owf9bFjsI4khKU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nCHZRiItMFV2iDKspkwdGnR6DplR3qfevR652dKDTZi0Lw2wBsMu9OV6UL6Y0bmzX
         pUeDO78bLa4A9MAOv6IifvLDUdNDIQNk3zSejsSoeR/M7hFOUQ0kyXKyoCkgUqPTMR
         5Uer5t6IeQLOCO0sgyz1JzhxL6SzWFMz31K+oLIg=
Message-ID: <8497fe9a11ac1837813ee5f14b6ebae8fa6bf707.camel@kernel.org>
Subject: Re: [PATCH] ceph: don't return -ESTALE if there's still an open file
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 May 2020 08:10:09 -0400
In-Reply-To: <20200514111453.GA99187@suse.com>
References: <20200514111453.GA99187@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-14 at 12:14 +0100, Luis Henriques wrote:
> Similarly to commit 03f219041fdb ("ceph: check i_nlink while converting
> a file handle to dentry"), this fixes another corner case with
> name_to_handle_at/open_by_handle_at.  The issue has been detected by
> xfstest generic/467, when doing:
> 
>  - name_to_handle_at("/cephfs/myfile")
>  - open("/cephfs/myfile")
>  - unlink("/cephfs/myfile")
>  - open_by_handle_at()
> 
> The call to open_by_handle_at should not fail because the file still
> exists and we do have a valid handle to it.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/export.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 79dc06881e78..8556df9d94d0 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -171,12 +171,21 @@ struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino)
>  
>  static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
>  {
> +	struct ceph_inode_info *ci;
>  	struct inode *inode = __lookup_inode(sb, ino);
> +
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  	if (inode->i_nlink == 0) {
> -		iput(inode);
> -		return ERR_PTR(-ESTALE);
> +		bool is_open;
> +		ci = ceph_inode(inode);
> +		spin_lock(&ci->i_ceph_lock);
> +		is_open = __ceph_is_file_opened(ci);
> +		spin_unlock(&ci->i_ceph_lock);
> +		if (!is_open) {
> +			iput(inode);
> +			return ERR_PTR(-ESTALE);
> +		}
>  	}
>  	return d_obtain_alias(inode);
>  }

Thanks Luis. Out of curiousity, is there any reason we shouldn't ignore
the i_nlink value here? Does anything obviously break if we do?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

