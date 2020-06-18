Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910CFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B0A206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgFRKul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:50:41 -0400
Received: from foss.arm.com ([217.140.110.172]:47940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbgFRKuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:50:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAAFA31B;
        Thu, 18 Jun 2020 03:50:38 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EA903F71F;
        Thu, 18 Jun 2020 03:50:37 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] arm_pmu: Introduce pmu_irq_ops
To:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        maz@kernel.org, Will Deacon <will.deacon@arm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
 <20200617113851.607706-7-alexandru.elisei@arm.com>
 <159242539231.62212.11549121838391298623@swboyd.mtv.corp.google.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <8db25400-5a01-18f6-d362-af3ad229361a@arm.com>
Date:   Thu, 18 Jun 2020 11:51:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159242539231.62212.11549121838391298623@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/17/20 9:23 PM, Stephen Boyd wrote:
> Quoting Alexandru Elisei (2020-06-17 04:38:50)
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index df352b334ea7..17e5952d21e4 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -26,8 +26,46 @@
>>  
>>  #include <asm/irq_regs.h>
>>  
>> +static int armpmu_count_irq_users(const int irq);
>> +
>> +struct pmu_irq_ops {
>> +       void (*enable_pmuirq)(unsigned int irq);
>> +       void (*disable_pmuirq)(unsigned int irq);
>> +       void (*free_pmuirq)(unsigned int irq, int cpu, void __percpu *devid);
> Does 'cpu' need to be signed?

I'm not sure what you mean. The cpu argument comes from
drivers/perf/arm_pmu_platform.c::armpmu_free_irqs -> arpmu_free_irq, where is the
iterator variable used by the macro for_each_cpu. The documentation for the macro
states:

/**
* for_each_cpu - iterate over every cpu in a mask
* @cpu: the (optionally unsigned) integer iterator ^^^^^^^^^^^^^^^^^^^

I could write a patch to convert to an unsigned int, but it seems like unnecessary
churn to me.

>> +};
>> +
>> +static void armpmu_free_pmuirq(unsigned int irq, int cpu, void __percpu *devid)
>> +{
>> +       free_irq(irq, per_cpu_ptr(devid, cpu));
>> +}
>> +
>> +static const struct pmu_irq_ops pmuirq_ops = {
>> +       .enable_pmuirq = enable_irq,
>> +       .disable_pmuirq = disable_irq_nosync,
>> +       .free_pmuirq = armpmu_free_pmuirq
>> +};
>> +
>> +static void armpmu_enable_percpu_pmuirq(unsigned int irq)
>> +{
>> +       enable_percpu_irq(irq, IRQ_TYPE_NONE);
>> +}
>> +
>> +static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
>> +                                  void __percpu *devid)
>> +{
>> +       if (armpmu_count_irq_users(irq) == 1)
>> +               free_percpu_irq(irq, devid);
>> +}
>> +
>> +static const struct pmu_irq_ops percpu_pmuirq_ops = {
>> +       .enable_pmuirq = armpmu_enable_percpu_pmuirq,
>> +       .disable_pmuirq = disable_percpu_irq,
>> +       .free_pmuirq = armpmu_free_percpu_pmuirq
>> +};
>> +
>>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>>  static DEFINE_PER_CPU(int, cpu_irq);
> Same question as above.

Same situation as above - cpu is the iterator variable for for_each_cpu.

Thanks,
Alex
