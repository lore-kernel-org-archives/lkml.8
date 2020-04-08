Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049CEC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C13206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JKww8zzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgDHUwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:52:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52040 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgDHUwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:52:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038KqGG3110994;
        Wed, 8 Apr 2020 15:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586379136;
        bh=p0M5GtLjUPtfurSNi0LOCBLuwwn5bx3wGcJNnqhj6+c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JKww8zzDD2FtkRjkM0+clKsu44ksrcM2abHyLsyXjJYs9g3S3HRAYl0qfvVCSL/F+
         GVMBS4DZF1mWkpPkQEMSW4RUstMZ428OZQqBc5CfPcXjnGOAQ5cihO0JNZgHKCvXeU
         fw3XLLeoVG61y4TpkGDjv25kUAA8zHNzNS7VPKpU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 038KqGLP060963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Apr 2020 15:52:16 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 15:52:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 15:52:15 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038KqF0Y013623;
        Wed, 8 Apr 2020 15:52:15 -0500
Subject: Re: [PATCH v2] rpmsg: core: Add wildcard match for name service
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200310155058.1607-1-mathieu.poirier@linaro.org>
 <591bd727-32af-9ea2-8c46-98f46ee3711e@ti.com>
 <CANLsYkyv+4cSCY27kA6qfo2XMzXy_h+DmXTe0nVZuUkC0kyRUQ@mail.gmail.com>
 <ca77fe73-3baf-64ff-c9e2-b2f35f96ffe3@ti.com>
 <CANLsYkz8iqiperjdQVcwAC3YGT5cmEvJcu8fPFGF5-X6eKVUDQ@mail.gmail.com>
 <34d1277f-c35e-5df8-7d0c-ea1e961a127f@st.com> <20200327193602.GA22939@xps15>
 <77cba22f-5911-e88a-ec25-50cbe9b8fbbe@ti.com>
 <CANLsYkxWSQNA0SqP5p1d_EK6am5rV-ONrvou1UyuNMnMjGW71Q@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <56a34534-f005-1e1c-a8c5-8bef02664eac@ti.com>
