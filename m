Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14A420720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DL2kOzOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgFKVRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:17:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgFKVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:17:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05BLH9CF102368;
        Thu, 11 Jun 2020 16:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591910229;
        bh=SmVf5z+uPxAwVHzHogMC1cxqd7jWMeEM7ZJxKNhZeGA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DL2kOzOgQWTQgQ9dPHKaKHF6MoqBD27joWzX0lJ0FvnkMdhoAJZgdoWGpFIyJRYnF
         cux1f2ecvZSvnTOYP71W9m6qdmSaTvg8QgJAOHD2PLYNivH619grsArcBOlNIDtDaC
         S0Rzs7VQUo3RMPuLfo67cGwi0BPw1MYnMmCibDTs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05BLH9XL073055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 16:17:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 11
 Jun 2020 16:17:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 11 Jun 2020 16:17:09 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05BLH5Up051553;
        Thu, 11 Jun 2020 16:17:08 -0500
Subject: Re: [PATCH v7 3/5] remoteproc: Add support for runtime PM
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>, <od@zcrc.me>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20200515104340.10473-1-paul@crapouillou.net>
 <20200515104340.10473-3-paul@crapouillou.net>
 <035bf8ad-3ef0-8314-ae5c-a94a24c230c8@ti.com>
 <P2TQAQ.3VDG3B8W2EPF3@crapouillou.net>
 <daa239fe-afd4-ff2e-3d5c-db09434cac95@ti.com>
 <9XPMBQ.UM94FDID8MZW@crapouillou.net>
 <107dc1d3-05c6-61be-b82c-197f0c43cdba@ti.com>
 <VUEPBQ.GMXO6YRLF7N22@crapouillou.net> <20200611043951.GA3251@builder.lan>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b877e6cf-b519-0926-01d2-ff5a41f0ef15@ti.com>
Date:   Thu, 11 Jun 2020 16:17:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611043951.GA3251@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 11:39 PM, Bjorn Andersson wrote:
> On Wed 10 Jun 02:40 PDT 2020, Paul Cercueil wrote:
> 
>> Hi,
>>
>> Le lun. 8 juin 2020 à 18:10, Suman Anna <s-anna@ti.com> a écrit :
>>> Hi Paul,
>>>
>>> On 6/8/20 5:46 PM, Paul Cercueil wrote:
>>>> Hi Suman,
>>>>
>>>>>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>>>>>> Call pm_runtime_get_sync() before the firmware is loaded, and
>>>>>>>> pm_runtime_put() after the remote processor has been stopped.
>>>>>>>>
>>>>>>>> Even though the remoteproc device has no PM
>>>>>>>> callbacks, this allows the
>>>>>>>> parent device's PM callbacks to be properly called.
>>>>>>>
>>>>>>> I see this patch staged now for 5.8, and the latest
>>>>>>> -next branch has broken the pm-runtime autosuspend
>>>>>>> feature we have in the OMAP remoteproc driver. See
>>>>>>> commit 5f31b232c674 ("remoteproc/omap: Add support
>>>>>>> for runtime auto-suspend/resume").
>>>>>>>
>>>>>>> What was the original purpose of this patch, because
>>>>>>> there can be differing backends across different
>>>>>>> SoCs.
>>>>>>
>>>>>> Did you try pm_suspend_ignore_children()? It looks like it
>>>>>> was made for your use-case.
>>>>>
>>>>> Sorry for the delay in getting back. So, using
>>>>> pm_suspend_ignore_children() does fix my current issue.
>>>>>
>>>>> But I still fail to see the original purpose of this patch in
>>>>> the remoteproc core especially given that the core itself does
>>>>> not have any callbacks. If the sole intention was to call the
>>>>> parent pdev's callbacks, then I feel that state-machine is
>>>>> better managed within that particular platform driver itself,
>>>>> as the sequencing/device management can vary with different
>>>>> platform drivers.
>>>>
>>>> The problem is that with Ingenic SoCs some clocks must be enabled in
>>>> order to load the firmware, and the core doesn't give you an option
>>>> to register a callback to be called before loading it.
>>>
>>> Yep, I have similar usage in one of my remoteproc drivers (see
>>> keystone_remoteproc.c), and I think this all stems from the need to
>>> use/support loading into a processor's internal memories. My driver does
>>> leverage the pm-clks backend plugged into pm_runtime, so you won't see
>>> explicit calls on the clocks.
>>>
>>> I guess the question is what exact PM features you are looking for with
>>> the Ingenic SoC. I do see you are using pm_runtime autosuspend, and your
>>> callbacks are managing the clocks, but reset is managed only in
>>> start/stop.
>>>
>>>> The first version of my patchset added .prepare/.unprepare
>>>> callbacks to the struct rproc_ops, but the feedback from the
>>>> maintainers was that I should do it via runtime PM. However, it was
>>>> not possible to keep it contained in the driver, since again the
>>>> core doesn't provide a "prepare" callback, so no place to call
>>>> pm_runtime_get_sync().
>>> FWIW, the .prepare/.unprepare callbacks is actually now part of the
>>> rproc core. Looks like multiple developers had a need for this, and this
>>> functionality went in at the same time as your driver :). Not sure if
>>> you looked up the prior patches, I leveraged the patch that Loic had
>>> submitted a long-time ago, and a revised version of it is now part of
>>> 5.8-rc1.
>>
>> WTF maintainers, you refuse my patchset for adding a .prepare/.unprepare,
>> ask me to do it via runtime PM, then merge another patchset that adds these
>> callback. At least be constant in your decisions.
>>
> 
> Sorry, I missed this when applying the two patches, but you're of course
> right.
> 
>> Anyway, now we have two methods added to linux-next for doing the exact same
>> thing. What should we do about it?
>>
> 
> I like the pm_runtime approach and as it was Arnaud that asked you to
> change it, perhaps he and Loic can agree on updating the ST driver so we
> can drop the prepare/unprepare ops again?

These callbacks were added primarily in preparation for the TI K3 rproc 
drivers, not just ST (the patch was resurrected from a very old patch 
from Loic).

I still think prepare/unprepare is actually better suited to scale well 
for the long term. This pm_runtime logic will now make the early-boot 
scenarios complicated, as you would have to match its status, but all 
actual operations are on the actual parent remoteproc platform device 
and not the child remoteproc device. I think it serves to mess up the 
state-machines of different platform drivers due to additional refcounts 
acquired and maybe performing some operations out of sequence to what a 
platform driver wants esp. if there is automated backend usage like 
genpd, pm_clks etc. I am yet to review Mathieu's latest MCU sync series, 
but the concept of different sync_ops already scales w.r.t the 
prepare/unprepare.

As for my K3 drivers, the callbacks are doing more than just turning on 
clocks, as the R5Fs in general as a complex power-on sequence. I do not 
have remoteproc auto-suspend atm on the K3 drivers, but that typically 
means shutting down and restoring the core and would involve all the 
hardware-specific sequences, so the rpm callback implementations will be 
more than just clocks.

I looked through the patch history on the Ingenic remoteproc driver, and 
the only reason for either of runtime pm usage or prepare/unprepare ops 
usage is to ensure that clocks do not stay enabled in the case the 
processor is not loaded/started. The driver is using auto-boot, so when 
it probes, in general we expect the remoteproc to be running. So, the 
only failure case is if there is no firmware. Otherwise, Paul could have 
just used clk_bulk API in probe and remove.

Anyway, I will provide some additional review comments on the pm_runtime 
usage within the Ingenic rproc driver.

regards
Suman

