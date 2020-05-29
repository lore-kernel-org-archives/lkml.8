Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF217C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987F72074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgE2GxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:53:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2GxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:53:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57FB9AEE7;
        Fri, 29 May 2020 06:52:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D7E801E1289; Fri, 29 May 2020 08:52:58 +0200 (CEST)
Date:   Fri, 29 May 2020 08:52:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     jeffm@suse.com, jack@suse.cz, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH] reiserfs: Replace kmalloc with kcalloc in the comment
Message-ID: <20200529065258.GK14550@quack2.suse.cz>
References: <1590714150-15895-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590714150-15895-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-05-20 09:02:30, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Use kcalloc instead of kmalloc in the comment according to
> the previous kcalloc() call.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/reiserfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 6419e6d..21ad762 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -1066,7 +1066,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
>  			} else {
>  				/* paste hole to the indirect item */
>  				/*
> -				 * If kmalloc failed, max_to_insert becomes
> +				 * If kcalloc failed, max_to_insert becomes
>  				 * zero and it means we only have space for
>  				 * one block
>  				 */
> -- 
> 2.9.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
