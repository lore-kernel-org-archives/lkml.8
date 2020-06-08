Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5C4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267392078B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="spLeCZCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFHWqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:46:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45996 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgFHWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1591656391; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27Rv1Q6nYslL7GrWdq47XLrEYYLVoo4sA7By/cpIaqc=;
        b=spLeCZCLUeEuXvhm+USTmV2SAeWIGUBiPX5V2tryieK6iLWVFK00l2ZuXRGgw+LavDVQ7E
        secwbfIbqhpXMBVK3Alkt477dIvR9wyK3GfDI+U1fYyAc9fpHcpfyl+Om7pSuFtAWoN0XQ
        2jqsTSqp2tUISxAR0YbYseEASuMcCu8=
Date:   Tue, 09 Jun 2020 00:46:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v7 3/5] remoteproc: Add support for runtime PM
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Message-Id: <9XPMBQ.UM94FDID8MZW@crapouillou.net>
In-Reply-To: <daa239fe-afd4-ff2e-3d5c-db09434cac95@ti.com>
References: <20200515104340.10473-1-paul@crapouillou.net>
        <20200515104340.10473-3-paul@crapouillou.net>
        <035bf8ad-3ef0-8314-ae5c-a94a24c230c8@ti.com>
        <P2TQAQ.3VDG3B8W2EPF3@crapouillou.net>
        <daa239fe-afd4-ff2e-3d5c-db09434cac95@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>> Call pm_runtime_get_sync() before the firmware is loaded, and
>>>> pm_runtime_put() after the remote processor has been stopped.
>>>> 
>>>> Even though the remoteproc device has no PM callbacks, this allows 
>>>> the
>>>> parent device's PM callbacks to be properly called.
>>> 
>>> I see this patch staged now for 5.8, and the latest -next branch 
>>> has broken the pm-runtime autosuspend feature we have in the OMAP 
>>> remoteproc driver. See commit 5f31b232c674 ("remoteproc/omap: Add 
>>> support for runtime auto-suspend/resume").
>>> 
>>> What was the original purpose of this patch, because there can be 
>>> differing backends across different SoCs.
>> 
>> Did you try pm_suspend_ignore_children()? It looks like it was made 
>> for your use-case.
> 
> Sorry for the delay in getting back. So, using 
> pm_suspend_ignore_children() does fix my current issue.
> 
> But I still fail to see the original purpose of this patch in the 
> remoteproc core especially given that the core itself does not have 
> any callbacks. If the sole intention was to call the parent pdev's 
> callbacks, then I feel that state-machine is better managed within 
> that particular platform driver itself, as the sequencing/device 
> management can vary with different platform drivers.

The problem is that with Ingenic SoCs some clocks must be enabled in 
order to load the firmware, and the core doesn't give you an option to 
register a callback to be called before loading it. The first version 
of my patchset added .prepare/.unprepare callbacks to the struct 
rproc_ops, but the feedback from the maintainers was that I should do 
it via runtime PM. However, it was not possible to keep it contained in 
the driver, since again the core doesn't provide a "prepare" callback, 
so no place to call pm_runtime_get_sync(). So we settled with having 
runtime PM in the core without callbacks, which will trigger the 
runtime PM callbacks of the driver at the right moment.

Sorry if that caused you trouble.

Cheers,
-Paul
>>> 

>>> 
>>>> 
>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>> ---
>>>> 
>>>> Notes:
>>>>      v2-v4: No change
>>>>      v5: Move calls to prepare/unprepare to 
>>>> rproc_fw_boot/rproc_shutdown
>>>>      v6: Instead of prepare/unprepare callbacks, use PM runtime 
>>>> callbacks
>>>>      v7: Check return value of pm_runtime_get_sync()
>>>> 
>>>>   drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
>>>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>>>> b/drivers/remoteproc/remoteproc_core.c
>>>> index a7f96bc98406..e33d1ef27981 100644
>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>> @@ -29,6 +29,7 @@
>>>>   #include <linux/devcoredump.h>
>>>>   #include <linux/rculist.h>
>>>>   #include <linux/remoteproc.h>
>>>> +#include <linux/pm_runtime.h>
>>>>   #include <linux/iommu.h>
>>>>   #include <linux/idr.h>
>>>>   #include <linux/elf.h>
>>>> @@ -1382,6 +1383,12 @@ static int rproc_fw_boot(struct rproc 
>>>> *rproc, const struct firmware *fw)
>>>>       if (ret)
>>>>           return ret;
>>>>   +    ret = pm_runtime_get_sync(dev);
>>>> +    if (ret < 0) {
>>>> +        dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>       dev_info(dev, "Booting fw image %s, size %zd\n", name, 
>>>> fw->size);
>>>>         /*
>>>> @@ -1391,7 +1398,7 @@ static int rproc_fw_boot(struct rproc 
>>>> *rproc, const struct firmware *fw)
>>>>       ret = rproc_enable_iommu(rproc);
>>>>       if (ret) {
>>>>           dev_err(dev, "can't enable iommu: %d\n", ret);
>>>> -        return ret;
>>>> +        goto put_pm_runtime;
>>>>       }
>>>>         rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>>>> @@ -1435,6 +1442,8 @@ static int rproc_fw_boot(struct rproc 
>>>> *rproc, const struct firmware *fw)
>>>>       rproc->table_ptr = NULL;
>>>>   disable_iommu:
>>>>       rproc_disable_iommu(rproc);
>>>> +put_pm_runtime:
>>>> +    pm_runtime_put(dev);
>>>>       return ret;
>>>>   }
>>>>   @@ -1840,6 +1849,8 @@ void rproc_shutdown(struct rproc *rproc)
>>>>         rproc_disable_iommu(rproc);
>>>>   +    pm_runtime_put(dev);
>>>> +
>>>>       /* Free the copy of the resource table */
>>>>       kfree(rproc->cached_table);
>>>>       rproc->cached_table = NULL;
>>>> @@ -2118,6 +2129,9 @@ struct rproc *rproc_alloc(struct device 
>>>> *dev, const char *name,
>>>>         rproc->state = RPROC_OFFLINE;
>>>>   +    pm_runtime_no_callbacks(&rproc->dev);
>>>> +    pm_runtime_enable(&rproc->dev);
>>>> +
>>>>       return rproc;
>>>>   }
>>>>   EXPORT_SYMBOL(rproc_alloc);
>>>> @@ -2133,6 +2147,7 @@ EXPORT_SYMBOL(rproc_alloc);
>>>>    */
>>>>   void rproc_free(struct rproc *rproc)
>>>>   {
>>>> +    pm_runtime_disable(&rproc->dev);
>>>>       put_device(&rproc->dev);
>>>>   }
>>>>   EXPORT_SYMBOL(rproc_free);
>>>> 
>>> 


