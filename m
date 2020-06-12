Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC56C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB18206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MqBqLMoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFLOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:47:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60032 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgFLOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:47:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CElNFo113344;
        Fri, 12 Jun 2020 09:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591973243;
        bh=novGnnOSWZcapN3VY9qt70B7cW95lNLcGYvxHqmmix8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MqBqLMoexSZKkY+QQFx4Gs1elJ5cMmW2kgRH8y29vr4YhWblUgtQx0gmszo/yfMHm
         xfiGQmL7Fn/8PwZk7qG8nKqjSv7fGl3vIZdU3KGGF8sTNe/I74kC08K5geFNu2SX+u
         gkGfpOfxYlnDb2nqHqGjvblvC8RLArVxLlgzWNAQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CElNEp006264;
        Fri, 12 Jun 2020 09:47:23 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 09:47:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 09:47:23 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CElNvX106307;
        Fri, 12 Jun 2020 09:47:23 -0500
Subject: Re: [PATCH v7 4/5] remoteproc: ingenic: Added remoteproc driver
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, <od@zcrc.me>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20200515104340.10473-1-paul@crapouillou.net>
 <20200515104340.10473-4-paul@crapouillou.net>
 <8cdcf5ef-1268-89f6-b229-ac711a80b790@ti.com>
 <FR8SBQ.5WXNHNH8P2P7@crapouillou.net>
 <fc1e14e7-4551-48c3-2820-f5889c50becb@ti.com>
 <G3ATBQ.KJYAFROKKWDP1@crapouillou.net>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <3f2ace72-29be-480e-5863-d0b0e647b3cf@ti.com>
