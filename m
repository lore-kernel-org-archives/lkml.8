Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63358C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304D12065C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hU4rUJhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLLrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:47:55 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39816 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1591962472; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJl6Q2IqljcoJAP3lE1gTk1Vu5cEpziz4RwHeUfu0LA=;
        b=hU4rUJhXecDwcvdGofWdnFM0GDt43f5AOpFmdCCwDEnvWU7HzVzDbgJu6ojuB0vxGRykOH
        izH3xFqpl/mJgQDucvOvgbyTjRZF2mgiFxboiMHg8MpSJ6aAzMXbC876rMnkZtNm6RFdBN
        PANrNYxORLP+qxHLTKKpQFjx6sSSCDQ=
Date:   Fri, 12 Jun 2020 13:47:40 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v7 4/5] remoteproc: ingenic: Added remoteproc driver
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Message-Id: <G3ATBQ.KJYAFROKKWDP1@crapouillou.net>
In-Reply-To: <fc1e14e7-4551-48c3-2820-f5889c50becb@ti.com>
References: <20200515104340.10473-1-paul@crapouillou.net>
        <20200515104340.10473-4-paul@crapouillou.net>
        <8cdcf5ef-1268-89f6-b229-ac711a80b790@ti.com>
        <FR8SBQ.5WXNHNH8P2P7@crapouillou.net>
        <fc1e14e7-4551-48c3-2820-f5889c50becb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