Date:   Wed, 8 Apr 2020 15:52:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkxWSQNA0SqP5p1d_EK6am5rV-ONrvou1UyuNMnMjGW71Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 10:59 AM, Mathieu Poirier wrote:
> On Tue, 7 Apr 2020 at 17:07, Suman Anna <s-anna@ti.com> wrote:
>>
>> Hi Mathieu, Arnaud,
>>
>> On 3/27/20 2:36 PM, Mathieu Poirier wrote:
>>> On Fri, Mar 27, 2020 at 10:35:34AM +0100, Arnaud POULIQUEN wrote:
>>>> Hi
>>>>
>>>> On 3/26/20 11:01 PM, Mathieu Poirier wrote:
>>>>> On Thu, 26 Mar 2020 at 14:42, Suman Anna <s-anna@ti.com> wrote:
>>>>>>
>>>>>> On 3/26/20 3:21 PM, Mathieu Poirier wrote:
>>>>>>> On Thu, 26 Mar 2020 at 09:06, Suman Anna <s-anna@ti.com> wrote:
>>>>>>>>
>>>>>>>> Hi Mathieu,
>>>>>>>>
>>>>>>>> On 3/10/20 10:50 AM, Mathieu Poirier wrote:
>>>>>>>>> Adding the capability to supplement the base definition published
>>>>>>>>> by an rpmsg_driver with a postfix description so that it is possible
>>>>>>>>> for several entity to use the same service.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>>>>>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>>>>>>
>>>>>>>> So, the concern I have here is that we are retrofitting this into the
>>>>>>>> existing 32-byte name field, and the question is if it is going to be
>>>>>>>> enough in general. That's the reason I went with the additional 32-byte
>>>>>>>> field with the "rpmsg: add a description field" patch.
>>>>>>>>
>>>>>>>
>>>>>>> That's a valid concern.
>>>>>>>
>>>>>>> Did you consider increasing the size of RPMSG_NAME_SIZE to 64? Have
>>>>>>> you found cases where that wouldn't work?  I did a survey of all the
>>>>>>> places the #define is used and all destination buffers are also using
>>>>>>> the same #define in their definition.  It would also be backward
>>>>>>> compatible with firmware implementations that use 32 byte.
>>>>>>
>>>>>> You can't directly bump the size without breaking the compatibility on
>>>>>> the existing rpmsg_ns_msg in firmwares right? All the Linux-side drivers
>>>>>> will be ok since they use the same macro but rpmsg_ns_msg has presence
>>>>>> on both kernel and firmware-sides.
>>>>>
>>>>> Ah yes yes... The amount of bytes coming out of the pipe won't match.
>>>>> Let me think a little...
>>>>
>>>> +1 for Suman's concern.
>>>>
>>>> Anyway i would like to challenge the need of more than 32 bytes to
>>>> differentiate service instances.
>>>> "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", seems to me enough if we only need
>>>> to differentiate the instances.
>>
>> Remember that the rpmsg_device_id name takes some space within here. So,
>> the shorter the rpmsg_device_id table name, the more room you have.
>>
>>>>
>>>> But perhaps the need is also to provide a short description of the service?
>>
>> I am mostly using it to provide a unique instantiation name. In anycase,
>> I have cross-checked against my current firmwares, and so far all of
>> them happen to have the name + desc < 31 bytes.
>>
>>
>>>>
>>>> Suman, could you share some examples of your need?
>>>
>>> Looking at things further it is possible to extend the name of the service to
>>> 64 byte while keeping backward compatibility by looking up the size of @len
>>> in function rpmsg_ns_cb().  From there work with an rpmsg_ns_msg or a new
>>> rpmsg_ns_msg64, pretty much the way you did in your patch[1].  In fact the
>>> approach is the same except you are using 2 arrays of 32 byte and I'm using one
>>> of 64.
>>>
>>> As Arnaud mentioned, is there an immediate need to support a 64-byte name?  If
>>> not than I suggest to move forward with this patch and address the issue when we
>>> get there - at least we know there is room for extention. Otherwise I'll spin
>>> off another revision but it will be bigger and more complex.
>>
>> Yeah ok. I have managed to get my downstream drivers that use the desc
>> field working with this patch after modifying the firmwares to publish
>> using combined name, and adding logic in probe to get the trailing
>> portion of the name.
> 
> Perfect
> 
>>
>> So, the only thing that is missing or content for another patch is if we
>> need to add some tooling/helper stuff for giving the trailing stuff to
>> rpmsg drivers?
> 
> So that all rpmsg drivers don't come up with their own parsing that
> ends up doing the same thing.  Let me think about that - I may have to
> get back to you...

Yep. Sure no problem. It can be a patch on top of this as well.

Arnaud,
Do you have immediate need for the tooling stuff for the rpmsg-tty driver?

regards
Suman


> 
>>
>> regards
>> Suman
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>> [1]. https://patchwork.kernel.org/patch/11096599/
>>>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> Changes for V2:
>>>>>>>>> - Added Arnaud's Acked-by.
>>>>>>>>> - Rebased to latest rproc-next.
>>>>>>>>>
>>>>>>>>>  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
>>>>>>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>>>>>>> index e330ec4dfc33..bfd25978fa35 100644
>>>>>>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>>>>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>>>>>>> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
>>>>>>>>>  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
>>>>>>>>>                                 const struct rpmsg_device_id *id)
>>>>>>>>>  {
>>>>>>>>> -     return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
>>>>>>>>> +     size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
>>>>>>>>> +
>>>>>>>>> +     /*
>>>>>>>>> +      * Allow for wildcard matches.  For example if rpmsg_driver::id_table
>>>>>>>>> +      * is:
>>>>>>>>> +      *
>>>>>>>>> +      * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
>>>>>>>>> +      *      { .name = "rpmsg-client-sample" },
>>>>>>>>> +      *      { },
>>>>>>>>> +      * }
>>>>>>>>> +      *
>>>>>>>>> +      * Then it is possible to support "rpmsg-client-sample*", i.e:
>>>>>>>>> +      *      rpmsg-client-sample
>>>>>>>>> +      *      rpmsg-client-sample_instance0
>>>>>>>>> +      *      rpmsg-client-sample_instance1
>>>>>>>>> +      *      ...
>>>>>>>>> +      *      rpmsg-client-sample_instanceX
>>>>>>>>> +      */
>>>>>>>>> +     return strncmp(id->name, rpdev->id.name, len) == 0;
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>>  /* match rpmsg channel and rpmsg driver */
>>>>>>>>>
>>>>>>>>
>>>>>>
>>

