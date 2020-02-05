Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C94EC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442EE2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBEOBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:01:49 -0500
Received: from foss.arm.com ([217.140.110.172]:47588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgBEOBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:01:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB65731B;
        Wed,  5 Feb 2020 06:01:48 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F733F68E;
        Wed,  5 Feb 2020 06:01:48 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Don't try to map on error faults
To:     Robin Murphy <robin.murphy@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org
References: <20200205100719.24999-1-tomeu.vizoso@collabora.com>
 <3500c501-b166-6a1e-267b-31a4e5c62619@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <565bac84-9e3c-21de-9043-f508e98ae6bf@arm.com>
Date:   Wed, 5 Feb 2020 14:01:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3500c501-b166-6a1e-267b-31a4e5c62619@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2020 13:25, Robin Murphy wrote:
> On 05/02/2020 10:07 am, Tomeu Vizoso wrote:
>> If the exception type isn't one of the normal faults, don't try to map
>> and instead go straight to a terminal fault.
> 
> "One of the the normal faults" seems a rather vague way of saying "a
> translation fault", which is what we're specifically handling here, and
> logically the only fault reflecting something not yet mapped rather than
> mapped inappropriately ;)
> 
> (Who knows how the level ended up as 1-4 rather than 0-3 as it really
> should be - another Mali Mystery(TM)...)

Ah, but you're thinking of LPAE not Mali Magic Page Tables ('inspired
by' LPAE but not actually compatible....) ;) However I do wonder what
will happen when we enable aarch64 page tables in Bifrost.

>> Otherwise, we can get flooded by kernel warnings and further faults.
> 
> Either way,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index 763cfca886a7..80abddb4544c 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -596,8 +596,9 @@ static irqreturn_t
>> panfrost_mmu_irq_handler_thread(int irq, void *data)
>>           source_id = (fault_status >> 16);
>>             /* Page fault only */
>> -        if ((status & mask) == BIT(i)) {
>> -            WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
>> +        if ((status & mask) == BIT(i) &&
>> +             exception_type >= 0xC1 &&
>> +             exception_type <= 0xC4) {

I would suggest the best option here is to copy mali_kbase and check
against a mask, in kbase[1] we have:

	switch (fault_status & AS_FAULTSTATUS_EXCEPTION_CODE_MASK) {

	case AS_FAULTSTATUS_EXCEPTION_CODE_TRANSLATION_FAULT:

[1]
https://gitlab.freedesktop.org/panfrost/linux-panfrost/blob/a864e6b9fbd093a033a90d5bbdd6dcc79a0667b2/mali_kbase_mmu.c#L108

Where:

#define AS_FAULTSTATUS_EXCEPTION_CODE_MASK                      (0x7<<3)
#define AS_FAULTSTATUS_EXCEPTION_CODE_TRANSLATION_FAULT         (0x0<<3)

Steve

>>                 ret = panfrost_mmu_map_fault_addr(pfdev, i, addr);
>>               if (!ret) {
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

