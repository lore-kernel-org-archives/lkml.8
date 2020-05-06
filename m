Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B40C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A569208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EF5rBrg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgEFRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:35:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59248 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:35:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046HZVkw103808;
        Wed, 6 May 2020 12:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588786531;
        bh=EaGNiVHRrlAZYXXBERxfZT7BGumy9fgH/Sfqh9FjJlc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EF5rBrg4HaRDOlGi6AEnqAdzew8tmyq3c6VEkbyVuQhCVWPq7GTRT3wdAFQhU0o/1
         l4gbAAe7XGImtfHrJbviASZQITOZ+Q9R6V/BfcOeUgmpsfVobtkx5RLpbf2Dq7GDPG
         yIwsqKJOE0XeGpHrG4sTB4N4OCyHsCE1Tgq95ii4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046HZVFP049979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 12:35:31 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 12:35:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 12:35:31 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046HZUNM126702;
        Wed, 6 May 2020 12:35:30 -0500
Subject: Re: [RFC][PATCH 1/4] devicetree: bindings: Add linux,cma-heap tag for
 reserved memory
To:     John Stultz <john.stultz@linaro.org>
CC:     Brian Starkey <brian.starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
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
 <1bddb721-d4d9-f113-bacc-0a0ca2d57753@ti.com>
 <CALAqxLWnEj-c3CYGC6p23cwMqce-MV6pJOzGbp+ptWFB0NQoog@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <1b82e66e-01b9-5c4d-9777-1aa34bf1b07e@ti.com>
Date:   Wed, 6 May 2020 13:35:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWnEj-c3CYGC6p23cwMqce-MV6pJOzGbp+ptWFB0NQoog@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 12:30 PM, John Stultz wrote:
> On Wed, May 6, 2020 at 9:04 AM Andrew F. Davis <afd@ti.com> wrote:
>> On 5/4/20 4:50 AM, Brian Starkey wrote:
>>> On Fri, May 01, 2020 at 11:40:16AM -0700, John Stultz wrote:
>>>> So the name we expose is the CMA name itself. So with dt it will be
>>>> the name of the reserved memory node that the flag property is added
>>>> to.
>>>>
>>>
>>> Yeah I'm just wondering if that's "stable" so we can say "the heap
>>> will use the node name", or if saying that would cause us a headache
>>> in the future.
>>
>>
>> The issue is going to be this causes the node name in DT to become a
>> kind of ABI. Right now until we have some userspace lib that enumerates
>> the heaps in a stable way programs will hard-code the full heap name,
>> which right now would look like:
>>
>> char *heap = "/dev/dma_heap/dma_heap_mem@89000000";
>>
> 
> If that's what the device chose to export.
> 


Well no "device" exported it, we did mostly automatically using only DT
information. When making a DT I don't want to be thinking about how
names will break userspace, for instance if node naming guidance is
updated do apps suddenly stop working? That worries me a bit.


>> Yuk.. we might want to look into exporting heap properties to make them
>> searchable based on something other than name here soon. Or this will be
>> a mess to cleanup in the future.
> 
> Eh. I don't see this as such an issue. On different systems we have
> different device nodes. Some boards have more or fewer NICs, or
> various partitions, etc. There has to be some device specific userland
> config that determines which partitions are mounted where (this is my
> "gralloc is fstab" thesis :)
> 


Oh I agree here, net interface names and /dev/<hd> names have a history
of changing, but those did both break a lot of apps. It could be argued
they were abusing the API by making assumptions about the names, but we
still have old scripts floating assuming "eth0" is going to just work..

So the sooner we get this fstab scheme in place and in practice, the
fewer apps in the wild will hard-code names.


> I think with the heaps, qualities other than name are going to be
> poorly specified or unenumerable, so any generic query interface is
> going to fall down there (and be awful to use).
> 


Sure, so this "fstab" style config will have to be a mapping of names
(which we will have to make static per heap in kernel) to properties
that interest the current users of a system. For now I can only think of
cached/uncached, contiguous/sg, and secure/mappable. Then maybe a list
of devices that can consume buffers of that variety, should allow for
simple constraint matching. I'll need to think on this a bit more as the
use-cases show up..

Andrew


> thanks
> -john
> 
