Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16986C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA9B206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHJLCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:02:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbgHJLCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:02:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14C88507FDD3097F454F;
        Mon, 10 Aug 2020 19:02:03 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 19:01:55 +0800
Subject: Re: [PATCH] coresight: etm4x: Add Support for HiSilicon ETM device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <gregkh@linuxfoundation.org>, <saiprakash.ranjan@codeaurora.org>
References: <1596461740-13527-1-git-send-email-liuqi115@huawei.com>
 <d7271f87-719a-cc3b-6306-bb07f24fe070@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <7aa0b078-7edd-db6a-c47e-fc6a00c2dd46@huawei.com>
Date:   Mon, 10 Aug 2020 19:01:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d7271f87-719a-cc3b-6306-bb07f24fe070@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,
Thanks for your review.

On 2020/8/4 18:47, Suzuki K Poulose wrote:
> Hi Qi
> 
> On 08/03/2020 02:35 PM, Qi Liu wrote:
>> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
>> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
> 
> Does the ETMv4.5 on your system implement system instructions to access
> the ETMs ? If so, please could you give the following series on your
> board ?
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2020-July/587745.html
> 

ETMv4.5 on Hip09 platform does not support system instructions.
> 
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 0c35cd5e..4a4f0bd 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -1561,6 +1561,8 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>>   };
>>
>>   static const struct amba_id etm4_ids[] = {
>> +    CS_AMBA_ID(0x000b6d02),            /* HiSilicon-Hip09 */
>> +    CS_AMBA_ID(0x000b6d01),            /* HiSilicon-Hip08 */
> 
> Please use CS_AMBA_UCI_ID() instead.
> 
> We should stop using the CS_AMBA_ID()
> 
ok, I'll fix this in next version.

Thanks,
Qi
> 
> Suzuki
> 
> .
> 