Le jeu. 11 juin 2020 =E0 19:21, Suman Anna <s-anna@ti.com> a =E9crit :
> Hi Paul,
>=20
> On 6/11/20 5:21 PM, Paul Cercueil wrote:
>> Hi Suman,
>>=20
>> Le jeu. 11 juin 2020 =E0 16:47, Suman Anna <s-anna@ti.com> a =E9crit :
>>> Hi Paul,
>>>=20
>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>> This driver is used to boot, communicate with and load firmwares=20
>>>> to the
>>>> MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
>>>> Ingenic.
>>>=20
>>> I have a few comments w.r.t pm_runtime usage in this driver.
>>>=20
>>>>=20
>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> ---
>>>>=20
>>>> Notes:
>>>>      v2: Remove exception for always-mapped memories
>>>>      v3: - Use clk_bulk API
>>>>          - Move device-managed code to its own patch [3/4]
>>>>          - Move devicetree table right above ingenic_rproc_driver
>>>>          - Removed #ifdef CONFIG_OF around devicetree table
>>>>          - Removed .owner =3D THIS_MODULE in ingenic_rproc_driver
>>>>          - Removed useless platform_set_drvdata()
>>>>      v4: - Add fix reported by Julia
>>>>          - Change Kconfig symbol to INGENIC_VPU_RPROC
>>>>          - Add documentation to struct vpu
>>>>          - disable_irq_nosync() -> disable_irq()
>>>>      v5: No change
>>>>      v6: Instead of prepare/unprepare callbacks, use PM runtime=20
>>>> =7F=7F=7Fcallbacks
>>>>      v7: - Remove use of of_match_ptr()
>>>>          - Move Kconfig symbol so that it's in alphabetical order
>>>>          - Add missing doc for private structure field aux_base
>>>>          - Don't check for (len <=3D 0) in da_to_va()
>>>>          - Add missing \n in dev_info/dev_err messages
>>>>=20
>>>>   drivers/remoteproc/Kconfig         |   9 +
>>>>   drivers/remoteproc/Makefile        |   1 +
>>>>   drivers/remoteproc/ingenic_rproc.c | 280=20
>>>> +++++++++++++++++++++++++++++
>>>>   3 files changed, 290 insertions(+)
>>>>   create mode 100644 drivers/remoteproc/ingenic_rproc.c
>>>>=20
>>>> diff --git a/drivers/remoteproc/Kconfig=20
>>>> b/drivers/remoteproc/Kconfig
>>>> index fbaed079b299..c4d1731295eb 100644
>>>> --- a/drivers/remoteproc/Kconfig
>>>> +++ b/drivers/remoteproc/Kconfig
>>>> @@ -23,6 +23,15 @@ config IMX_REMOTEPROC
>>>>   =7F        It's safe to say N here.
>>>>   =7F+config INGENIC_VPU_RPROC
>>>> +    tristate "Ingenic JZ47xx VPU remoteproc support"
>>>> +    depends on MIPS || COMPILE_TEST
>>>> +    help
>>>> +      Say y or m here to support the VPU in the JZ47xx SoCs from=20
>>>> =7F=7F=7FIngenic.
>>>> +
>>>> +      This can be either built-in or a loadable module.
>>>> +      If unsure say N.
>>>> +
>>>>   config MTK_SCP
>>>>       tristate "Mediatek SCP support"
>>>>       depends on ARCH_MEDIATEK
>>>> diff --git a/drivers/remoteproc/Makefile=20
>>>> b/drivers/remoteproc/Makefile
>>>> index 0effd3825035..e8b886e511f0 100644
>>>> --- a/drivers/remoteproc/Makefile
>>>> +++ b/drivers/remoteproc/Makefile
>>>> @@ -10,6 +10,7 @@ remoteproc-y                +=3D remoteproc_sysfs.o
>>>>   remoteproc-y                +=3D remoteproc_virtio.o
>>>>   remoteproc-y                +=3D remoteproc_elf_loader.o
>>>>   obj-$(CONFIG_IMX_REMOTEPROC)        +=3D imx_rproc.o
>>>> +obj-$(CONFIG_INGENIC_VPU_RPROC)        +=3D ingenic_rproc.o
>>>>   obj-$(CONFIG_MTK_SCP)            +=3D mtk_scp.o mtk_scp_ipi.o
>>>>   obj-$(CONFIG_OMAP_REMOTEPROC)        +=3D omap_remoteproc.o
>>>>   obj-$(CONFIG_WKUP_M3_RPROC)        +=3D wkup_m3_rproc.o
>>>> diff --git a/drivers/remoteproc/ingenic_rproc.c=20
>>>> =7F=7F=7Fb/drivers/remoteproc/ingenic_rproc.c
>>>> new file mode 100644
>>>> index 000000000000..189020d77b25
>>>> --- /dev/null
>>>> +++ b/drivers/remoteproc/ingenic_rproc.c
>>>> @@ -0,0 +1,280 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Ingenic JZ47xx remoteproc driver
>>>> + * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
>>>> + */
>>>> +
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>> +#include <linux/remoteproc.h>
>>>> +
>>>> +#include "remoteproc_internal.h"
>>>> +
>>>> +#define REG_AUX_CTRL        0x0
>>>> +#define REG_AUX_MSG_ACK        0x10
>>>> +#define REG_AUX_MSG        0x14
>>>> +#define REG_CORE_MSG_ACK    0x18
>>>> +#define REG_CORE_MSG        0x1C
>>>> +
>>>> +#define AUX_CTRL_SLEEP        BIT(31)
>>>> +#define AUX_CTRL_MSG_IRQ_EN    BIT(3)
>>>> +#define AUX_CTRL_NMI_RESETS    BIT(2)
>>>> +#define AUX_CTRL_NMI        BIT(1)
>>>> +#define AUX_CTRL_SW_RESET    BIT(0)
>>>> +
>>>> +struct vpu_mem_map {
>>>> +    const char *name;
>>>> +    unsigned int da;
>>>> +};
>>>> +
>>>> +struct vpu_mem_info {
>>>> +    const struct vpu_mem_map *map;
>>>> +    unsigned long len;
>>>> +    void __iomem *base;
>>>> +};
>>>> +
>>>> +static const struct vpu_mem_map vpu_mem_map[] =3D {
>>>> +    { "tcsm0", 0x132b0000 },
>>>> +    { "tcsm1", 0xf4000000 },
>>>> +    { "sram",  0x132f0000 },
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct vpu - Ingenic VPU remoteproc private structure
>>>> + * @irq: interrupt number
>>>> + * @clks: pointers to the VPU and AUX clocks
>>>> + * @aux_base: raw pointer to the AUX interface registers
>>>> + * @mem_info: array of struct vpu_mem_info, which contain the=20
>>>> =7F=7F=7Fmapping info of
>>>> + *            each of the external memories
>>>> + * @dev: private pointer to the device
>>>> + */
>>>> +struct vpu {
>>>> +    int irq;
>>>> +    struct clk_bulk_data clks[2];
>>>> +    void __iomem *aux_base;
>>>> +    struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
>>>> +    struct device *dev;
>>>> +};
>>>> +
>>>> +static int ingenic_rproc_start(struct rproc *rproc)
>>>> +{
>>>> +    struct vpu *vpu =3D rproc->priv;
>>>> +    u32 ctrl;
>>>> +
>>>> +    enable_irq(vpu->irq);
>>>> +
>>>> +    /* Reset the AUX and enable message IRQ */
>>>> +    ctrl =3D AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI |=20
>>>> AUX_CTRL_MSG_IRQ_EN;
>>>> +    writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int ingenic_rproc_stop(struct rproc *rproc)
>>>> +{
>>>> +    struct vpu *vpu =3D rproc->priv;
>>>> +
>>>> +    disable_irq(vpu->irq);
>>>> +
>>>> +    /* Keep AUX in reset mode */
>>>> +    writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
>>>> +{
>>>> +    struct vpu *vpu =3D rproc->priv;
>>>> +
>>>> +    writel(vqid, vpu->aux_base + REG_CORE_MSG);
>>>> +}
>>>> +
>>>> +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da,=20
>>>> =7F=7F=7Fsize_t len)
>>>> +{
>>>> +    struct vpu *vpu =3D rproc->priv;
>>>> +    void __iomem *va =3D NULL;
>>>> +    unsigned int i;
>>>> +
>>>> +    for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>>> +        const struct vpu_mem_info *info =3D &vpu->mem_info[i];
>>>> +        const struct vpu_mem_map *map =3D info->map;
>>>> +
>>>> +        if (da >=3D map->da && (da + len) < (map->da + info->len)) {
>>>> +            va =3D info->base + (da - map->da);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return (__force void *)va;
>>>> +}
>>>> +
>>>> +static struct rproc_ops ingenic_rproc_ops =3D {
>>>> +    .start =3D ingenic_rproc_start,
>>>> +    .stop =3D ingenic_rproc_stop,
>>>> +    .kick =3D ingenic_rproc_kick,
>>>> +    .da_to_va =3D ingenic_rproc_da_to_va,
>>>> +};
>>>> +
>>>> +static irqreturn_t vpu_interrupt(int irq, void *data)
>>>> +{
>>>> +    struct rproc *rproc =3D data;
>>>> +    struct vpu *vpu =3D rproc->priv;
>>>> +    u32 vring;
>>>> +
>>>> +    vring =3D readl(vpu->aux_base + REG_AUX_MSG);
>>>> +
>>>> +    /* Ack the interrupt */
>>>> +    writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
>>>> +
>>>> +    return rproc_vq_interrupt(rproc, vring);
>>>> +}
>>>> +
>>>> +static void ingenic_rproc_disable_clks(void *data)
>>>> +{
>>>> +    struct vpu *vpu =3D data;
>>>> +
>>>> +    pm_runtime_resume(vpu->dev);
>>>> +    pm_runtime_disable(vpu->dev);
>>>> +
>>>> +    clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>> +}
>>>> +
>>>> +static int ingenic_rproc_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct device *dev =3D &pdev->dev;
>>>> +    struct resource *mem;
>>>> +    struct rproc *rproc;
>>>> +    struct vpu *vpu;
>>>> +    unsigned int i;
>>>> +    int ret;
>>>> +
>>>> +    rproc =3D devm_rproc_alloc(dev, "ingenic-vpu",
>>>> +                 &ingenic_rproc_ops, NULL, sizeof(*vpu));
>>>> +    if (!rproc)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    vpu =3D rproc->priv;
>>>> +    vpu->dev =3D &pdev->dev;
>>>> +    platform_set_drvdata(pdev, vpu);
>>>> +
>>>> +    mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,=20
>>>> "aux");
>>>> +    vpu->aux_base =3D devm_ioremap_resource(dev, mem);
>>>> +    if (IS_ERR(vpu->aux_base)) {
>>>> +        dev_err(dev, "Failed to ioremap\n");
>>>> +        return PTR_ERR(vpu->aux_base);
>>>> +    }
>>>> +
>>>> +    for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>>> +        mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>>> +                           vpu_mem_map[i].name);
>>>> +
>>>> +        vpu->mem_info[i].base =3D devm_ioremap_resource(dev, mem);
>>>> +        if (IS_ERR(vpu->mem_info[i].base)) {
>>>> +            ret =3D PTR_ERR(vpu->mem_info[i].base);
>>>> +            dev_err(dev, "Failed to ioremap\n");
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        vpu->mem_info[i].len =3D resource_size(mem);
>>>> +        vpu->mem_info[i].map =3D &vpu_mem_map[i];
>>>> +    }
>>>> +
>>>> +    vpu->clks[0].id =3D "vpu";
>>>> +    vpu->clks[1].id =3D "aux";
>>>> +
>>>> +    ret =3D devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks),=20
>>>> vpu->clks);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Failed to get clocks\n");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    vpu->irq =3D platform_get_irq(pdev, 0);
>>>> +    if (vpu->irq < 0)
>>>> +        return vpu->irq;
>>>> +
>>>> +    ret =3D devm_request_irq(dev, vpu->irq, vpu_interrupt, 0,=20
>>>> "VPU", =7F=7F=7Frproc);
>>>> +    if (ret < 0) {
>>>> +        dev_err(dev, "Failed to request IRQ\n");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    disable_irq(vpu->irq);
>>>> +
>>>> +    /* The clocks must be enabled for the firmware to be loaded=20
>>>> in =7F=7F=7FTCSM */
>>>> +    ret =3D clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks),=20
>>>> vpu->clks);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Unable to start clocks\n");
>>>> +        return ret;
>>>> +    }
>>>=20
>>> You are enabling the clocks directly here and also trying to manage=20
>>> =7F=7Fthem through pm_runtime callbacks again.
>>=20
>> Yes. The clocks need to be enabled in the probe.
>=20
> For the preferred non CONFIG_PM case now and lack of=20
> prepare/unprepare().

