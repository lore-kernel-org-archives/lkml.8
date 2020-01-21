Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19BBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44624653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgAUQWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:22:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:55986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:22:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B23DAFDC;
        Tue, 21 Jan 2020 16:22:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 78A021E0A4E; Tue, 21 Jan 2020 17:22:15 +0100 (CET)
Date:   Tue, 21 Jan 2020 17:22:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/quota: remove unused macro
Message-ID: <20200121162215.GB5803@quack2.suse.cz>
References: <1579602334-57039-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579602334-57039-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-01-20 18:25:34, Alex Shi wrote:
> __QUOTA_V2_PARANOIA  macro is never used. better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Jan Kara <jack@suse.com> 
> Cc: linux-kernel@vger.kernel.org 

Thanks. I've merged the patch.

								Honza

> ---
>  fs/quota/quota_v2.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
> index 53429c29c784..58fc2a7c7fd1 100644
> --- a/fs/quota/quota_v2.c
> +++ b/fs/quota/quota_v2.c
> @@ -22,8 +22,6 @@
>  MODULE_DESCRIPTION("Quota format v2 support");
>  MODULE_LICENSE("GPL");
>  
> -#define __QUOTA_V2_PARANOIA
> -
>  static void v2r0_mem2diskdqb(void *dp, struct dquot *dquot);
>  static void v2r0_disk2memdqb(struct dquot *dquot, void *dp);
>  static int v2r0_is_id(void *dp, struct dquot *dquot);
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
