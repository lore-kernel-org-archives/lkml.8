Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56CC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22783206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgG1IjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:39:00 -0400
Received: from elvis.franken.de ([193.175.24.41]:51651 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgG1Ii7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:38:59 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k0L8B-0000DV-01; Tue, 28 Jul 2020 10:38:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E208CC0A94; Tue, 28 Jul 2020 10:30:16 +0200 (CEST)
Date:   Tue, 28 Jul 2020 10:30:16 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, od@zcrc.me,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: Remove legacy MIPS_MACHINE option
Message-ID: <20200728083016.GB9062@alpha.franken.de>
References: <20200726165828.55175-1-paul@crapouillou.net>
 <20200726165828.55175-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726165828.55175-2-paul@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 06:58:28PM +0200, Paul Cercueil wrote:
> The CONFIG_MIPS_MACHINE option is dead code that hasn't been used in
> years. The Kconfig option is not selected anywhere, and the
> <asm/mips_machine.h> is not included anywhere either.
> 
> To make things worse, for years it co-existed with a separate MIPS
> machine implementation as <asm/machine.h>. The two defined the
> 'mips_machine' structure with different fields, and the 'MIPS_MACHINE'
> macro with different parameters. The two used the same memory area
> (defined by the linker script) to store data, and you could totally use
> the two at the same time for all kinds of funny results.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/Kconfig                    |  3 --
>  arch/mips/include/asm/mips_machine.h | 46 ---------------------
>  arch/mips/kernel/Makefile            |  1 -
>  arch/mips/kernel/mips_machine.c      | 62 ----------------------------
>  4 files changed, 112 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mips_machine.h
>  delete mode 100644 arch/mips/kernel/mips_machine.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
