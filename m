Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4922071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgCSMhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:37:54 -0400
Received: from elvis.franken.de ([193.175.24.41]:51030 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgCSMhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:37:54 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jEuQl-0004K1-03; Thu, 19 Mar 2020 13:37:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D7B79C026A; Thu, 19 Mar 2020 13:37:15 +0100 (CET)
Date:   Thu, 19 Mar 2020 13:37:15 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     bibo mao <maobibo@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hartley <james.hartley@sondrel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Add header files reference with path prefix
Message-ID: <20200319123715.GC10783@alpha.franken.de>
References: <1584424994-21922-1-git-send-email-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584424994-21922-1-git-send-email-maobibo@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:03:14AM -0400, bibo mao wrote:
> There are some common header files which are referenced locally
> with #includenext method, includenext is tricky method and only
> used on mips platform.
> 
> This patech removes includenext method, replace it with defailed
> pathname prefix for header files.
> 
> This patch passes to compile on all mips platform with defconfig,
> and is verified on my loongson64 box.
> 
> Changes:
> --------
> v2:
>   - Fix compiling issue on malta platform
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: bibo mao <maobibo@loongson.cn>
> ---
>  arch/mips/include/asm/mach-ar7/irq.h           | 2 +-
>  arch/mips/include/asm/mach-ath79/irq.h         | 2 +-
>  arch/mips/include/asm/mach-emma2rh/irq.h       | 2 +-
>  arch/mips/include/asm/mach-ip27/irq.h          | 2 +-
>  arch/mips/include/asm/mach-ip30/irq.h          | 2 +-
>  arch/mips/include/asm/mach-lantiq/falcon/irq.h | 2 +-
>  arch/mips/include/asm/mach-lantiq/xway/irq.h   | 2 +-
>  arch/mips/include/asm/mach-lasat/irq.h         | 2 +-
>  arch/mips/include/asm/mach-loongson64/irq.h    | 2 +-
>  arch/mips/include/asm/mach-malta/irq.h         | 2 +-
>  arch/mips/include/asm/mach-pic32/irq.h         | 2 +-
>  arch/mips/include/asm/mach-pistachio/irq.h     | 2 +-
>  arch/mips/include/asm/mach-ralink/irq.h        | 2 +-
>  arch/mips/include/asm/mach-rm/mc146818rtc.h    | 2 +-
>  arch/mips/include/asm/mach-vr41xx/irq.h        | 2 +-
>  arch/mips/include/asm/mach-xilfpga/irq.h       | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)

Applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
