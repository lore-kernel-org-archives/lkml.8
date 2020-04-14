Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1C5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52447206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437598AbgDNJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:22:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:45174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437590AbgDNJWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:22:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CBD4AD9F;
        Tue, 14 Apr 2020 09:22:50 +0000 (UTC)
Date:   Tue, 14 Apr 2020 11:22:50 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org, jpoimboe@redhat.com,
        shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] x86/unwind/orc: make some symbols static
In-Reply-To: <20200413082203.22853-1-yanaijie@huawei.com>
Message-ID: <alpine.LSU.2.21.2004141121110.6508@pobox.suse.cz>
References: <20200413082203.22853-1-yanaijie@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Jason Yan wrote:

> Fix the following sparse warning:
> 
> arch/x86/kernel/unwind_orc.c:19:5: warning: symbol 'cur_orc_ip_table'
> was not declared. Should it be static?
> arch/x86/kernel/unwind_orc.c:20:18: warning: symbol 'cur_orc_table' was
> not declared. Should it be static?
> arch/x86/kernel/unwind_orc.c:22:14: warning: symbol 'lookup_num_blocks'
> was not declared. Should it be static?
> arch/x86/kernel/unwind_orc.c:23:6: warning: symbol 'orc_init' was not
> declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  arch/x86/kernel/unwind_orc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index e9cc182aa97e..0dbabc469ce2 100644
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

Thanks for the patch, but Josh already fixed it in 
https://lore.kernel.org/lkml/63b5cab2e28b9c08854fc57f5b512a9ccf76ad95.1584033751.git.jpoimboe@redhat.com/

Josh, any plans to add the patch set into the current queue?

Miroslav
