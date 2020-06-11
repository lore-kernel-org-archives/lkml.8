Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D9B2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WKWFOzB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFKWVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:21:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43524 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1591914086; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4VrZUb1l8jGB29Y9MOdyeY/lzHVeVpEQw+G1O6gu+w=;
        b=WKWFOzB6GZ92EEhyewBpQ5pQx4XWWWqrL3+kGNsmlVegRZOqXFppx5aaBc/mPGtUdrAZ+K
        2P8v8yg/KnYdiMUtvZu3M3G1vJJ87xlt+MU99kW7HLzrcE0U+Te4i/lgSjsYkgGV9rvEHC
        BAmWGDVoiOnUjDl0j3cQbo23GPBj4qU=
Date:   Fri, 12 Jun 2020 00:21:15 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v7 4/5] remoteproc: ingenic: Added remoteproc driver
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Message-Id: <FR8SBQ.5WXNHNH8P2P7@crapouillou.net>
In-Reply-To: <8cdcf5ef-1268-89f6-b229-ac711a80b790@ti.com>
References: <20200515104340.10473-1-paul@crapouillou.net>
        <20200515104340.10473-4-paul@crapouillou.net>
        <8cdcf5ef-1268-89f6-b229-ac711a80b790@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

Le jeu. 11 juin 2020 =E0 16:47, Suman Anna <s-anna@ti.com> a =E9crit :
> Hi Paul,
>=20
> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>> This driver is used to boot, communicate with and load firmwares to=20
>> the
>> MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
>> Ingenic.
>=20
> I have a few comments w.r.t pm_runtime usage in this driver.
>=20
>>=20
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>=20
>> Notes:
>>      v2: Remove exception for always-mapped memories
>>      v3: - Use clk_bulk API
>>      	- Move device-managed code to its own patch [3/4]
>>      	- Move devicetree table right above ingenic_rproc_driver
>>      	- Removed #ifdef CONFIG_OF around devicetree table
>>      	- Removed .owner =3D THIS_MODULE in ingenic_rproc_driver
>>      	- Removed useless platform_set_drvdata()
>>      v4: - Add fix reported by Julia
>>      	- Change Kconfig symbol to INGENIC_VPU_RPROC
>>      	- Add documentation to struct vpu
>>      	- disable_irq_nosync() -> disable_irq()
>>      v5: No change
>>      v6: Instead of prepare/unprepare callbacks, use PM runtime=20
>> callbacks
>>      v7: - Remove use of of_match_ptr()
>>      	- Move Kconfig symbol so that it's in alphabetical order
>>      	- Add missing doc for private structure field aux_base
>>      	- Don't check for (len <=3D 0) in da_to_va()
>>      	- Add missing \n in dev_info/dev_err messages
>>=20
>>   drivers/remoteproc/Kconfig         |   9 +
>>   drivers/remoteproc/Makefile        |   1 +
>>   drivers/remoteproc/ingenic_rproc.c | 280=20
>> +++++++++++++++++++++++++++++
>>   3 files changed, 290 insertions(+)
>>   create mode 100644 drivers/remoteproc/ingenic_rproc.c
>>=20
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index fbaed079b299..c4d1731295eb 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -23,6 +23,15 @@ config IMX_REMOTEPROC
>>   =7F  	  It's safe to say N here.
>>   =7F+config INGENIC_VPU_RPROC
>> +	tristate "Ingenic JZ47xx VPU remoteproc support"
>> +	depends on MIPS || COMPILE_TEST
>> +	help
>> +	  Say y or m here to support the VPU in the JZ47xx SoCs from=20
>> Ingenic.
>> +
>> +	  This can be either built-in or a loadable module.
>> +	  If unsure say N.
>> +
>>   config MTK_SCP
>>   	tristate "Mediatek SCP support"
>>   	depends on ARCH_MEDIATEK
>> diff --git a/drivers/remoteproc/Makefile=20
>> b/drivers/remoteproc/Makefile
>> index 0effd3825035..e8b886e511f0 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -10,6 +10,7 @@ remoteproc-y				+=3D remoteproc_sysfs.o
>>   remoteproc-y				+=3D remoteproc_virtio.o
>>   remoteproc-y				+=3D remoteproc_elf_loader.o
>>   obj-$(CONFIG_IMX_REMOTEPROC)		+=3D imx_rproc.o
>> +obj-$(CONFIG_INGENIC_VPU_RPROC)		+=3D ingenic_rproc.o
>>   obj-$(CONFIG_MTK_SCP)			+=3D mtk_scp.o mtk_scp_ipi.o
>>   obj-$(CONFIG_OMAP_REMOTEPROC)		+=3D omap_remoteproc.o
>>   obj-$(CONFIG_WKUP_M3_RPROC)		+=3D wkup_m3_rproc.o
>> diff --git a/drivers/remoteproc/ingenic_rproc.c=20
>> b/drivers/remoteproc/ingenic_rproc.c
>> new file mode 100644
>> index 000000000000..189020d77b25
>> --- /dev/null
>> +++ b/drivers/remoteproc/ingenic_rproc.c
>> @@ -0,0 +1,280 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Ingenic JZ47xx remoteproc driver
>> + * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/remoteproc.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +#define REG_AUX_CTRL		0x0
>> +#define REG_AUX_MSG_ACK		0x10
>> +#define REG_AUX_MSG		0x14
>> +#define REG_CORE_MSG_ACK	0x18
>> +#define REG_CORE_MSG		0x1C
>> +
>> +#define AUX_CTRL_SLEEP		BIT(31)
>> +#define AUX_CTRL_MSG_IRQ_EN	BIT(3)
>> +#define AUX_CTRL_NMI_RESETS	BIT(2)
>> +#define AUX_CTRL_NMI		BIT(1)
>> +#define AUX_CTRL_SW_RESET	BIT(0)
>> +
>> +struct vpu_mem_map {
>> +	const char *name;
>> +	unsigned int da;
>> +};
>> +
>> +struct vpu_mem_info {
>> +	const struct vpu_mem_map *map;
>> +	unsigned long len;
>> +	void __iomem *base;
>> +};
>> +
>> +static const struct vpu_mem_map vpu_mem_map[] =3D {
>> +	{ "tcsm0", 0x132b0000 },
>> +	{ "tcsm1", 0xf4000000 },
>> +	{ "sram",  0x132f0000 },
>> +};
>> +
>> +/**
>> + * struct vpu - Ingenic VPU remoteproc private structure
>> + * @irq: interrupt number
>> + * @clks: pointers to the VPU and AUX clocks
>> + * @aux_base: raw pointer to the AUX interface registers
>> + * @mem_info: array of struct vpu_mem_info, which contain the=20
>> mapping info of
>> + *            each of the external memories
>> + * @dev: private pointer to the device
>> + */
>> +struct vpu {
>> +	int irq;
>> +	struct clk_bulk_data clks[2];
>> +	void __iomem *aux_base;
>> +	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
>> +	struct device *dev;
>> +};
>> +
>> +static int ingenic_rproc_start(struct rproc *rproc)
>> +{
>> +	struct vpu *vpu =3D rproc->priv;
>> +	u32 ctrl;
>> +
>> +	enable_irq(vpu->irq);
>> +
>> +	/* Reset the AUX and enable message IRQ */
>> +	ctrl =3D AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN;
>> +	writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ingenic_rproc_stop(struct rproc *rproc)
>> +{
>> +	struct vpu *vpu =3D rproc->priv;
>> +
>> +	disable_irq(vpu->irq);
>> +
>> +	/* Keep AUX in reset mode */
>> +	writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
>> +{
>> +	struct vpu *vpu =3D rproc->priv;
>> +
>> +	writel(vqid, vpu->aux_base + REG_CORE_MSG);
>> +}
>> +
>> +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da,=20
>> size_t len)
>> +{
>> +	struct vpu *vpu =3D rproc->priv;
>> +	void __iomem *va =3D NULL;
>> +	unsigned int i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>> +		const struct vpu_mem_info *info =3D &vpu->mem_info[i];
>> +		const struct vpu_mem_map *map =3D info->map;
>> +
>> +		if (da >=3D map->da && (da + len) < (map->da + info->len)) {
>> +			va =3D info->base + (da - map->da);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return (__force void *)va;
>> +}
>> +
>> +static struct rproc_ops ingenic_rproc_ops =3D {
>> +	.start =3D ingenic_rproc_start,
>> +	.stop =3D ingenic_rproc_stop,
>> +	.kick =3D ingenic_rproc_kick,
>> +	.da_to_va =3D ingenic_rproc_da_to_va,
>> +};
>> +
>> +static irqreturn_t vpu_interrupt(int irq, void *data)
>> +{
>> +	struct rproc *rproc =3D data;
>> +	struct vpu *vpu =3D rproc->priv;
>> +	u32 vring;
>> +
>> +	vring =3D readl(vpu->aux_base + REG_AUX_MSG);
>> +
>> +	/* Ack the interrupt */
>> +	writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
>> +
>> +	return rproc_vq_interrupt(rproc, vring);
>> +}
>> +
>> +static void ingenic_rproc_disable_clks(void *data)
>> +{
>> +	struct vpu *vpu =3D data;
>> +
>> +	pm_runtime_resume(vpu->dev);
>> +	pm_runtime_disable(vpu->dev);
>> +
>> +	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
>> +}
>> +
>> +static int ingenic_rproc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct resource *mem;
>> +	struct rproc *rproc;
>> +	struct vpu *vpu;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	rproc =3D devm_rproc_alloc(dev, "ingenic-vpu",
>> +				 &ingenic_rproc_ops, NULL, sizeof(*vpu));
>> +	if (!rproc)
>> +		return -ENOMEM;
>> +
>> +	vpu =3D rproc->priv;
>> +	vpu->dev =3D &pdev->dev;
>> +	platform_set_drvdata(pdev, vpu);
>> +
>> +	mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
>> +	vpu->aux_base =3D devm_ioremap_resource(dev, mem);
>> +	if (IS_ERR(vpu->aux_base)) {
>> +		dev_err(dev, "Failed to ioremap\n");
>> +		return PTR_ERR(vpu->aux_base);
>> +	}
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>> +		mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +						   vpu_mem_map[i].name);
>> +
>> +		vpu->mem_info[i].base =3D devm_ioremap_resource(dev, mem);
>> +		if (IS_ERR(vpu->mem_info[i].base)) {
>> +			ret =3D PTR_ERR(vpu->mem_info[i].base);
>> +			dev_err(dev, "Failed to ioremap\n");
>> +			return ret;
>> +		}
>> +
>> +		vpu->mem_info[i].len =3D resource_size(mem);
>> +		vpu->mem_info[i].map =3D &vpu_mem_map[i];
>> +	}
>> +
>> +	vpu->clks[0].id =3D "vpu";
>> +	vpu->clks[1].id =3D "aux";
>> +
>> +	ret =3D devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks), vpu->clks);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get clocks\n");
>> +		return ret;
>> +	}
>> +
>> +	vpu->irq =3D platform_get_irq(pdev, 0);
>> +	if (vpu->irq < 0)
>> +		return vpu->irq;
>> +
>> +	ret =3D devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, "VPU",=20
>> rproc);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to request IRQ\n");
>> +		return ret;
>> +	}
>> +
>> +	disable_irq(vpu->irq);
>> +
>> +	/* The clocks must be enabled for the firmware to be loaded in=20
>> TCSM */
>> +	ret =3D clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
>> +	if (ret) {
>> +		dev_err(dev, "Unable to start clocks\n");
>> +		return ret;
>> +	}
>=20
> You are enabling the clocks directly here and also trying to manage=20
> them through pm_runtime callbacks again.

