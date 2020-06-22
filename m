Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41C8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF0220707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="y/k/kI/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgFVRvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:51:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730038AbgFVRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:51:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MHZH8r029291;
        Mon, 22 Jun 2020 19:51:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=+PZsq8pFjVtQXiwxiX30dj4ToQd67jSm/ujam/GPUnM=;
 b=y/k/kI/BEZfSRPgEhSyAorUbrMGEkO40uaKtDL8O28sh8GMZGDJ3spw0kOITNq3TjC05
 Pf9ajyufwqEAi9TkLiHhBTrcIxr8lcQz2sW2GfSUvlcIldl+a5ROUcLW7VfK2/f+UlPt
 9WN1s9AvXJBjuJIUDJOfmb8p1ZFNQ61tOGhLyJzxz8/d5G9vi3MRjaYBTCENajpuZHUh
 WA4LmlyW/zXB1rlnGXZLau9/Q5MF6kW/C8ew7CcULefBV65QXNqkQh4FDxdM3TE0T7vV
 sM3o6KFA2y8UrF/Y4crFHoHMqDqg27eEwrdbVtLqz8yxjY7oFbygxGstdX/mIIppLxv0 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31s9bhts7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 19:51:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4BD7410002A;
        Mon, 22 Jun 2020 19:51:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10DFD2C90A2;
        Mon, 22 Jun 2020 19:51:28 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 19:51:26 +0200
Subject: Re: [PATCH v7 3/5] remoteproc: Add support for runtime PM
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "od@zcrc.me" <od@zcrc.me>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20200515104340.10473-1-paul@crapouillou.net>
 <20200515104340.10473-3-paul@crapouillou.net>
 <035bf8ad-3ef0-8314-ae5c-a94a24c230c8@ti.com>
 <P2TQAQ.3VDG3B8W2EPF3@crapouillou.net>
 <daa239fe-afd4-ff2e-3d5c-db09434cac95@ti.com>
 <9XPMBQ.UM94FDID8MZW@crapouillou.net>
 <107dc1d3-05c6-61be-b82c-197f0c43cdba@ti.com>
 <VUEPBQ.GMXO6YRLF7N22@crapouillou.net> <20200611043951.GA3251@builder.lan>
 <b877e6cf-b519-0926-01d2-ff5a41f0ef15@ti.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <1e526a91-9322-c1dd-79aa-b47ffcf11694@st.com>
