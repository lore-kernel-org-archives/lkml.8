Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB0520873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgE0Mzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbgE0Mzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:55:52 -0400
Received: from [192.168.0.106] (193-116-100-240.tpgi.com.au [193.116.100.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C7E2084C;
        Wed, 27 May 2020 12:55:50 +0000 (UTC)
Subject: Re: [PATCH 3/4] m68k: optimize cc-option calls for cpuflags-y
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
References: <20200526123810.301667-1-masahiroy@kernel.org>
 <20200526123810.301667-3-masahiroy@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c0dc228a-ab53-d2da-0211-c8597b3473df@linux-m68k.org>
Date:   Wed, 27 May 2020 22:55:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526123810.301667-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/5/20 10:38 pm, Masahiro Yamada wrote:
> arch/m68k/Makefile computes lots of unneeded cc-option calls.
> 
> For example, if CONFIG_M5441x is not defined, there is not point in
> evaluating the following compiler flag.
> 
>   cpuflags-$(CONFIG_M5441x)      := $(call cc-option,-mcpu=54455,-mcfv4e)
> 
> The result is set to cpuflags-, then thrown away.
> 
> The right hand side of ':=' is immediately expanded. Hence, all of the
> 16 calls for cc-option are evaluated. This is expensive since cc-option
> invokes the compiler. This occurs even if you are not attempting to
> build anything, like 'make ARCH=m68k help'.
> 
> Use '=' to expand the value _lazily_. The evaluation for cc-option is
> delayed until $(cpuflags-y) is expanded. So, the cc-option test happens
> just once at most.
> 
> This commit mimics tune-y of arch/arm/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
> 
>   arch/m68k/Makefile | 45 ++++++++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 88d4d8bbecd6..ae6e29da3a3e 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -32,30 +32,33 @@ endif
>   #	compiler cpu type flag.
>   #
>   ifndef CONFIG_M68040
> -cpuflags-$(CONFIG_M68060)	:= -m68060
> +cpuflags-$(CONFIG_M68060)	= -m68060
>   endif
>   ifndef CONFIG_M68060
> -cpuflags-$(CONFIG_M68040)	:= -m68040
> +cpuflags-$(CONFIG_M68040)	= -m68040
>   endif
> -cpuflags-$(CONFIG_M68030)	:=
> -cpuflags-$(CONFIG_M68020)	:=
> -cpuflags-$(CONFIG_M68000)	:= -m68000
> -cpuflags-$(CONFIG_M5441x)	:= $(call cc-option,-mcpu=54455,-mcfv4e)
> -cpuflags-$(CONFIG_M54xx)	:= $(call cc-option,-mcpu=5475,-m5200)
> -cpuflags-$(CONFIG_M5407)	:= $(call cc-option,-mcpu=5407,-m5200)
> -cpuflags-$(CONFIG_M532x)	:= $(call cc-option,-mcpu=532x,-m5307)
> -cpuflags-$(CONFIG_M537x)	:= $(call cc-option,-mcpu=537x,-m5307)
> -cpuflags-$(CONFIG_M5307)	:= $(call cc-option,-mcpu=5307,-m5200)
> -cpuflags-$(CONFIG_M528x)	:= $(call cc-option,-mcpu=528x,-m5307)
> -cpuflags-$(CONFIG_M5275)	:= $(call cc-option,-mcpu=5275,-m5307)
> -cpuflags-$(CONFIG_M5272)	:= $(call cc-option,-mcpu=5272,-m5307)
> -cpuflags-$(CONFIG_M5271)	:= $(call cc-option,-mcpu=5271,-m5307)
> -cpuflags-$(CONFIG_M523x)	:= $(call cc-option,-mcpu=523x,-m5307)
> -cpuflags-$(CONFIG_M525x)	:= $(call cc-option,-mcpu=5253,-m5200)
> -cpuflags-$(CONFIG_M5249)	:= $(call cc-option,-mcpu=5249,-m5200)
> -cpuflags-$(CONFIG_M520x)	:= $(call cc-option,-mcpu=5208,-m5200)
> -cpuflags-$(CONFIG_M5206e)	:= $(call cc-option,-mcpu=5206e,-m5200)
> -cpuflags-$(CONFIG_M5206)	:= $(call cc-option,-mcpu=5206,-m5200)
> +cpuflags-$(CONFIG_M68030)	=
> +cpuflags-$(CONFIG_M68020)	=
> +cpuflags-$(CONFIG_M68000)	= -m68000
> +cpuflags-$(CONFIG_M5441x)	= $(call cc-option,-mcpu=54455,-mcfv4e)
> +cpuflags-$(CONFIG_M54xx)	= $(call cc-option,-mcpu=5475,-m5200)
> +cpuflags-$(CONFIG_M5407)	= $(call cc-option,-mcpu=5407,-m5200)
> +cpuflags-$(CONFIG_M532x)	= $(call cc-option,-mcpu=532x,-m5307)
> +cpuflags-$(CONFIG_M537x)	= $(call cc-option,-mcpu=537x,-m5307)
> +cpuflags-$(CONFIG_M5307)	= $(call cc-option,-mcpu=5307,-m5200)
> +cpuflags-$(CONFIG_M528x)	= $(call cc-option,-mcpu=528x,-m5307)
> +cpuflags-$(CONFIG_M5275)	= $(call cc-option,-mcpu=5275,-m5307)
> +cpuflags-$(CONFIG_M5272)	= $(call cc-option,-mcpu=5272,-m5307)
> +cpuflags-$(CONFIG_M5271)	= $(call cc-option,-mcpu=5271,-m5307)
> +cpuflags-$(CONFIG_M523x)	= $(call cc-option,-mcpu=523x,-m5307)
> +cpuflags-$(CONFIG_M525x)	= $(call cc-option,-mcpu=5253,-m5200)
> +cpuflags-$(CONFIG_M5249)	= $(call cc-option,-mcpu=5249,-m5200)
> +cpuflags-$(CONFIG_M520x)	= $(call cc-option,-mcpu=5208,-m5200)
> +cpuflags-$(CONFIG_M5206e)	= $(call cc-option,-mcpu=5206e,-m5200)
> +cpuflags-$(CONFIG_M5206)	= $(call cc-option,-mcpu=5206,-m5200)
> +
> +# Evaluate tune cc-option calls now
> +cpuflags-y := $(cpuflags-y)
>   
>   KBUILD_AFLAGS += $(cpuflags-y)
>   KBUILD_CFLAGS += $(cpuflags-y)
> 
