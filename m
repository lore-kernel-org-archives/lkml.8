Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C24C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09FC22BEA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHNCR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgHNCR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:17:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5BF20771;
        Fri, 14 Aug 2020 02:17:26 +0000 (UTC)
Date:   Thu, 13 Aug 2020 22:17:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zejiang Tang <tangzejiang@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ftrace: Remove redundant #ifdef
 CONFIG_DYNAMIC_FTRAC
Message-ID: <20200813221725.102a3b3e@oasis.local.home>
In-Reply-To: <1597370895-5412-1-git-send-email-tangzejiang@loongson.cn>
References: <1597370895-5412-1-git-send-email-tangzejiang@loongson.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 10:08:15 +0800
Zejiang Tang <tangzejiang@loongson.cn> wrote:

> There exists redundant #ifdef CONFIG_DYNAMIC_FTRAC in ftrace.c, remove it.
> 
> Signed-off-by: Zejiang Tang <tangzejiang@loongson.cn>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  arch/mips/kernel/ftrace.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 2625232..f57e68f 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -37,10 +37,6 @@ void arch_ftrace_update_code(int command)
>  	ftrace_modify_all_code(command);
>  }
>  
> -#endif
> -
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -
>  #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
>  #define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
>  #define JUMP_RANGE_MASK ((1UL << 28) - 1)

