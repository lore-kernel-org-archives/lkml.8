Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D080AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C66C20776
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590923369;
	bh=FghhYqKlaTRbFKgAaP4e9YXbKVNDOMp4WqJZfCrcChs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O3x04KVrxz2QONwg7OHXXCvuQCKGhqgRjqMolwd9PXCQXb4K61AFqlzGH3M159MAb
	 saAZv0zaSc0uZ7dm7j7o65VbSjh9cBcNhuhzEep8YVi+u+W+ZVeN/lsTAwSRRB9RqG
	 JigotSD96dH9N14UvKFzUDrKHxwEERWNZ61hCGLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgEaLJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 07:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:09:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEEE20707;
        Sun, 31 May 2020 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590923367;
        bh=FghhYqKlaTRbFKgAaP4e9YXbKVNDOMp4WqJZfCrcChs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IHCvLUpDo9Kbt6tA3zFV3vp8NAoz76KPjQ8F7BlWIh0dpViN44diK8Z5tTHo7SyX8
         wl59oa+ZSyaRFiEDkUkV9aVTYm2IASUFOwcAMrLA8nTZAStkJe6DVCYAzNPSuiWF3U
         Wf7NtM0vQDCwpmaW74YoLFmoBmnD3bPKUYi44Zd8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jfLqH-00Gg3Y-Fm; Sun, 31 May 2020 12:09:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 31 May 2020 12:09:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Saidi, Ali" <alisaidi@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
In-Reply-To: <20200530174929.7bf6d5d7@why>
References: <20200529015501.15771-1-alisaidi@amazon.com>
 <8c3be990888ecfb7cca9503853dc4aac@kernel.org>
 <2C4F431F-8140-4C82-B4BD-E51DE618FC08@amazon.com>
 <20200530174929.7bf6d5d7@why>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <eed907d48de84c96e3ceb27c1ed6f622@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alisaidi@amazon.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, benh@amazon.com, dwmw@amazon.co.uk, zeev@amazon.com, zorik@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-30 17:49, Marc Zyngier wrote:
> Hi Ali,
> 
> On Fri, 29 May 2020 12:36:42 +0000
> "Saidi, Ali" <alisaidi@amazon.com> wrote:
> 
>> Hi Marc,
>> 
>> > On May 29, 2020, at 3:33 AM, Marc Zyngier <maz@kernel.org> wrote:
>> >
>> > Hi Ali,
>> >
>> >> On 2020-05-29 02:55, Ali Saidi wrote:
>> >> If an interrupt is disabled the ITS driver has sent a discard removing
>> >> the DeviceID and EventID from the ITT. After this occurs it can't be
>> >> moved to another collection with a MOVI and a command error occurs if
>> >> attempted. Before issuing the MOVI command make sure that the IRQ isn't
>> >> disabled and change the activate code to try and use the previous
>> >> affinity.
>> >>
>> >> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
>> >> ---
>> >> drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
>> >> 1 file changed, 15 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/drivers/irqchip/irq-gic-v3-its.c
>> >> b/drivers/irqchip/irq-gic-v3-its.c
>> >> index 124251b0ccba..1235dd9a2fb2 100644
>> >> --- a/drivers/irqchip/irq-gic-v3-its.c
>> >> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> >> @@ -1540,7 +1540,11 @@ static int its_set_affinity(struct irq_data *d,
>> >> const struct cpumask *mask_val,
>> >>      /* don't set the affinity when the target cpu is same as current one
>> >> */
>> >>      if (cpu != its_dev->event_map.col_map[id]) {
>> >>              target_col = &its_dev->its->collections[cpu];
>> >> -             its_send_movi(its_dev, target_col, id);
>> >> +
>> >> +             /* If the IRQ is disabled a discard was sent so don't move */
>> >> +             if (!irqd_irq_disabled(d))
>> >> +                     its_send_movi(its_dev, target_col, id);
>> >> +
>> >
>> > This looks wrong. What you are testing here is whether the interrupt
>> > is masked, not that there isn't a valid translation.
>> I’m not exactly sure the correct condition, but what I’m looking for
>> is interrupts which are deactivated and we have thus sent a discard.
> 
> That looks like IRQD_IRQ_STARTED not being set in this case.
> 
>> >
>> > In the commit message, you're saying that we've issued a discard.
>> > This hints at doing a set_affinity on an interrupt that has been
>> > deactivated (mapping removed). Is that actually the case? If so,
>> > why was it deactivated
>> > the first place?
>> This is the case. If we down a NIC, that interface’s MSIs will be
>> deactivated but remain allocated until the device is unbound from the
>> driver or the NIC is brought up.
>> 
>> While stressing down/up a device I’ve found that irqbalance can move
>> interrupts and you end up with the situation described. The device is
>> downed, the interrupts are deactivated but still present and then
>> trying to move one results in sending a MOVI after the DISCARD which
>> is an error per the GIC spec.
> 
> Not great indeed. But this is not, as far as I can tell, a GIC
> driver problem.
> 
> The semantic of activate/deactivate (which maps to started/shutdown
> in the IRQ code) is that the HW resources for a given interrupt are
> only committed when the interrupt is activated. Trying to perform
> actions involving the HW on an interrupt that isn't active cannot be
> guaranteed to take effect.
> 
> I'd rather address it in the core code, by preventing set_affinity (and
> potentially others) to take place when the interrupt is not in the
> STARTED state. Userspace would get an error, which is perfectly
> legitimate, and which it already has to deal with it for plenty of 
> other
> reasons.

How about this:

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 453a8a0f4804..1a2ac1392c0f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -147,7 +147,8 @@ cpumask_var_t irq_default_affinity;
  static bool __irq_can_set_affinity(struct irq_desc *desc)
  {
  	if (!desc || !irqd_can_balance(&desc->irq_data) ||
-	    !desc->irq_data.chip || !desc->irq_data.chip->irq_set_affinity)
+	    !desc->irq_data.chip || !desc->irq_data.chip->irq_set_affinity ||
+	    !irqd_is_started(&desc->irq_data))
  		return false;
  	return true;
  }

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
