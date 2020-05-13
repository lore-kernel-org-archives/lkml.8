Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A094C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF682054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kQe1A1lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgEMWcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:32:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56562 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbgEMWcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:32:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DMVpi5022860;
        Wed, 13 May 2020 17:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589409111;
        bh=wpC4NeO+HpUXSvG9zpusitUlas7P/Sa0nfDeG97/ReQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kQe1A1lPTW7cz3S9FMQ4egy1jfAwoMPDZTDOYGLRrUrEA9YZTvdeqq52s42T67X3F
         1v63wdd6nVBNdx937FZD45+wRoeyPzpFWXBLFCImcrbe8UqM6b3kZMYAhr7ggpj0yu
         rnSgztxaYK7n/MWhk04LzVZ3+WCybYTF34w4/vZM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DMVpbk113101
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 17:31:51 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 17:31:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 17:31:51 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DMVpjG127310;
        Wed, 13 May 2020 17:31:51 -0500
Subject: Re: [PATCH 3/3] remoteproc/k3-dsp: Add support for L2RAM loading on
 C66x DSPs
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200325201839.15896-1-s-anna@ti.com>
 <20200325201839.15896-4-s-anna@ti.com> <20200428195855.GC10552@xps15>
 <CANLsYkwgCJrDu-Y5iyG0maCVqFqDXW_0vD4Sv2e+-dwryTNaRA@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <23097792-5166-09f1-9343-0b5626a9cb03@ti.com>
