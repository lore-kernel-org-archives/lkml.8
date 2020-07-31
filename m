Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2997C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C6C2076B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbgGaGP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:15:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbgGaGP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:15:27 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B32FF126CD88B9C5463;
        Fri, 31 Jul 2020 14:15:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 31 Jul 2020
 14:15:14 +0800
Subject: Re: [PATCH] drm/amdkfd: Put ACPI table after using it
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>
References: <1595411308-15654-1-git-send-email-guohanjun@huawei.com>
 <443ace32-0860-f823-bc3f-3faafd5da54e@amd.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <4d220f68-e259-ee4d-127d-7f9056aa7aa6@huawei.com>
Date:   Fri, 31 Jul 2020 14:15:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <443ace32-0860-f823-bc3f-3faafd5da54e@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/31 10:41, Felix Kuehling wrote:
> Hi Hanjun,
> 
> Sorry for the late reply.
> 
> Thank you for the patch and the explanation. This seems to have been
> broken since the first version of KFD in 2014. See one suggestion inline.
> 
> Am 2020-07-22 um 5:48 a.m. schrieb Hanjun Guo:
>> The acpi_get_table() should be coupled with acpi_put_table() if
>> the mapped table is not used at runtime to release the table
>> mapping.
>>
>> In kfd_create_crat_image_acpi(), crat_table is copied to pcrat_image,
>> and in kfd_create_vcrat_image_cpu(), the acpi_table is only used to
>> get the OEM info, so those table mappings need to be release after
>> using it.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 1009a3b..d378e61 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -756,6 +756,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>>   	struct acpi_table_header *crat_table;
>>   	acpi_status status;
>>   	void *pcrat_image;
>> +	int rc = 0;
>>   
>>   	if (!crat_image)
>>   		return -EINVAL;
>> @@ -776,17 +777,21 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>>   
>>   	if (ignore_crat) {
>>   		pr_info("CRAT table disabled by module option\n");
> 
> We should probably move this check to before we get the CRAT table.
> There is not point getting and putting it if we're going to ignore it
> anyway.
> 
> Do you want to send an updated patch with that change? Or maybe do it as
> a 2-patch series?

I will do it as 2-patch series and send a updated patch set.

Thanks
Hanjun

