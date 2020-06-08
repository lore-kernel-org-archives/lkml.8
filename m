Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967872078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sNLV/DmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgFIAs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:48:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48224 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgFHXKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:10:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 058NAi4F060849;
        Mon, 8 Jun 2020 18:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591657844;
        bh=J15eJufKdDHorGHaYKdBz4fOpJXaofZH0gLXbZy+af4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sNLV/DmZnULJuDOJYu9WDMgnzhgTBpfc+gZVE24GmrdNpm/BaeTxTkn7RXro2QdHh
         f+PtS5/zox1sRzGEr73qdNqenszENbRmHt2OtNIP2siu7SyDNa4wSzYNSlgEiphQyJ
         NIJzoTuStuqacbcd38bWFfZ64HcfmKAholGBF0HM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 058NAiBX072956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 18:10:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Jun
 2020 18:10:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Jun 2020 18:10:44 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 058NAiXa040586;
        Mon, 8 Jun 2020 18:10:44 -0500
Subject: Re: [PATCH v7 3/5] remoteproc: Add support for runtime PM
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, <od@zcrc.me>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <20200515104340.10473-1-paul@crapouillou.net>
 <20200515104340.10473-3-paul@crapouillou.net>
 <035bf8ad-3ef0-8314-ae5c-a94a24c230c8@ti.com>
 <P2TQAQ.3VDG3B8W2EPF3@crapouillou.net>
 <daa239fe-afd4-ff2e-3d5c-db09434cac95@ti.com>
 <9XPMBQ.UM94FDID8MZW@crapouillou.net>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <107dc1d3-05c6-61be-b82c-197f0c43cdba@ti.com>
Date:   Mon, 8 Jun 2020 18:10:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9XPMBQ.UM94FDID8MZW@crapouillou.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 6/8/20 5:46 PM, Paul Cercueil wrote:
> Hi Suman,
> 
>>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>>> Call pm_runtime_get_sync() before the firmware is loaded, and
>>>>> pm_runtime_put() after the remote processor has been stopped.
>>>>>
>>>>> Even though the remoteproc device has no PM callbacks, this allows the
>>>>> parent device's PM callbacks to be properly called.
>>>>
>>>> I see this patch staged now for 5.8, and the latest -next branch 
>>>> has broken the pm-runtime autosuspend feature we have in the 
>>>> OMAP remoteproc driver. See commit 5f31b232c674 ("remoteproc/omap: 
>>>> Add support for runtime auto-suspend/resume").
>>>>
>>>> What was the original purpose of this patch, because there can be 
>>>> differing backends across different SoCs.
>>>
>>> Did you try pm_suspend_ignore_children()? It looks like it was made 
>>> for your use-case.
>>
>> Sorry for the delay in getting back. So, using 
>> pm_suspend_ignore_children() does fix my current issue.
>>
>> But I still fail to see the original purpose of this patch in the 
>> remoteproc core especially given that the core itself does not have 
>> any callbacks. If the sole intention was to call the parent pdev's 
>> callbacks, then I feel that state-machine is better managed within 
>> that particular platform driver itself, as the sequencing/device 
>> management can vary with different platform drivers.
> 
> The problem is that with Ingenic SoCs some clocks must be enabled in 
> order to load the firmware, and the core doesn't give you an option to 
> register a callback to be called before loading it.

Yep, I have similar usage in one of my remoteproc drivers (see 
keystone_remoteproc.c), and I think this all stems from the need to 
use/support loading into a processor's internal memories. My driver does 
leverage the pm-clks backend plugged into pm_runtime, so you won't see 
explicit calls on the clocks.

I guess the question is what exact PM features you are looking for with 
the Ingenic SoC. I do see you are using pm_runtime autosuspend, and your 
callbacks are managing the clocks, but reset is managed only in start/stop.

> The first version of 
> my patchset added .prepare/.unprepare callbacks to the struct rproc_ops, 
> but the feedback from the maintainers was that I should do it via 
> runtime PM. However, it was not possible to keep it contained in the 
> driver, since again the core doesn't provide a "prepare" callback, so no 
> place to call pm_runtime_get_sync(). 

FWIW, the .prepare/.unprepare callbacks is actually now part of the 
rproc core. Looks like multiple developers had a need for this, and this 
functionality went in at the same time as your driver :). Not sure if 
you looked up the prior patches, I leveraged the patch that Loic had 
submitted a long-time ago, and a revised version of it is now part of 
5.8-rc1.

