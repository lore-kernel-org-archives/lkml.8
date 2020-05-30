Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2D6207D5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590857374;
	bh=YWheN8pRzzh5on2sRrgHuSvShRln/nsEjRo8kYtNcBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wTDBJqOyqyKVKOejwKGbL8lhX+CAN86wHAD0/0XdvmI1rz0Jg8NppD4bCeArWhln2
	 mPoZPgNgxxXKS7Yf+/XAZFwnGvfyZqkfNpfeuXnWe6cQZ761IgZPd67vrJsksX++GL
	 vMIhTtAkbd6iixhM+41ArCboJybIvVbF6XKDae/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgE3Qtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgE3Qtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:49:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C111D20723;
        Sat, 30 May 2020 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590857372;
        bh=YWheN8pRzzh5on2sRrgHuSvShRln/nsEjRo8kYtNcBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OhwXPkc5TFFi2g6RwCC8UmPtBMmQjX4EGvFhkHd9zu6B/NO9LADHV8avNBKM6xjnh
         VBUKpxEF1ZPnsC/dkOs1H+dx0XPy4QECu/9rBML77iuq/5m09uE4UH2SADgQKbFNQI
         AtQYHsjZh6fczpsFVcXRw67kT1Bxu//MFCWcuGT8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jf4fr-00GZ2c-4m; Sat, 30 May 2020 17:49:31 +0100
Date:   Sat, 30 May 2020 17:49:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Saidi, Ali" <alisaidi@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Message-ID: <20200530174929.7bf6d5d7@why>
In-Reply-To: <2C4F431F-8140-4C82-B4BD-E51DE618FC08@amazon.com>
References: <20200529015501.15771-1-alisaidi@amazon.com>
        <8c3be990888ecfb7cca9503853dc4aac@kernel.org>
        <2C4F431F-8140-4C82-B4BD-E51DE618FC08@amazon.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alisaidi@amazon.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, benh@amazon.com, dwmw@amazon.co.uk, zeev@amazon.com, zorik@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On Fri, 29 May 2020 12:36:42 +0000
"Saidi, Ali" <alisaidi@amazon.com> wrote:

> Hi Marc,
>=20
> > On May 29, 2020, at 3:33 AM, Marc Zyngier <maz@kernel.org> wrote:
> >=20
> > Hi Ali,
> >  =20
> >> On 2020-05-29 02:55, Ali Saidi wrote:
> >> If an interrupt is disabled the ITS driver has sent a discard removing
> >> the DeviceID and EventID from the ITT. After this occurs it can't be
> >> moved to another collection with a MOVI and a command error occurs if
> >> attempted. Before issuing the MOVI command make sure that the IRQ isn't
> >> disabled and change the activate code to try and use the previous
> >> affinity.
> >>=20
> >> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> >> ---
> >> drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
> >> 1 file changed, 15 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> >> b/drivers/irqchip/irq-gic-v3-its.c
> >> index 124251b0ccba..1235dd9a2fb2 100644
> >> --- a/drivers/irqchip/irq-gic-v3-its.c
> >> +++ b/drivers/irqchip/irq-gic-v3-its.c
> >> @@ -1540,7 +1540,11 @@ static int its_set_affinity(struct irq_data *d,
> >> const struct cpumask *mask_val,
> >>      /* don't set the affinity when the target cpu is same as current =
one
> >> */
> >>      if (cpu !=3D its_dev->event_map.col_map[id]) {
> >>              target_col =3D &its_dev->its->collections[cpu];
> >> -             its_send_movi(its_dev, target_col, id);
> >> +
> >> +             /* If the IRQ is disabled a discard was sent so don't mo=
ve */
> >> +             if (!irqd_irq_disabled(d))
> >> +                     its_send_movi(its_dev, target_col, id);
> >> + =20
> >=20
> > This looks wrong. What you are testing here is whether the interrupt
> > is masked, not that there isn't a valid translation. =20
> I=E2=80=99m not exactly sure the correct condition, but what I=E2=80=99m =
looking for
> is interrupts which are deactivated and we have thus sent a discard.=20

That looks like IRQD_IRQ_STARTED not being set in this case.

> >=20
> > In the commit message, you're saying that we've issued a discard.
> > This hints at doing a set_affinity on an interrupt that has been
> > deactivated (mapping removed). Is that actually the case? If so,
> > why was it deactivated
> > the first place? =20
> This is the case. If we down a NIC, that interface=E2=80=99s MSIs will be
> deactivated but remain allocated until the device is unbound from the
> driver or the NIC is brought up.=20
>=20
> While stressing down/up a device I=E2=80=99ve found that irqbalance can m=
ove
> interrupts and you end up with the situation described. The device is
> downed, the interrupts are deactivated but still present and then
> trying to move one results in sending a MOVI after the DISCARD which
> is an error per the GIC spec.=20

Not great indeed. But this is not, as far as I can tell, a GIC
driver problem.

The semantic of activate/deactivate (which maps to started/shutdown
in the IRQ code) is that the HW resources for a given interrupt are
only committed when the interrupt is activated. Trying to perform
actions involving the HW on an interrupt that isn't active cannot be
guaranteed to take effect.

I'd rather address it in the core code, by preventing set_affinity (and
potentially others) to take place when the interrupt is not in the
STARTED state. Userspace would get an error, which is perfectly
legitimate, and which it already has to deal with it for plenty of other
reasons.

>=20
> >  =20
> >>              its_dev->event_map.col_map[id] =3D cpu;
> >>              irq_data_update_effective_affinity(d,
> >> cpumask_of(cpu)); }
> >> @@ -3439,8 +3443,16 @@ static int its_irq_domain_activate(struct
> >> irq_domain *domain,
> >>      if (its_dev->its->numa_node >=3D 0)
> >>              cpu_mask =3D cpumask_of_node(its_dev->its->numa_node);
> >>=20
> >> -     /* Bind the LPI to the first possible CPU */
> >> -     cpu =3D cpumask_first_and(cpu_mask, cpu_online_mask);
> >> +     /* If the cpu set to a different CPU that is still online
> >> use it */
> >> +     cpu =3D its_dev->event_map.col_map[event];
> >> +
> >> +     cpumask_and(cpu_mask, cpu_mask, cpu_online_mask);
> >> +
> >> +     if (!cpumask_test_cpu(cpu, cpu_mask)) {
> >> +             /* Bind the LPI to the first possible CPU */
> >> +             cpu =3D cpumask_first(cpu_mask);
> >> +     }
> >> +
> >>      if (cpu >=3D nr_cpu_ids) {
> >>              if (its_dev->its->flags &
> >> ITS_FLAGS_WORKAROUND_CAVIUM_23144) return -EINVAL; =20
> >=20
> > So you deactivate an interrupt, do a set_affinity that doesn't issue
> > a MOVI but preserves the affinity, then reactivate it and hope that
> > the new mapping will target the "right" CPU.
> >=20
> > That seems a bit mad, but I presume this isn't the whole story... =20
> Doing some experiments it appears as though other interrupts
> controllers do preserve affinity across deactivate/activate, so this
> is my attempt at doing the same.=20

I believe this is only an artefact of these other controllers not
requiring any resource to be committed into the HW (SPIs wouldn't care,
for example).

Thanks,

	M.
--=20
Jazz is not dead. It just smells funny...
