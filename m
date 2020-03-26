Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF1C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB22070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="akOyR4oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCZUmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:42:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47506 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:42:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02QKgi6d103951;
        Thu, 26 Mar 2020 15:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585255364;
        bh=EUflnEgAvYUlVA4lTCxEonyMJtce+B/VpTkWznk+t/A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=akOyR4oG0OoOKt3OjtlH1EIOWFcUc8blXV/6giiRrN6tZ+cV0gDErIYPECG9+P6ZV
         6+PFG2Hfuz0QCp5CtjuVVbuvSBa9KzY9Xa/QbrvpFi+PQloVL1dyQg+SAmMvKDKU0o
         HMlhBvCW+srKCjPMbbbuylMCmFVMqXQwU0PSABsg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02QKgiN0049276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Mar 2020 15:42:44 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 26
 Mar 2020 15:42:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 26 Mar 2020 15:42:44 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02QKgiX2130521;
        Thu, 26 Mar 2020 15:42:44 -0500
Subject: Re: [PATCH v2] rpmsg: core: Add wildcard match for name service
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200310155058.1607-1-mathieu.poirier@linaro.org>
 <591bd727-32af-9ea2-8c46-98f46ee3711e@ti.com>
 <CANLsYkyv+4cSCY27kA6qfo2XMzXy_h+DmXTe0nVZuUkC0kyRUQ@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <ca77fe73-3baf-64ff-c9e2-b2f35f96ffe3@ti.com>
Date:   Thu, 26 Mar 2020 15:42:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkyv+4cSCY27kA6qfo2XMzXy_h+DmXTe0nVZuUkC0kyRUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 3:21 PM, Mathieu Poirier wrote:
> On Thu, 26 Mar 2020 at 09:06, Suman Anna <s-anna@ti.com> wrote:
>>
>> Hi Mathieu,
>>
>> On 3/10/20 10:50 AM, Mathieu Poirier wrote:
>>> Adding the capability to supplement the base definition published
>>> by an rpmsg_driver with a postfix description so that it is possible
>>> for several entity to use the same service.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>
>> So, the concern I have here is that we are retrofitting this into the
>> existing 32-byte name field, and the question is if it is going to be
>> enough in general. That's the reason I went with the additional 32-byte
>> field with the "rpmsg: add a description field" patch.
>>
> 
> That's a valid concern.
> 
> Did you consider increasing the size of RPMSG_NAME_SIZE to 64? Have
> you found cases where that wouldn't work?  I did a survey of all the
> places the #define is used and all destination buffers are also using
> the same #define in their definition.  It would also be backward
> compatible with firmware implementations that use 32 byte.

You can't directly bump the size without breaking the compatibility on
the existing rpmsg_ns_msg in firmwares right? All the Linux-side drivers
will be ok since they use the same macro but rpmsg_ns_msg has presence
on both kernel and firmware-sides.

regards
Suman

> 
> Thanks,
> Mathieu
> 
>> regards
>> Suman
>>
>>> ---
>>> Changes for V2:
>>> - Added Arnaud's Acked-by.
>>> - Rebased to latest rproc-next.
>>>
>>>  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index e330ec4dfc33..bfd25978fa35 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
>>>  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
>>>                                 const struct rpmsg_device_id *id)
>>>  {
>>> -     return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
>>> +     size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
>>> +
>>> +     /*
>>> +      * Allow for wildcard matches.  For example if rpmsg_driver::id_table
>>> +      * is:
>>> +      *
>>> +      * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
>>> +      *      { .name = "rpmsg-client-sample" },
>>> +      *      { },
>>> +      * }
>>> +      *
>>> +      * Then it is possible to support "rpmsg-client-sample*", i.e:
>>> +      *      rpmsg-client-sample
>>> +      *      rpmsg-client-sample_instance0
>>> +      *      rpmsg-client-sample_instance1
>>> +      *      ...
>>> +      *      rpmsg-client-sample_instanceX
>>> +      */
>>> +     return strncmp(id->name, rpdev->id.name, len) == 0;
>>>  }
>>>
>>>  /* match rpmsg channel and rpmsg driver */
>>>
>>