Date:   Fri, 12 Jun 2020 09:47:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <G3ATBQ.KJYAFROKKWDP1@crapouillou.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 6/12/20 6:47 AM, Paul Cercueil wrote:
> Hi Suman,
> 
> Le jeu. 11 juin 2020 à 19:21, Suman Anna <s-anna@ti.com> a écrit :
>> Hi Paul,
>>
>> On 6/11/20 5:21 PM, Paul Cercueil wrote:
>>> Hi Suman,
>>>
>>> Le jeu. 11 juin 2020 à 16:47, Suman Anna <s-anna@ti.com> a écrit :
>>>> Hi Paul,
>>>>
>>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>>> This driver is used to boot, communicate with and load firmwares to 
>>>>> the
>>>>> MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
>>>>> Ingenic.
>>>>
>>>> I have a few comments w.r.t pm_runtime usage in this driver.
>>>>
>>>>>
>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>      v2: Remove exception for always-mapped memories
>>>>>      v3: - Use clk_bulk API
>>>>>          - Move device-managed code to its own patch [3/4]
>>>>>          - Move devicetree table right above ingenic_rproc_driver
>>>>>          - Removed #ifdef CONFIG_OF around devicetree table
>>>>>          - Removed .owner = THIS_MODULE in ingenic_rproc_driver
>>>>>          - Removed useless platform_set_drvdata()
>>>>>      v4: - Add fix reported by Julia
>>>>>          - Change Kconfig symbol to INGENIC_VPU_RPROC
>>>>>          - Add documentation to struct vpu
>>>>>          - disable_irq_nosync() -> disable_irq()
>>>>>      v5: No change
>>>>>      v6: Instead of prepare/unprepare callbacks, use PM runtime 
>>>>> callbacks
>>>>>      v7: - Remove use of of_match_ptr()
>>>>>          - Move Kconfig symbol so that it's in alphabetical order
>>>>>          - Add missing doc for private structure field aux_base
>>>>>          - Don't check for (len <= 0) in da_to_va()
>>>>>          - Add missing \n in dev_info/dev_err messages
>>>>>
>>>>>   drivers/remoteproc/Kconfig         |   9 +
>>>>>   drivers/remoteproc/Makefile        |   1 +
>>>>>   drivers/remoteproc/ingenic_rproc.c | 280 
>>>>> +++++++++++++++++++++++++++++
>>>>>   3 files changed, 290 insertions(+)
>>>>>   create mode 100644 drivers/remoteproc/ingenic_rproc.c
>>>>>
>>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>>> index fbaed079b299..c4d1731295eb 100644
>>>>> --- a/drivers/remoteproc/Kconfig
>>>>> +++ b/drivers/remoteproc/Kconfig
>>>>> @@ -23,6 +23,15 @@ config IMX_REMOTEPROC
>>>>>           It's safe to say N here.
>>>>>   +config INGENIC_VPU_RPROC
>>>>> +    tristate "Ingenic JZ47xx VPU remoteproc support"
>>>>> +    depends on MIPS || COMPILE_TEST
>>>>> +    help
>>>>> +      Say y or m here to support the VPU in the JZ47xx SoCs 
>>>>> from Ingenic.
>>>>> +
>>>>> +      This can be either built-in or a loadable module.
>>>>> +      If unsure say N.
>>>>> +
>>>>>   config MTK_SCP
>>>>>       tristate "Mediatek SCP support"
>>>>>       depends on ARCH_MEDIATEK
>>>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>>>>> index 0effd3825035..e8b886e511f0 100644
>>>>> --- a/drivers/remoteproc/Makefile
>>>>> +++ b/drivers/remoteproc/Makefile
>>>>> @@ -10,6 +10,7 @@ remoteproc-y                += remoteproc_sysfs.o
>>>>>   remoteproc-y                += remoteproc_virtio.o
>>>>>   remoteproc-y                += remoteproc_elf_loader.o
>>>>>   obj-$(CONFIG_IMX_REMOTEPROC)        += imx_rproc.o
>>>>> +obj-$(CONFIG_INGENIC_VPU_RPROC)        += ingenic_rproc.o
>>>>>   obj-$(CONFIG_MTK_SCP)            += mtk_scp.o mtk_scp_ipi.o
>>>>>   obj-$(CONFIG_OMAP_REMOTEPROC)        += omap_remoteproc.o
>>>>>   obj-$(CONFIG_WKUP_M3_RPROC)        += wkup_m3_rproc.o
>>>>> diff --git a/drivers/remoteproc/ingenic_rproc.c 
>>>>> b/drivers/remoteproc/ingenic_rproc.c
>>>>> new file mode 100644
>>>>> index 000000000000..189020d77b25
>>>>> --- /dev/null
>>>>> +++ b/drivers/remoteproc/ingenic_rproc.c
>>>>> @@ -0,0 +1,280 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * Ingenic JZ47xx remoteproc driver
>>>>> + * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
>>>>> + */
>>>>> +
>>>>> +#include <linux/bitops.h>
>>>>> +#include <linux/clk.h>
>>>>> +#include <linux/err.h>
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>> +#include <linux/remoteproc.h>
>>>>> +
>>>>> +#include "remoteproc_internal.h"
>>>>> +
>>>>> +#define REG_AUX_CTRL        0x0
>>>>> +#define REG_AUX_MSG_ACK        0x10
>>>>> +#define REG_AUX_MSG        0x14
>>>>> +#define REG_CORE_MSG_ACK    0x18
>>>>> +#define REG_CORE_MSG        0x1C
>>>>> +
>>>>> +#define AUX_CTRL_SLEEP        BIT(31)
>>>>> +#define AUX_CTRL_MSG_IRQ_EN    BIT(3)
>>>>> +#define AUX_CTRL_NMI_RESETS    BIT(2)
>>>>> +#define AUX_CTRL_NMI        BIT(1)
>>>>> +#define AUX_CTRL_SW_RESET    BIT(0)
>>>>> +
>>>>> +struct vpu_mem_map {
>>>>> +    const char *name;
>>>>> +    unsigned int da;
>>>>> +};
>>>>> +
>>>>> +struct vpu_mem_info {
>>>>> +    const struct vpu_mem_map *map;
>>>>> +    unsigned long len;
>>>>> +    void __iomem *base;
>>>>> +};
>>>>> +
>>>>> +static const struct vpu_mem_map vpu_mem_map[] = {
>>>>> +    { "tcsm0", 0x132b0000 },
>>>>> +    { "tcsm1", 0xf4000000 },
>>>>> +    { "sram",  0x132f0000 },
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct vpu - Ingenic VPU remoteproc private structure
>>>>> + * @irq: interrupt number
>>>>> + * @clks: pointers to the VPU and AUX clocks
>>>>> + * @aux_base: raw pointer to the AUX interface registers
>>>>> + * @mem_info: array of struct vpu_mem_info, which contain the 
>>>>> mapping info of
>>>>> + *            each of the external memories
>>>>> + * @dev: private pointer to the device
>>>>> + */
>>>>> +struct vpu {
>>>>> +    int irq;
>>>>> +    struct clk_bulk_data clks[2];
>>>>> +    void __iomem *aux_base;
>>>>> +    struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
>>>>> +    struct device *dev;
>>>>> +};
>>>>> +
>>>>> +static int ingenic_rproc_start(struct rproc *rproc)
>>>>> +{
>>>>> +    struct vpu *vpu = rproc->priv;
>>>>> +    u32 ctrl;
>>>>> +
>>>>> +    enable_irq(vpu->irq);
>>>>> +
>>>>> +    /* Reset the AUX and enable message IRQ */
>>>>> +    ctrl = AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN;
>>>>> +    writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int ingenic_rproc_stop(struct rproc *rproc)
>>>>> +{
>>>>> +    struct vpu *vpu = rproc->priv;
>>>>> +
>>>>> +    disable_irq(vpu->irq);
>>>>> +
>>>>> +    /* Keep AUX in reset mode */
>>>>> +    writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
>>>>> +{
>>>>> +    struct vpu *vpu = rproc->priv;
>>>>> +
>>>>> +    writel(vqid, vpu->aux_base + REG_CORE_MSG);
>>>>> +}
>>>>> +
>>>>> +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 
>>>>> da, size_t len)
>>>>> +{
>>>>> +    struct vpu *vpu = rproc->priv;
>>>>> +    void __iomem *va = NULL;
>>>>> +    unsigned int i;
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>>>> +        const struct vpu_mem_info *info = &vpu->mem_info[i];
>>>>> +        const struct vpu_mem_map *map = info->map;
>>>>> +
>>>>> +        if (da >= map->da && (da + len) < (map->da + info->len)) {
>>>>> +            va = info->base + (da - map->da);
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return (__force void *)va;
>>>>> +}
>>>>> +
>>>>> +static struct rproc_ops ingenic_rproc_ops = {
>>>>> +    .start = ingenic_rproc_start,
>>>>> +    .stop = ingenic_rproc_stop,
>>>>> +    .kick = ingenic_rproc_kick,
>>>>> +    .da_to_va = ingenic_rproc_da_to_va,
>>>>> +};
>>>>> +
>>>>> +static irqreturn_t vpu_interrupt(int irq, void *data)
>>>>> +{
>>>>> +    struct rproc *rproc = data;
>>>>> +    struct vpu *vpu = rproc->priv;
>>>>> +    u32 vring;
>>>>> +
>>>>> +    vring = readl(vpu->aux_base + REG_AUX_MSG);
>>>>> +
>>>>> +    /* Ack the interrupt */
>>>>> +    writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
>>>>> +
>>>>> +    return rproc_vq_interrupt(rproc, vring);
>>>>> +}
>>>>> +
>>>>> +static void ingenic_rproc_disable_clks(void *data)
>>>>> +{
>>>>> +    struct vpu *vpu = data;
>>>>> +
>>>>> +    pm_runtime_resume(vpu->dev);
>>>>> +    pm_runtime_disable(vpu->dev);
>>>>> +
>>>>> +    clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>>> +}
>>>>> +
>>>>> +static int ingenic_rproc_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +    struct device *dev = &pdev->dev;
>>>>> +    struct resource *mem;
>>>>> +    struct rproc *rproc;
>>>>> +    struct vpu *vpu;
>>>>> +    unsigned int i;
>>>>> +    int ret;
>>>>> +
>>>>> +    rproc = devm_rproc_alloc(dev, "ingenic-vpu",
>>>>> +                 &ingenic_rproc_ops, NULL, sizeof(*vpu));
>>>>> +    if (!rproc)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    vpu = rproc->priv;
>>>>> +    vpu->dev = &pdev->dev;
>>>>> +    platform_set_drvdata(pdev, vpu);
>>>>> +
>>>>> +    mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
>>>>> +    vpu->aux_base = devm_ioremap_resource(dev, mem);
>>>>> +    if (IS_ERR(vpu->aux_base)) {
>>>>> +        dev_err(dev, "Failed to ioremap\n");
>>>>> +        return PTR_ERR(vpu->aux_base);
>>>>> +    }
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>>>> +        mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>>>> +                           vpu_mem_map[i].name);
>>>>> +
>>>>> +        vpu->mem_info[i].base = devm_ioremap_resource(dev, mem);
>>>>> +        if (IS_ERR(vpu->mem_info[i].base)) {
>>>>> +            ret = PTR_ERR(vpu->mem_info[i].base);
>>>>> +            dev_err(dev, "Failed to ioremap\n");
>>>>> +            return ret;
>>>>> +        }
>>>>> +
>>>>> +        vpu->mem_info[i].len = resource_size(mem);
>>>>> +        vpu->mem_info[i].map = &vpu_mem_map[i];
>>>>> +    }
>>>>> +
>>>>> +    vpu->clks[0].id = "vpu";
>>>>> +    vpu->clks[1].id = "aux";
>>>>> +
>>>>> +    ret = devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks), vpu->clks);
>>>>> +    if (ret) {
>>>>> +        dev_err(dev, "Failed to get clocks\n");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    vpu->irq = platform_get_irq(pdev, 0);
>>>>> +    if (vpu->irq < 0)
>>>>> +        return vpu->irq;
>>>>> +
>>>>> +    ret = devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, 
>>>>> "VPU", rproc);
>>>>> +    if (ret < 0) {
>>>>> +        dev_err(dev, "Failed to request IRQ\n");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    disable_irq(vpu->irq);
>>>>> +
>>>>> +    /* The clocks must be enabled for the firmware to be 
>>>>> loaded in TCSM */
>>>>> +    ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>>> +    if (ret) {
>>>>> +        dev_err(dev, "Unable to start clocks\n");
>>>>> +        return ret;
>>>>> +    }
>>>>
>>>> You are enabling the clocks directly here and also trying to 
>>>> manage them through pm_runtime callbacks again.
>>>
>>> Yes. The clocks need to be enabled in the probe.
>>
>> For the preferred non CONFIG_PM case now and lack of prepare/unprepare().
> 
> I want to make it clear that I'm not against having .prepare/.unprepare, 
> but I want to see what maintainers have to say.

Yes, it is the solution though to meet all your needs if CONFIG_PM is 
not used in general.

> 
>>>
>>>>> +
>>>>> +    pm_runtime_irq_safe(dev);
>>>>
>>>> Nothing wrong with this, but this does take an additional 
>>>> reference count on the parent device (a bus device for you??), and 
>>>> also implies that your clk driver code can all run in atomic 
>>>> context so unless you have a strong reason, it is safe to drop this.
>>>
>>> The clock driver code can run in atomic context, it is guaranteed 
>>> by the clk API.
>>
>> OK.
>>
>>>
>>>>
>>>>> +    pm_runtime_set_active(dev);
>>>>
>>>> The get_sync below would have been sufficient if you had either 
>>>> limited the clk API above to just clk_prepare, or you could have 
>>>> moved the whole clk API above into your runtime resume callback.
>>>
>>> You assume that pm_runtime_get() will enable the clocks, but that's 
>>> only true if CONFIG_PM is set.
>>>
>>> The reason the clocks are enabled in the probe, and 
>>> pm_runtime_set_active() is called, is that it works whether or not 
>>> CONFIG_PM is set.
>>
>> As I said, if the intention is to reflect the clocks active state in 
>> rpm status, then pm_runtime_get_noresume() does the job for you 
>> instead of get_sync(). pm_runtime_get_sync() typically does 3 things - 
>> increment the usage count, invoke your callbacks (enable clocks for 
>> you), and sets the status to active, with the last two steps optional 
>> depending on usage count.
> 
> So pm_runtime_get_noresume() instead of pm_runtime_set_active() + 
> pm_runtime_get_sync()?

Its, pm_runtime_set_active() + pm_runtime_get_noresume().

They do exactly what you desire in the sequence, clocks are already 
enabled, so you set the status and increment the rpm usage count.

> 
>>>
>>>>> +    pm_runtime_enable(dev);
>>>>> +    pm_runtime_get_sync(dev);
>>>>
>>>> If the intention was to increment the usage count with the above 
>>>> sequence, pm_runtime_get_noresume() is better. But dropping all of 
>>>> the above and just using get_sync would have been sufficient.
>>>>
>>>>> +    pm_runtime_use_autosuspend(dev);
>>>>
>>>> I don't see any setting of the autosuspend delay (default value 
>>>> is 0). So, you might have as well just not used this at all, and 
>>>> just used pm_runtime_put() below.
>>>
>>> Autosuspend delay value can be set from userspace.
>>
>> Yes, but I don't see a specific purpose for it in your driver. Either 
>> you have remoteproc running (and so clocks enabled always), or you 
>> don't have a firmware loaded and want clocks disabled (not sure you 
>> would want to waste power for certain of amount of time).
> 
> What I had in mind is that it would prevent the hardware from being 
> quickly disabled then re-enabled when switching firmwares. But it's not 
> like it takes a long time to stop/start the clock, so this could go 
> away, yes.

