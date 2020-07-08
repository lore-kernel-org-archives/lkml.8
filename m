Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356D72078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgGHPLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:11:40 -0400
Received: from foss.arm.com ([217.140.110.172]:45934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:11:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F801FB;
        Wed,  8 Jul 2020 08:11:39 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6E43F237;
        Wed,  8 Jul 2020 08:11:39 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
 <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <6b75da91-c24d-4d54-e6ac-ff580141fda9@arm.com>
Date:   Wed, 8 Jul 2020 10:11:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/8/20 5:35 AM, Nicolas Saenz Julienne wrote:
> Hi Jim,
> 
> On Tue, 2020-07-07 at 17:08 -0500, Jeremy Linton wrote:
>> Hi,
>>
>> I spun this up on my 8G model using the PFTF firmware from:
>>
>> https://github.com/pftf/RPi4/releases
>>
>> Which allows me to switch between ACPI/DT on the machine. In DT mode it
>> works fine now,
> 
> Nice, would that count as a Tested-by from you?

If it worked... :)

> 
>> but with ACPI I continue to have failures unless I
>> disable CMA via cma=0 on the kernel command line.
> 
> Yes, I see why, in atomic_pool_expand() memory is allocated from CMA without
> checking its correctness. That calls for a separate fix. I'll try to think of
> something.
> 
>> It think that is because
>>
>> using DT:
>>
>> [    0.000000] Reserved memory: created CMA memory pool at
>> 0x0000000037400000, size 64 MiB
>>
>>
>> using ACPI:
>> [    0.000000] cma: Reserved 64 MiB at 0x00000000f8000000
>>
>> Which is AFAIK because the default arm64 CMA allocation is just below
>> the arm64_dma32_phys_limit.
> 
> As I'm sure you know, we fix the CMA address trough DT, isn't that possible
> trough ACPI?

Well there isn't a linux specific cma location property in ACPI. There 
are various ways to infer the information, like looking for the lowest 
_DMA() range and using that to lower the arm64_dma32_phys_limit. OTOH, 
as it stands I don't think that information is available early enough to 
setup the cma pool.

But as you mention the atomic pool code is allocating from CMA under the 
assumption that its going to be below the GFP_DMA range, which might not 
be generally true (due to lack of DT cma properties too?).
