Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB0C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B312072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDHHUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:20:44 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:32894 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726453AbgDHHUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:20:44 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 8 Apr
 2020 15:20:20 +0800
Received: from [10.28.64.103] (10.28.64.103) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 8 Apr
 2020 15:20:19 +0800
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <cooperyan@zhaoxin.com>
References: <1585647599-6649-1-git-send-email-CodyYao-oc@zhaoxin.com>
 <20200331101834.GP20730@hirez.programming.kicks-ass.net>
From:   CodyYao-oc <CodyYao-oc@zhaoxin.com>
Message-ID: <238c0da5-c542-55b1-aaed-d4345516b84b@zhaoxin.com>
Date:   Wed, 8 Apr 2020 15:20:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331101834.GP20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.64.103]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/31 下午6:18, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 05:39:59PM +0800, CodyYao-oc wrote:
>> Zhaoxin CPU has provided facilities for monitoring performance
>> via PMU(Performance Monitor Unit), but the functionality is unused so far.
>> Therefore, add support for zhaoxin pmu to make performance related
>> hardware events available.
> 
> This looks like an Intel Architectural PMU v2 or so, is that correct? Do
> you have a link to documentation for your CPU?
> 
I'm sorry for such a late reply. Yes, the usage method is the same as 
Intel PMU v2, but there is no online document at present. For your 
convenience, provide some event descriptions as follows:

-----------------------------------------------------------------------------------------------------------------------------------
Event                      | Event  | Umask |          Description
                            | Select |       |
-----------------------------------------------------------------------------------------------------------------------------------
cpu-cycles                 |  82h   |  00h  | unhalt core clock
instructions               |  00h   |  00h  | number of instructions at 
retirement.
cache-references           |  15h   |  05h  | number of fillq pushs at 
the current cycle.
cache-misses               |  1ah   |  05h  | number of l2 miss pushed 
by fillq.
branch-instructions        |  28h   |  00h  | counts the number of 
branch instructions retired.
branch-misses              |  29h   |  00h  | mispredicted branch 
instructions at retirement.
bus-cycles                 |  83h   |  00h  | unhalt bus clock
stalled-cycles-frontend    |  01h   |  01h  | Increments each cycle the 
# of Uops issued by the RAT to RS.
stalled-cycles-backend     |  0fh   |  04h  | RS0/1/2/3/45 empty
L1-dcache-loads            |  68h   |  05h  | number of retire/commit load.
L1-dcache-load-misses      |  4bh   |  05h  | retired load uops whose 
data source followed an L1 miss.
L1-dcache-stores           |  69h   |  06h  | number of retire/commit 
Store,no LEA
L1-dcache-store-misses     |  62h   |  05h  | cache lines in M state 
evicted out of L1D due to Snoop HitM or dirty line replacement.
L1-icache-loads            |  00h   |  03h  | number of l1i cache access 
for valid normal fetch,including un-cacheable access.
L1-icache-load-misses      |  01h   |  03h  | number of l1i cache miss 
for valid normal fetch,including un-cacheable miss.
L1-icache-prefetches       |  0ah   |  03h  | number of prefetch.
L1-icache-prefetch-misses  |  0bh   |  03h  | number of prefetch miss.
dTLB-loads                 |  68h   |  05h  | number of retire/commit load
dTLB-load-misses           |  2ch   |  05h  | number of load operations 
miss all level tlbs and cause a tablewalk.
dTLB-stores                |  69h   |  06h  | number of retire/commit 
Store,no LEA
dTLB-store-misses          |  30h   |  05h  | number of store operations 
miss all level tlbs and cause a tablewalk.
dTLB-prefetches            |  64h   |  05h  | number of hardware pte 
prefetch requests dispatched out of the prefetch FIFO.
dTLB-prefetch-misses       |  65h   |  05h  | number of hardware pte 
prefetch requests miss the l1d data cache.
iTLB-load                  |  00h   |  00h  | actually counter instructions.
iTLB-load-misses           |  34h   |  05h  | number of code operations 
miss all level tlbs and cause a tablewalk.
-----------------------------------------------------------------------------------------------------------------------------------


>> +static void zhaoxin_pmu_disable_all(void)
>> +{
>> +	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>> +}
>> +
>> +static void zhaoxin_pmu_enable_all(int added)
>> +{
>> +	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
>> +}
>> +
>> +static inline u64 zhaoxin_pmu_get_status(void)
>> +{
>> +	u64 status;
>> +
>> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
>> +
>> +	return status;
>> +}
>> +
>> +static inline void zhaoxin_pmu_ack_status(u64 ack)
>> +{
>> +	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
>> +}
> 
>> +static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
>> +{
>> +	struct perf_sample_data data;
>> +	struct cpu_hw_events *cpuc;
>> +	int bit;
>> +	u64 status;
>> +	bool is_zxc;
>> +	int handled = 0;
>> +
>> +	cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	apic_write(APIC_LVTPC, APIC_DM_NMI);
>> +	zhaoxin_pmu_disable_all();
>> +	status = zhaoxin_pmu_get_status();
>> +	if (!status)
>> +		goto done;
>> +
>> +	if (boot_cpu_data.x86 == 0x06 &&
>> +		(boot_cpu_data.x86_model == 0x0f ||
>> +			boot_cpu_data.x86_model == 0x19))
>> +		is_zxc = true;
>> +again:
>> +
>> +	/*Clearing status works only if the global control is enable on zxc.*/
>> +	if (is_zxc)
>> +		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
>> +
>> +	zhaoxin_pmu_ack_status(status);
>> +
>> +	if (is_zxc)
>> +		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> 
> That's an unfortunate errata; perhaps write it like so:
> 

Thank you very much for your advice, I have changed the code.

> static inline void zxc_pmu_ack_status(u64 status)
> {
> 	/*
> 	 * ZXC needs global control enabled in order to clear status bits.
> 	 */
> 	zhaoxin_pmu_enable_all(0);
> 	zhaoxin_pmu_ack_status(status);
> 	zhaoxin_pmu_disable_all();
> }
> 
> 	if (is_zxc)
> 		zxc_pmu_ack_status(status);
> 	else
> 		zhaoxin_pmu_ack_status(status);
> 
> Alternatively; you can do a whole zxc specific handle_irq() and move the
> get/ack status before disable_all(). If you do that, then factor this:
> 
>> +	/*
>> +	 * CondChgd bit 63 doesn't mean any overflow status. Ignore
>> +	 * and clear the bit.
>> +	 */
>> +	if (__test_and_clear_bit(63, (unsigned long *)&status)) {
>> +		if (!status)
>> +			goto done;
>> +	}
>> +
>> +	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
>> +		struct perf_event *event = cpuc->events[bit];
>> +
>> +		handled++;
>> +
>> +		if (!test_bit(bit, cpuc->active_mask))
>> +			continue;
>> +
>> +		x86_perf_event_update(event);
>> +		perf_sample_data_init(&data, 0, event->hw.last_period);
>> +
>> +		if (!x86_perf_event_set_period(event))
>> +			continue;
>> +
>> +		if (perf_event_overflow(event, &data, regs))
>> +			x86_pmu_stop(event, 0);
>> +	}
> 
> bit into it's own function so you don't have to duplicate it. Then the
> two handle_irq() functions only differ in the status handling.
> 
>> +
>> +	/*
>> +	 * Repeat if there is more work to be done:
>> +	 */
>> +	status = zhaoxin_pmu_get_status();
>> +	if (status)
>> +		goto again;
>> +
>> +done:
>> +	zhaoxin_pmu_enable_all(0);
>> +	return handled;
>> +}
> .
> 