Also note that pm_runtime_put() is already asynchronous, so it doesn't 
happen right away.

> 
>>>
>>>>> +
>>>>> +    ret = devm_add_action_or_reset(dev, 
>>>>> ingenic_rproc_disable_clks, vpu);
>>>>> +    if (ret) {
>>>>> +        dev_err(dev, "Unable to register action\n");
>>>>> +        goto out_pm_put;
>>>>> +    }
>>>>> +
>>>>> +    ret = devm_rproc_add(dev, rproc);
>>>>> +    if (ret) {
>>>>> +        dev_err(dev, "Failed to register remote processor\n");
>>>>> +        goto out_pm_put;
>>>>> +    }
>>>>
>>>> You are using auto-boot, so the firmware loading is an 
>>>> asynchronous event and most probably you would run through below 
>>>> sequence first, and end up disabling the clocks with an incorrect 
>>>> rpm status.
>>>
>>> The driver can auto-load the firmware, but that does not mean it 
>>> will. We actually don't do that, and load a task-specific firmware 
>>> onto the remote processor on demand.
>>
>> Yeah OK, depends on what is preferred by default. If it is more 
>> standard practise that the remoteproc is booted by userspace always, 
>> then I suggest setting auto_boot as false. But nothing wrong with 
>> expecting to boot by default with a starting firmware.
> 
> Ok, I didn't know there was a way to disable auto-boot.

