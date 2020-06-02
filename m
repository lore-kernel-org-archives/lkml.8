Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE11C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5759320678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFBUyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:54:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10476C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:54:22 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jgDvL-0003XN-0L; Tue, 02 Jun 2020 22:54:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4DB14100F18; Tue,  2 Jun 2020 22:54:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Herrenschmidt\, Benjamin" <benh@amazon.com>,
        "maz\@kernel.org" <maz@kernel.org>,
        "Saidi\, Ali" <alisaidi@amazon.com>
Cc:     "jason\@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Woodhouse\, David" <dwmw@amazon.co.uk>,
        "Zilberman\, Zeev" <zeev@amazon.com>,
        "Machulsky\, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
In-Reply-To: <37e55e71faf76dc3db76d89c20c1bdfff942e380.camel@amazon.com>
References: <20200529015501.15771-1-alisaidi@amazon.com> <8c3be990888ecfb7cca9503853dc4aac@kernel.org> <2C4F431F-8140-4C82-B4BD-E51DE618FC08@amazon.com> <20200530174929.7bf6d5d7@why> <eed907d48de84c96e3ceb27c1ed6f622@kernel.org> <37e55e71faf76dc3db76d89c20c1bdfff942e380.camel@amazon.com>
Date:   Tue, 02 Jun 2020 22:54:14 +0200
Message-ID: <87y2p5fatl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Herrenschmidt, Benjamin" <benh@amazon.com> writes:
> On Sun, 2020-05-31 at 12:09 +0100, Marc Zyngier wrote:
>> > The semantic of activate/deactivate (which maps to started/shutdown
>> > in the IRQ code) is that the HW resources for a given interrupt are
>> > only committed when the interrupt is activated. Trying to perform
>> > actions involving the HW on an interrupt that isn't active cannot be
>> > guaranteed to take effect.
>> > 
>> > I'd rather address it in the core code, by preventing set_affinity (and
>> > potentially others) to take place when the interrupt is not in the
>> > STARTED state. Userspace would get an error, which is perfectly
>> > legitimate, and which it already has to deal with it for plenty of
>> > other
>> > reasons.
>
> So I finally found time to dig a bit in there :) Code has changed a bit
> since last I looked. But I have memories of the startup code messing
> around with the affinity, and here it is. In irq_startup() :
>
>
> 		switch (__irq_startup_managed(desc, aff, force)) {
> 		case IRQ_STARTUP_NORMAL:
> 			ret = __irq_startup(desc);
> 			irq_setup_affinity(desc);
> 			break;
> 		case IRQ_STARTUP_MANAGED:
> 			irq_do_set_affinity(d, aff, false);
> 			ret = __irq_startup(desc);
> 			break;
> 		case IRQ_STARTUP_ABORT:
> 			irqd_set_managed_shutdown(d);
> 			return 0;
>
> So we have two cases here. Normal and managed.
>
> In the managed case, we set the affinity before startup. I feel like your
> patch might break that or am I missing something ?

It will break stuff because the affinity is not stored in case that the
interrupt is not started.

I think we can fix this in the core code but that needs more thought.
__irq_can_set_affinity() is definitely the wrong place.

Thanks,

        tglx

