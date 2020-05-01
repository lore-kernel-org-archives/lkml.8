Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1DDC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DE4208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgEALIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:08:55 -0400
Received: from foss.arm.com ([217.140.110.172]:38750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbgEALIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:08:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF4A30E;
        Fri,  1 May 2020 04:08:53 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7C0A3F73D;
        Fri,  1 May 2020 04:08:50 -0700 (PDT)
Subject: Re: [RFC][PATCH 3/4] dma-buf: cma_heap: Extend logic to export CMA
 regions tagged with "linux,cma-heap"
To:     Brian Starkey <brian.starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, nd@arm.com
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-4-john.stultz@linaro.org>
 <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <47e7eded-7240-887a-39e1-97c55bf752e7@arm.com>
Date:   Fri, 1 May 2020 12:08:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 11:21 am, Brian Starkey wrote:
> Hi John,
> 
> On Fri, May 01, 2020 at 07:39:48AM +0000, John Stultz wrote:
>> This patch reworks the cma_heap initialization so that
>> we expose both the default CMA region and any CMA regions
>> tagged with "linux,cma-heap" in the device-tree.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>> Cc: "Andrew F. Davis" <afd@ti.com>
>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> Cc: Liam Mark <lmark@codeaurora.org>
>> Cc: Pratik Patel <pratikp@codeaurora.org>
>> Cc: Laura Abbott <labbott@redhat.com>
>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>> Cc: Chenbo Feng <fengc@google.com>
>> Cc: Alistair Strachan <astrachan@google.com>
>> Cc: Sandeep Patil <sspatil@google.com>
>> Cc: Hridya Valsaraju <hridya@google.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>>   drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
>> index 626cf7fd033a..dd154e2db101 100644
>> --- a/drivers/dma-buf/heaps/cma_heap.c
>> +++ b/drivers/dma-buf/heaps/cma_heap.c
>> @@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
>>   {
>>   	struct cma_heap *cma_heap;
>>   	struct dma_heap_export_info exp_info;
>> +	struct cma *default_cma = dev_get_cma_area(NULL);
>> +
>> +	/* We only add the default heap and explicitly tagged heaps */
>> +	if (cma != default_cma && !cma_dma_heap_enabled(cma))
>> +		return 0;
> 
> Thinking about the pl111 thread[1], I'm wondering if we should also
> let drivers call this directly to expose their CMA pools, even if they
> aren't tagged for dma-heaps in DT. But perhaps that's too close to
> policy.

That sounds much like what my first thoughts were - apologies if I'm 
wildly off-base here, but as far as I understand:

- Device drivers know whether they have their own "memory-region" or not.
- Device drivers already have to do *something* to participate in dma-buf.
- Device drivers know best how they make use of both the above.
- Therefore couldn't it be left to drivers to choose whether to register 
their CMA regions as heaps, without having to mess with DT at all?

Robin.

> 
> Cheers,
> -Brian
> 
> [1] https://lists.freedesktop.org/archives/dri-devel/2020-April/264358.html
> 
>>   
>>   	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
>>   	if (!cma_heap)
>> @@ -162,16 +167,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
>>   	return 0;
>>   }
>>   
>> -static int add_default_cma_heap(void)
>> +static int cma_heaps_init(void)
>>   {
>> -	struct cma *default_cma = dev_get_cma_area(NULL);
>> -	int ret = 0;
>> -
>> -	if (default_cma)
>> -		ret = __add_cma_heap(default_cma, NULL);
>> -
>> -	return ret;
>> +	cma_for_each_area(__add_cma_heap, NULL);
>> +	return 0;
>>   }
>> -module_init(add_default_cma_heap);
>> +module_init(cma_heaps_init);
>>   MODULE_DESCRIPTION("DMA-BUF CMA Heap");
>>   MODULE_LICENSE("GPL v2");
>> -- 
>> 2.17.1
>>
