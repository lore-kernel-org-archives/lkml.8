Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48423C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B92020738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I/yi5K88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEUTwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:52:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42470 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgEUTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:52:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LJq3rW081620;
        Thu, 21 May 2020 14:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590090723;
        bh=Vb/5S9ewFa3yrp3KZRQqIR2YgutT5LYsiuL4DYpKPE8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I/yi5K88+YAIrR3aTAnM80hh9e++JV72R6OISQRJNEQCWBfbw7PKgAtAHkIXQvRCp
         qZZB7bqz9rN1+fjlAUn+EhskN+VDNzUJLTOFFIN52UU9RykxYqzdtofgrtslyqafPE
         gfx874K5k8FDDS6F0Fa8SMP5KCsG9Me/zQrx+lcQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LJq35u024370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 14:52:03 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 14:52:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 14:52:03 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LJq3Sc036393;
        Thu, 21 May 2020 14:52:03 -0500
Subject: Re: [PATCH 2/4] remoteproc: introduce version element into resource
 type field
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-3-s-anna@ti.com> <20200521175421.GI408178@builder.lan>
 <b338480e-c586-f988-f5b6-784551b7beb6@ti.com>
 <20200521192146.GO408178@builder.lan>
 <57ae5678-fd0a-07a8-6165-a2cf7ccdef88@ti.com>
 <20200521194116.GP408178@builder.lan>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <5529e8ff-b5ed-9dd6-e7f6-55a00225c2b9@ti.com>
Date:   Thu, 21 May 2020 14:52:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521194116.GP408178@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/20 2:41 PM, Bjorn Andersson wrote:
> On Thu 21 May 12:29 PDT 2020, Suman Anna wrote:
> 
>> On 5/21/20 2:21 PM, Bjorn Andersson wrote:
>>> On Thu 21 May 12:06 PDT 2020, Suman Anna wrote:
>>>
>>>> Hi Bjorn,
>>>>
>>>> On 5/21/20 12:54 PM, Bjorn Andersson wrote:
>>>>> On Wed 25 Mar 13:46 PDT 2020, Suman Anna wrote:
>>>>>
>>>>>> The current remoteproc core has supported only 32-bit remote
>>>>>> processors and as such some of the current resource structures
>>>>>> may not scale well for 64-bit remote processors, and would
>>>>>> require new versions of resource types. Each resource is currently
>>>>>> identified by a 32-bit type field. Introduce the concept of version
>>>>>> for these resource types by overloading this 32-bit type field
>>>>>> into two 16-bit version and type fields with the existing resources
>>>>>> behaving as version 0 thereby providing backward compatibility.
>>>>>>
>>>>>> The version field is passed as an additional argument to each of
>>>>>> the handler functions, and all the existing handlers are updated
>>>>>> accordingly. Each specific handler will be updated on a need basis
>>>>>> when a new version of the resource type is added.
>>>>>>
>>>>>
>>>>> I really would prefer that we add additional types for the new
>>>>> structures, neither side will be compatible with new versions without
>>>>> enhancements to their respective implementations anyways.
>>>>
>>>> OK.
>>>>
>>>>>
>>>>>> An alternate way would be to introduce the new types as completely
>>>>>> new resource types which would require additional customization of
>>>>>> the resource handlers based on the 32-bit or 64-bit mode of a remote
>>>>>> processor, and introduction of an additional mode flag to the rproc
>>>>>> structure.
>>>>>>
>>>>>
>>>>> What would this "mode" indicate? If it's version 0 or 1?
>>>>
>>>> No, for indicating if the remoteproc is 32-bit or 64-bit and adjust the
>>>> loading handlers if the resource types need to be segregated accordingly.
>>>>
>>>
>>> Sorry, I think I'm misunderstanding something. Wouldn't your 64-bit
>>> remote processor need different firmware from your 32-bit processor
>>> anyways, if you want to support the wider resource? And you would pack
>>> your firmware with the appropriate resource types?
>>
>> Yes, that's correct.
>>
>>>
>>> Afaict the bit width of your remote processor, busses or memory is
>>> unrelated to the choice of number of bits used to express things in the
>>> resource table.
>>
>> I would have to add the new resource type to the loading_handlers right, so
>> it is a question of whether we want to impose any restrictions in remoteproc
>> core or not from supporting a certain resource type (eg: I don't expect
>> RSC_TRACE entries on 64-bit processors).
>>
> 
> Right, but either you add support for new resource types to the
> loading_handlers, or you add the version checks within each handler,
> either way you will have to do some work to be compatible with new
> versions.
> 
> Regarding what resources would be fit for a 64-bit processor probably
> relates to many things, in particular the question of what we actually
> mean when we say that a coprocessor is 64-bit. So I don't really see a
> need for the remoteproc core to prevent someone to design their
> system/firmware to have a 64-bit CPU being passed 32-bit addresses.

OK. In general, I have seen firmware developers get confused w.r.t the 
resource types, that's why I was inclined to go with the restrictive 
checking. Anyway, will rework the support as per the comments.

regards
Suman


