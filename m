Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7972253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cMFb1qJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgAUKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:24:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22224 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgAUKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:24:16 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LAO72H001766;
        Tue, 21 Jan 2020 11:24:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=r2PFRu55emQGS1E2Mz3tcIsCBCYBYyUHqyFYKp1Mu/I=;
 b=cMFb1qJ+dm2tbLxHxR18NVP4Jugi37sM0/EHu6ynbN1o6tBT+vH0K17VRnzeDQbO/ztH
 EHQ2zS6rHZJ/Lr9px/rj0hhP6duqOOcL2AJVg9Y0M6lkOsG9pwodh2O/smMmwaPA4r2j
 OqpMwOrilsh6fXqrkXoUalWFKKzPfHuKjcD7abIdQUt4Ug01U9JjwDslX9G/w8KOyCAv
 MRnWwW5SBKvdidjQiIwK4+qLwSRFgvbIwKWNHnn6JQNHMXmjQfI3IB1ioogw44FzIXJf
 2+racS/5qj0AWsByRDa++rIu6luPO0GxtjqNYwqezifSc1SQXuii8upRfMyTnuu+4OHt ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1dx4c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 11:24:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB2A0100038;
        Tue, 21 Jan 2020 11:24:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6EA82AD13B;
        Tue, 21 Jan 2020 11:24:04 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan
 2020 11:24:03 +0100
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
CC:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <od@zcrc.me>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-3-paul@crapouillou.net> <20191221202039.GG549437@yoga>
 <1579122951.3.2@crapouillou.net> <20200120201944.GO1511@yoga>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <894685c4-e5e7-f860-4fe7-b0e3637ed3bb@st.com>
Date:   Tue, 21 Jan 2020 11:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120201944.GO1511@yoga>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-21,2020-01-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,Paul,

On 1/20/20 9:19 PM, Bjorn Andersson wrote:
> On Wed 15 Jan 13:15 PST 2020, Paul Cercueil wrote:
> 
>> Hi Bjorn,
>>
>>
>> Le sam., déc. 21, 2019 at 12:20, Bjorn Andersson
>> <bjorn.andersson@linaro.org> a écrit :
>>> On Tue 10 Dec 08:40 PST 2019, Paul Cercueil wrote:
>>>
>>>>  The .prepare() callback is called before the firmware is loaded to
>>>>  memory. This is useful for instance in the case where some setup is
>>>>  required for the memory to be accessible.
>>>>
>>>
>>> Would it make sense to somehow tie this prepare/unprepare to the actual
>>> struct rproc_mem_entry that needs the resource enabled?
>>
>> Do you need such granularity?
>>
> 
> I don't have such needs, but given some of the memory structure that
> Suman and Loic has been talking about I would expect that such need
> exists
> 
>> In my case, the three memories need the same clock to be enabled.
>>
> 
> But we can update your driver to associate your one clock with the
> memory objects if/when we end up implementing this later.

IMHO, as mention Fabien the prepare/unprepare should probably not in the stop/start
but in rproc_fw_boot and rproc_resource_cleanup. This should cover more usecases (such as power domain) and
avoid a unprepare/prepare on crash recovery.

Nevertheless I'm wondering if it's more like PM runtime that should be implemented here...?

Regards,
Arnaud

> 
> Regards,
> Bjorn
> 
>> -Paul
>>
>>
>>>
>>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>  ---
>>>>
>>>>  Notes:
>>>>      v2-v4: No change
>>>>
>>>>   drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
>>>>   include/linux/remoteproc.h           |  4 ++++
>>>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>>  diff --git a/drivers/remoteproc/remoteproc_core.c
>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>  index 0a9fc7fdd1c3..3ea5f675a148 100644
>>>>  --- a/drivers/remoteproc/remoteproc_core.c
>>>>  +++ b/drivers/remoteproc/remoteproc_core.c
>>>>  @@ -1299,11 +1299,19 @@ static int rproc_start(struct rproc *rproc,
>>>> const struct firmware *fw)
>>>>   	struct device *dev = &rproc->dev;
>>>>   	int ret;
>>>>
>>>>  +	if (rproc->ops->prepare) {
>>>>  +		ret = rproc->ops->prepare(rproc);
>>>>  +		if (ret) {
>>>>  +			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
>>>>  +			return ret;
>>>>  +		}
>>>>  +	}
>>>>  +

>>>>   	/* load the ELF segments to memory */
>>>>   	ret = rproc_load_segments(rproc, fw);
>>>>   	if (ret) {
>>>>   		dev_err(dev, "Failed to load program segments: %d\n", ret);
>>>>  -		return ret;
>>>>  +		goto unprepare_rproc;
>>>>   	}
>>>>
>>>>   	/*
>>>>  @@ -1354,6 +1362,9 @@ static int rproc_start(struct rproc *rproc,
>>>> const struct firmware *fw)
>>>>   	rproc_unprepare_subdevices(rproc);
>>>>   reset_table_ptr:
>>>>   	rproc->table_ptr = rproc->cached_table;
>>>>  +unprepare_rproc:
>>>>  +	if (rproc->ops->unprepare)
>>>>  +		rproc->ops->unprepare(rproc);
>>>>
>>>>   	return ret;
>>>>   }
>>>>  @@ -1483,6 +1494,9 @@ static int rproc_stop(struct rproc *rproc,
>>>> bool crashed)
>>>>
>>>>   	rproc->state = RPROC_OFFLINE;
>>>>
>>>>  +	if (rproc->ops->unprepare)
>>>>  +		rproc->ops->unprepare(rproc);
>>>>  +
>>>>   	dev_info(dev, "stopped remote processor %s\n", rproc->name);
>>>>
>>>>   	return 0;
>>>>  diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>  index 5f201f0c86c3..a6272d1ba384 100644
>>>>  --- a/include/linux/remoteproc.h
>>>>  +++ b/include/linux/remoteproc.h
>>>>  @@ -355,6 +355,8 @@ enum rsc_handling_status {
>>>>
>>>>   /**
>>>>    * struct rproc_ops - platform-specific device handlers
>>>>  + * @prepare:	prepare the device for power up (before the firmware
>>>> is loaded)
>>>>  + * @unprepare:	unprepare the device after it is stopped
>>>>    * @start:	power on the device and boot it
>>>>    * @stop:	power off the device
>>>>    * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>>>>  @@ -371,6 +373,8 @@ enum rsc_handling_status {
>>>>    * @get_boot_addr:	get boot address to entry point specified in
>>>> firmware
>>>>    */
>>>>   struct rproc_ops {
>>>>  +	int (*prepare)(struct rproc *rproc);
>>>>  +	void (*unprepare)(struct rproc *rproc);
>>>>   	int (*start)(struct rproc *rproc);
>>>>   	int (*stop)(struct rproc *rproc);
>>>>   	void (*kick)(struct rproc *rproc, int vqid);
>>>>  --
>>>>  2.24.0
>>>>
>>
>>
