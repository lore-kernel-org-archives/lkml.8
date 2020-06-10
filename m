Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B349204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ce+QbuQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgFJJkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:40:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35056 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgFJJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1591782018; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/On/ehwkZW4dAQENJyOYSDUUPJRshtztM0aVijS26gU=;
        b=ce+QbuQFbGIzGybPr0EWbT7tL9A+5UnZ6SZg8HZN/OiCUaNPR6R9qkbDL1Vmj1pUvDFtOz
        ak0Z5yilp0RgWIRDZ5WT5cW3kEMM1MXnot1tc1YJYW6D71Cppo5LBWW9vEZPpdEQQpYIGC
        BWiUj13/2kCN8Ib28jH0DXmz/uEu9SI=
Date:   Wed, 10 Jun 2020 11:40:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v7 3/5] remoteproc: Add support for runtime PM
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Message-Id: <VUEPBQ.GMXO6YRLF7N22@crapouillou.net>
In-Reply-To: <107dc1d3-05c6-61be-b82c-197f0c43cdba@ti.com>
References: <20200515104340.10473-1-paul@crapouillou.net>
        <20200515104340.10473-3-paul@crapouillou.net>
        <035bf8ad-3ef0-8314-ae5c-a94a24c230c8@ti.com>
        <P2TQAQ.3VDG3B8W2EPF3@crapouillou.net>
        <daa239fe-afd4-ff2e-3d5c-db09434cac95@ti.com>
        <9XPMBQ.UM94FDID8MZW@crapouillou.net>
        <107dc1d3-05c6-61be-b82c-197f0c43cdba@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 8 juin 2020 =E0 18:10, Suman Anna <s-anna@ti.com> a =E9crit :
> Hi Paul,
>=20
> On 6/8/20 5:46 PM, Paul Cercueil wrote:
>> Hi Suman,
>>=20
>>>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>>>> Call pm_runtime_get_sync() before the firmware is loaded, and
>>>>>> pm_runtime_put() after the remote processor has been stopped.
>>>>>>=20
>>>>>> Even though the remoteproc device has no PM callbacks, this=20
>>>>>> allows the
>>>>>> parent device's PM callbacks to be properly called.
>>>>>=20
>>>>> I see this patch staged now for 5.8, and the latest -next branch=20
>>>>> =7F=7F=7F=7Fhas =7F=7Fbroken the pm-runtime autosuspend feature we ha=
ve in=20
>>>>> the =7F=7F=7F=7FOMAP =7F=7Fremoteproc driver. See commit 5f31b232c674=
=20
>>>>> ("remoteproc/omap: =7F=7F=7F=7FAdd =7F=7Fsupport for runtime=20
>>>>> auto-suspend/resume").
>>>>>=20
>>>>> What was the original purpose of this patch, because there can be=20
>>>>> =7F=7F=7F=7F=7F=7Fdiffering backends across different SoCs.
>>>>=20
>>>> Did you try pm_suspend_ignore_children()? It looks like it was=20
>>>> made =7F=7F=7Ffor =7Fyour use-case.
>>>=20
>>> Sorry for the delay in getting back. So, using=20
>>> =7F=7Fpm_suspend_ignore_children() does fix my current issue.
>>>=20
>>> But I still fail to see the original purpose of this patch in the=20
>>> =7F=7Fremoteproc core especially given that the core itself does not=20
>>> have =7F=7Fany callbacks. If the sole intention was to call the parent=20
>>> pdev's =7F=7Fcallbacks, then I feel that state-machine is better=20
>>> managed within =7F=7Fthat particular platform driver itself, as the=20
>>> sequencing/device =7F=7Fmanagement can vary with different platform=20
>>> drivers.
>>=20
>> The problem is that with Ingenic SoCs some clocks must be enabled in=20
>> =7Forder to load the firmware, and the core doesn't give you an option=20
>> to =7Fregister a callback to be called before loading it.
>=20
> Yep, I have similar usage in one of my remoteproc drivers (see=20
> keystone_remoteproc.c), and I think this all stems from the need to=20
> use/support loading into a processor's internal memories. My driver=20
> does leverage the pm-clks backend plugged into pm_runtime, so you=20
> won't see explicit calls on the clocks.
>=20
> I guess the question is what exact PM features you are looking for=20
> with the Ingenic SoC. I do see you are using pm_runtime autosuspend,=20
> and your callbacks are managing the clocks, but reset is managed only=20
> in start/stop.
>=20
>> The first version of =7Fmy patchset added .prepare/.unprepare=20
>> callbacks to the struct rproc_ops, =7Fbut the feedback from the=20
>> maintainers was that I should do it via =7Fruntime PM. However, it was=20
>> not possible to keep it contained in the =7Fdriver, since again the=20
>> core doesn't provide a "prepare" callback, so no =7Fplace to call=20
>> pm_runtime_get_sync().
> FWIW, the .prepare/.unprepare callbacks is actually now part of the=20
> rproc core. Looks like multiple developers had a need for this, and=20
> this functionality went in at the same time as your driver :). Not=20
> sure if you looked up the prior patches, I leveraged the patch that=20
> Loic had submitted a long-time ago, and a revised version of it is=20
> now part of 5.8-rc1.

