Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D36207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:24:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:51108 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFAPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:24:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CA0128030879;
        Mon,  1 Jun 2020 15:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ifxv-QgnvLvF; Mon,  1 Jun 2020 18:24:50 +0300 (MSK)
Date:   Mon, 1 Jun 2020 18:24:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Marc Zyngier <maz@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paul.burton@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <jhogan@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 0/6] mips: Add DT bindings for MIPS CDMM and
 MIPS GIC
Message-ID: <20200601152449.2okwqaqw4262nedu@mobilestation>
References: <20200601122121.15809-1-Sergey.Semin@baikalelectronics.ru>
 <d59ef33155e2ae965e79522ab220c177@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d59ef33155e2ae965e79522ab220c177@kernel.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On Mon, Jun 01, 2020 at 01:31:27PM +0100, Marc Zyngier wrote:
> On 2020-06-01 13:21, Serge Semin wrote:
> 
> [...]
> 
> > Since Paul isn't looking after the MIPS arch code anymore, Ralf hasn't
> > been seen maintaining MIPS for a long time, Thomas is only responsible
> > for the next part of it:
> > 	F:      Documentation/devicetree/bindings/mips/
> > 	F:      Documentation/mips/
> > 	F:      arch/mips/
> > 	F:      drivers/platform/mips/
> > the MIPS-specific drivers like:
> > 	F:	drivers/bus/mips_cdmm.c
> > 	F:	drivers/irqchip/irq-mips-cpu.c
> > 	F:	drivers/irqchip/irq-mips-gic.c
> > 	F:	drivers/clocksource/mips-gic-timer.c
> > 	F:	drivers/cpuidle/cpuidle-cps.c
> > seem to be left for the subsystems maintainers to support. So if you
> > don't
> > mind or unless there is a better alternative, I can help with looking
> > after them to ease the maintainers review burden and since I'll be
> > working
> > on our MIPS-based SoC drivers integrating into the mainline kernel repo
> > anyway. If you don't like this idea, please just decline the last
> > patch in the series.
> 

> Given how deeply integrated the MIPS GIC is in the architecture, I'd
> really like Thomas to co-maintain it, or at the very least give his
> blessing on you being the dedicated point of contact for MIPS GIC
> stuff.

I don't mind either way. First option might be even better. Thomas, what do you
think?

-Sergey

> 
> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
