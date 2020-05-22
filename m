Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D5FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB142070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pni8T/B8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgEVS7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:59:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48958 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbgEVS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:59:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MIx5tD018590;
        Fri, 22 May 2020 13:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590173945;
        bh=cWQVyiUOGA6CdUt5XXyh7cFJsbmK3Mc23pxMgj5Hzmg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pni8T/B83UwO2WLa8S+nfay+6qWJQQptvGZT3X7n5c1MIJ+gmrNnuPD3C83kR6dh/
         Xt6Bn01NtTd7CRym4xhSIj9g5lCr3TCZHr5w73XqHtXiuLIROFz2pTlK+qI/ZAYLnP
         GnL/xnvtxdZ0Z5gtUC39tpxV77IHwSn/pXFHtiNk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04MIx55t032460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 13:59:05 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 13:59:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 13:59:04 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MIx414059462;
        Fri, 22 May 2020 13:59:04 -0500
Subject: Re: [PATCH 3/4] remoteproc: add support for a new 64-bit trace
 version
To:     =?UTF-8?Q?Cl=c3=a9ment_Leger?= <cleger@kalray.eu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-4-s-anna@ti.com> <20200521180417.GJ408178@builder.lan>
 <997d6f9a-64ba-7a89-e909-9a5a474120b0@ti.com>
 <f15b0c6d-eee8-b839-0c79-a5316dbbfa7b@ti.com> <20200522173346.GJ11847@yoga>
 <1739080680.4218297.1590170621467.JavaMail.zimbra@kalray.eu>
 <1334263091.4218509.1590171014972.JavaMail.zimbra@kalray.eu>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4fab212b-a9d2-927e-d3d7-e591912fd6cf@ti.com>
Date:   Fri, 22 May 2020 13:59:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1334263091.4218509.1590171014972.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clement,

>  > ----- On 22 May, 2020, at 20:03, Clément Leger cleger@kalray.eu wrote:>
>> Hi Suman,
>>
>> ----- On 22 May, 2020, at 19:33, Bjorn Andersson bjorn.andersson@linaro.org
>> wrote:
>>
>>> On Fri 22 May 09:54 PDT 2020, Suman Anna wrote:
>>>
>>>> On 5/21/20 2:42 PM, Suman Anna wrote:
>>>>> Hi Bjorn,
>>>>>
>>>>> On 5/21/20 1:04 PM, Bjorn Andersson wrote:
>>>>>> On Wed 25 Mar 13:47 PDT 2020, Suman Anna wrote:
>>> [..]
>>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>> [..]
>>>>>>> +struct fw_rsc_trace2 {
>>>>>>
>>>>>> Sounds more like fw_rsc_trace64 to me - in particular since the version
>>>>>> of trace2 is 1...
>>>>>
>>>>> Yeah, will rename this.
>>>>>
>>>>>>
>>>>>>> +    u32 padding;
>>>>>>> +    u64 da;
>>>>>>> +    u32 len;
>>>>>>> +    u32 reserved;
>>>>>>
>>>>>> What's the purpose of this reserved field?
>>>>>
>>>>> Partly to make sure the entire resource is aligned on an 8-byte, and
>>>>> partly copied over from fw_rsc_trace entry. I guess 32-bits is already
>>>>> large enough of a size for trace entries irrespective of 32-bit or
>>>>> 64-bit traces, so I doubt if we want to make the len field also a u64.
>>>>
>>>> Looking at this again, I can drop both padding and reserved fields, if I
>>>> move the len field before da. Any preferences/comments?
>>
> Sorry, my message went a bit too fast... So as I was saying:
> 
> Not only the in-structure alignment matters but also in the resource table.
> Since the resource table is often packed (see [1] for instance), if a trace
> resource is embedded in the resource table after another resource aligned
> on 32 bits only, your 64 bits trace field will potentially end up
> misaligned.

Right. Since one can mix and match the resources of different sizes and 
include them in any order, the onus is going to be on the resource table 
constructors to ensure the inter-resource alignments, if any are 
required. The resource table format allows you to add padding fields in 
between if needed, and the remoteproc core relies on the offsets.

I can only ensure the alignment within this resource structure with 
ready-available access and conversion to/from a 64-bit type, as long as 
the resource is starting on a 64-bit boundary.

> 
> To overcome this, there is multiple solutions:
> 
> - Split the 64 bits fields into 32bits low and high parts:
> Since all resources are aligned on 32bits, it will be ok

Yes, this is one solution. At the same time, this means you need 
additional conversion logic for converting to and from 64-bit field. In 
this particular case, da is the address of the trace buffer pointer on a 
64-bit processor, so we can directly use the address of the trace 
buffer. Guess it is a question of easier translation vs packing the 
resource table as tight as possible.

> 
> - Use memcpy_from/to_io when reading/writing such fields
> As I said in a previous message this should probably be used since
> the memories that are accessed by rproc are io mem (ioremap in almost
> all drivers).

Anything running out of DDR actually doesn't need the io mem semantics, 
so we actually need to be fixing the drivers. Blindly changing the 
current memcpy to memcpy_to_io in the core loader is also not right. Any 
internal memories properties will actually depend on the processor and 
SoC. Eg: The R5 TCM interfaces in general can be treated as normal memories.

regards
Suman

> 
> Regards,
> 
> Clément
> 
> [1]  https://github.com/OpenAMP/open-amp/blob/master/apps/machine/zynqmp_r5/rsc_table.h
>>
>>
>>
>>
>>>>
>>>
>>> Sounds good to me.
>>>
>>> Thanks,
>>> Bjorn

