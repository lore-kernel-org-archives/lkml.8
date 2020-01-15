Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFFC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBC5222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="XI99Ek+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgAON5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:57:22 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45014 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbgAON5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579096636; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGIQZT647dLPuh5EteOzSUzs4uLjGYYYagATX7iSVV8=;
        b=XI99Ek+CdlOiftKW9gqWMLaZalIdz5VcxgYXNusBe8c3FZvWVg9xQ0/frNwEpBPypnco8d
        gYMOWBIcqrdL840W5DKFh6ImA/OAcxIKouCQSfc2j0Z0WJ2/c+qaO4cG8XsjU9v5Eogfxu
        ObSAvSK7FwdqhCE+Qv8m0csbH9+nVHk=
Date:   Wed, 15 Jan 2020 10:57:01 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, od@zcrc.me,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1579096621.3.0@crapouillou.net>
In-Reply-To: <8026844b-75d2-edfb-c3ed-fdabd34a9aa0@linaro.org>
References: <20200114150619.14611-1-paul@crapouillou.net>
        <8026844b-75d2-edfb-c3ed-fdabd34a9aa0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano=20
<daniel.lezcano@linaro.org> a =C3=A9crit :
> On 14/01/2020 16:06, Paul Cercueil wrote:
>>  From: Maarten ter Huurne <maarten@treewalker.org>
>>=20
>>  OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>=20
>>  SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>>  JZ4780 have a 64-bit OST.
>>=20
>>  This driver will register both a clocksource and a sched_clock to=20
>> the
>>  system.
>=20
> Is the JZ47xx OST really a mfd needing a regmap? (Note regmap_read=20
> will
> take a lock).

Yes, the TCU_REG_OST_TCSR register is shared with the clocks driver.

- Paul


