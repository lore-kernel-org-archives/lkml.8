Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D4AC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A0D214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QK1DBcPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgEFQEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:04:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55280 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgEFQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:04:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046G4ET5110157;
        Wed, 6 May 2020 11:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588781054;
        bh=jrBEKIuDSFaXhQfGrlKMPFW+Bx5UgahVAfVa73raab4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QK1DBcPecEckxuot4abYGboZrEbwYN8Rn9JK6Oeim1zGW9j/AvtOUFyDSgD2I1Bqe
         XveTUdb5sUjHIFiSM3FDtHr3bTgTVe+HCK1HY6um/weszTHox3ptURhZzAW7saxWSl
         PXUrwG8AUQcRPbUDNTUWv4RgJiMXknD77JEEENG0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046G4Efl031379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 11:04:14 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 11:04:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 11:04:13 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046G4CAX086976;
        Wed, 6 May 2020 11:04:12 -0500
Subject: Re: [RFC][PATCH 1/4] devicetree: bindings: Add linux,cma-heap tag for
 reserved memory
To:     Brian Starkey <brian.starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mm <linux-mm@kvack.org>, nd <nd@arm.com>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-2-john.stultz@linaro.org>
 <20200501104216.4f226c2a7bzval5o@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLVScV1j-zxw=cwpE0+eDoaubchXx6SJgu=1Zvh8HnE-Tg@mail.gmail.com>
 <20200504085007.5yrjhknkg6ugbqwk@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <1bddb721-d4d9-f113-bacc-0a0ca2d57753@ti.com>
Date:   Wed, 6 May 2020 12:04:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504085007.5yrjhknkg6ugbqwk@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 4:50 AM, Brian Starkey wrote:
> On Fri, May 01, 2020 at 11:40:16AM -0700, John Stultz wrote:
>> On Fri, May 1, 2020 at 3:42 AM Brian Starkey <brian.starkey@arm.com> wrote:
>>>
>>> Hi,
>>>
>>> On Fri, May 01, 2020 at 07:39:46AM +0000, John Stultz wrote:
>>>> This patch adds a linux,cma-heap property for CMA reserved memory
>>>> regions, which will be used to allow the region to be exposed via
>>>> the DMA-BUF Heaps interface
>>>>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Cc: "Andrew F. Davis" <afd@ti.com>
>>>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>> Cc: Liam Mark <lmark@codeaurora.org>
>>>> Cc: Pratik Patel <pratikp@codeaurora.org>
>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>>>> Cc: Chenbo Feng <fengc@google.com>
>>>> Cc: Alistair Strachan <astrachan@google.com>
>>>> Cc: Sandeep Patil <sspatil@google.com>
>>>> Cc: Hridya Valsaraju <hridya@google.com>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Cc: linux-mm@kvack.org
>>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>>> ---
>>>>  .../devicetree/bindings/reserved-memory/reserved-memory.txt    | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>>> index bac4afa3b197..e97b6a4c3bc0 100644
>>>> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>>> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>>> @@ -68,6 +68,9 @@ Linux implementation note:
>>>>  - If a "linux,cma-default" property is present, then Linux will use the
>>>>    region for the default pool of the contiguous memory allocator.
>>>>
>>>> +- If a "linux,cma-heap" property is present, then Linux will expose the
>>>> +  the CMA region via the DMA-BUF Heaps interface.
>>>> +
>>>
>>> Would it be useful or even possible to give some indication of what
>>> the heap will end up being called? I'm afraid I don't remember what if
>>> any conclusions came out of previous discussions on UAPI for heap
>>> enumeration.
>>
>> So the name we expose is the CMA name itself. So with dt it will be
>> the name of the reserved memory node that the flag property is added
>> to.
>>
> 
> Yeah I'm just wondering if that's "stable" so we can say "the heap
> will use the node name", or if saying that would cause us a headache
> in the future.


The issue is going to be this causes the node name in DT to become a
kind of ABI. Right now until we have some userspace lib that enumerates
the heaps in a stable way programs will hard-code the full heap name,
which right now would look like:

char *heap = "/dev/dma_heap/dma_heap_mem@89000000";

Yuk.. we might want to look into exporting heap properties to make them
searchable based on something other than name here soon. Or this will be
a mess to cleanup in the future.

Andrew


> 
>>> I suppose CMA names haven't been relevant to userspace before, but
>>> they perhaps would be with this change.
>>>
>>> Alternatively, leaving it effectively undefined doesn't tie us down,
>>> and something like links in sysfs can be added as a richer API in the
>>> future.
>>
>> Hrm. Mind expanding on what you're thinking here?
> 
> Super hand-wavy, something like:
> 
> /sys/devices/blah/display@2f000000/cma_region is a symlink to
> 	/sys/class/dma_heaps/heap_display
> 
> I think danvet had some thoughts in this vein.
> 
> Cheers,
> -Brian
> 
>>
>> thanks
>> -john
