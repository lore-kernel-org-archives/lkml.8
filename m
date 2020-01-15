Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E43C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB9222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Uw26TWOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgAOPJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:09:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726562AbgAOPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:09:38 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FEw6Cs015516;
        Wed, 15 Jan 2020 16:09:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=oY/yYuph59ZqrkV+Eznpr3R9n6eoYf1RmuTALklKNYw=;
 b=Uw26TWOQnY4Wgr1w38wQ//dX+AdZ0SGREbBKLtiOo1UrmQHp8m1cpJvf13KVNDegVbhG
 oJpMi1I3hK3ZbwRhaRzdAggRYhlDRBZyDyVI2O8VjABKx0vtCmVG3j2X8nzlTW2AxyD/
 gKkBStVz15PYnVlMUaC+Cyk7eqoenV7t+nvuhQ8J3fihVYyN6ICL16TJsNiyKaF1RInW
 JBtVz5LoClXV7D/Ui2RjvoggUaxI3XGVCP59Sm3ROpAOawPq2ca0eLc8cP+nQg3xMK2+
 oq5Pl7cjbiI1yUQVVIngyuenAXAWk96hRsp0ODXv4ihsrMhmqkmfsLKaUNzSSMB8u5eA IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78sc0y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 16:09:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7398B10002A;
        Wed, 15 Jan 2020 16:09:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B51F2BC7D2;
        Wed, 15 Jan 2020 16:09:30 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 16:09:29 +0100
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
To:     =?UTF-8?Q?Cl=c3=a9ment_Leger?= <cleger@kalray.eu>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200115102142.11229-1-cleger@kalray.eu>
 <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
 <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com>
Date:   Wed, 15 Jan 2020 16:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/20 3:28 PM, Clément Leger wrote:
> Hi Arnaud,
> 
> ----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
> 
>> Hi Clément,
>>
>> On 1/15/20 11:21 AM, Clement Leger wrote:
>>> In order to support preallocated notify ids, if their value is
>>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
>>> dynamically but try to allocate the requested one. This is useful when
>>> using custom ids to bind them to custom vendor resources. For instance,
>>> it allow to assign a group of queues to a specific interrupti in order
>>> to dispatch notifications.
>>>
>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
>>>  include/linux/remoteproc.h           |  1 +
>>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index 307df98347ba..b1485fcd0f11 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>>>  	/*
>>>  	 * Assign an rproc-wide unique index for this vring
>>>  	 * TODO: assign a notifyid for rvdev updates as well
>>> -	 * TODO: support predefined notifyids (via resource table)
>>>  	 */
>>> -	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "idr_alloc failed: %d\n", ret);
>>> -		return ret;
>>> +	if (rsc->vring[i].notifyid == FW_RSC_NOTIFY_ID_ANY) {
>>> +		ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +		notifyid = ret;
>>> +
>>> +		/* Let the rproc know the notifyid of this vring.*/
>>> +		rsc->vring[i].notifyid = notifyid;
>>> +	} else {
>>> +		/* Reserve requested notify_id */
>>> +		notifyid = rsc->vring[i].notifyid;
>>> +		ret = idr_alloc(&rproc->notifyids, rvring, notifyid,
>>> +				notifyid + 1, GFP_KERNEL);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
>>> +			return ret;
>>> +		}
>>>  	}
>>> -	notifyid = ret;
>>>  
>>>  	/* Potentially bump max_notifyid */
>>>  	if (notifyid > rproc->max_notifyid)
>>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>>>  
>>>  	rvring->notifyid = notifyid;
>>>  
>>> -	/* Let the rproc know the notifyid of this vring.*/
>>> -	rsc->vring[i].notifyid = notifyid;
>>>  	return 0;
>>>  }
>> The rproc_free_vring function resets the notifyid to -1 on free.
>> This could generate a side effect if the resource table is not reloaded.
> 
> Oh indeed, I did not thought of that. What would you recommend ?
> If using -1 in free vring, notify ids will be reallocated at next
> round.
Regarding the code i'm not sure that it is useful to reset the notifyID to -1 on free.
In current version, on alloc, the notifyID is overwriten without check.
And as vdev status is updated, vring struct in resource table should be considered as invalid
Except if i missed a usecase/race condition...

> 
> I was also worried that it would break some existing user applications
> which uses "0" as a notify id in vring but expect the id to be
> allocated dynamically. With my modification, it means it will try to 
> use "0" as a predefined id, leading to allocation failure.
> 
Yes this could introduce regression for firmware that sets 0 as default value.
Probably better to introduce this patch with a new version of the resource table :)

Regards
Arnaud
>>
>>>  
>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>> index 16ad66683ad0..dcae3394243e 100644
>>> --- a/include/linux/remoteproc.h
>>> +++ b/include/linux/remoteproc.h
>>> @@ -123,6 +123,7 @@ enum fw_resource_type {
>>>  };
>>>  
>>>  #define FW_RSC_ADDR_ANY (-1)
>>> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in
>>> rproc_free_vring
> 
> Indeed.
> 
> Thanks for your review.
> 
> Regards,
> 
> Clément
> 
>>
>> Regards,
>> Arnaud
>>>  
>>>  /**
>>>   * struct fw_rsc_carveout - physically contiguous memory request