Yes, you can just set the rproc->auto_boot = false after rproc_alloc() 
and before rproc_add(). Again, it depends on what you desire. I have 
seen some rproc drivers set this actually based on a DT flag.

> 
>>>
>>>>> +
>>>>> +out_pm_put:
>>>>> +    pm_runtime_put_autosuspend(dev);
>>>>
>>>> And finally, with the remoteproc core rpm patch, this would all 
>>>> have been unnecessary.
>>>>
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct of_device_id ingenic_rproc_of_matches[] = {
>>>>> +    { .compatible = "ingenic,jz4770-vpu-rproc", },
>>>>> +    {}
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
>>>>> +
>>>>> +static int __maybe_unused ingenic_rproc_suspend(struct device *dev)
>>>>> +{
>>>>> +    struct vpu *vpu = dev_get_drvdata(dev);
>>>>> +
>>>>> +    clk_bulk_disable(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int __maybe_unused ingenic_rproc_resume(struct device *dev)
>>>>> +{
>>>>> +    struct vpu *vpu = dev_get_drvdata(dev);
>>>>> +
>>>>> +    return clk_bulk_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
>>>>> +}
>>>>> +
>>>>> +static const struct dev_pm_ops __maybe_unused ingenic_rproc_pm = {
>>>>> +    SET_RUNTIME_PM_OPS(ingenic_rproc_suspend, 
>>>>> ingenic_rproc_resume, NULL)
>>>>> +};
>>>>> +
>>>>> +static struct platform_driver ingenic_rproc_driver = {
>>>>> +    .probe = ingenic_rproc_probe,
>>>>> +    .driver = {
>>>>> +        .name = "ingenic-vpu",
>>>>> +#ifdef CONFIG_PM
>>>>
>>>> Not sure why you would want to maintain this conditional, because 
>>>> runtime_pm is a core dependency now for your driver to work properly.
>>>
>>> No, it is not - the driver works perfectly fine with CONFIG_PM 
>>> being disabled, and having a hardcoded dependency on CONFIG_PM is 
>>> not something we want.
>>
>> OK, so if IIUC, in general CONFIG_PM is not a typical usage for your 
>> MIPS platforms. Your driver is the first non-ARM remoteproc driver :), 
>> CONFIG_PM is almost a given on most ARM platforms.
>>
>> So, I fail to see how your clocks can stay disabled then when 
>> CONFIG_PM=n if the remoteproc fails to load with the current code, 
>> which was your primary argument for using prepare/unprepare (based on 
>> comments on prior versions). It looks to me that your needs are indeed 
>> better suited with the prepare/unprepare ops as in your initial series.
> 
> Yes, I find the rpm in remoteproc core solution more elegant, but that 
> doesn't work as well for me in the CONFIG_PM=n case.
> 
>> And in the case of CONFIG_PM=y, you have three levels of code that 
>> enables the clocks (the bare clk API, the pm_runtime_get in probe, and 
>> the pm_runtime_get in the remoteproc core). Depending on the rpm 
>> status, it may or may not invoke the callbacks.
> 
> pm_runtime_get() in the probe won't call pm_resume, since the rpm status 
> is marked as active with pm_runtime_set_active(), so the clocks are 
> enabled only once in the probe. 

Right, that's what I meant by last sentence above.

And even if the remoteproc core calls
> pm_runtime_get() in the middle of the probe (why would it?) it would 
> still work fine since the clock enable/disable API is reference-counted.

Yeah, mostly it won't happen because of the firmware_class loading, and 
you will run through the end of your probe before you get loaded.

So, how critical is this disabling clocks feature, because it doesn't 
work in your preferred CONFIG_PM=n case. And if the most common way for 
you is to load and unload from userspace anyway, you can just manage the 
clocks in probe and remove, and rely on modprobe or sysfs bind/unbind to 
ensure the clocks stay disabled.

regards
Suman

> 
> Cheers,
> -Paul
> 
>> regards
>> Suman
>>
>>>
>>> Cheers,
>>> -Paul
>>>
>>>> regards
>>>> Suman
>>>>
>>>>> +        .pm = &ingenic_rproc_pm,
>>>>> +#endif
>>>>> +        .of_match_table = ingenic_rproc_of_matches,
>>>>> +    },
>>>>> +};
>>>>> +module_platform_driver(ingenic_rproc_driver);
>>>>> +
>>>>> +MODULE_LICENSE("GPL");
>>>>> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>>>> +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control driver");
>>>>>
>>>>
>>>
>>>
>>
> 
> 