WTF maintainers, you refuse my patchset for adding a=20
.prepare/.unprepare, ask me to do it via runtime PM, then merge another=20
patchset that adds these callback. At least be constant in your=20
decisions.

Anyway, now we have two methods added to linux-next for doing the exact=20
same thing. What should we do about it?

-Paul

> So we settled with having runtime
>> PM in the core without callbacks, which will trigger the runtime PM=20
>> =7Fcallbacks of the driver at the right moment.
>=20
> Looks like we can do some cleanup on the Ingenic SoC driver depending=20
> on the features you want.
>=20
> regards
> Suman
>=20
>>=20
>> Sorry if that caused you trouble.
>>=20
>> Cheers,
>> -Paul
>>>>>=20
>>=20
>>>>>=20
>>>>>>=20
>>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>>> ---
>>>>>>=20
>>>>>> Notes:
>>>>>>      v2-v4: No change
>>>>>>      v5: Move calls to prepare/unprepare to=20
>>>>>> =7F=7F=7F=7F=7Frproc_fw_boot/rproc_shutdown
>>>>>>      v6: Instead of prepare/unprepare callbacks, use PM runtime=20
>>>>>> =7F=7F=7F=7F=7F=7F=7F=7Fcallbacks
>>>>>>      v7: Check return value of pm_runtime_get_sync()
>>>>>>=20
>>>>>>   drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
>>>>>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c=20
>>>>>> =7F=7F=7F=7F=7F=7F=7F=7Fb/drivers/remoteproc/remoteproc_core.c
>>>>>> index a7f96bc98406..e33d1ef27981 100644
>>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>>> @@ -29,6 +29,7 @@
>>>>>>   #include <linux/devcoredump.h>
>>>>>>   #include <linux/rculist.h>
>>>>>>   #include <linux/remoteproc.h>
>>>>>> +#include <linux/pm_runtime.h>
>>>>>>   #include <linux/iommu.h>
>>>>>>   #include <linux/idr.h>
>>>>>>   #include <linux/elf.h>
>>>>>> @@ -1382,6 +1383,12 @@ static int rproc_fw_boot(struct rproc=20
>>>>>> =7F=7F=7F=7F=7F*rproc, =7F=7F=7Fconst struct firmware *fw)
>>>>>>       if (ret)
>>>>>>           return ret;
>>>>>>   =7F+    ret =3D pm_runtime_get_sync(dev);
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>>       dev_info(dev, "Booting fw image %s, size %zd\n", name,=20
>>>>>> =7F=7F=7F=7F=7Ffw->size);
>>>>>>   =7F      /*
>>>>>> @@ -1391,7 +1398,7 @@ static int rproc_fw_boot(struct rproc=20
>>>>>> =7F=7F=7F=7F=7F*rproc, =7F=7F=7Fconst struct firmware *fw)
>>>>>>       ret =3D rproc_enable_iommu(rproc);
>>>>>>       if (ret) {
>>>>>>           dev_err(dev, "can't enable iommu: %d\n", ret);
>>>>>> -        return ret;
>>>>>> +        goto put_pm_runtime;
>>>>>>       }
>>>>>>   =7F      rproc->bootaddr =3D rproc_get_boot_addr(rproc, fw);
>>>>>> @@ -1435,6 +1442,8 @@ static int rproc_fw_boot(struct rproc=20
>>>>>> =7F=7F=7F=7F=7F*rproc, =7F=7F=7Fconst struct firmware *fw)
>>>>>>       rproc->table_ptr =3D NULL;
>>>>>>   disable_iommu:
>>>>>>       rproc_disable_iommu(rproc);
>>>>>> +put_pm_runtime:
>>>>>> +    pm_runtime_put(dev);
>>>>>>       return ret;
>>>>>>   }
>>>>>>   =7F@@ -1840,6 +1849,8 @@ void rproc_shutdown(struct rproc *rproc)
>>>>>>   =7F      rproc_disable_iommu(rproc);
>>>>>>   =7F+    pm_runtime_put(dev);
>>>>>> +
>>>>>>       /* Free the copy of the resource table */
>>>>>>       kfree(rproc->cached_table);
>>>>>>       rproc->cached_table =3D NULL;
>>>>>> @@ -2118,6 +2129,9 @@ struct rproc *rproc_alloc(struct device=20
>>>>>> =7F=7F=7F=7F=7F*dev, =7F=7F=7Fconst char *name,
>>>>>>   =7F      rproc->state =3D RPROC_OFFLINE;
>>>>>>   =7F+    pm_runtime_no_callbacks(&rproc->dev);
>>>>>> +    pm_runtime_enable(&rproc->dev);
>>>>>> +
>>>>>>       return rproc;
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(rproc_alloc);
>>>>>> @@ -2133,6 +2147,7 @@ EXPORT_SYMBOL(rproc_alloc);
>>>>>>    */
>>>>>>   void rproc_free(struct rproc *rproc)
>>>>>>   {
>>>>>> +    pm_runtime_disable(&rproc->dev);
>>>>>>       put_device(&rproc->dev);
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(rproc_free);
>>>>>>=20
>>>>>=20
>>=20
>>=20
>=20


