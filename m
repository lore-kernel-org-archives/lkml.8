Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F30C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D8A206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgG1U5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:57:22 -0400
Received: from elvis.franken.de ([193.175.24.41]:52464 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgG1U5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:57:19 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k0Wez-0007gK-02; Tue, 28 Jul 2020 22:57:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 16C87C0A9B; Tue, 28 Jul 2020 22:52:45 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:52:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] MIPS: Loongson64: Process ISA Node in DeviceTree
Message-ID: <20200728205245.GC22052@alpha.franken.de>
References: <20200728153708.1296374-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728153708.1296374-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 11:36:54PM +0800, Jiaxun Yang wrote:
> Hi,
> 
> This series convert reservation of Loongson64 Logic PIO into DeviceTree based
> method.
> 
> It can be used to replace Huacai's
> "MIPS: Loongson64: Reserve legacy MMIO space according to bridge type".
> 
> Thanks.
> 
> v2:
>   - Address Rob and Huacai's review comments.
> v3:
>   - Address Rob, Thomas's review comments.
> v4:
>   - Fix typo & grammar issue according to Xuerui's suggestion.
> 
> Jiaxun Yang (5):
>   of_address: Add bus type match for pci ranges parser
>   MIPS: Loongson64: Process ISA Node in DeviceTree
>   MIPS: Loongson64: Enlarge IO_SPACE_LIMIT
>   MIPS: Loongson64: DTS: Fix ISA and PCI I/O ranges for RS780E PCH
>   MIPS: Loongson64: Add ISA node for LS7A PCH
> 
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |  7 ++
>  arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  4 +-
>  arch/mips/include/asm/io.h                    |  2 -
>  arch/mips/include/asm/mach-generic/spaces.h   |  4 +
>  .../mips/include/asm/mach-loongson64/spaces.h |  3 +-
>  arch/mips/loongson64/init.c                   | 87 +++++++++++++------
>  drivers/of/address.c                          | 29 ++++---
>  include/linux/of_address.h                    |  4 +
>  8 files changed, 97 insertions(+), 43 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