Yes. The clocks need to be enabled in the probe.

>> +
>> +	pm_runtime_irq_safe(dev);
>=20
> Nothing wrong with this, but this does take an additional reference=20
> count on the parent device (a bus device for you??), and also implies=20
> that your clk driver code can all run in atomic context so unless you=20
> have a strong reason, it is safe to drop this.

The clock driver code can run in atomic context, it is guaranteed by=20
the clk API.

>=20
>> +	pm_runtime_set_active(dev);
>=20
> The get_sync below would have been sufficient if you had either=20
> limited the clk API above to just clk_prepare, or you could have=20
> moved the whole clk API above into your runtime resume callback.

You assume that pm_runtime_get() will enable the clocks, but that's=20
only true if CONFIG_PM is set.

The reason the clocks are enabled in the probe, and=20
pm_runtime_set_active() is called, is that it works whether or not=20
CONFIG_PM is set.

>> +	pm_runtime_enable(dev);
>> +	pm_runtime_get_sync(dev);
>=20
> If the intention was to increment the usage count with the above=20
> sequence, pm_runtime_get_noresume() is better. But dropping all of=20
> the above and just using get_sync would have been sufficient.
>=20
>> +	pm_runtime_use_autosuspend(dev);
>=20
> I don't see any setting of the autosuspend delay (default value is=20
> 0). So, you might have as well just not used this at all, and just=20
> used pm_runtime_put() below.

