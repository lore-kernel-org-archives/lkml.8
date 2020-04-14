Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD7DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ADE206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437615AbgDNJXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:23:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437562AbgDNJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:23:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AD76AEF5;
        Tue, 14 Apr 2020 09:23:37 +0000 (UTC)
Date:   Tue, 14 Apr 2020 11:23:37 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, mingo@kernel.org, peterz@infradead.org,
        shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/unwind: Make some variables static
In-Reply-To: <20200413144727.51258-1-songmuchun@bytedance.com>
Message-ID: <alpine.LSU.2.21.2004141123030.6508@pobox.suse.cz>
References: <20200413144727.51258-1-songmuchun@bytedance.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Muchun Song wrote:

> The variables are local to the source and do not need to be
> in global scope, so make them static.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/kernel/unwind_orc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index e9cc182aa97ee..0dbabc469ce2d 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -16,11 +16,11 @@ extern struct orc_entry __start_orc_unwind[];
>  extern struct orc_entry __stop_orc_unwind[];
>  
>  static DEFINE_MUTEX(sort_mutex);
> -int *cur_orc_ip_table = __start_orc_unwind_ip;
> -struct orc_entry *cur_orc_table = __start_orc_unwind;
> +static int *cur_orc_ip_table = __start_orc_unwind_ip;
> +static struct orc_entry *cur_orc_table = __start_orc_unwind;
>  
> -unsigned int lookup_num_blocks;
> -bool orc_init;
> +static unsigned int lookup_num_blocks;
> +static bool orc_init;
>  
>  static inline unsigned long orc_ip(const int *ip)
>  {
> -- 

Already fixed in 
https://lore.kernel.org/lkml/63b5cab2e28b9c08854fc57f5b512a9ccf76ad95.1584033751.git.jpoimboe@redhat.com/

Thanks,
Miroslav
