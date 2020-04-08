Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E65C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDD620747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgDHLfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:35:08 -0400
Received: from foss.arm.com ([217.140.110.172]:37210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgDHLfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:35:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE1C31B;
        Wed,  8 Apr 2020 04:35:07 -0700 (PDT)
Received: from [10.37.12.149] (unknown [10.37.12.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420603F73D;
        Wed,  8 Apr 2020 04:35:06 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: armv8_deprecated: Fix undef_hook mask for thumb
 setend
To:     fredrik@strupe.net, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com
References: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
 <20200407092744.GA2665@gaia> <a2b345a4-30a0-3218-8c8d-e84ec2317dc9@arm.com>
 <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
 <20200408090111.GA27331@gaia>
 <9979396e-5d01-0cfe-722f-3a4f6e81dc01@strupe.net>
 <ab77076b-774d-9158-bc0c-3cfdd36b6e37@strupe.net>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f2c442f8-d2b6-c859-ca1a-2b8a343047e6@arm.com>
Date:   Wed, 8 Apr 2020 12:39:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ab77076b-774d-9158-bc0c-3cfdd36b6e37@strupe.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 12:29 PM, Fredrik Strupe wrote:
> For thumb instructions, call_undef_hook() in traps.c first reads a u16,
> and if the u16 indicates a T32 instruction (u16 >= 0xe800), a second
> u16 is read, which then makes up the the lower half-word of a T32
> instruction. For T16 instructions, the second u16 is not read,
> which makes the resulting u32 opcode always have the upper half set to
> 0.
> 
> However, having the upper half of instr_mask in the undef_hook set to 0
> masks out the upper half of all thumb instructions - both T16 and T32.
> This results in trapped T32 instructions with the lower half-word equal
> to the T16 encoding of setend (b650) being matched, even though the upper
> half-word is not 0000 and thus indicates a T32 opcode.
> 
> An example of such a T32 instruction is eaa0b650, which should raise a
> SIGILL since T32 instructions with an eaa prefix are unallocated as per
> Arm ARM, but instead works as a SETEND because the second half-word is set
> to b650.
> 
> This patch fixes the issue by extending instr_mask to include the
> upper u32 half, which will still match T16 instructions where the upper
> half is 0, but not T32 instructions.
> 
> Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks")
> ---
>   arch/arm64/kernel/armv8_deprecated.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 9d3442d62..8c06dfee0 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -609,7 +609,7 @@ static struct undef_hook setend_hooks[] = {
>   	},
>   	{
>   		/* Thumb mode */
> -		.instr_mask	= 0x0000fff7,
> +		.instr_mask	= 0xfffffff7,
>   		.instr_val	= 0x0000b650,
>   		.pstate_mask	= (PSR_AA32_T_BIT | PSR_AA32_MODE_MASK),
>   		.pstate_val	= (PSR_AA32_T_BIT | PSR_AA32_MODE_USR),
> 

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
