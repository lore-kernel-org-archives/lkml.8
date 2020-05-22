Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D026C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C96C20727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TOM3TO7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgEVQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:54:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:54:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MGsX4f118967;
        Fri, 22 May 2020 11:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590166473;
        bh=TxXfcp4NBZuZnip4wrTBwhcuqULHHZ7OaIVZVzP/oTc=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=TOM3TO7FWuQthj/WT7i4tssoY69CjUrlIN7IHpBRxK+VB9EAUKL3/BAD1+1Px8Nu8
         LmE29ezyzenEOk6Wvj4lSqvcVZH/Nf+5MH3kvZjImOoC6m40faFzryEpKViwIOmLu1
         YrZlROKaO0mV/TuMJQMAod9uFVrqd37TneLXeWhM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04MGsXWi006221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 11:54:33 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 11:54:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 11:54:32 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MGsWik020018;
        Fri, 22 May 2020 11:54:32 -0500
Subject: Re: [PATCH 3/4] remoteproc: add support for a new 64-bit trace
 version
From:   Suman Anna <s-anna@ti.com>
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
 <20200325204701.16862-4-s-anna@ti.com> <20200521180417.GJ408178@builder.lan>
 <997d6f9a-64ba-7a89-e909-9a5a474120b0@ti.com>
