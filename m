Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A4CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E1B20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgE0NEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbgE0NEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:04:35 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3AC620873;
        Wed, 27 May 2020 13:04:32 +0000 (UTC)
Subject: Re: [PATCH 1/4] m68k: add arch/m68k/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
References: <20200526123810.301667-1-masahiroy@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <03086d60-52eb-384c-da03-11c127b7132f@linux-m68k.org>
Date:   Wed, 27 May 2020 23:04:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526123810.301667-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/5/20 10:38 pm, Masahiro Yamada wrote:
> Use the standard obj-y form to specify the sub-directories under
> arch/m68k/. No functional change intended.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
> 
>   arch/m68k/Kbuild   | 19 +++++++++++++++++++
>   arch/m68k/Makefile | 20 +-------------------
>   2 files changed, 20 insertions(+), 19 deletions(-)
>   create mode 100644 arch/m68k/Kbuild
> 
> diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
> new file mode 100644
> index 000000000000..7dc1398dd188
> --- /dev/null
> +++ b/arch/m68k/Kbuild
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y				+= kernel/ mm/
> +obj-$(CONFIG_Q40)		+= q40/
> +obj-$(CONFIG_AMIGA)		+= amiga/
> +obj-$(CONFIG_ATARI)		+= atari/
> +obj-$(CONFIG_MAC)		+= mac/
> +obj-$(CONFIG_HP300)		+= hp300/
> +obj-$(CONFIG_APOLLO)		+= apollo/
> +obj-$(CONFIG_MVME147)		+= mvme147/
> +obj-$(CONFIG_MVME16x)		+= mvme16x/
> +obj-$(CONFIG_BVME6000)		+= bvme6000/
> +obj-$(CONFIG_SUN3X)		+= sun3x/ sun3/
> +obj-$(CONFIG_SUN3)		+= sun3/ sun3/prom/
> +obj-$(CONFIG_NATFEAT)		+= emu/
> +obj-$(CONFIG_M68040)		+= fpsp040/
> +obj-$(CONFIG_M68060)		+= ifpsp060/
> +obj-$(CONFIG_M68KFPU_EMU)	+= math-emu/
> +obj-$(CONFIG_M68000)		+= 68000/
> +obj-$(CONFIG_COLDFIRE)		+= coldfire/
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 5d9288384096..88d4d8bbecd6 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -97,27 +97,9 @@ head-$(CONFIG_SUN3)		:= arch/m68k/kernel/sun3-head.o
>   head-$(CONFIG_M68000)		:= arch/m68k/68000/head.o
>   head-$(CONFIG_COLDFIRE)		:= arch/m68k/coldfire/head.o
>   
> -core-y				+= arch/m68k/kernel/	arch/m68k/mm/
> +core-y				+= arch/m68k/
>   libs-y				+= arch/m68k/lib/
>   
> -core-$(CONFIG_Q40)		+= arch/m68k/q40/
> -core-$(CONFIG_AMIGA)		+= arch/m68k/amiga/
> -core-$(CONFIG_ATARI)		+= arch/m68k/atari/
> -core-$(CONFIG_MAC)		+= arch/m68k/mac/
> -core-$(CONFIG_HP300)		+= arch/m68k/hp300/
> -core-$(CONFIG_APOLLO)		+= arch/m68k/apollo/
> -core-$(CONFIG_MVME147)		+= arch/m68k/mvme147/
> -core-$(CONFIG_MVME16x)		+= arch/m68k/mvme16x/
> -core-$(CONFIG_BVME6000)		+= arch/m68k/bvme6000/
> -core-$(CONFIG_SUN3X)		+= arch/m68k/sun3x/	arch/m68k/sun3/
> -core-$(CONFIG_SUN3)		+= arch/m68k/sun3/	arch/m68k/sun3/prom/
> -core-$(CONFIG_NATFEAT)		+= arch/m68k/emu/
> -core-$(CONFIG_M68040)		+= arch/m68k/fpsp040/
> -core-$(CONFIG_M68060)		+= arch/m68k/ifpsp060/
> -core-$(CONFIG_M68KFPU_EMU)	+= arch/m68k/math-emu/
> -core-$(CONFIG_M68000)		+= arch/m68k/68000/
> -core-$(CONFIG_COLDFIRE)		+= arch/m68k/coldfire/
> -
>   
>   all:	zImage
>   
> 
