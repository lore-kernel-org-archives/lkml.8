Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D33C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659FA208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgGaJoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:44:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732080AbgGaJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:44:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6ED531B;
        Fri, 31 Jul 2020 02:44:52 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C083F66E;
        Fri, 31 Jul 2020 02:44:50 -0700 (PDT)
Subject: Re: [RFC PATCH 08/14] coresight: etm4x: Convert all register accesses
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-9-suzuki.poulose@arm.com>
 <20200730202021.GE3155687@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c3f6b2a2-67d6-44ed-9e03-c9f929bb469e@arm.com>
Date:   Fri, 31 Jul 2020 10:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200730202021.GE3155687@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2020 09:20 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:34PM +0100, Suzuki K Poulose wrote:
>> Convert all register accesses from etm4x driver to use a wrapper
>> to allow switching the access at runtime with little overhead.
>>
>> co-developed by sed tool ;-), mostly equivalent to :
>>
>> s/readl\(_relaxed\)\?(drvdata->base + \(.*\))/etm4x_\1_read32(csdev, \2)
>> s/writel\(_relaxed\)\?(\(.*\), drvdata->base + \(.*\))/etm4x_\1_write32(csdev, \2, \3)
>>
>> We don't want to replace them with the csdev_access_* to
>> avoid a function call for every register access for system
>> register access.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-sysfs.c         |   9 +-
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 334 +++++++++---------
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  24 ++
>>   3 files changed, 189 insertions(+), 178 deletions(-)
>>


Agreed to all the comments.

>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index b8283e1d6d88..2b51d03ab6d7 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -120,6 +120,30 @@
>>   #define TRCCIDR2			0xFF8
>>   #define TRCCIDR3			0xFFC
>>   
>> +#define etm4x_relaxed_read32(csa, offset)		\
>> +	readl_relaxed((csa)->base + (offset))
>> +
>> +#define etm4x_read32(csa, offset)			\
>> +	readl((csa)->base + (offset))
>> +
>> +#define etm4x_relaxed_write32(csa, val, offset)		\
>> +	writel_relaxed((val), (csa)->base + (offset))
>> +
>> +#define etm4x_write32(csa, val, offset)			\
>> +	writel((val), (csa)->base + (offset))
>> +
>> +#define etm4x_relaxed_read64(csa, offset)		\
>> +	readq_relaxed((csa)->base + (offset))
>> +
>> +#define etm4x_read64(csa, offset)			\
>> +	readq((csa)->base + (offset))
>> +
>> +#define etm4x_relaxed_write64(csa, val, offset)		\
>> +	writeq_relaxed((val), (csa)->base + (offset))
>> +
>> +#define etm4x_write64(csa, val, offset)			\
>> +	writeq((val), (csa)->base + (offset))
>> +
> 
> Since I haven't gone through the rest of the patches I'll assume you want to
> enhance the above to pick an access type at some point in the future.
> 

Yes, they are plumbed in with the introduction of system instruction
support. We don't want to the overhead of a function call for
each register access. Also, we would like to avoid jumping
through the large switch..cases for a compile time constant
offset. Hence this macro.

Cheers
Suzuki
