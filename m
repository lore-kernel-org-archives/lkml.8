Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D80C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5853524954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgEAOte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:49:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbgEAOt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:49:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B66731B;
        Fri,  1 May 2020 07:49:27 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA4E3F68F;
        Fri,  1 May 2020 07:49:25 -0700 (PDT)
Subject: Re: [PATCH 2/5] arm/arm64: smccc: Add the definition for SMCCCv1.2
 version/error codes
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-3-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <921e3b04-f624-38ba-2304-a1f0bdffded9@arm.com>
Date:   Fri, 1 May 2020 15:46:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430114814.14116-3-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 12:48, Sudeep Holla wrote:
> Add the definition for SMCCC v1.2 version and new error code added.
> While at it, also add a note that ARM DEN 0070A is deprecated and is
> now merged into the main SMCCC specification(ARM DEN 0028C).
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   include/linux/arm-smccc.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 6c1d1eda3be4..9d9a2e42e919 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -56,6 +56,7 @@
>   
>   #define ARM_SMCCC_VERSION_1_0		0x10000
>   #define ARM_SMCCC_VERSION_1_1		0x10001
> +#define ARM_SMCCC_VERSION_1_2		0x10002
>   
>   #define ARM_SMCCC_VERSION_FUNC_ID					\
>   	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> @@ -314,10 +315,14 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>    */
>   #define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
>   
> -/* Return codes defined in ARM DEN 0070A */
> +/*
> + * Return codes defined in ARM DEN 0070A
> + * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028C
> + */
>   #define SMCCC_RET_SUCCESS			0
>   #define SMCCC_RET_NOT_SUPPORTED			-1
>   #define SMCCC_RET_NOT_REQUIRED			-2
> +#define SMCCC_RET_INVALID_PARAMETER		-3
>   
>   /*
>    * Like arm_smccc_1_1* but always returns SMCCC_RET_NOT_SUPPORTED.
> 

