Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28518C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD9A222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgAOVuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:50:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAOVuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:50:24 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irqYO-0001iT-88; Wed, 15 Jan 2020 22:50:20 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 97E47101228; Wed, 15 Jan 2020 22:50:19 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
In-Reply-To: <1579121936.3.1@crapouillou.net>
References: <1579110897.3.0@crapouillou.net> <87y2u8xzq0.fsf@nanos.tec.linutronix.de> <1579121936.3.1@crapouillou.net>
Date:   Wed, 15 Jan 2020 22:50:19 +0100
Message-ID: <87muaoxuck.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cercueil <paul@crapouillou.net> writes:
> Le mer., janv. 15, 2020 at 20:54, Thomas Gleixner <tglx@linutronix.de> 
>> That lock still a massive contention point as clock readouts can be 
>> pretty
>> frequent depending on workloads. Just think about tracing ...
>> 
>> So I really would avoid both the lock and that ugly 64bit readout 
>> thing.
>
> The 64bit readout thing is gone in V3.
>
> The lock cannot go away unless we have a way to retrieve the underlying 
> mmio pointer from the regmap, which the regmap maintainers will never 
> accept. So I can't really change that now. Besides, 
> drivers/clocksource/ingenic-timer.c also registers a clocksource that's 
> read with the regmap, and nobody complained.

I don't complain. I just told you that a spinlock in that code path is
really suboptimal.

I missed the one in the other driver, but the same problem exists there.

Thanks,

        tglx
