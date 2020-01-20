Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8250CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3920684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hl8G0C8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATJwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:52:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33438 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgATJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:52:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9hghj010236;
        Mon, 20 Jan 2020 10:52:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=19LC3t0yD1vea7NKrLgMBzpnY35r0sJa/RXUO9LAVvg=;
 b=hl8G0C8q2ZB008kQFGc3FfxX3YMrE1Q2M97qksqJl3OBm8Bzx33Hi5RSZdPD5ltkTG1+
 MswEsz5kWMlQTvv02J3COCecbt9DAR5fs+9ixR/fUVDdkvJUbw1eo9kmA+GKb1rW2/D/
 c+p0/W22oEOLCpeZ09Y02iQ5cvcSd6/EbqIJy23IJJezN/yBobRQQRckF/SkWtticLHn
 TvjVSVE1nxfi/1v7Y7IC2pXoE3IH3Ll/tqJ8ET5wsbtE1nOLcU6QQlJxRiiO9VokKWJ+
 9bNMotDKgagIbYOXxHn0vQOOJ6R9iirgVrn0oOxazpwKDGD//qdbv/g+JVNFFhlaa3r1 uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc4rukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 10:52:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B826210003B;
        Mon, 20 Jan 2020 10:52:27 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag3node4.st.com [10.75.127.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A2DE32A4D69;
        Mon, 20 Jan 2020 10:52:27 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by GPXDAG3NODE4.st.com
 (10.75.127.71) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan
 2020 10:52:27 +0100
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
To:     =?UTF-8?Q?Cl=c3=a9ment_Leger?= <cleger@kalray.eu>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200115102142.11229-1-cleger@kalray.eu>
 <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
 <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
 <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com>
 <612100872.12377996.1579101063237.JavaMail.zimbra@kalray.eu>
 <20200117225217.GA27535@xps15>
 <377421261.12898679.1579462834671.JavaMail.zimbra@kalray.eu>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <49a1a4f7-3b08-91c1-e619-cba33880385d@st.com>
Date:   Mon, 20 Jan 2020 10:52:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <377421261.12898679.1579462834671.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To GPXDAG3NODE4.st.com
 (10.75.127.71)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/19/20 8:40 PM, Clément Leger wrote:
> Hi Mathieu,
> 
> ----- On 17 Jan, 2020, at 23:52, Mathieu Poirier mathieu.poirier@linaro.org wrote:
> 
>> Hey guys,
>>
>> On Wed, Jan 15, 2020 at 04:11:03PM +0100, Clément Leger wrote:
>>>
>>>
>>> ----- On 15 Jan, 2020, at 16:09, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
>>>
>>>> On 1/15/20 3:28 PM, Clément Leger wrote:
>>>>> Hi Arnaud,
>>>>>
>>>>> ----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
>>>>>
>>>>>> Hi Clément,
>>>>>>
>>>>>> On 1/15/20 11:21 AM, Clement Leger wrote:
>>>>>>> In order to support preallocated notify ids, if their value is
>>>>>>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
>>>>>>> dynamically but try to allocate the requested one. This is useful when
>>>>>>> using custom ids to bind them to custom vendor resources. For instance,
>>>>>>> it allow to assign a group of queues to a specific interrupti in order
>>>>>>> to dispatch notifications.
>>>>>>>
>>>>>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>>>>>>> ---
>>>>>>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
>>>>>>>  include/linux/remoteproc.h           |  1 +
>>>>>>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>>>> index 307df98347ba..b1485fcd0f11 100644
>>>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>>>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>>>>>>>  	/*
>>>>>>>  	 * Assign an rproc-wide unique index for this vring
>>>>>>>  	 * TODO: assign a notifyid for rvdev updates as well
>>>>>>> -	 * TODO: support predefined notifyids (via resource table)
>>>>>>>  	 */
>>>>>>> -	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>>>>>>> -	if (ret < 0) {
>>>>>>> -		dev_err(dev, "idr_alloc failed: %d\n", ret);
>>>>>>> -		return ret;
>>>>>>> +	if (rsc->vring[i].notifyid == FW_RSC_NOTIFY_ID_ANY) {
>>>>>>> +		ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>>>>>>> +		if (ret < 0) {
>>>>>>> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
>>>>>>> +			return ret;
>>>>>>> +		}
>>>>>>> +		notifyid = ret;
>>>>>>> +
>>>>>>> +		/* Let the rproc know the notifyid of this vring.*/
>>>>>>> +		rsc->vring[i].notifyid = notifyid;
>>>>>>> +	} else {
>>>>>>> +		/* Reserve requested notify_id */
>>>>>>> +		notifyid = rsc->vring[i].notifyid;
>>>>>>> +		ret = idr_alloc(&rproc->notifyids, rvring, notifyid,
>>>>>>> +				notifyid + 1, GFP_KERNEL);
>>>>>>> +		if (ret < 0) {
>>>>>>> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
>>>>>>> +			return ret;
>>>>>>> +		}
>>>>>>>  	}
>>>>>>> -	notifyid = ret;
>>>>>>>  
>>>>>>>  	/* Potentially bump max_notifyid */
>>>>>>>  	if (notifyid > rproc->max_notifyid)
>>>>>>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>>>>>>>  
>>>>>>>  	rvring->notifyid = notifyid;
>>>>>>>  
>>>>>>> -	/* Let the rproc know the notifyid of this vring.*/
>>>>>>> -	rsc->vring[i].notifyid = notifyid;
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>> The rproc_free_vring function resets the notifyid to -1 on free.
>>>>>> This could generate a side effect if the resource table is not reloaded.
>>>>>
>>>>> Oh indeed, I did not thought of that. What would you recommend ?
>>>>> If using -1 in free vring, notify ids will be reallocated at next
>>>>> round.
>>>> Regarding the code i'm not sure that it is useful to reset the notifyID to -1 on
>>>> free.
>>
>> I'm not sure setting notifyid to -1 in rproc_free_vring() is such a big problem.
>> No matter the code path I look at, if rproc_free_vring() is called something
>> serious has happened and the resource table will be reloaded if another attempt
>> at booting the remote processor is done.  It can also be that a graceful
>> shutdown is underway, in which case the resource table will be reloaded anyway
>> if/when the slave is brought back in service.
>>
>> Let me know if I'm missing a scenario.
> 
> No, you are actually right
My concern here is that the resource table can be uncorrelated from the Firmware.
For instance the remote proc firmware could run autonomously.
In this case only the resource table will be managed.
Should we consider that this resource table must be reloaded on a stop/start from application?
Now regarding the da that is also reset to 0 (instead of FW_RSC_ADDR_ANY) in rproc_free_vring, i suppose that
my scenario is not realistic...on restart rproc would try to allocate vring at address 0, Leading to a crash.

> 
>>
>> To me the real problem is if a FW image has set the notifyids in the resource
>> table to 0xffffffff, thinking they will be overwritten.  In that case things
>> will really south.
> 
> Hum, if set to 0xFFFFFFFF, then they will be assigned dynamically and updated
> in the resource table (with this patch). But your probably mean existing code,
> right ?
point also not clear for me. In existing code the notifyids is always overwritten.
Mathieu could you details what you have in mind here?
> 
>>
>>>> In current version, on alloc, the notifyID is overwriten without check.
>>>> And as vdev status is updated, vring struct in resource table should be
>>>> considered as invalid
>>>> Except if i missed a usecase/race condition...
>>>>
>>>>>
>>>>> I was also worried that it would break some existing user applications
>>>>> which uses "0" as a notify id in vring but expect the id to be
>>>>> allocated dynamically. With my modification, it means it will try to
>>>>> use "0" as a predefined id, leading to allocation failure.
>>
>> From my point of view they will have been lucky for all this time.  Even with
>> a new version of the resource table (which I think is the right way go)
>> cases like this will break.
> 
> Agreed, and actually, I may have missread some code. I can't find were I read
> that. By the way, is there any documentation which state the allowed values of
> notify ids ?
0 seems a valid value. I'm not aware about a constraint on the notify ID.
With the current implementation, the initial values are simply ignored, therefore do not seem to be a problem.    
With Clément's patch, the issue is for legacy firmwares with both vrings IDs initialized to the same value (0 or another value different from -1).
The rproc_alloc_vring fails while trying to reserve the same IDs for both vring.
If this patch is introduced with a new version of the resource table a constraint on the notiifyID seems acceptable.

Thanks,
Arnaud

> 
>>
>> Thanks,
>> Mathieu
>>
>>>>>
>>>> Yes this could introduce regression for firmware that sets 0 as default value.
>>>> Probably better to introduce this patch with a new version of the resource table
>>>> :)
>>>
>>> Understood ;)
>>>
>>> Regards,
>>>
>>> Clément
>>>
>>>>
>>>> Regards
>>>> Arnaud
>>>>>>
>>>>>>>  
>>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>>>> index 16ad66683ad0..dcae3394243e 100644
>>>>>>> --- a/include/linux/remoteproc.h
>>>>>>> +++ b/include/linux/remoteproc.h
>>>>>>> @@ -123,6 +123,7 @@ enum fw_resource_type {
>>>>>>>  };
>>>>>>>  
>>>>>>>  #define FW_RSC_ADDR_ANY (-1)
>>>>>>> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in
>>>>>>> rproc_free_vring
>>>>>
>>>>> Indeed.
>>>>>
>>>>> Thanks for your review.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Clément
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Arnaud
>>>>>>>  
>>>>>>>  /**
>>>>>>>   * struct fw_rsc_carveout - physically contiguous memory request