I want to make it clear that I'm not against having=20
.prepare/.unprepare, but I want to see what maintainers have to say.

>>=20
>>>> +
>>>> +    pm_runtime_irq_safe(dev);
>>>=20
>>> Nothing wrong with this, but this does take an additional reference=20
>>> =7F=7Fcount on the parent device (a bus device for you??), and also=20
>>> implies =7F=7Fthat your clk driver code can all run in atomic context=20
>>> so unless you =7F=7Fhave a strong reason, it is safe to drop this.
>>=20
>> The clock driver code can run in atomic context, it is guaranteed by=20
>> the =7Fclk API.
>=20
> OK.
>=20
>>=20
>>>=20
>>>> +    pm_runtime_set_active(dev);
>>>=20
>>> The get_sync below would have been sufficient if you had either=20
>>> =7F=7Flimited the clk API above to just clk_prepare, or you could have=20
>>> moved =7F=7Fthe whole clk API above into your runtime resume callback.
>>=20
>> You assume that pm_runtime_get() will enable the clocks, but that's=20
>> only =7Ftrue if CONFIG_PM is set.
>>=20
>> The reason the clocks are enabled in the probe, and=20
>> =7Fpm_runtime_set_active() is called, is that it works whether or not=20
>> =7FCONFIG_PM is set.
>=20
> As I said, if the intention is to reflect the clocks active state in=20
> rpm status, then pm_runtime_get_noresume() does the job for you=20
> instead of get_sync(). pm_runtime_get_sync() typically does 3 things=20
> - increment the usage count, invoke your callbacks (enable clocks for=20
> you), and sets the status to active, with the last two steps optional=20
> depending on usage count.

