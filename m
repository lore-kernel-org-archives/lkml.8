Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C016920775
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgF1G2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgF1G2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:28:41 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B1C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 23:28:41 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D6CADC01A; Sun, 28 Jun 2020 08:28:39 +0200 (CEST)
Date:   Sun, 28 Jun 2020 08:28:24 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [RFC PATCH 1/2] 9p: retrieve fid from file when file instance
 exist.
Message-ID: <20200628062824.GB13335@nautica>
References: <20200628020608.36512-1-jianyong.wu@arm.com>
 <20200628020608.36512-2-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200628020608.36512-2-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Sun, Jun 28, 2020:
> In the current setattr implementation in 9p, fid will always retrieved from
> dentry no matter file instance exist or not when setattr. There will
> be some info related to open file instance dropped. so it's better
> to retrieve fid from file instance if file instance is passed to setattr.
> 
> for example:
> fd=open("tmp", O_RDWR);
> ftruncate(fd, 10);
> 
> the file context related with fd info will lost as fid will always be
> retrieved from dentry, then the backend can't get the info of file context.
> it is against the original intention of user and may lead to bug.

I agree on principle, this makes more sense to use the file's fid.

Just a comment below, but while I'm up in commit message I'll also be
annoying with it -- please try to fix grammar mistakes for next
patches/version (mostly missing some 'be' for future passive form; but I
don't understand why you use future at all and some passive forms could
probably be made active to simplify... Anyway we're not here to discuss
English grammar but words missing out is sloppy and that gives a bad
impression for no good reason)

> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  fs/9p/vfs_inode.c      | 5 ++++-
>  fs/9p/vfs_inode_dotl.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index c9255d399917..010869389523 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -1100,7 +1100,10 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
>  
>  	retval = -EPERM;
>  	v9ses = v9fs_dentry2v9ses(dentry);
> -	fid = v9fs_fid_lookup(dentry);
> +	if (iattr->ia_valid & ATTR_FILE)
> +		fid = iattr->ia_file->private_data;

hmm, normally setattr cannot happen on a file that hasn't been opened so
private_data should always be set, but it doesn't cost much to play safe
and check? e.g. something like this is more conservative:

struct p9_fid *fid = NULL;
...
if (iattr->ia_valid & ATTR_FILE) {
	fid = iattr->ia_file->private_data;
	WARN_ON(!fid);
}
if (!fid)
	fid = v9fs_fid_lookup(dentry);



What do you think?

-- 
Dominique
