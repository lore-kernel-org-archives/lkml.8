Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68064C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF392073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBLMzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:55:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLMzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:55:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3944AEA8;
        Wed, 12 Feb 2020 12:55:28 +0000 (UTC)
Message-ID: <99f7237895054dd55ac8a9c8dab24bf36c9cb035.camel@suse.de>
Subject: Re: [PATCH v2] irqchip/bcm2835: Quiesce IRQs left enabled by
 bootloader
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lukas Wunner <lukas@wunner.de>, Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Date:   Wed, 12 Feb 2020 13:55:23 +0100
In-Reply-To: <20200212123651.apio6kno2cqhcskb@wunner.de>
References: <20200212123651.apio6kno2cqhcskb@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4pyIkNRgC0DyWCZW7hzB"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4pyIkNRgC0DyWCZW7hzB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 13:36 +0100, Lukas Wunner wrote:
> On Tue, Feb 11, 2020 at 08:47:05PM -0800, Florian Fainelli wrote:
> > The commit message is a bit long and starts
> > going into details that I am not sure add anything
>=20
> I adhere to the school of thought which holds that commit messages
> shall provide complete context, including numbers to back up claims,
> user-visible impact, affected versions, genesis of the fix and so on.
> By that logic there's no such a thing as a too long commit message.
>=20
> Nevertheless please find a shortened version below, complete with
> the Fixes tag you requested as well as your R-b.
>=20
>=20
> On Wed, Feb 12, 2020 at 08:13:29AM +0000, Marc Zyngier wrote:
> > It otherwise looks good. You can either resend it with a fixed commit
> > message,
> > or provide me with a commit message that I can stick there while applyi=
ng
> > it.
>=20
> The below also contains the patch itself, so can be applied directly
> with git am --scissors.  Feel free to tweak as you see fit.
> Shout if I've missed anything.  Thanks.
>=20
> -- >8 --
> From: Lukas Wunner <lukas@wunner.de>
> Subject: [PATCH] irqchip/bcm2835: Quiesce IRQs left enabled by bootloader
>=20
> Per the spec, the BCM2835's IRQs are all disabled when coming out of
> power-on reset.  Its IRQ driver assumes that's still the case when the
> kernel boots and does not perform any initialization of the registers.
> However the Raspberry Pi Foundation's bootloader leaves the USB
> interrupt enabled when handing over control to the kernel.
>=20
> Quiesce IRQs and the FIQ if they were left enabled and log a message to
> let users know that they should update the bootloader once a fixed
> version is released.
>=20
> If the USB interrupt is not quiesced and the USB driver later on claims
> the FIQ (as it does on the Raspberry Pi Foundation's downstream kernel),
> interrupt latency for all other peripherals increases and occasional
> lockups occur.  That's because both the FIQ and the normal USB interrupt
> fire simultaneously.
>=20
> On a multicore Raspberry Pi, if normal interrupts are routed to CPU 0
> and the FIQ to CPU 1 (hardcoded in the Foundation's kernel), then a USB
> interrupt causes CPU 0 to spin in bcm2836_chained_handle_irq() until the
> FIQ on CPU 1 has cleared it.  Other peripherals' interrupts are starved
> as long.  I've seen CPU 0 blocked for up to 2.9 msec.  eMMC throughput
> on a Compute Module 3 irregularly dips to 23.0 MB/s without this commit
> but remains relatively constant at 23.5 MB/s with this commit.
>=20
> The lockups occur when CPU 0 receives a USB interrupt while holding a
> lock which CPU 1 is trying to acquire while the FIQ is temporarily
> disabled on CPU 1.  At best users get RCU CPU stall warnings, but most
> of the time the system just freezes.
>=20
> Fixes: 89214f009c1d ("ARM: bcm2835: add interrupt controller driver")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: stable@vger.kernel.org # v3.7+
> Cc: Serge Schneider <serge@raspberrypi.org>
> Cc: Kristina Brooks <notstina@gmail.com>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

> ---
>  drivers/irqchip/irq-bcm2835.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.=
c
> index 418245d..eca9ac7 100644
> --- a/drivers/irqchip/irq-bcm2835.c
> +++ b/drivers/irqchip/irq-bcm2835.c
> @@ -135,6 +135,7 @@ static int __init armctrl_of_init(struct device_node
> *node,
>  {
>  	void __iomem *base;
>  	int irq, b, i;
> +	u32 reg;
> =20
>  	base =3D of_iomap(node, 0);
>  	if (!base)
> @@ -157,6 +158,19 @@ static int __init armctrl_of_init(struct device_node
> *node,
>  				handle_level_irq);
>  			irq_set_probe(irq);
>  		}
> +
> +		reg =3D readl_relaxed(intc.enable[b]);
> +		if (reg) {
> +			writel_relaxed(reg, intc.disable[b]);
> +			pr_err(FW_BUG "Bootloader left irq enabled: "
> +			       "bank %d irq %*pbl\n", b, IRQS_PER_BANK, &reg);
> +		}
> +	}
> +
> +	reg =3D readl_relaxed(base + REG_FIQ_CONTROL);
> +	if (reg & REG_FIQ_ENABLE) {
> +		writel_relaxed(0, base + REG_FIQ_CONTROL);
> +		pr_err(FW_BUG "Bootloader left fiq enabled\n");
>  	}
> =20
>  	if (is_2836) {


--=-4pyIkNRgC0DyWCZW7hzB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5D9bsACgkQlfZmHno8
x/6JvwgAjF0lgwGkDLzNHbL6ctrZ6WikqYyRPEJ5WcwqCtqiGQtvs4QRF/FSoSOy
NHX/FJkM5uUDUytjusv5njqeKxzZVRmwFRdA+KRIiHRsi86bewGOluXG65xYl4G2
tA93LYAEL9C/7tmgeJhNOXjYhhM6aEkEe2ou8zUnMVeJT3z0dmur04L2imqDjSM1
Mg/sigcZdt+Pzdlj3AnI/eXwzT+3WuIA6BVd0MhKs9lGU8xKGTR4dgDSmAWO+FHi
rrishM5LJ3eEuAXlUWqIKgCvnIvdQELDb1bq+6+M/U1k8j5w0QOeu9yHBZhFkEXv
rfXZ3IlEk/vxRajBVaVzkkvB0KhufA==
=Mq7O
-----END PGP SIGNATURE-----

--=-4pyIkNRgC0DyWCZW7hzB--