So we settled with having runtime
> PM in the core without callbacks, which will trigger the runtime PM 
> callbacks of the driver at the right moment.

Looks like we can do some cleanup on the Ingenic SoC driver depending on 
the features you want.

regards
Suman

> 
> Sorry if that caused you trouble.
> 
> Cheers,
> -Paul
>>>>
> 
>>>>
>>>>>
>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>      v2-v4: No change
>>>>>      v5: Move calls to prepare/unprepare to 
>>>>> rproc_fw_boot/rproc_shutdown
>>>>>      v6: Instead of prepare/unprepare callbacks, use PM runtime 
>>>>> callbacks
>>>>>      v7: Check return value of pm_runtime_get_sync()
>>>>>
>>>>>   drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
>>>>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>> index a7f96bc98406..e33d1ef27981 100644
>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>> @@ -29,6 +29,7 @@
>>>>>   #include <linux/devcoredump.h>
>>>>>   #include <linux/rculist.h>
>>>>>   #include <linux/remoteproc.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>   #include <linux/iommu.h>
>>>>>   #include <linux/idr.h>
>>>>>   #include <linux/elf.h>
>>>>> @@ -1382,6 +1383,12 @@ static int rproc_fw_boot(struct rproc 
>>>>> *rproc, const struct firmware *fw)
>>>>>       if (ret)
>>>>>           return ret;
>>>>>   +    ret = pm_runtime_get_sync(dev);
>>>>> +    if (ret < 0) {
>>>>> +        dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>>       dev_info(dev, "Booting fw image %s, size %zd\n", name, 
>>>>> fw->size);
>>>>>         /*
>>>>> @@ -1391,7 +1398,7 @@ static int rproc_fw_boot(struct rproc 
>>>>> *rproc, const struct firmware *fw)
>>>>>       ret = rproc_enable_iommu(rproc);
>>>>>       if (ret) {
>>>>>           dev_err(dev, "can't enable iommu: %d\n", ret);
>>>>> -        return ret;
>>>>> +        goto put_pm_runtime;
>>>>>       }
>>>>>         rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>>>>> @@ -1435,6 +1442,8 @@ static int rproc_fw_boot(struct rproc 
>>>>> *rproc, const struct firmware *fw)
>>>>>       rproc->table_ptr = NULL;
>>>>>   disable_iommu:
>>>>>       rproc_disable_iommu(rproc);
>>>>> +put_pm_runtime:
>>>>> +    pm_runtime_put(dev);
>>>>>       return ret;
>>>>>   }
>>>>>   @@ -1840,6 +1849,8 @@ void rproc_shutdown(struct rproc *rproc)
>>>>>         rproc_disable_iommu(rproc);
>>>>>   +    pm_runtime_put(dev);
>>>>> +
>>>>>       /* Free the copy of the resource table */
>>>>>       kfree(rproc->cached_table);
>>>>>       rproc->cached_table = NULL;
>>>>> @@ -2118,6 +2129,9 @@ struct rproc *rproc_alloc(struct device 
>>>>> *dev, const char *name,
>>>>>         rproc->state = RPROC_OFFLINE;
>>>>>   +    pm_runtime_no_callbacks(&rproc->dev);
>>>>> +    pm_runtime_enable(&rproc->dev);
>>>>> +
>>>>>       return rproc;
>>>>>   }
>>>>>   EXPORT_SYMBOL(rproc_alloc);
>>>>> @@ -2133,6 +2147,7 @@ EXPORT_SYMBOL(rproc_alloc);
>>>>>    */
>>>>>   void rproc_free(struct rproc *rproc)
>>>>>   {
>>>>> +    pm_runtime_disable(&rproc->dev);
>>>>>       put_device(&rproc->dev);
>>>>>   }
>>>>>   EXPORT_SYMBOL(rproc_free);
>>>>>
>>>>
> 
> 

