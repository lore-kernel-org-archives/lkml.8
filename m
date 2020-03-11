Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from Galois.linutronix.de ([193.142.43.55]:38788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgCKPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:43:29 -0400
From: Thomas Gleixner <tglx@linutronix.de>
To: Tim Harvey <tharvey@gateworks.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v8 07/14] gpio: thunderx: Use the default parent apis for {request,release}_resources
In-Reply-To: <CAJ+vNU2gnKKxX2YL1JUSnpF7qNqKVAsPhC2emv=Y79HPJbZXzw@mail.gmail.com>
References: <20190430101230.21794-1-lokeshvutla@ti.com> <20190430101230.21794-8-lokeshvutla@ti.com> <CAJ+vNU2gnKKxX2YL1JUSnpF7qNqKVAsPhC2emv=Y79HPJbZXzw@mail.gmail.com>
Date: Wed, 11 Mar 2020 16:43:18 +0100
Message-ID: <87zhcmkicp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tim,

Tim Harvey <tharvey@gateworks.com> writes:
> On Tue, Apr 30, 2019 at 3:14 AM Lokesh Vutla <lokeshvutla@ti.com> wrote:
>> -       if (parent_data && parent_data->chip->irq_request_resources) {
>> -               r = parent_data->chip->irq_request_resources(parent_data);
>> -               if (r)
>> -                       goto error;
>> -       }
>> +       r = irq_chip_request_resources_parent(data);
>> +       if (r)
>> +               gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
>
> This patch breaks irq resources for thunderx-gpio as
> parent_data->chip->irq_request_resources is undefined thus your new
> irq_chip_request_resources_parent() returns -ENOSYS causing this
> function to return an error where as before it would happily return 0.
>
> Is the following the correct fix or should we qualify
> data->parent_data->chip->irq_request_resources before calling
> irq_chip_request_resources_parent() in thunderx-gpio?

You are not supposed to fiddle with parent data at all. Just because C
allows you is no excuse to violate abstractions in the first place.

irq_chip_request_resources_parent() rightfully returns -ENOSYS when it
can't request a resource from the parent chip because that chip does not
have anything to offer.

It's up to the caller to do something sensible with the return code. If
your chip is happy with the parent not providing it then handle
-ENOSYS. None of the chip callbacks should return -ENOSYS. If one does
then that wants to be fixed.

Thanks,

        tglx


