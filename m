Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75982C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA0820714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="g2v40gs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgC0Jf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:35:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3412 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgC0Jf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:35:56 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R9SX6P022476;
        Fri, 27 Mar 2020 10:35:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=6nNFnk8jID5lHjOahVO0boRafihUTXXOYaMNQuIINKA=;
 b=g2v40gs2320Af1QC6KtcQhpiDc6DulbBptbFNUoLwpElORI3qytUWlno3YXkjN312VIP
 cersvx0NFkGPlPYzjD6GoG1h9U3rDlLlf0N7HWl2xGWHtW5iQm6G64nLasdZlRNBL7/E
 uacv/4LrjxaQ6iVcqMR82NJAO7mQT3HRYOBDp/nEXovnqzbQN8VVfg/Ik9ORLJ65/iqa
 Hn9/DBFtZilZoxEcmMupeso3aow68phDII++mj465ELGzeoMpLaG889rj1DrrDEeJzkd
 gO2h9/rfoPVkjtjwSAVA8+XxbPzf9ZBOldWIIrgtsAJyerkOX2MPAmhsjqK7/Pbcf8xa Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw8xehc57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 10:35:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1894410002A;
        Fri, 27 Mar 2020 10:35:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 240FA21FEA3;
        Fri, 27 Mar 2020 10:35:50 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 10:35:44 +0100
Subject: Re: [PATCH v2] rpmsg: core: Add wildcard match for name service
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200310155058.1607-1-mathieu.poirier@linaro.org>
 <591bd727-32af-9ea2-8c46-98f46ee3711e@ti.com>
 <CANLsYkyv+4cSCY27kA6qfo2XMzXy_h+DmXTe0nVZuUkC0kyRUQ@mail.gmail.com>
 <ca77fe73-3baf-64ff-c9e2-b2f35f96ffe3@ti.com>
 <CANLsYkz8iqiperjdQVcwAC3YGT5cmEvJcu8fPFGF5-X6eKVUDQ@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <34d1277f-c35e-5df8-7d0c-ea1e961a127f@st.com>
Date:   Fri, 27 Mar 2020 10:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkz8iqiperjdQVcwAC3YGT5cmEvJcu8fPFGF5-X6eKVUDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_02:2020-03-26,2020-03-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 3/26/20 11:01 PM, Mathieu Poirier wrote:
> On Thu, 26 Mar 2020 at 14:42, Suman Anna <s-anna@ti.com> wrote:
>>
>> On 3/26/20 3:21 PM, Mathieu Poirier wrote:
>>> On Thu, 26 Mar 2020 at 09:06, Suman Anna <s-anna@ti.com> wrote:
>>>>
>>>> Hi Mathieu,
>>>>
>>>> On 3/10/20 10:50 AM, Mathieu Poirier wrote:
>>>>> Adding the capability to supplement the base definition published
>>>>> by an rpmsg_driver with a postfix description so that it is possible
>>>>> for several entity to use the same service.
>>>>>
>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>>
>>>> So, the concern I have here is that we are retrofitting this into the
>>>> existing 32-byte name field, and the question is if it is going to be
>>>> enough in general. That's the reason I went with the additional 32-byte
>>>> field with the "rpmsg: add a description field" patch.
>>>>
>>>
>>> That's a valid concern.
>>>
>>> Did you consider increasing the size of RPMSG_NAME_SIZE to 64? Have
>>> you found cases where that wouldn't work?  I did a survey of all the
>>> places the #define is used and all destination buffers are also using
>>> the same #define in their definition.  It would also be backward
>>> compatible with firmware implementations that use 32 byte.
>>
>> You can't directly bump the size without breaking the compatibility on
>> the existing rpmsg_ns_msg in firmwares right? All the Linux-side drivers
>> will be ok since they use the same macro but rpmsg_ns_msg has presence
>> on both kernel and firmware-sides.
> 
> Ah yes yes... The amount of bytes coming out of the pipe won't match.
> Let me think a little...

+1 for Suman's concern.

Anyway i would like to challenge the need of more than 32 bytes to
differentiate service instances.
"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", seems to me enough if we only need
to differentiate the instances.

But perhaps the need is also to provide a short description of the service?

Suman, could you share some examples of your need?

Regards
Arnaud
   
> 
>>
>> regards
>> Suman
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>> regards
>>>> Suman
>>>>
>>>>> ---
>>>>> Changes for V2:
>>>>> - Added Arnaud's Acked-by.
>>>>> - Rebased to latest rproc-next.
>>>>>
>>>>>  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
>>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>>> index e330ec4dfc33..bfd25978fa35 100644
>>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>>> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
>>>>>  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
>>>>>                                 const struct rpmsg_device_id *id)
>>>>>  {
>>>>> -     return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
>>>>> +     size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
>>>>> +
>>>>> +     /*
>>>>> +      * Allow for wildcard matches.  For example if rpmsg_driver::id_table
>>>>> +      * is:
>>>>> +      *
>>>>> +      * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
>>>>> +      *      { .name = "rpmsg-client-sample" },
>>>>> +      *      { },
>>>>> +      * }
>>>>> +      *
>>>>> +      * Then it is possible to support "rpmsg-client-sample*", i.e:
>>>>> +      *      rpmsg-client-sample
>>>>> +      *      rpmsg-client-sample_instance0
>>>>> +      *      rpmsg-client-sample_instance1
>>>>> +      *      ...
>>>>> +      *      rpmsg-client-sample_instanceX
>>>>> +      */
>>>>> +     return strncmp(id->name, rpdev->id.name, len) == 0;
>>>>>  }
>>>>>
>>>>>  /* match rpmsg channel and rpmsg driver */
>>>>>
>>>>
>>
