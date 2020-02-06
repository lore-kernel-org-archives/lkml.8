Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEFFC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A4D21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgBFJnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:43:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBFJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:43:33 -0500
Received: from [185.104.136.29] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1izdh1-0000BK-9J; Thu, 06 Feb 2020 10:43:28 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 139C6100C31; Thu,  6 Feb 2020 09:42:47 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH] genirq: Clarify that irq wake state is orthogonal to enable/disable
In-Reply-To: <5e3b279f.1c69fb81.383f9.1da3@mx.google.com>
References: <20200205060953.49167-1-swboyd@chromium.org> <87zhdxrzhh.fsf@nanos.tec.linutronix.de> <5e3b279f.1c69fb81.383f9.1da3@mx.google.com>
Date:   Thu, 06 Feb 2020 09:42:47 +0000
Message-ID: <87r1z8rqzs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <swboyd@chromium.org> writes:
> Quoting Thomas Gleixner (2020-02-05 04:27:06)
>> >   *   Wakeup mode lets this IRQ wake the system from sleep
>> >   *   states like "suspend to RAM".
>> > + *
>> > + *   Note: irq enable/disable state is completely orthogonal
>> > + *   to the enable/disable state of irq wake. An irq can be
>> > + *   disabled with disable_irq() and still wake the system as
>> > + *   long as the irq has wake enabled.
>> 
>> It clearly should say that this is really depending on the hardware
>> implementation of the particual interrupt chip whether disabled + wake
>> mode is supported.
>> 
>
> Ok. I'm having trouble parsing this. Is there a consistent wording that
> can be put here?

See below.

> The API seems fraught with peril if an implementation of an irqchip is
> allowed to ignore wakeup on interrupts that are marked for wakeup while
> the irq is disabled. Driver writers won't be able to write drivers that
> work across implementations if the irq can't wake the system reliably.

It's not really well defined but thats a result of the gazillion
variants of irq chips which all have their own quirks. The wakeup
mechansims are also widely different, some of them are built into the
SOC, others require external logic. And a large part of these things is
completely undocumented. Welcome to my wonderful world.

So versus consistent wording. I'm fine with the paragraph you suggested,
but please amend it with something like this:

    If this does not hold, then either the underlying irq chip and the
    related driver need to be investigated.

Thanks,

        tglx