>=20
>>  Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>=20
>>  Notes:
>>      v2: local_irq_save/restore were moved within=20
>> sched_clock_register
>>      v3: Only register as 32-bit clocksource to simplify things
>>=20
>>   drivers/clocksource/Kconfig       |   8 ++
>>   drivers/clocksource/Makefile      |   1 +
>>   drivers/clocksource/ingenic-ost.c | 183=20
>> ++++++++++++++++++++++++++++++
>>   3 files changed, 192 insertions(+)
>>   create mode 100644 drivers/clocksource/ingenic-ost.c
>>=20
>>  diff --git a/drivers/clocksource/Kconfig=20
>> b/drivers/clocksource/Kconfig
>>  index 5fdd76cb1768..5be2f876f64f 100644
>>  --- a/drivers/clocksource/Kconfig
>>  +++ b/drivers/clocksource/Kconfig
>>  @@ -697,4 +697,12 @@ config INGENIC_TIMER
>>   	help
>>   	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>>=20
>>  +config INGENIC_OST
>>  +	bool "Ingenic JZ47xx Operating System Timer"
>>  +	depends on MIPS || COMPILE_TEST
>>  +	depends on COMMON_CLK
>>  +	select MFD_SYSCON
>>  +	help
>>  +	  Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
>>  +
>>   endmenu
>>  diff --git a/drivers/clocksource/Makefile=20
>> b/drivers/clocksource/Makefile
>>  index 4dfe4225ece7..6bc97a6fd229 100644
>>  --- a/drivers/clocksource/Makefile
>>  +++ b/drivers/clocksource/Makefile
>>  @@ -80,6 +80,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+=3D asm9260_timer.o
>>   obj-$(CONFIG_H8300_TMR8)		+=3D h8300_timer8.o
>>   obj-$(CONFIG_H8300_TMR16)		+=3D h8300_timer16.o
>>   obj-$(CONFIG_H8300_TPU)			+=3D h8300_tpu.o
>>  +obj-$(CONFIG_INGENIC_OST)		+=3D ingenic-ost.o
>>   obj-$(CONFIG_INGENIC_TIMER)		+=3D ingenic-timer.o
>>   obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
>>   obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
>>  diff --git a/drivers/clocksource/ingenic-ost.c=20
>> b/drivers/clocksource/ingenic-ost.c
>>  new file mode 100644
>>  index 000000000000..2c91e3b34572
>>  --- /dev/null
>>  +++ b/drivers/clocksource/ingenic-ost.c
>>  @@ -0,0 +1,183 @@
>>  +// SPDX-License-Identifier: GPL-2.0
>>  +/*
>>  + * JZ47xx SoCs TCU Operating System Timer driver
>>  + *
>>  + * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
>>  + * Copyright (C) 2020 Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/clk.h>
>>  +#include <linux/clocksource.h>
>>  +#include <linux/mfd/ingenic-tcu.h>
>>  +#include <linux/mfd/syscon.h>
>>  +#include <linux/of.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/pm.h>
>>  +#include <linux/regmap.h>
>>  +#include <linux/sched_clock.h>
>>  +
>>  +#define TCU_OST_TCSR_MASK	0xffc0
>>  +#define TCU_OST_TCSR_CNT_MD	BIT(15)
>>  +
>>  +#define TCU_OST_CHANNEL		15
>>  +
>>  +struct ingenic_ost_soc_info {
>>  +	bool is64bit;
>>  +};
>>  +
>>  +struct ingenic_ost {
>>  +	struct regmap *map;
>>  +	struct clk *clk;
>>  +
>>  +	struct clocksource cs;
>>  +};
>>  +
>>  +static struct ingenic_ost *ingenic_ost;
>>  +
>>  +static u64 notrace ingenic_ost_read_cntl(void)
>>  +{
>>  +	u32 val;
>>  +
>>  +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val);
>>  +
>>  +	return val;
>>  +}
>>  +
>>  +static u64 notrace ingenic_ost_read_cnth(void)
>>  +{
>>  +	u32 val;
>>  +
>>  +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTH, &val);
>>  +
>>  +	return val;
>>  +}
>>  +
>>  +static u64 notrace ingenic_ost_clocksource_readl(struct=20
>> clocksource *cs)
>>  +{
>>  +	return ingenic_ost_read_cntl();
>>  +}
>>  +
>>  +static u64 notrace ingenic_ost_clocksource_readh(struct=20
>> clocksource *cs)
>>  +{
>>  +	return ingenic_ost_read_cnth();
>>  +}
>>  +
>>  +static int __init ingenic_ost_probe(struct platform_device *pdev)
>>  +{
>>  +	const struct ingenic_ost_soc_info *soc_info;
>>  +	struct device *dev =3D &pdev->dev;
>>  +	struct ingenic_ost *ost;
>>  +	struct clocksource *cs;
>>  +	unsigned long rate;
>>  +	int err;
>>  +
>>  +	soc_info =3D device_get_match_data(dev);
>>  +	if (!soc_info)
>>  +		return -EINVAL;
>>  +
>>  +	ost =3D devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
>>  +	if (!ost)
>>  +		return -ENOMEM;
>>  +
>>  +	ingenic_ost =3D ost;
>>  +
>>  +	ost->map =3D device_node_to_regmap(dev->parent->of_node);
>>  +	if (!ost->map) {
>>  +		dev_err(dev, "regmap not found\n");
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	ost->clk =3D devm_clk_get(dev, "ost");
>>  +	if (IS_ERR(ost->clk))
>>  +		return PTR_ERR(ost->clk);
>>  +
>>  +	err =3D clk_prepare_enable(ost->clk);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	/* Clear counter high/low registers */
>>  +	if (soc_info->is64bit)
>>  +		regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
>>  +	regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
>>  +
>>  +	/* Don't reset counter at compare value. */
>>  +	regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
>>  +			   TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
>>  +
>>  +	rate =3D clk_get_rate(ost->clk);
>>  +
>>  +	/* Enable OST TCU channel */
>>  +	regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
>>  +
>>  +	cs =3D &ost->cs;
>>  +	cs->name	=3D "ingenic-ost";
>>  +	cs->rating	=3D 320;
>>  +	cs->flags	=3D CLOCK_SOURCE_IS_CONTINUOUS;
>>  +	cs->mask	=3D CLOCKSOURCE_MASK(32);
>>  +
>>  +	if (soc_info->is64bit)
>>  +		cs->read =3D ingenic_ost_clocksource_readl;
>>  +	else
>>  +		cs->read =3D ingenic_ost_clocksource_readh;
>>  +
>>  +	err =3D clocksource_register_hz(cs, rate);
>>  +	if (err) {
>>  +		dev_err(dev, "clocksource registration failed: %d\n", err);
>>  +		clk_disable_unprepare(ost->clk);
>>  +		return err;
>>  +	}
>>  +
>>  +	if (soc_info->is64bit)
>>  +		sched_clock_register(ingenic_ost_read_cntl, 32, rate);
>>  +	else
>>  +		sched_clock_register(ingenic_ost_read_cnth, 32, rate);
>>  +	return 0;
>>  +}
>>  +
>>  +static int __maybe_unused ingenic_ost_suspend(struct device *dev)
>>  +{
>>  +	struct ingenic_ost *ost =3D dev_get_drvdata(dev);
>>  +
>>  +	clk_disable(ost->clk);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int __maybe_unused ingenic_ost_resume(struct device *dev)
>>  +{
>>  +	struct ingenic_ost *ost =3D dev_get_drvdata(dev);
>>  +
>>  +	return clk_enable(ost->clk);
>>  +}
>>  +
>>  +static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops =3D=20
>> {
>>  +	/* _noirq: We want the OST clock to be gated last / ungated first=20
>> */
>>  +	.suspend_noirq =3D ingenic_ost_suspend,
>>  +	.resume_noirq  =3D ingenic_ost_resume,
>>  +};
>>  +
>>  +static const struct ingenic_ost_soc_info jz4725b_ost_soc_info =3D {
>>  +	.is64bit =3D false,
>>  +};
>>  +
>>  +static const struct ingenic_ost_soc_info jz4770_ost_soc_info =3D {
>>  +	.is64bit =3D true,
>>  +};
>>  +
>>  +static const struct of_device_id ingenic_ost_of_match[] =3D {
>>  +	{ .compatible =3D "ingenic,jz4725b-ost", .data =3D=20
>> &jz4725b_ost_soc_info, },
>>  +	{ .compatible =3D "ingenic,jz4770-ost", .data =3D=20
>> &jz4770_ost_soc_info, },
>>  +	{ }
>>  +};
>>  +
>>  +static struct platform_driver ingenic_ost_driver =3D {
>>  +	.driver =3D {
>>  +		.name =3D "ingenic-ost",
>>  +#ifdef CONFIG_PM_SUSPEND
>>  +		.pm =3D &ingenic_ost_pm_ops,
>>  +#endif
>>  +		.of_match_table =3D ingenic_ost_of_match,
>>  +	},
>>  +};
>>  +builtin_platform_driver_probe(ingenic_ost_driver,=20
>> ingenic_ost_probe);
>>=20
>=20
>=20
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM=20
> SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20

=

