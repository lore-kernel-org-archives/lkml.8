Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18459C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E932146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583354221;
	bh=ZK3EZH24PdCA4p7WCYRCBidIeBe2zKk0o/B3DsyXUa0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=sqIKoxSyMes7aCE8PGBDcTCGdVFIfxDJ50Sxp6bkYE+3oe5kmeOCCs+NnWXDXQ9uv
	 FgxkfI+LpbvIrVr7DBmTJBysO54BiBelekcFziGY9szSX3vXD1F/Q1NKtQDOS1u6MU
	 nB3qe9QgW+tfbwToTPvbttbaT0oWhwDWENn6zxto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbgCDUhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:37:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388482AbgCDUg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:36:56 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E5721556;
        Wed,  4 Mar 2020 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583354215;
        bh=ZK3EZH24PdCA4p7WCYRCBidIeBe2zKk0o/B3DsyXUa0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hz3fbN5uN/sdJi1K+xLlQ9TrsNkRtVwRQJs7dmN7PvDmGNH6t7tP31oRWZgm9c3wJ
         Xxk6WgX6q4THg8LmiiNnmpjeSh8hH1pS7Z0vM0ivD4H/Bn6y02Oxc64Cdk+2omq7Ua
         +QyrBjNbneUXapBT9Q2oTzY55tWuO3xLJzPW2T0w=
Message-ID: <f09ffef023cfb8740f6a9a289215e53a16bebb2d.camel@kernel.org>
Subject: Re: [PATCH] fs/ceph/export: remove unused variable 'err'
From:   Jeff Layton <jlayton@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 15:36:54 -0500
In-Reply-To: <1583252499-16078-1-git-send-email-hqjagain@gmail.com>
References: <1583252499-16078-1-git-send-email-hqjagain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 00:21 +0800, Qiujun Huang wrote:
> fix gcc '-Wunused-but-set-variable' warning:
> fs/ceph/export.c: In function ‘__get_parent’:
> fs/ceph/export.c:294:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
>   int err;
> 
> and needn't use the return value of ceph_mdsc_create_request.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  fs/ceph/export.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index b6bfa94..b7bb41c 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -291,7 +291,6 @@ static struct dentry *__get_parent(struct super_block *sb,
>  	struct ceph_mds_request *req;
>  	struct inode *inode;
>  	int mask;
> -	int err;
>  
>  	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPPARENT,
>  				       USE_ANY_MDS);
> @@ -314,7 +313,7 @@ static struct dentry *__get_parent(struct super_block *sb,
>  	req->r_args.getattr.mask = cpu_to_le32(mask);
>  
>  	req->r_num_caps = 1;
> -	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	ceph_mdsc_do_request(mdsc, NULL, req);
>  	inode = req->r_target_inode;
>  	if (inode)
>  		ihold(inode);

I think we probably ought to just return ERR_PTR(err) in that case
instead of discarding it. It looks like today we'll end up returning
ENOENT when that errors out which doesn't seem right when there is a
different issue.

-- 
Jeff Layton <jlayton@kernel.org>

