Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63375C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E8420714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgBKO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:28:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbgBKO2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:28:20 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B638F4232B6164BF7E35;
        Tue, 11 Feb 2020 22:28:16 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 22:28:14 +0800
Subject: Re: [PATCH -next] staging: vc04_services: remove set but unused
 variable 'local_entity_uc'
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20200211134356.59904-1-yuehaibing@huawei.com>
 <20200211142433.GG1778@kadam>
CC:     <nsaenzjulienne@suse.de>, <gregkh@linuxfoundation.org>,
        <wahrenst@gmx.net>, <jamal.k.shareef@gmail.com>,
        <marcgonzalez@google.com>, <nishkadg.linux@gmail.com>,
        <nachukannan@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <85f21dab-b0eb-c416-3434-9a10a00d7f77@huawei.com>
Date:   Tue, 11 Feb 2020 22:28:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200211142433.GG1778@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/11 22:24, Dan Carpenter wrote:
> On Tue, Feb 11, 2020 at 09:43:56PM +0800, YueHaibing wrote:
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_use_internal:
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2346:16:
>>  warning: variable local_entity_uc set but not used [-Wunused-but-set-variable]
>>
>> commit bd8aa2850f00 ("staging: vc04_services: Get of even more suspend/resume states")
>> left behind this unused variable.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index c456ced..d30d24d 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -2343,7 +2343,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>>  	enum vchiq_status ret = VCHIQ_SUCCESS;
>>  	char entity[16];
>>  	int *entity_uc;
>> -	int local_uc, local_entity_uc;
>> +	int local_uc;
>>  
>>  	if (!arm_state)
>>  		goto out;
>> @@ -2367,7 +2367,6 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>>  
>>  	write_lock_bh(&arm_state->susp_res_lock);
>>  	local_uc = ++arm_state->videocore_use_count;
>> -	local_entity_uc = ++(*entity_uc);
>                           ^^
> This ++ is required.

oops..., Thanks!

> 
> regards,
> dan carpenter
> 
> 
> .
> 

