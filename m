Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8B220791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHMKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:47:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMKrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:47:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDB8231B;
        Thu, 13 Aug 2020 03:47:20 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CB6A3F70D;
        Thu, 13 Aug 2020 03:47:19 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:47:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] driver/perf: Add PMU driver for the ARM DMC-620
 memory controller.
Message-ID: <20200813104716.GB45195@C02TD0UTHF1T.local>
References: <1589229894-18863-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589229894-18863-1-git-send-email-tuanphan@os.amperecomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:44:52PM -0700, Tuan Phan wrote:
> DMC-620 PMU supports 10 total counters that are independently
> programmable for different events and can be individually started and
> stopped.
> 
> ACPI is only supported; device tree support is welcomed to be added and
> tested for other platforms.
> 
> Usage example:
>   #perf stat -e arm_dmc620_10008c000/clk_cycle_count/ -C 0
>   Get perf event for clk_cycle_count counter.
> 
>   #perf stat -e arm_dmc620_10008c000/clkdiv2_allocate,mask=0x1f,match=0x2f,
>   incr=2,invert=1/ -C 0
>   The above example shows how to specify mask, match, incr,
>   invert parameters for clkdiv2_allocate event.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> Changes in v2:
> - Removed IRQF_SHARED flag and added support for multiple 
> PMUs sharing the same interrupt.
> - Fixed an interrupt handler race condition.
> 
> The ACPI binding spec for PMU DMC620 is under beta and located
> in ARM server group under project "ACPI on ARM". 

I'm not sure what this means. Where is this ARM server group itself
located?

Looking at the TRM, I couldn't see where many of the register field
values were defined, which makes it difficult to review. Which
documentation are you looking at?

[...]	

> +#define DMC620_PA_SHIFT					12
> +#define DMC620_CNT_MAX_PERIOD				0xffffffff
> +#define DMC620_PMU_CLKDIV2_MAX_COUNTERS			8
> +#define DMC620_PMU_CLK_MAX_COUNTERS			2
> +#define DMC620_PMU_MAX_COUNTERS				\
> +	(DMC620_PMU_CLKDIV2_MAX_COUNTERS + DMC620_PMU_CLK_MAX_COUNTERS)
> +
> +#define DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_OFFSET	8

Could we please drop the '_OFFSET' suffix? I don't think it's adding
anything, and it makes this more painful to read/write.

Looking at the TRM, this is at offset 0xA08. If this is all relative to
0xA00 there should be a comment to that effect. Similarly, the offsets
below are relative to each counter's group of registers, and we should
comment that.

How about:

/*
 * The PMU registers start at 0xA00 in the DMC-620 memory map, and these
 * offsets are relative to that base.
 *
 * Each counter has a group of control/value registers, and the
 * PMU_COUNTERx offsets are within a counter group.
 *
 * The counter registers groups start at 0xA10.
 */

> +#define  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK	\
> +		(DMC620_PMU_CLKDIV2_MAX_COUNTERS - 1)
> +#define DMC620_PMU_OVERFLOW_STATUS_CLK_OFFSET		12
> +#define  DMC620_PMU_OVERFLOW_STATUS_CLK_MASK		\
> +		(DMC620_PMU_CLK_MAX_COUNTERS - 1)
> +#define DMC620_PMU_COUNTERS_BASE_OFFSET			16

Can we please write the offsets in hexadecimal? That makes it much
easier to compare with the TRM.

> +#define DMC620_PMU_COUNTER_MASK_31_00_OFFSET		0

As implied earlier, please use 'COUNTERx' to make it clear that this is
a relative offset within a given counter group.

> +#define DMC620_PMU_COUNTER_MASK_63_32_OFFSET		4
> +#define DMC620_PMU_COUNTER_MATCH_31_00_OFFSET		8
> +#define DMC620_PMU_COUNTER_MATCH_63_32_OFFSET		12
> +#define DMC620_PMU_COUNTER_CONTROL_OFFSET		16
> +#define  DMC620_PMU_COUNTER_CONTROL_ENABLE_MASK		BIT(0)
> +#define  DMC620_PMU_COUNTER_CONTROL_INVERT_SHIFT	1
> +#define  DMC620_PMU_COUNTER_CONTROL_EVENT_MUX		(((x)&0x1f)>>2)
> +#define  DMC620_PMU_COUNTER_CONTROL_EVENT_MUX_SHIFT	2
> +#define  DMC620_PMU_COUNTER_CONTROL_INCR		(((x)&0x1ff)>>7)
> +#define  DMC620_PMU_COUNTER_CONTROL_INCR_SHIFT		7
> +#define DMC620_PMU_COUNTER_SNAPSHOT_OFFSET		24
> +#define DMC620_PMU_COUNTER_VALUE_OFFSET			32
> +#define DMC620_PMU_COUNTER_REG_BYTE_LENGTH		40

Please replace DMC620_PMU_COUNTER_REG_BYTE_LENGTH with:

/* Offset of the registers for a given counter, relative to 0xA00 */
#define DMC620_PMU_COUNTERx_OFFSET(x) \
	(DMC620_PMU_COUNTERS_BASE_OFFSET + 0x28 * (x))

... which is a bit clearer here, and will simplify the read/write
functions later.

