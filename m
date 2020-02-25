Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F182CC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21BA21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="msmrRAW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgBYKuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:50:39 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:22909 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730353AbgBYKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:50:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582627838; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=AFKpvKI08/4aEKhec5+V+oShaiX1jdixcVe3ggUV3Fc=; b=msmrRAW2bZ9mBuYxdzxwKESyhG5+KqffYsW+qPm93w2ArPURzuac5B219Q00gTg20MxN0+8F
 x/DBAdN6JnBzjUjDLBR0Uh23fWefhOJGoktRJyWj/iE986KCf237QiJ1tQBirMFvCyuWw58i
 opxT9ei+3kNQlP0qGBCLQIXbys0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e54fbee.7fa68208fae8-smtp-out-n02;
 Tue, 25 Feb 2020 10:50:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4011C433A2; Tue, 25 Feb 2020 10:50:21 +0000 (UTC)
Received: from [10.204.78.247] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: snaseem)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA106C43383;
        Tue, 25 Feb 2020 10:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA106C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=snaseem@codeaurora.org
Subject: Re: [PATCH] nvmem: core: Fix msb clearing bits
To:     Mukesh Ojha <mojha@codeaurora.org>, srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org
References: <1580474635-11965-1-git-send-email-snaseem@codeaurora.org>
 <06a518e3-cff4-e2e0-2a4b-f4bfa2c6dcdc@codeaurora.org>
From:   Shadab Naseem <snaseem@codeaurora.org>
Message-ID: <658fde02-c57e-2a1e-b262-634b56ce4cde@codeaurora.org>
Date:   Tue, 25 Feb 2020 16:20:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <06a518e3-cff4-e2e0-2a4b-f4bfa2c6dcdc@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder as it is easily reproducible in 32 bit targets.

Regards

-Shadab

On 2/14/2020 12:46 PM, Mukesh Ojha wrote:
>
> On 1/31/2020 6:13 PM, Shadab Naseem wrote:
>> When clearing the msb bits of the resultant buffer, it is
>> masked with the modulo of the number of bits needed with
>> respect to the BITS_PER_BYTE. To mask out the buffer,
>> it is passed though GENMASK of the remainder of the bits
>> starting from zeroth bit. This case is valid if nbits is not
>> a multiple of BITS_PER_BYTE and you are actually creating
>> a GENMASK. If the nbits coming is a multiple of BITS_PER_BYTE,
>> it would pass a negative value to the high bit number of
>> GENMASK with zero as the lower bit number.
>>
>> As per the definition of the GENMASK, the higher bit number (h)
>> is right operand for bitwise right shift. If the value of the
>> right operand is negative or is greater or equal to the number
>> of bits in the promoted left operand, the behavior is undefined.
>> So passing a negative value to GENMASK could behave differently
>> across architecture, specifically between 64 and 32 bit.
>> Also, on passing the hard-coded negative value as GENMASK(-1, 0)
>> is giving compiler warning for shift-count-overflow.
>> Hence making a check for clearing the MSB if the nbits are not
>> a multiple of BITS_PER_BYTE.
>>
>> Signed-off-by: Shadab Naseem <snaseem@codeaurora.org>
>> ---
>>   drivers/nvmem/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 1e4a798..23c1547 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -926,7 +926,8 @@ static void 
>> nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
>>           *p-- = 0;
>>         /* clear msb bits if any leftover in the last byte */
>> -    *p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
>> +    if (cell->nbits%BITS_PER_BYTE)
>> +        *p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
>
>
> LGTM..
>
> Reviewed-by: mojha@codeaurora.org
>
>
> Thanks
> Mukesh
>
>>   }
>>     static int __nvmem_cell_read(struct nvmem_device *nvmem,