Date:   Wed, 13 May 2020 17:31:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwgCJrDu-Y5iyG0maCVqFqDXW_0vD4Sv2e+-dwryTNaRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 4/28/20 3:09 PM, Mathieu Poirier wrote:
> On Tue, 28 Apr 2020 at 13:58, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> On Wed, Mar 25, 2020 at 03:18:39PM -0500, Suman Anna wrote:
>>> The resets for the DSP processors on K3 SoCs are managed through the
>>> Power and Sleep Controller (PSC) module. Each DSP typically has two
>>> resets - a global module reset for powering on the device, and a local
>>> reset that affects only the CPU while allowing access to the other
>>> sub-modules within the DSP processor sub-systems.
>>>
>>> The C66x DSPs have two levels of internal RAMs that can be used to
>>> boot from, and the firmware loading into these RAMs require the
>>> local reset to be asserted with the device powered on/enabled using
>>> the module reset. Enhance the K3 DSP remoteproc driver to add support
>>> for loading into the internal RAMs. The local reset is deasserted on
>>> SoC power-on-reset, so logic has to be added in probe in remoteproc
>>> mode to balance the remoteproc state-machine.
>>>
>>> Note that the local resets are a no-op on C71x cores, and the hardware
>>> does not supporting loading into its internal RAMs.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>>   drivers/remoteproc/ti_k3_dsp_remoteproc.c | 82 +++++++++++++++++++++++
>>>   1 file changed, 82 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>>> index fd0d84f46f90..7b712ef74611 100644
>>> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>>> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>>> @@ -175,6 +175,9 @@ static int k3_dsp_rproc_reset(struct k3_dsp_rproc *kproc)
>>>                return ret;
>>>        }
>>>
>>> +     if (kproc->data->uses_lreset)
>>> +             return ret;
>>> +
>>>        ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
>>>                                                    kproc->ti_sci_id);
>>>        if (ret) {
>>> @@ -192,6 +195,9 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>>>        struct device *dev = kproc->dev;
>>>        int ret;
>>>
>>> +     if (kproc->data->uses_lreset)
>>> +             goto lreset;
>>> +
>>>        ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
>>>                                                   kproc->ti_sci_id);
>>>        if (ret) {
>>> @@ -199,6 +205,7 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>>>                return ret;
>>>        }
>>>
>>> +lreset:
>>>        ret = reset_control_deassert(kproc->reset);
>>>        if (ret) {
>>>                dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
>>> @@ -210,6 +217,63 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>>>        return ret;
>>>   }
>>>
>>> +/*
>>> + * The C66x DSP cores have a local reset that affects only the CPU, and a
>>> + * generic module reset that powers on the device and allows the DSP internal
>>> + * memories to be accessed while the local reset is asserted. This function is
>>> + * used to release the global reset on C66x DSPs to allow loading into the DSP
>>> + * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
>>> + * firmware loading, and is followed by the .start() ops after loading to
>>> + * actually let the C66x DSP cores run. The local reset on C71x cores is a
>>> + * no-op and the global reset cannot be released on C71x cores until after
>>> + * the firmware images are loaded, so this function does nothing for C71x cores.
>>> + */
>>> +static int k3_dsp_rproc_prepare(struct rproc *rproc)
>>> +{
>>> +     struct k3_dsp_rproc *kproc = rproc->priv;
>>> +     struct device *dev = kproc->dev;
>>> +     int ret;
>>> +
>>> +     /* local reset is no-op on C71x processors */
>>> +     if (!kproc->data->uses_lreset)
>>> +             return 0;
>>
>> In k3_dsp_rproc_release() the condition is "if (kproc->data->uses_lreset)" and
>> here it is the opposite, which did a good job at getting me confused.

Do you prefer I add a comment there? It needs to bail out there since 
the get_device portion would be executed here.

>>
>> Taking a step back, I assume c71 DSPs will have their own k3_dsp_dev_data where
>> the users_lreset flag will be false.  

Yes.

In that case I think it would make the
>> code easier to understand if the k3_dsp_rproc_ops was declared without the
>> .prepare and .unprepare.  In probe(), if data->uses_lreset is true then
>> k3_dsp_rproc_prepare() and k3_dsp_rproc_unprepare() are set.

Yeah, ok, that will avoid the confusion and limit the 
prepare()/unprepare() only for C66 DSPs.

>>
> 
> I forgot... Since this is a C71 related change, was there a reason to
> lump it with the C66 set?  If not I would simply move that to the C71
> work.

OK, I can remove this logic here, and add the prepare()/unprepare() 
conditionally for C66x in the C71 patch.

> 
>> I am done reviewing this set.

Thanks for all the review comments.

regards
Suman

>>
>> Thanks,
>> Mathieu
>>
>>> +
>>> +     ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
>>> +                                                 kproc->ti_sci_id);
>>> +     if (ret)
>>> +             dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
>>> +                     ret);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +/*
>>> + * This function implements the .unprepare() ops and performs the complimentary
>>> + * operations to that of the .prepare() ops. The function is used to assert the
>>> + * global reset on applicable C66x cores. This completes the second portion of
>>> + * powering down the C66x DSP cores. The cores themselves are only halted in the
>>> + * .stop() callback through the local reset, and the .unprepare() ops is invoked
>>> + * by the remoteproc core after the remoteproc is stopped to balance the global
>>> + * reset.
>>> + */
>>> +static int k3_dsp_rproc_unprepare(struct rproc *rproc)
>>> +{
>>> +     struct k3_dsp_rproc *kproc = rproc->priv;
>>> +     struct device *dev = kproc->dev;
>>> +     int ret;
>>> +
>>> +     /* local reset is no-op on C71x processors */
>>> +     if (!kproc->data->uses_lreset)
>>> +             return 0;
>>> +
>>> +     ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
>>> +                                                 kproc->ti_sci_id);
>>> +     if (ret)
>>> +             dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>   /*
>>>    * Power up the DSP remote processor.
>>>    *
>>> @@ -353,6 +417,8 @@ static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>>>   }
>>>
>>>   static const struct rproc_ops k3_dsp_rproc_ops = {
>>> +     .prepare        = k3_dsp_rproc_prepare,
>>> +     .unprepare      = k3_dsp_rproc_unprepare,
>>>        .start          = k3_dsp_rproc_start,
>>>        .stop           = k3_dsp_rproc_stop,
>>>        .kick           = k3_dsp_rproc_kick,
>>> @@ -644,6 +710,22 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>>>                goto disable_clk;
>>>        }
>>>
>>> +     /*
>>> +      * ensure the DSP local reset is asserted to ensure the DSP doesn't
>>> +      * execute bogus code in .prepare() when the module reset is released.
>>> +      */
>>> +     if (data->uses_lreset) {
>>> +             ret = reset_control_status(kproc->reset);
>>> +             if (ret < 0) {
>>> +                     dev_err(dev, "failed to get reset status, status = %d\n",
>>> +                             ret);
>>> +                     goto release_mem;
>>> +             } else if (ret == 0) {
>>> +                     dev_warn(dev, "local reset is deasserted for device\n");
>>> +                     k3_dsp_rproc_reset(kproc);
>>> +             }
>>> +     }
>>> +
>>>        ret = rproc_add(rproc);
>>>        if (ret) {
>>>                dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
>>> --
>>> 2.23.0
>>>