So pm_runtime_get_noresume() instead of pm_runtime_set_active() +=20
pm_runtime_get_sync()?

>>=20
>>>> +    pm_runtime_enable(dev);
>>>> +    pm_runtime_get_sync(dev);
>>>=20
>>> If the intention was to increment the usage count with the above=20
>>> =7F=7Fsequence, pm_runtime_get_noresume() is better. But dropping all=20
>>> of the =7F=7Fabove and just using get_sync would have been sufficient.
>>>=20
>>>> +    pm_runtime_use_autosuspend(dev);
>>>=20
>>> I don't see any setting of the autosuspend delay (default value is=20
>>> 0). =7F=7FSo, you might have as well just not used this at all, and=20
>>> just used =7F=7Fpm_runtime_put() below.
>>=20
>> Autosuspend delay value can be set from userspace.
>=20
> Yes, but I don't see a specific purpose for it in your driver. Either=20
> you have remoteproc running (and so clocks enabled always), or you=20
> don't have a firmware loaded and want clocks disabled (not sure you=20
> would want to waste power for certain of amount of time).

What I had in mind is that it would prevent the hardware from being=20
quickly disabled then re-enabled when switching firmwares. But it's not=20
like it takes a long time to stop/start the clock, so this could go=20
away, yes.

>>=20
>>>> +
>>>> +    ret =3D devm_add_action_or_reset(dev,=20
>>>> ingenic_rproc_disable_clks, =7F=7F=7Fvpu);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Unable to register action\n");
>>>> +        goto out_pm_put;
>>>> +    }
>>>> +
>>>> +    ret =3D devm_rproc_add(dev, rproc);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Failed to register remote processor\n");
>>>> +        goto out_pm_put;
>>>> +    }
>>>=20
>>> You are using auto-boot, so the firmware loading is an asynchronous=20
>>> =7F=7Fevent and most probably you would run through below sequence=20
>>> first, =7F=7Fand end up disabling the clocks with an incorrect rpm=20
>>> status.
>>=20
>> The driver can auto-load the firmware, but that does not mean it=20
>> will. =7FWe actually don't do that, and load a task-specific firmware=20
>> onto the =7Fremote processor on demand.
>=20
> Yeah OK, depends on what is preferred by default. If it is more=20
> standard practise that the remoteproc is booted by userspace always,=20
> then I suggest setting auto_boot as false. But nothing wrong with=20
> expecting to boot by default with a starting firmware.

