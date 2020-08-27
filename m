Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80552C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5186120639
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgH0GVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:21:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgH0GVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:21:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D843429906582A372087;
        Thu, 27 Aug 2020 14:21:40 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 14:21:36 +0800
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Move the ignore_crat check before the
 CRAT table get
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>
References: <1598430556-18788-1-git-send-email-guohanjun@huawei.com>
 <eb7a2496-c7a6-caeb-8b44-4da07686ce12@amd.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <8caa6963-a296-8fac-4477-f8c3974efd14@huawei.com>
Date:   Thu, 27 Aug 2020 14:21:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eb7a2496-c7a6-caeb-8b44-4da07686ce12@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/27 12:28, Felix Kuehling wrote:
> 
> Am 2020-08-26 um 4:29 a.m. schrieb Hanjun Guo:
>> If the ignore_crat is set to non-zero value, it's no point getting
>> the CRAT table, so just move the ignore_crat check before we get the
>> CRAT table.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 6a250f8..ed77b109 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -764,6 +764,11 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>>   
>>   	*crat_image = NULL;
>>   
>> +	if (ignore_crat) {
> 
> A conflicting change in this area was just submitted on Monday to
> amd-staging-drm-next. You'll need to rebase your patch. It should be
> straight-forward. ignore_crat was replaced with a function call
> kfd_ignore_crat().
> 
> Other than that, your patch series looks good to me. If I don't see an
> update from you in a day or two, I'll fix it up myself and add my R-b.

Please fix it up by yourself, thanks a lot for the help!

Regards
Hanjun

