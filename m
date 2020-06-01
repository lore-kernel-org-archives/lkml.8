Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8977C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D97207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xfXwxQLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFAOqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgFAOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:46:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A8C03E96F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/UgT1POWifvMyJNciOhK8kmfi25RCwYtZsLhUmUhAxQ=; b=xfXwxQLIKqe6CYTZE8B3XMFjT
        QohrjTCJ9iVED68MI64wBiPdRxYlTOwCytLQ8bepIUXyuRNrYkqX2DZWNbtNEjUtszhFapIgAFKwX
        pcPL2C4PE9aS+E+XomPiBu1qbqAZRwZKbCzQhDwWqanV3+cFnxwndmRQM7Y968XzBxm2uiIXlI9SA
        xixTqchLnibodP/P4pinLpT3OlouW8wjfGN2pqWsjOr2iuXTvIgIuhvkjWdkTUaHmBGlJ0dJGlLRZ
        LblReP9VAmUhB7URVY0uK49wtuU9shUTPSsTI8LtzA+RBdUW4Jy0jM0qlUNL7t5WzoiCfBiNP16g1
        yU57jiSxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39982)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jflhl-0000XW-Bb; Mon, 01 Jun 2020 15:46:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jflhX-0003OW-Sb; Mon, 01 Jun 2020 15:46:07 +0100
Date:   Mon, 1 Jun 2020 15:46:07 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/5] arm: decompressor: set malloc pool size for the
 decompressor
Message-ID: <20200601144607.GI1551@shell.armlinux.org.uk>
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <CGME20200601142810eucas1p1767585cf172d26aedb551d7453aa7402@eucas1p1.samsung.com>
 <20200601142754.26139-2-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601142754.26139-2-l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:27:50PM +0200, Łukasz Stelmach wrote:
> Move the definition of malloc pool size of the decompressor to
> a single place. This value will be exposed later for kexec_file loader.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm/boot/compressed/Makefile | 2 ++
>  arch/arm/boot/compressed/head.S   | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 9c11e7490292..b3594cd1588c 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -125,6 +125,8 @@ KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
>  		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
>  		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
>  LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
> +# malloc pool size
> +LDFLAGS_vmlinux += --defsym _malloc_size=0x10000
>  # Supply ZRELADDR to the decompressor via a linker symbol.
>  ifneq ($(CONFIG_AUTO_ZRELADDR),y)
>  LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index e8e1c866e413..dcc1afa60fb9 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -309,7 +309,8 @@ restart:	adr	r0, LC0
>  #ifndef CONFIG_ZBOOT_ROM
>  		/* malloc space is above the relocated stack (64k max) */
>  		add	sp, sp, r0
> -		add	r10, sp, #0x10000
> +		ldr	r10, =_malloc_size
> +		add	r10, r10, sp

This says "locate _malloc_size in a literal pool somewhere, and load it
using a PC-relative offset".  Are you sure that the literal pool is
sensibly located?

Would it be better to use a definition for this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