Message-ID: <f15b0c6d-eee8-b839-0c79-a5316dbbfa7b@ti.com>
Date:   Fri, 22 May 2020 11:54:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <997d6f9a-64ba-7a89-e909-9a5a474120b0@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/20 2:42 PM, Suman Anna wrote:
> Hi Bjorn,
> 
> On 5/21/20 1:04 PM, Bjorn Andersson wrote:
>> On Wed 25 Mar 13:47 PDT 2020, Suman Anna wrote:
>>
>>> Introduce a new trace entry resource structure that accommodates
>>> a 64-bit device address to support 64-bit processors. This is to
>>> be used using an overloaded version value of 1 in the upper 32-bits
>>> of the previous resource type field. The new resource still uses
>>> 32-bits for the length field (followed by a 32-bit reserved field,
>>> so can be updated in the future), which is a sufficiently large
>>> trace buffer size. A 32-bit padding field also had to be added
>>> to align the device address on a 64-bit boundary, and match the
>>> usage on the firmware side.
>>>
>>> The remoteproc debugfs logic also has been adjusted accordingly.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>>   drivers/remoteproc/remoteproc_core.c    | 40 ++++++++++++++++++++-----
>>>   drivers/remoteproc/remoteproc_debugfs.c | 37 ++++++++++++++++++-----
>>>   include/linux/remoteproc.h              | 26 ++++++++++++++++
>>>   3 files changed, 87 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index 53bc37c508c6..b9a097990862 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -609,21 +609,45 @@ void rproc_vdev_release(struct kref *ref)
>>>    *
>>>    * Returns 0 on success, or an appropriate error code otherwise
>>>    */
>>> -static int rproc_handle_trace(struct rproc *rproc, struct 
>>> fw_rsc_trace *rsc,
>>> +static int rproc_handle_trace(struct rproc *rproc, void *rsc,
>>>                     int offset, int avail, u16 ver)
>>>   {
>>>       struct rproc_debug_trace *trace;
>>>       struct device *dev = &rproc->dev;
>>> +    struct fw_rsc_trace *rsc1;
>>> +    struct fw_rsc_trace2 *rsc2;
>>>       char name[15];
>>> +    size_t rsc_size;
>>> +    u32 reserved;
>>> +    u64 da;
>>> +    u32 len;
>>> +
>>> +    if (!ver) {
>>
>> This looks like a switch to me, but I also do think this looks rather
>> crude, if you spin off the tail of this function and call it from a
>> rproc_handle_trace() and rproc_handle_trace64() I believe this would be
>> cleaner.
> 
> Yeah, ok. Will refactor for this in v2.
> 
>>
>>> +        rsc1 = (struct fw_rsc_trace *)rsc;
>>> +        rsc_size = sizeof(*rsc1);
>>> +        reserved = rsc1->reserved;
>>> +        da = rsc1->da;
>>> +        len = rsc1->len;
>>> +    } else if (ver == 1) {
>>> +        rsc2 = (struct fw_rsc_trace2 *)rsc;
>>> +        rsc_size = sizeof(*rsc2);
>>> +        reserved = rsc2->reserved;
>>> +        da = rsc2->da;
>>> +        len = rsc2->len;
>>> +    } else {
>>> +        dev_err(dev, "unsupported trace rsc version %d\n", ver);
>>
>> If we use "type" to describe your 64-bit-da-trace then this sanity check
>> would have been taken care of by the core.
>>
>>> +        return -EINVAL;
>>> +    }
>>> -    if (sizeof(*rsc) > avail) {
>>> +    if (rsc_size > avail) {
>>>           dev_err(dev, "trace rsc is truncated\n");
>>>           return -EINVAL;
>>>       }
>>>       /* make sure reserved bytes are zeroes */
>>> -    if (rsc->reserved) {
>>> -        dev_err(dev, "trace rsc has non zero reserved bytes\n");
>>> +    if (reserved) {
>>> +        dev_err(dev, "trace rsc has non zero reserved bytes, value = 
>>> 0x%x\n",
>>> +            reserved);
>>>           return -EINVAL;
>>>       }
>>> @@ -632,8 +656,8 @@ static int rproc_handle_trace(struct rproc 
>>> *rproc, struct fw_rsc_trace *rsc,
>>>           return -ENOMEM;
>>>       /* set the trace buffer dma properties */
>>> -    trace->trace_mem.len = rsc->len;
>>> -    trace->trace_mem.da = rsc->da;
>>> +    trace->trace_mem.len = len;
>>> +    trace->trace_mem.da = da;
>>>       /* set pointer on rproc device */
>>>       trace->rproc = rproc;
>>> @@ -652,8 +676,8 @@ static int rproc_handle_trace(struct rproc 
>>> *rproc, struct fw_rsc_trace *rsc,
>>>       rproc->num_traces++;
>>> -    dev_dbg(dev, "%s added: da 0x%x, len 0x%x\n",
>>> -        name, rsc->da, rsc->len);
>>> +    dev_dbg(dev, "%s added: da 0x%llx, len 0x%x\n",
>>> +        name, da, len);
>>>       return 0;
>>>   }
>>> diff --git a/drivers/remoteproc/remoteproc_debugfs.c 
>>> b/drivers/remoteproc/remoteproc_debugfs.c
>>> index 3560eed7a360..ff43736db45a 100644
>>> --- a/drivers/remoteproc/remoteproc_debugfs.c
>>> +++ b/drivers/remoteproc/remoteproc_debugfs.c
>>> @@ -192,7 +192,8 @@ static int rproc_rsc_table_show(struct seq_file 
>>> *seq, void *p)
>>>       struct resource_table *table = rproc->table_ptr;
>>>       struct fw_rsc_carveout *c;
>>>       struct fw_rsc_devmem *d;
>>> -    struct fw_rsc_trace *t;
>>> +    struct fw_rsc_trace *t1;
>>> +    struct fw_rsc_trace2 *t2;
>>>       struct fw_rsc_vdev *v;
>>>       int i, j;
>>> @@ -205,6 +206,7 @@ static int rproc_rsc_table_show(struct seq_file 
>>> *seq, void *p)
>>>           int offset = table->offset[i];
>>>           struct fw_rsc_hdr *hdr = (void *)table + offset;
>>>           void *rsc = (void *)hdr + sizeof(*hdr);
>>> +        u16 ver = hdr->st.v;
>>>           switch (hdr->st.t) {
>>>           case RSC_CARVEOUT:
>>> @@ -230,13 +232,32 @@ static int rproc_rsc_table_show(struct seq_file 
>>> *seq, void *p)
>>>               seq_printf(seq, "  Name %s\n\n", d->name);
>>>               break;
>>>           case RSC_TRACE:
>>> -            t = rsc;
>>> -            seq_printf(seq, "Entry %d is of type %s\n",
>>> -                   i, types[hdr->st.t]);
>>> -            seq_printf(seq, "  Device Address 0x%x\n", t->da);
>>> -            seq_printf(seq, "  Length 0x%x Bytes\n", t->len);
>>> -            seq_printf(seq, "  Reserved (should be zero) [%d]\n", 
>>> t->reserved);
>>> -            seq_printf(seq, "  Name %s\n\n", t->name);
>>> +            if (ver == 0) {
>>
>> Again, this is a switch, here in a switch. Just defining a new
>> RSC_TRACE64 type would reduce the amount of code here...
> 
> OK.
> 
>>
>>> +                t1 = rsc;
>>> +                seq_printf(seq, "Entry %d is version %d of type %s\n",
>>> +                       i, ver, types[hdr->st.t]);
>>> +                seq_printf(seq, "  Device Address 0x%x\n",
>>> +                       t1->da);
>>> +                seq_printf(seq, "  Length 0x%x Bytes\n",
>>> +                       t1->len);
>>> +                seq_printf(seq, "  Reserved (should be zero) [%d]\n",
>>> +                       t1->reserved);
>>> +                seq_printf(seq, "  Name %s\n\n", t1->name);
>>> +            } else if (ver == 1) {
>>> +                t2 = rsc;
>>> +                seq_printf(seq, "Entry %d is version %d of type %s\n",
>>> +                       i, ver, types[hdr->st.t]);
>>> +                seq_printf(seq, "  Device Address 0x%llx\n",
>>> +                       t2->da);
>>> +                seq_printf(seq, "  Length 0x%x Bytes\n",
>>> +                       t2->len);
>>> +                seq_printf(seq, "  Reserved (should be zero) [%d]\n",
>>> +                       t2->reserved);
>>> +                seq_printf(seq, "  Name %s\n\n", t2->name);
>>> +            } else {
>>> +                seq_printf(seq, "Entry %d is an unsupported version 
>>> %d of type %s\n",
>>> +                       i, ver, types[hdr->st.t]);
>>> +            }
>>>               break;
>>>           case RSC_VDEV:
>>>               v = rsc;
>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>> index 526d3cb45e37..3b3bea42f8b1 100644
>>> --- a/include/linux/remoteproc.h
>>> +++ b/include/linux/remoteproc.h
>>> @@ -243,6 +243,32 @@ struct fw_rsc_trace {
>>>       u8 name[32];
>>>   } __packed;
>>> +/**
>>> + * struct fw_rsc_trace2 - trace buffer declaration supporting 64-bits
>>> + * @padding: initial padding after type field for aligned 64-bit access
>>> + * @da: device address (64-bit)
>>> + * @len: length (in bytes)
>>> + * @reserved: reserved (must be zero)
>>> + * @name: human-readable name of the trace buffer
>>> + *
>>> + * This resource entry is an enhanced version of the fw_rsc_trace 
>>> resourec entry
>>> + * and the provides equivalent functionality but designed for 64-bit 
>>> remote
>>> + * processors.
>>> + *
>>> + * @da specifies the device address of the buffer, @len specifies
>>> + * its size, and @name may contain a human readable name of the 
>>> trace buffer.
>>> + *
>>> + * After booting the remote processor, the trace buffers are exposed 
>>> to the
>>> + * user via debugfs entries (called trace0, trace1, etc..).
>>> + */
>>> +struct fw_rsc_trace2 {
>>
>> Sounds more like fw_rsc_trace64 to me - in particular since the version
>> of trace2 is 1...
> 
> Yeah, will rename this.
> 
>>
>>> +    u32 padding;
>>> +    u64 da;
>>> +    u32 len;
>>> +    u32 reserved;
>>
>> What's the purpose of this reserved field?
> 
> Partly to make sure the entire resource is aligned on an 8-byte, and 
> partly copied over from fw_rsc_trace entry. I guess 32-bits is already 
> large enough of a size for trace entries irrespective of 32-bit or 
> 64-bit traces, so I doubt if we want to make the len field also a u64.

Looking at this again, I can drop both padding and reserved fields, if I 
move the len field before da. Any preferences/comments?

regards
Suman

> 
> regards
> Suman
> 
>>
>> Regards,
>> Bjorn
>>
>>> +    u8 name[32];
>>> +} __packed;
>>> +
>>>   /**
>>>    * struct fw_rsc_vdev_vring - vring descriptor entry
>>>    * @da: device address
>>> -- 
>>> 2.23.0
>>>
> 

