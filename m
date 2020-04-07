Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61139C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E3B20644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgDGKm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:42:28 -0400
Received: from foss.arm.com ([217.140.110.172]:54894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgDGKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:42:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2B431B;
        Tue,  7 Apr 2020 03:42:27 -0700 (PDT)
Received: from [10.37.12.154] (unknown [10.37.12.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268C13F73D;
        Tue,  7 Apr 2020 03:42:25 -0700 (PDT)
Subject: Re: [PATCH] arm64: armv8_deprecated: Fix undef_hook mask for thumb
 setend
To:     catalin.marinas@arm.com, fredrik@strupe.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com
References: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
 <20200407092744.GA2665@gaia>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a2b345a4-30a0-3218-8c8d-e84ec2317dc9@arm.com>
Date:   Tue, 7 Apr 2020 11:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200407092744.GA2665@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2020 10:27 AM, Catalin Marinas wrote:
> On Mon, Apr 06, 2020 at 04:16:05PM +0200, Fredrik Strupe wrote:
>> Use a full 32-bit mask to prevent accidental matchings of thumb32
>> instructions where the second half-word is equal to the thumb16 setend
>> encoding.
>>
>> This fixes the same problem as the following patch:
>>
>>      https://lkml.org/lkml/2020/3/16/341
> 
> This link is not guaranteed to be stable and the commit should have the
> full description rather than referring to another email.
> 
>> but for setend emulation instead.
>>
>> Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
> 
> It also needs Fixes: and Cc: stable tags.
> 
>> ---
>>   arch/arm64/kernel/armv8_deprecated.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index 9d3442d62..8c06dfee0 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -609,7 +609,7 @@ static struct undef_hook setend_hooks[] = {
>>   	},
>>   	{
>>   		/* Thumb mode */
>> -		.instr_mask	= 0x0000fff7,
>> +		.instr_mask	= 0xfffffff7,
>>   		.instr_val	= 0x0000b650,
> 
> I can see how this could happen but it would be useful to provide a
> concrete example in the commit log.
> 
> The instruction opcode built by call_undef_hook() first reads a u16 as a
> T16 instruction and the above should be fine. However, if this looks
> like a T32 opcode, it reads a subsequent u16 which becomes the lowest
> half-word and the above mask/val may inadvertently match it.
> 

We also do a check on the pstate_val, along with the instr_val to
confirm the mode. So this should be fine as it is ?

Suzuki
