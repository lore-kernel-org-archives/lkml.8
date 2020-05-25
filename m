Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5EFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259A3206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbgEYInZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:43:25 -0400
Received: from elvis.franken.de ([193.175.24.41]:38038 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388465AbgEYInZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:43:25 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jd8hc-0005hs-00; Mon, 25 May 2020 10:43:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9337CC01DC; Mon, 25 May 2020 10:42:34 +0200 (CEST)
Date:   Mon, 25 May 2020 10:42:34 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     YuanJunQing <yuanjunqing66@163.com>
Cc:     paulburton@kernel.org, chenhc@lemote.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulichao@loongson.cn
Subject: Re: [PATCH] MIPS: Fix IRQ tracing when call handle_fpe()
Message-ID: <20200525084234.GA5057@alpha.franken.de>
References: <20200525033123.13114-1-yuanjunqing66@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525033123.13114-1-yuanjunqing66@163.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:31:23AM +0800, YuanJunQing wrote:
>  Register "a1" is unsaved in this function,
>  when CONFIG_TRACE_IRQFLAGS is enabled,
>  the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
>  and this may change register "a1".
>  The variment of register "a1" may send SIGFPE signal
>  to task when call do_fpe(),and this may kill the task.
> 
> Signed-off-by: YuanJunQing <yuanjunqing66@163.com>
> ---
>  arch/mips/kernel/genex.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 8236fb291e3f..956a76429773 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -480,16 +480,18 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
>  	.set	mips1
>  	SET_HARDFLOAT
> -	cfc1	a1, fcr31
> +	cfc1	s0, fcr31
>  	.set	pop
>  	CLI
>  	TRACE_IRQS_OFF
> +	move    a1,s0
>  	.endm

do we realy need to read fcr31 that early ? Wouldn't it work to
just move the cfc1 below TRACE_IRQS_OFF ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