> +#define DMC620_PMU_CLKDIV2_CYCLE_COUNT			0x0
> +#define DMC620_PMU_CLKDIV2_ALLOCATE			0x1
> +#define DMC620_PMU_CLKDIV2_QUEUE_DEPTH			0x2
> +#define DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA		0x3
> +#define DMC620_PMU_CLKDIV2_READ_BACKLOG			0x4
> +#define DMC620_PMU_CLKDIV2_WAITING_FOR_MI		0x5
> +#define DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION		0x6
> +#define DMC620_PMU_CLKDIV2_ENQUEUE			0x7
> +#define DMC620_PMU_CLKDIV2_ARBITRATE			0x8
> +#define DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE	0x9
> +#define DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE	0xA
> +#define DMC620_PMU_CLKDIV2_READ_DEPTH			0xB
> +#define DMC620_PMU_CLKDIV2_WRITE_DEPTH			0xC
> +#define DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH		0xD
> +#define DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH		0xE
> +#define DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH		0xF
> +#define DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH		0x10
> +#define DMC620_PMU_CLKDIV2_ACTIVATE			0x11
> +#define DMC620_PMU_CLKDIV2_RDWR				0x12
> +#define DMC620_PMU_CLKDIV2_REFRESH			0x13
> +#define DMC620_PMU_CLKDIV2_TRAINING_REQUEST		0x14
> +#define DMC620_PMU_CLKDIV2_T_MAC_TRACKER		0x15
> +#define DMC620_PMU_CLKDIV2_BK_FSM_TRACKER		0x16
> +#define DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER		0x17
> +#define DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN		0x18
> +#define DMC620_PMU_CLKDIV2_RANKS_IN_SREF		0x19
> +#define DMC620_PMU_CLK_CYCLE_COUNTER			0x20
> +#define DMC620_PMU_CLK_REQUEST				0x21
> +#define DMC620_PMU_CLK_UPLOAD_STALL			0x22
> +#define DMC620_PMU_CLK_INDICATE_MASK			0x20

Which documentation did you get these value from? I couldn't spot them
in the TRM. Likewise for the control register bits, so I fear I'm
missing something obvious.

> +static LIST_HEAD(dmc620_pmu_affinities);
> +static DEFINE_MUTEX(dmc620_pmu_affinity_lock);
> +
> +struct dmc620_pmu_affinity {
> +	struct hlist_node node;
> +	struct list_head affinity_list;
> +	struct list_head instance_list;
> +	refcount_t refcount;
> +	unsigned int irq;
> +	unsigned int cpu;
> +};

The 'affinity' naming is a bit cojnfusing, since this really represents
an IRQ. Could we please rename 'affinity' to 'irq', and use 'node' to
distinguish list entries from the list as a whole? i.e.

| static LIST_HEAD(dmc620_pmu_irqs);
| static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
| 
| struct dmc620_pmu_irq {
| 	struct hlist_node node;
| 	struct list_head pmus_list;
| 	struct list_head irqs_node;
| 	refcount_t refcount;
| 	unsigned int irq;
| 	unsigned int cpu;
| }

> +
> +struct dmc620_pmu {
> +	struct pmu pmu;
> +	struct platform_device *pdev;
> +
> +	void __iomem *base;
> +	struct dmc620_pmu_affinity *affinity;
> +	struct list_head affinity_list;

... and similarly:

|	struct dmc620_pmu_irq *irq;
|	struct list_head pmus_node;

> +
> +	/*
> +	 * We put all clkdiv2 and clk counters to a same array.
> +	 * The first DMC620_PMU_CLKDIV2_MAX_COUNTERS bits belong to
> +	 * clkdiv2 counters, the last DMC620_PMU_CLK_MAX_COUNTERS
> +	 * belong to clk counters.
> +	 */
> +	DECLARE_BITMAP(used_mask, DMC620_PMU_MAX_COUNTERS);
> +	struct perf_event *act_counter[DMC620_PMU_MAX_COUNTERS];

Please rename this to 'events', to match what we do for the CPU PMU.
It's shorter and clearer.

> +};
> +
> +#define to_dmc620_pmu(p) (container_of(p, struct dmc620_pmu, pmu))
> +
> +static int cpuhp_state_num;

[...]

> +static inline
> +unsigned int dmc620_pmu_creg_read(struct dmc620_pmu *dmc620_pmu,
> +					  unsigned int idx,
> +					  unsigned int offset)

Please make this return a u32, as readl() does.

> +{
> +	return readl(dmc620_pmu->base + DMC620_PMU_COUNTERS_BASE_OFFSET +
> +			(idx * DMC620_PMU_COUNTER_REG_BYTE_LENGTH + offset));
> +}
> +
> +static inline
> +void dmc620_pmu_creg_write(struct dmc620_pmu *dmc620_pmu,
> +				  unsigned int idx,
> +				  unsigned int offset,
> +				  unsigned int val)

Please make 'val' a u32, as writel() consumes.

> +{
> +	writel(val, dmc620_pmu->base + DMC620_PMU_COUNTERS_BASE_OFFSET +
> +		(idx * DMC620_PMU_COUNTER_REG_BYTE_LENGTH + offset));
> +}

[...]

> +static u64 dmc620_pmu_read_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +
> +	return (u64)dmc620_pmu_creg_read(dmc620_pmu,
> +			  event->hw.idx,
> +			  DMC620_PMU_COUNTER_VALUE_OFFSET);

You shouldn't need to cast to u64 here. The compiler can figure out the
type promotion.

[...]

> +static struct dmc620_pmu_affinity *__dmc620_pmu_get_affinity(int irq)
> +{
> +	struct dmc620_pmu_affinity *aff;
> +	int ret;
> +
> +	list_for_each_entry(aff, &dmc620_pmu_affinities, affinity_list)
> +		if (aff->irq == irq && refcount_inc_not_zero(&aff->refcount))
> +			return aff;
> +
> +	aff = kzalloc(sizeof(*aff), GFP_KERNEL);
> +	if (!aff)
> +		return ERR_PTR(-ENOMEM);
> +
> +	aff->instance_list.next = &aff->instance_list;
> +	aff->instance_list.prev = &aff->instance_list;

This should be:

|	LIST_INIT_HEAD(&aff->instance_list);

Thanks,
Mark.
