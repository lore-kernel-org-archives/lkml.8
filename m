Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6AAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C62070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEKWfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:35:54 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:51396 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgEKWfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:35:54 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BMTfmh021469;
        Mon, 11 May 2020 22:35:38 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 30x9acbmrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 22:35:37 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 19E0A53;
        Mon, 11 May 2020 22:35:37 +0000 (UTC)
Received: from hpe.com (unknown [16.214.161.148])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id C4BC047;
        Mon, 11 May 2020 22:35:35 +0000 (UTC)
Date:   Mon, 11 May 2020 17:35:35 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Russ Anderson <rja@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: [PATCH] x86/platform/uv: HUB RTC cleanup
Message-ID: <20200511223535.GA23676@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_11:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=13
 phishscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused event code and other cleanup for HUB RTC.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
---
 arch/x86/platform/uv/uv_time.c | 362 +----------------------------------------
 1 file changed, 8 insertions(+), 354 deletions(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 7af31b245636..1777b7164ff8 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -1,25 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * SGI RTC clock/timer routines.
+ * HPE RTC clock routine.
  *
+ *  Copyright (C) 2020 Hewlett Packard Enterprise, All rights reserved.
  *  Copyright (c) 2009-2013 Silicon Graphics, Inc.  All Rights Reserved.
  *  Copyright (c) Dimitri Sivanich
  */
 #include <linux/clockchips.h>
-#include <linux/slab.h>
-
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
-#include <asm/uv/bios.h>
-#include <asm/uv/uv.h>
-#include <asm/apic.h>
-#include <asm/cpu.h>
 
-#define RTC_NAME		"sgi_rtc"
+#define RTC_NAME		"hub_rtc"
 
 static u64 uv_read_rtc(struct clocksource *cs);
-static int uv_rtc_next_event(unsigned long, struct clock_event_device *);
-static int uv_rtc_shutdown(struct clock_event_device *evt);
 
 static struct clocksource clocksource_uv = {
 	.name		= RTC_NAME,
@@ -29,325 +22,23 @@ static struct clocksource clocksource_uv = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct clock_event_device clock_event_device_uv = {
-	.name			= RTC_NAME,
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.shift			= 20,
-	.rating			= 400,
-	.irq			= -1,
-	.set_next_event		= uv_rtc_next_event,
-	.set_state_shutdown	= uv_rtc_shutdown,
-	.event_handler		= NULL,
-};
-
-static DEFINE_PER_CPU(struct clock_event_device, cpu_ced);
-
-/* There is one of these allocated per node */
-struct uv_rtc_timer_head {
-	spinlock_t	lock;
-	/* next cpu waiting for timer, local node relative: */
-	int		next_cpu;
-	/* number of cpus on this node: */
-	int		ncpus;
-	struct {
-		int	lcpu;		/* systemwide logical cpu number */
-		u64	expires;	/* next timer expiration for this cpu */
-	} cpu[1];
-};
-
-/*
- * Access to uv_rtc_timer_head via blade id.
- */
-static struct uv_rtc_timer_head		**blade_info __read_mostly;
-
-static int				uv_rtc_evt_enable;
-
-/*
- * Hardware interface routines
- */
-
-/* Send IPIs to another node */
-static void uv_rtc_send_IPI(int cpu)
-{
-	unsigned long apicid, val;
-	int pnode;
-
-	apicid = cpu_physical_id(cpu);
-	pnode = uv_apicid_to_pnode(apicid);
-	apicid |= uv_apicid_hibits;
-	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
-	      (apicid << UVH_IPI_INT_APIC_ID_SHFT) |
-	      (X86_PLATFORM_IPI_VECTOR << UVH_IPI_INT_VECTOR_SHFT);
-
-	uv_write_global_mmr64(pnode, UVH_IPI_INT, val);
-}
-
-/* Check for an RTC interrupt pending */
-static int uv_intr_pending(int pnode)
-{
-	if (is_uv1_hub())
-		return uv_read_global_mmr64(pnode, UVH_EVENT_OCCURRED0) &
-			UV1H_EVENT_OCCURRED0_RTC1_MASK;
-	else if (is_uvx_hub())
-		return uv_read_global_mmr64(pnode, UVXH_EVENT_OCCURRED2) &
-			UVXH_EVENT_OCCURRED2_RTC_1_MASK;
-	return 0;
-}
-
-/* Setup interrupt and return non-zero if early expiration occurred. */
-static int uv_setup_intr(int cpu, u64 expires)
-{
-	u64 val;
-	unsigned long apicid = cpu_physical_id(cpu) | uv_apicid_hibits;
-	int pnode = uv_cpu_to_pnode(cpu);
-
-	uv_write_global_mmr64(pnode, UVH_RTC1_INT_CONFIG,
-		UVH_RTC1_INT_CONFIG_M_MASK);
-	uv_write_global_mmr64(pnode, UVH_INT_CMPB, -1L);
-
-	if (is_uv1_hub())
-		uv_write_global_mmr64(pnode, UVH_EVENT_OCCURRED0_ALIAS,
-				UV1H_EVENT_OCCURRED0_RTC1_MASK);
-	else
-		uv_write_global_mmr64(pnode, UVXH_EVENT_OCCURRED2_ALIAS,
-				UVXH_EVENT_OCCURRED2_RTC_1_MASK);
-
-	val = (X86_PLATFORM_IPI_VECTOR << UVH_RTC1_INT_CONFIG_VECTOR_SHFT) |
-		((u64)apicid << UVH_RTC1_INT_CONFIG_APIC_ID_SHFT);
-
-	/* Set configuration */
-	uv_write_global_mmr64(pnode, UVH_RTC1_INT_CONFIG, val);
-	/* Initialize comparator value */
-	uv_write_global_mmr64(pnode, UVH_INT_CMPB, expires);
-
-	if (uv_read_rtc(NULL) <= expires)
-		return 0;
-
-	return !uv_intr_pending(pnode);
-}
-
-/*
- * Per-cpu timer tracking routines
- */
-
-static __init void uv_rtc_deallocate_timers(void)
-{
-	int bid;
-
-	for_each_possible_blade(bid) {
-		kfree(blade_info[bid]);
-	}
-	kfree(blade_info);
-}
-
-/* Allocate per-node list of cpu timer expiration times. */
-static __init int uv_rtc_allocate_timers(void)
-{
-	int cpu;
-
-	blade_info = kcalloc(uv_possible_blades, sizeof(void *), GFP_KERNEL);
-	if (!blade_info)
-		return -ENOMEM;
-
-	for_each_present_cpu(cpu) {
-		int nid = cpu_to_node(cpu);
-		int bid = uv_cpu_to_blade_id(cpu);
-		int bcpu = uv_cpu_blade_processor_id(cpu);
-		struct uv_rtc_timer_head *head = blade_info[bid];
-
-		if (!head) {
-			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
-				(uv_blade_nr_possible_cpus(bid) *
-					2 * sizeof(u64)),
-				GFP_KERNEL, nid);
-			if (!head) {
-				uv_rtc_deallocate_timers();
-				return -ENOMEM;
-			}
-			spin_lock_init(&head->lock);
-			head->ncpus = uv_blade_nr_possible_cpus(bid);
-			head->next_cpu = -1;
-			blade_info[bid] = head;
-		}
-
-		head->cpu[bcpu].lcpu = cpu;
-		head->cpu[bcpu].expires = ULLONG_MAX;
-	}
-
-	return 0;
-}
-
-/* Find and set the next expiring timer.  */
-static void uv_rtc_find_next_timer(struct uv_rtc_timer_head *head, int pnode)
-{
-	u64 lowest = ULLONG_MAX;
-	int c, bcpu = -1;
-
-	head->next_cpu = -1;
-	for (c = 0; c < head->ncpus; c++) {
-		u64 exp = head->cpu[c].expires;
-		if (exp < lowest) {
-			bcpu = c;
-			lowest = exp;
-		}
-	}
-	if (bcpu >= 0) {
-		head->next_cpu = bcpu;
-		c = head->cpu[bcpu].lcpu;
-		if (uv_setup_intr(c, lowest))
-			/* If we didn't set it up in time, trigger */
-			uv_rtc_send_IPI(c);
-	} else {
-		uv_write_global_mmr64(pnode, UVH_RTC1_INT_CONFIG,
-			UVH_RTC1_INT_CONFIG_M_MASK);
-	}
-}
-
-/*
- * Set expiration time for current cpu.
- *
- * Returns 1 if we missed the expiration time.
- */
-static int uv_rtc_set_timer(int cpu, u64 expires)
-{
-	int pnode = uv_cpu_to_pnode(cpu);
-	int bid = uv_cpu_to_blade_id(cpu);
-	struct uv_rtc_timer_head *head = blade_info[bid];
-	int bcpu = uv_cpu_blade_processor_id(cpu);
-	u64 *t = &head->cpu[bcpu].expires;
-	unsigned long flags;
-	int next_cpu;
-
-	spin_lock_irqsave(&head->lock, flags);
-
-	next_cpu = head->next_cpu;
-	*t = expires;
-
-	/* Will this one be next to go off? */
-	if (next_cpu < 0 || bcpu == next_cpu ||
-			expires < head->cpu[next_cpu].expires) {
-		head->next_cpu = bcpu;
-		if (uv_setup_intr(cpu, expires)) {
-			*t = ULLONG_MAX;
-			uv_rtc_find_next_timer(head, pnode);
-			spin_unlock_irqrestore(&head->lock, flags);
-			return -ETIME;
-		}
-	}
-
-	spin_unlock_irqrestore(&head->lock, flags);
-	return 0;
-}
-
-/*
- * Unset expiration time for current cpu.
- *
- * Returns 1 if this timer was pending.
- */
-static int uv_rtc_unset_timer(int cpu, int force)
-{
-	int pnode = uv_cpu_to_pnode(cpu);
-	int bid = uv_cpu_to_blade_id(cpu);
-	struct uv_rtc_timer_head *head = blade_info[bid];
-	int bcpu = uv_cpu_blade_processor_id(cpu);
-	u64 *t = &head->cpu[bcpu].expires;
-	unsigned long flags;
-	int rc = 0;
-
-	spin_lock_irqsave(&head->lock, flags);
-
-	if ((head->next_cpu == bcpu && uv_read_rtc(NULL) >= *t) || force)
-		rc = 1;
-
-	if (rc) {
-		*t = ULLONG_MAX;
-		/* Was the hardware setup for this timer? */
-		if (head->next_cpu == bcpu)
-			uv_rtc_find_next_timer(head, pnode);
-	}
-
-	spin_unlock_irqrestore(&head->lock, flags);
-
-	return rc;
-}
-
-
-/*
- * Kernel interface routines.
- */
 
 /*
  * Read the RTC.
  *
  * Starting with HUB rev 2.0, the UV RTC register is replicated across all
- * cachelines of it's own page.  This allows faster simultaneous reads
- * from a given socket.
+ * cachelines of its own page.  This allows faster simultaneous reads from
+ * a given socket.
  */
 static u64 uv_read_rtc(struct clocksource *cs)
 {
 	unsigned long offset;
 
-	if (uv_get_min_hub_revision_id() == 1)
-		offset = 0;
-	else
-		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
+	offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
 
 	return (u64)uv_read_local_mmr(UVH_RTC | offset);
 }
 
-/*
- * Program the next event, relative to now
- */
-static int uv_rtc_next_event(unsigned long delta,
-			     struct clock_event_device *ced)
-{
-	int ced_cpu = cpumask_first(ced->cpumask);
-
-	return uv_rtc_set_timer(ced_cpu, delta + uv_read_rtc(NULL));
-}
-
-/*
- * Shutdown the RTC timer
- */
-static int uv_rtc_shutdown(struct clock_event_device *evt)
-{
-	int ced_cpu = cpumask_first(evt->cpumask);
-
-	uv_rtc_unset_timer(ced_cpu, 1);
-	return 0;
-}
-
-static void uv_rtc_interrupt(void)
-{
-	int cpu = smp_processor_id();
-	struct clock_event_device *ced = &per_cpu(cpu_ced, cpu);
-
-	if (!ced || !ced->event_handler)
-		return;
-
-	if (uv_rtc_unset_timer(cpu, 0) != 1)
-		return;
-
-	ced->event_handler(ced);
-}
-
-static int __init uv_enable_evt_rtc(char *str)
-{
-	uv_rtc_evt_enable = 1;
-
-	return 1;
-}
-__setup("uvrtcevt", uv_enable_evt_rtc);
-
-static __init void uv_rtc_register_clockevents(struct work_struct *dummy)
-{
-	struct clock_event_device *ced = this_cpu_ptr(&cpu_ced);
-
-	*ced = clock_event_device_uv;
-	ced->cpumask = cpumask_of(smp_processor_id());
-	clockevents_register_device(ced);
-}
-
 static __init int uv_rtc_setup_clock(void)
 {
 	int rc;
@@ -357,47 +48,10 @@ static __init int uv_rtc_setup_clock(void)
 
 	rc = clocksource_register_hz(&clocksource_uv, sn_rtc_cycles_per_second);
 	if (rc)
-		printk(KERN_INFO "UV RTC clocksource failed rc %d\n", rc);
+		pr_info("HUB RTC clocksource failed rc %d\n", rc);
 	else
-		printk(KERN_INFO "UV RTC clocksource registered freq %lu MHz\n",
+		pr_info("HUB RTC clocksource registered freq %lu MHz\n",
 			sn_rtc_cycles_per_second/(unsigned long)1E6);
-
-	if (rc || !uv_rtc_evt_enable || x86_platform_ipi_callback)
-		return rc;
-
-	/* Setup and register clockevents */
-	rc = uv_rtc_allocate_timers();
-	if (rc)
-		goto error;
-
-	x86_platform_ipi_callback = uv_rtc_interrupt;
-
-	clock_event_device_uv.mult = div_sc(sn_rtc_cycles_per_second,
-				NSEC_PER_SEC, clock_event_device_uv.shift);
-
-	clock_event_device_uv.min_delta_ns = NSEC_PER_SEC /
-						sn_rtc_cycles_per_second;
-	clock_event_device_uv.min_delta_ticks = 1;
-
-	clock_event_device_uv.max_delta_ns = clocksource_uv.mask *
-				(NSEC_PER_SEC / sn_rtc_cycles_per_second);
-	clock_event_device_uv.max_delta_ticks = clocksource_uv.mask;
-
-	rc = schedule_on_each_cpu(uv_rtc_register_clockevents);
-	if (rc) {
-		x86_platform_ipi_callback = NULL;
-		uv_rtc_deallocate_timers();
-		goto error;
-	}
-
-	printk(KERN_INFO "UV RTC clockevents registered\n");
-
-	return 0;
-
-error:
-	clocksource_unregister(&clocksource_uv);
-	printk(KERN_INFO "UV RTC clockevents failed rc %d\n", rc);
-
 	return rc;
 }
 arch_initcall(uv_rtc_setup_clock);
-- 
2.12.3

