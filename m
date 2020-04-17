Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F86C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C22206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgDQHK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:10:26 -0400
Received: from verein.lst.de ([213.95.11.211]:56075 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgDQHK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:10:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A82A768BEB; Fri, 17 Apr 2020 09:10:23 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:10:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [patch 5/7] dma-pool: add pool sizes to debugfs
Message-ID: <20200417071023.GC19153@lst.de>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com> <alpine.DEB.2.22.394.2004141704050.68516@chino.kir.corp.google.com> <0c7144e3-057a-959d-0b7d-4a718bd6076c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7144e3-057a-959d-0b7d-4a718bd6076c@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:45:08AM -0500, Tom Lendacky wrote:
>
>
> On 4/14/20 7:04 PM, David Rientjes wrote:
>> The atomic DMA pools can dynamically expand based on non-blocking
>> allocations that need to use it.
>>
>> Export the sizes of each of these pools, in bytes, through debugfs for
>> measurement.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: David Rientjes <rientjes@google.com>
>> ---
>>   kernel/dma/pool.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index cf052314d9e4..3e22022c933b 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright (C) 2020 Google LLC
>>    */
>> +#include <linux/debugfs.h>
>>   #include <linux/dma-direct.h>
>>   #include <linux/dma-noncoherent.h>
>>   #include <linux/dma-contiguous.h>
>> @@ -15,6 +16,11 @@
>>   static struct gen_pool *atomic_pool_dma __ro_after_init;
>>   static struct gen_pool *atomic_pool_dma32 __ro_after_init;
>>   static struct gen_pool *atomic_pool_kernel __ro_after_init;
>> +#ifdef CONFIG_DEBUG_FS
>
> I don't think you need the #ifdef any more unless you just want to save 
> space. All of the debugfs routines have versions for whether 
> CONFIG_DEBUG_FS is defined or not.

Agreed.  I can fix this up.
