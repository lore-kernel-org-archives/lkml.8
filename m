Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8669C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD86020663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbgGaJqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:46:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731922AbgGaJqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:46:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40F7E31B;
        Fri, 31 Jul 2020 02:46:23 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EECEE3F718;
        Fri, 31 Jul 2020 02:46:21 -0700 (PDT)
Subject: Re: [RFC PATCH 09/14] coresight: etm4x: Add sysreg access helpers
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-10-suzuki.poulose@arm.com>
 <20200730214110.GF3155687@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f1d869e2-73bc-aebc-d4ce-79c324a7a36c@arm.com>
Date:   Fri, 31 Jul 2020 10:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200730214110.GF3155687@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2020 10:41 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:35PM +0100, Suzuki K Poulose wrote:
>> ETMv4.4 architecture defines the system instructions for accessing
>> ETM via register accesses. Add basic support for accessing a given
>> register via system instructions.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c |  39 ++
>>   drivers/hwtracing/coresight/coresight-etm4x.h | 379 ++++++++++++++++--
>>   2 files changed, 394 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c


>>   static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
>>   {
>>   	/* Writing 0 to TRCOSLAR unlocks the trace registers */
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 2b51d03ab6d7..f5d708206339 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h

		0x1FC
>> -/* Resource selection registers */
>> +/*
>> + * Resource selection registers, n = 2-31.
>> + * First pair (regs 0, 1) is always present and is reserved.
>> + */
>>   #define TRCRSCTLRn(n)			(0x200 + (n * 4))
>> -/* Single-shot comparator registers */
>> +/* Single-shot comparator registers, n = 0-7 */
>>   #define TRCSSCCRn(n)			(0x280 + (n * 4))
>>   #define TRCSSCSRn(n)			(0x2A0 + (n * 4))
>>   #define TRCSSPCICRn(n)			(0x2C0 + (n * 4))
>> @@ -80,11 +83,13 @@
>>   #define TRCPDCR				0x310
>>   #define TRCPDSR				0x314
>>   /* Trace registers (0x318-0xEFC) */
>> -/* Comparator registers */
>> +/* Address Comparator registers n = 0-15 */
>>   #define TRCACVRn(n)			(0x400 + (n * 8))
>>   #define TRCACATRn(n)			(0x480 + (n * 8))
>> +/* Data Value Comparator Value registers, n = 0-7 */
>>   #define TRCDVCVRn(n)			(0x500 + (n * 16))
>>   #define TRCDVCMRn(n)			(0x580 + (n * 16))
>> +/* ContextID/Virtual ContextID comparators, n = 0-7 */
> 
> Extra documentation is good but it has to be in a separate patch.
> 

Sure, will split this. It was partly for making sure that I don't
miss a case for a register in the list.

Cheers
Suzuki

