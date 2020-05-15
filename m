Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52325C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B2820758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOLiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:38:07 -0400
Received: from foss.arm.com ([217.140.110.172]:54402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgEOLiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:38:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34762D6E;
        Fri, 15 May 2020 04:38:06 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.24.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4893F305;
        Fri, 15 May 2020 04:38:03 -0700 (PDT)
Date:   Fri, 15 May 2020 12:38:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 3/7] firmware: smccc: Add the definition for SMCCCv1.2
 version/error codes
Message-ID: <20200515113801.GC67718@C02TD0UTHF1T.local>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-4-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506164411.3284-4-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:44:07PM +0100, Sudeep Holla wrote:
> Add the definition for SMCCC v1.2 version and new error code added.
> While at it, also add a note that ARM DEN 0070A is deprecated and is
> now merged into the main SMCCC specification(ARM DEN 0028C).
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Hmm... the SMCCC v1.2 doc still seems to be EAC rather than a final
release.

I don't expect that this would change, but I am a little hesitant to add
other stuff based on an unfinalized spec. Do we know when the final
release will be?

Thanks,
Mark.

> ---
>  include/linux/arm-smccc.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 6c1d1eda3be4..9d9a2e42e919 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -56,6 +56,7 @@
>  
>  #define ARM_SMCCC_VERSION_1_0		0x10000
>  #define ARM_SMCCC_VERSION_1_1		0x10001
> +#define ARM_SMCCC_VERSION_1_2		0x10002
>  
>  #define ARM_SMCCC_VERSION_FUNC_ID					\
>  	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> @@ -314,10 +315,14 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   */
>  #define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
>  
> -/* Return codes defined in ARM DEN 0070A */
> +/*
> + * Return codes defined in ARM DEN 0070A
> + * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028C
> + */
>  #define SMCCC_RET_SUCCESS			0
>  #define SMCCC_RET_NOT_SUPPORTED			-1
>  #define SMCCC_RET_NOT_REQUIRED			-2
> +#define SMCCC_RET_INVALID_PARAMETER		-3
>  
>  /*
>   * Like arm_smccc_1_1* but always returns SMCCC_RET_NOT_SUPPORTED.
> -- 
> 2.17.1
> 
