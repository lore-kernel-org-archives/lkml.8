Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B36C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0809A206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgDEQrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:47:33 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:47490 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDEQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:47:32 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992819AbgDEQr3TATqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Sun, 5 Apr 2020 18:47:29 +0200
Date:   Sun, 5 Apr 2020 17:47:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: malta: Set load address for 32bit kernel
 correctly
In-Reply-To: <20200405082451.694910-1-jiaxun.yang@flygoat.com>
Message-ID: <alpine.LFD.2.21.2004051738000.4156324@eddie.linux-mips.org>
References: <20200405082451.694910-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Apr 2020, Jiaxun Yang wrote:

> LLD failed to link vmlinux with 64bit load address for 32bit ELF
> while bfd will strip 64bit address into 32bit silently.
> To fix LLD build, we should supply a 32bit load address for 32bit
> kernel.
[...]
> diff --git a/arch/mips/mti-malta/Platform b/arch/mips/mti-malta/Platform
> index 2cc72c9b38e3..f9b49cba1764 100644
> --- a/arch/mips/mti-malta/Platform
> +++ b/arch/mips/mti-malta/Platform
> @@ -6,6 +6,10 @@ cflags-$(CONFIG_MIPS_MALTA)	+= -I$(srctree)/arch/mips/include/asm/mach-malta
>  ifdef CONFIG_KVM_GUEST
>      load-$(CONFIG_MIPS_MALTA)	+= 0x0000000040100000
>  else
> +ifdef CONFIG_64BIT
>      load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
> +else
> +    load-$(CONFIG_MIPS_MALTA)	+= 0x80100000

 Given the description above I think it should be done uniformly and 
automatically across all platforms by trimming the address supplied with 
$(load-y) to low 8 digits in a single place, that is at the place where 
the variable is consumed.  This will reduce clutter across Makefile 
fragments, avoid inconsistencies and extra work to handle individual 
platforms as the problem is triggered over and over again, and limit the 
risk of mistakes.

 Some error checking might be doable for verifying that the 64-bit address 
truncated is a sign-extended 32-bit value, but that perhaps would be an 
overkill as certainly any 64-bit system that sets the load address to be 
outside the sign-extended 32-bit address range does not support a !64BIT 
configuration anyway.

  Maciej