Autosuspend delay value can be set from userspace.

>> +
>> +	ret =3D devm_add_action_or_reset(dev, ingenic_rproc_disable_clks,=20
>> vpu);
>> +	if (ret) {
>> +		dev_err(dev, "Unable to register action\n");
>> +		goto out_pm_put;
>> +	}
>> +
>> +	ret =3D devm_rproc_add(dev, rproc);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register remote processor\n");
>> +		goto out_pm_put;
>> +	}
>=20
> You are using auto-boot, so the firmware loading is an asynchronous=20
> event and most probably you would run through below sequence first,=20
> and end up disabling the clocks with an incorrect rpm status.

The driver can auto-load the firmware, but that does not mean it will.=20
We actually don't do that, and load a task-specific firmware onto the=20
remote processor on demand.

>> +
>> +out_pm_put:
>> +	pm_runtime_put_autosuspend(dev);
>=20
> And finally, with the remoteproc core rpm patch, this would all have=20
> been unnecessary.
>=20
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id ingenic_rproc_of_matches[] =3D {
>> +	{ .compatible =3D "ingenic,jz4770-vpu-rproc", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
>> +
>> +static int __maybe_unused ingenic_rproc_suspend(struct device *dev)
>> +{
>> +	struct vpu *vpu =3D dev_get_drvdata(dev);
>> +
>> +	clk_bulk_disable(ARRAY_SIZE(vpu->clks), vpu->clks);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused ingenic_rproc_resume(struct device *dev)
>> +{
>> +	struct vpu *vpu =3D dev_get_drvdata(dev);
>> +
>> +	return clk_bulk_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
>> +}
>> +
>> +static const struct dev_pm_ops __maybe_unused ingenic_rproc_pm =3D {
>> +	SET_RUNTIME_PM_OPS(ingenic_rproc_suspend, ingenic_rproc_resume,=20
>> NULL)
>> +};
>> +
>> +static struct platform_driver ingenic_rproc_driver =3D {
>> +	.probe =3D ingenic_rproc_probe,
>> +	.driver =3D {
>> +		.name =3D "ingenic-vpu",
>> +#ifdef CONFIG_PM
>=20
> Not sure why you would want to maintain this conditional, because=20
> runtime_pm is a core dependency now for your driver to work properly.

No, it is not - the driver works perfectly fine with CONFIG_PM being=20
disabled, and having a hardcoded dependency on CONFIG_PM is not=20
something we want.

Cheers,
-Paul

> regards
> Suman
>=20
>> +		.pm =3D &ingenic_rproc_pm,
>> +#endif
>> +		.of_match_table =3D ingenic_rproc_of_matches,
>> +	},
>> +};
>> +module_platform_driver(ingenic_rproc_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>> +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control=20
>> driver");
>>=20
>=20


