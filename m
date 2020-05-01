Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8641C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B180E2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgEAOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:49:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbgEAOtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:49:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E98881FB;
        Fri,  1 May 2020 07:49:23 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67B03F68F;
        Fri,  1 May 2020 07:49:22 -0700 (PDT)
Subject: Re: [PATCH 1/5] arm/arm64: smccc: Update link to latest SMCCC
 specification
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-2-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <563cade1-5790-3b4f-4942-adc1ff90eb0f@arm.com>
Date:   Fri, 1 May 2020 15:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430114814.14116-2-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 12:48, Sudeep Holla wrote:
> The current link gets redirected to the revision B published in November
> 2016 though it actually points to the original revision A published in
> June 2013.
> 
> Let us update the link to point to the latest version, so that it
> doesn't get stal anytime soon. Currently it points to v1.2 published in

s/stal/stale/

otherwise:

Reviewed-by: Steven Price <steven.price@arm.com>

> March 2020.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   include/linux/arm-smccc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 59494df0f55b..6c1d1eda3be4 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -10,7 +10,7 @@
>   /*
>    * This file provides common defines for ARM SMC Calling Convention as
>    * specified in
> - * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> + * https://developer.arm.com/docs/den0028/latest
>    */
>   
>   #define ARM_SMCCC_STD_CALL	        _AC(0,U)
> 