Ok, I didn't know there was a way to disable auto-boot.

>>=20
>>>> +
>>>> +out_pm_put:
>>>> +    pm_runtime_put_autosuspend(dev);
>>>=20
>>> And finally, with the remoteproc core rpm patch, this would all=20
>>> have =7F=7Fbeen unnecessary.
>>>=20
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static const struct of_device_id ingenic_rproc_of_matches[] =3D {
>>>> +    { .compatible =3D "ingenic,jz4770-vpu-rproc", },
>>>> +    {}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
>>>> +
>>>> +static int __maybe_unused ingenic_rproc_suspend(struct device=20
>>>> *dev)
>>>> +{
>>>> +    struct vpu *vpu =3D dev_get_drvdata(dev);
>>>> +
>>>> +    clk_bulk_disable(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __maybe_unused ingenic_rproc_resume(struct device *dev)
>>>> +{
>>>> +    struct vpu *vpu =3D dev_get_drvdata(dev);
>>>> +
>>>> +    return clk_bulk_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops __maybe_unused ingenic_rproc_pm =3D {
>>>> +    SET_RUNTIME_PM_OPS(ingenic_rproc_suspend,=20
>>>> ingenic_rproc_resume, =7F=7F=7FNULL)
>>>> +};
>>>> +
>>>> +static struct platform_driver ingenic_rproc_driver =3D {
>>>> +    .probe =3D ingenic_rproc_probe,
>>>> +    .driver =3D {
>>>> +        .name =3D "ingenic-vpu",
>>>> +#ifdef CONFIG_PM
>>>=20
>>> Not sure why you would want to maintain this conditional, because=20
>>> =7F=7Fruntime_pm is a core dependency now for your driver to work=20
>>> properly.
>>=20
>> No, it is not - the driver works perfectly fine with CONFIG_PM being=20
>> =7Fdisabled, and having a hardcoded dependency on CONFIG_PM is not=20
>> =7Fsomething we want.
>=20
> OK, so if IIUC, in general CONFIG_PM is not a typical usage for your=20
> MIPS platforms. Your driver is the first non-ARM remoteproc driver=20
> :), CONFIG_PM is almost a given on most ARM platforms.
>=20
> So, I fail to see how your clocks can stay disabled then when=20
> CONFIG_PM=3Dn if the remoteproc fails to load with the current code,=20
> which was your primary argument for using prepare/unprepare (based on=20
> comments on prior versions). It looks to me that your needs are=20
> indeed better suited with the prepare/unprepare ops as in your=20
> initial series.

Yes, I find the rpm in remoteproc core solution more elegant, but that=20
doesn't work as well for me in the CONFIG_PM=3Dn case.

> And in the case of CONFIG_PM=3Dy, you have three levels of code that=20
> enables the clocks (the bare clk API, the pm_runtime_get in probe,=20
> and the pm_runtime_get in the remoteproc core). Depending on the rpm=20
> status, it may or may not invoke the callbacks.

pm_runtime_get() in the probe won't call pm_resume, since the rpm=20
status is marked as active with pm_runtime_set_active(), so the clocks=20
are enabled only once in the probe. And even if the remoteproc core=20
calls pm_runtime_get() in the middle of the probe (why would it?) it=20
would still work fine since the clock enable/disable API is=20
reference-counted.

Cheers,
-Paul

> regards
> Suman
>=20
>>=20
>> Cheers,
>> -Paul
>>=20
>>> regards
>>> Suman
>>>=20
>>>> +        .pm =3D &ingenic_rproc_pm,
>>>> +#endif
>>>> +        .of_match_table =3D ingenic_rproc_of_matches,
>>>> +    },
>>>> +};
>>>> +module_platform_driver(ingenic_rproc_driver);
>>>> +
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>>> +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control=20
>>>> driver");
>>>>=20
>>>=20
>>=20
>>=20
>=20


