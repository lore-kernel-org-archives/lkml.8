Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45429 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgCKQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:09:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so2530316otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190430101230.21794-1-lokeshvutla@ti.com> <20190430101230.21794-8-lokeshvutla@ti.com>
 <CAJ+vNU2gnKKxX2YL1JUSnpF7qNqKVAsPhC2emv=Y79HPJbZXzw@mail.gmail.com> <87zhcmkicp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zhcmkicp.fsf@nanos.tec.linutronix.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 11 Mar 2020 09:09:43 -0700
Message-ID: <CAJ+vNU2agPYq+Y3kXG40wcfUzA9q-27Cdvqj7gLT2o6RKCQK5Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] gpio: thunderx: Use the default parent apis for {request,release}_resources
To: Thomas Gleixner <tglx@linutronix.de>,
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 11, 2020 at 8:43 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Tim,
>
> Tim Harvey <tharvey@gateworks.com> writes:
> > On Tue, Apr 30, 2019 at 3:14 AM Lokesh Vutla <lokeshvutla@ti.com> wrote:
> >> -       if (parent_data && parent_data->chip->irq_request_resources) {
> >> -               r = parent_data->chip->irq_request_resources(parent_data);
> >> -               if (r)
> >> -                       goto error;
> >> -       }
> >> +       r = irq_chip_request_resources_parent(data);
> >> +       if (r)
> >> +               gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
> >
> > This patch breaks irq resources for thunderx-gpio as
> > parent_data->chip->irq_request_resources is undefined thus your new
> > irq_chip_request_resources_parent() returns -ENOSYS causing this
> > function to return an error where as before it would happily return 0.
> >
> > Is the following the correct fix or should we qualify
> > data->parent_data->chip->irq_request_resources before calling
> > irq_chip_request_resources_parent() in thunderx-gpio?
>
> You are not supposed to fiddle with parent data at all. Just because C
> allows you is no excuse to violate abstractions in the first place.
>
> irq_chip_request_resources_parent() rightfully returns -ENOSYS when it
> can't request a resource from the parent chip because that chip does not
> have anything to offer.
>
> It's up to the caller to do something sensible with the return code. If
> your chip is happy with the parent not providing it then handle
> -ENOSYS. None of the chip callbacks should return -ENOSYS. If one does
> then that wants to be fixed.
>

Ok, makes sense. Thank you and Lokesh for the feedback. I just
submitted a patch to fix the thunderx-gpio breakage.

Best Regards,

Tim