Date:   Mon, 22 Jun 2020 19:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b877e6cf-b519-0926-01d2-ff5a41f0ef15@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_10:2020-06-22,2020-06-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On 6/11/20 11:17 PM, Suman Anna wrote:
> On 6/10/20 11:39 PM, Bjorn Andersson wrote:
>> On Wed 10 Jun 02:40 PDT 2020, Paul Cercueil wrote:
>>
>>> Hi,
>>>
>>> Le lun. 8 juin 2020 à 18:10, Suman Anna <s-anna@ti.com> a écrit :
>>>> Hi Paul,
>>>>
>>>> On 6/8/20 5:46 PM, Paul Cercueil wrote:
>>>>> Hi Suman,
>>>>>
>>>>>>>> On 5/15/20 5:43 AM, Paul Cercueil wrote:
>>>>>>>>> Call pm_runtime_get_sync() before the firmware is loaded, and
>>>>>>>>> pm_runtime_put() after the remote processor has been stopped.
>>>>>>>>>
>>>>>>>>> Even though the remoteproc device has no PM
>>>>>>>>> callbacks, this allows the
>>>>>>>>> parent device's PM callbacks to be properly called.
>>>>>>>>
>>>>>>>> I see this patch staged now for 5.8, and the latest
>>>>>>>> -next branch has broken the pm-runtime autosuspend
>>>>>>>> feature we have in the OMAP remoteproc driver. See
>>>>>>>> commit 5f31b232c674 ("remoteproc/omap: Add support
>>>>>>>> for runtime auto-suspend/resume").
>>>>>>>>
>>>>>>>> What was the original purpose of this patch, because
>>>>>>>> there can be differing backends across different
>>>>>>>> SoCs.
>>>>>>>
>>>>>>> Did you try pm_suspend_ignore_children()? It looks like it
>>>>>>> was made for your use-case.
>>>>>>
>>>>>> Sorry for the delay in getting back. So, using
>>>>>> pm_suspend_ignore_children() does fix my current issue.
>>>>>>
>>>>>> But I still fail to see the original purpose of this patch in
>>>>>> the remoteproc core especially given that the core itself does
>>>>>> not have any callbacks. If the sole intention was to call the
>>>>>> parent pdev's callbacks, then I feel that state-machine is
>>>>>> better managed within that particular platform driver itself,
>>>>>> as the sequencing/device management can vary with different
>>>>>> platform drivers.
>>>>>
>>>>> The problem is that with Ingenic SoCs some clocks must be enabled in
>>>>> order to load the firmware, and the core doesn't give you an option
>>>>> to register a callback to be called before loading it.
>>>>
>>>> Yep, I have similar usage in one of my remoteproc drivers (see
>>>> keystone_remoteproc.c), and I think this all stems from the need to
>>>> use/support loading into a processor's internal memories. My driver does
>>>> leverage the pm-clks backend plugged into pm_runtime, so you won't see
>>>> explicit calls on the clocks.
>>>>
>>>> I guess the question is what exact PM features you are looking for with
>>>> the Ingenic SoC. I do see you are using pm_runtime autosuspend, and your
>>>> callbacks are managing the clocks, but reset is managed only in
>>>> start/stop.
>>>>
>>>>> The first version of my patchset added .prepare/.unprepare
>>>>> callbacks to the struct rproc_ops, but the feedback from the
>>>>> maintainers was that I should do it via runtime PM. However, it was
>>>>> not possible to keep it contained in the driver, since again the
>>>>> core doesn't provide a "prepare" callback, so no place to call
>>>>> pm_runtime_get_sync().
>>>> FWIW, the .prepare/.unprepare callbacks is actually now part of the
>>>> rproc core. Looks like multiple developers had a need for this, and this
>>>> functionality went in at the same time as your driver :). Not sure if
>>>> you looked up the prior patches, I leveraged the patch that Loic had
>>>> submitted a long-time ago, and a revised version of it is now part of
>>>> 5.8-rc1.
>>>
>>> WTF maintainers, you refuse my patchset for adding a .prepare/.unprepare,
>>> ask me to do it via runtime PM, then merge another patchset that adds these
>>> callback. At least be constant in your decisions.
>>>
>>
>> Sorry, I missed this when applying the two patches, but you're of course
>> right.
>>
>>> Anyway, now we have two methods added to linux-next for doing the exact same
>>> thing. What should we do about it?
>>>
>>
>> I like the pm_runtime approach and as it was Arnaud that asked you to
>> change it, perhaps he and Loic can agree on updating the ST driver so we
>> can drop the prepare/unprepare ops again?
> 
> These callbacks were added primarily in preparation for the TI K3 rproc 
> drivers, not just ST (the patch was resurrected from a very old patch 
> from Loic).
> 
> I still think prepare/unprepare is actually better suited to scale well 
> for the long term. This pm_runtime logic will now make the early-boot 
> scenarios complicated, as you would have to match its status, but all 
> actual operations are on the actual parent remoteproc platform device 
> and not the child remoteproc device. I think it serves to mess up the 
> state-machines of different platform drivers due to additional refcounts 
> acquired and maybe performing some operations out of sequence to what a 
> platform driver wants esp. if there is automated backend usage like 
> genpd, pm_clks etc. I am yet to review Mathieu's latest MCU sync series, 
> but the concept of different sync_ops already scales w.r.t the 
> prepare/unprepare.


> 
> As for my K3 drivers, the callbacks are doing more than just turning on 
> clocks, as the R5Fs in general as a complex power-on sequence. I do not 
> have remoteproc auto-suspend atm on the K3 drivers, but that typically 
> means shutting down and restoring the core and would involve all the 
> hardware-specific sequences, so the rpm callback implementations will be 
> more than just clocks.
> 
> I looked through the patch history on the Ingenic remoteproc driver, and 
> the only reason for either of runtime pm usage or prepare/unprepare ops 
> usage is to ensure that clocks do not stay enabled in the case the 
> processor is not loaded/started. The driver is using auto-boot, so when 
> it probes, in general we expect the remoteproc to be running. So, the 
> only failure case is if there is no firmware. Otherwise, Paul could have 
> just used clk_bulk API in probe and remove.
> 
> Anyway, I will provide some additional review comments on the pm_runtime 
> usage within the Ingenic rproc driver.

Sorry for the late answer...

Prepare/unprepare was proposed by Loïc for the memory management series.
We abandoned it and migrated the memory registrations in parse_fw ops.
So we don't use it anymore in ST.

I suggested the pm-runtime before TI patchset, as it was matching
with Ingenic driver need. 
Now with the additional need introduced by Suman, seems that it is not sufficient
for the K3-r5, due to the memory initialization.

Anyway do we have to choice between the 2 implementations?
Look to me that the pm_runtime could be used to manage the power for the
remoteproc device (and perhaps associated power domain).
While the .prepare is more for additional resources
which ,need to be initialized before loading the firmware (such as some specific
system resources).

Regards,
Arnaud

> 
> regards
> Suman
> 
