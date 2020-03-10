Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC4DC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58F24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCJAVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:21:16 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44352 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCJAVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:21:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 828E280307C8;
        Tue, 10 Mar 2020 00:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AWdmwkNkae7o; Tue, 10 Mar 2020 03:21:12 +0300 (MSK)
Date:   Tue, 10 Mar 2020 03:20:22 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] clocksource: Fix MIPS GIC and DW APB Timer for
 Baikal-T1 SoC support
References: <20200306125605.8143-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306125605.8143-1-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310002113.828E280307C8@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:56:00PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Aside from MIPS-specific r4k timer Baikal-T1 chip also provides a functionality
> of two another timers: embedded into the MIPS GIC timer and three external DW
> timers available over APB bus. But we can't use them before the corresponding
> drivers are properly fixed. First of all DW APB Timer shouldn't be bound to a
> single CPU, since as being accessible over APB they are external with respect
> to all possible CPUs. Secondly there might be more than just two DW APB Timers
> in the system (Baikal-T1 has three of them), so permit the driver to use one of
> them as a clocksource and the rest - for clockevents. Thirdly it's possible to
> use MIPS GIC timer as a clocksource so register it in the corresponding
> subsystem (the patch has been found in the Paul Burton MIPS repo so I left the
> original Signed-off-by attribute). Finally in the same way as r4k timer the
> MIPS GIC timer should be used with care when CPUFREQ config is enabled since in
> case of CM2 the timer counting depends on the CPU reference clock frequency
> while the clocksource subsystem currently doesn't support the timers with
> non-stable clock.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> 
> Paul Burton (1):
>   clocksource: mips-gic-timer: Register as sched_clock
> 
> Serge Semin (3):
>   clocksource: dw_apb_timer: Set clockevent any-possible-CPU mask
>   clocksource: dw_apb_timer_of: Fix missing clockevent timers
>   clocksource: mips-gic-timer: Set limitations on
>     clocksource/sched-clocks usage
> 
>  drivers/clocksource/dw_apb_timer.c    | 18 +++++++---------
>  drivers/clocksource/dw_apb_timer_of.c |  9 +++-----
>  drivers/clocksource/mips-gic-timer.c  | 30 ++++++++++++++++++++++-----
>  include/linux/dw_apb_timer.h          |  2 +-
>  4 files changed, 36 insertions(+), 23 deletions(-)
> 
> -- 
> 2.25.1
> 

Folks,

It appears our corporate email server changes the Message-Id field of
messages passing through it. Due to that the emails threading gets to be
broken. I'll resubmit the properly structured patchset as soon as our system
administrator fixes the problem. Sorry for the inconvenience cause by it.

Regards,
-Sergey

