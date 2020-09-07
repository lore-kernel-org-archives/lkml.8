Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397DEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE4D2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OJ/Y8jx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgIGS5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:57:01 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:61166 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729429AbgIGSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:07 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IoIJs010917;
        Mon, 7 Sep 2020 18:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=jhgn6CIUTGSk9V7LFzw7oFegTAqikNVinvzMFHWF2A4=;
 b=OJ/Y8jx90+jmg4bVit6ACINQ7cNePuXpAWMlOqoVwa2uOEv+stAG698y8PnE9vATn3JJ
 pM2KGXUIgNKjrzG186BCyQaiqEP3LH48hGlSqNnEZwjv9Mz5V9hfIn+pYVf82oOF+eei
 GNusZCj8EVg8x/Fo+UbL3/KWvvjAcunJ+cNmrsHYiKHCPc3SKIf/tI5l6nOGCF3aSsyc
 +nho4/6YgqzAzfHdk/lGbgm/ziUYVy0G3cDC67qNbtoF9t8mQq4UpSqxJ96ZkQb+X2xE
 Rpk/9aVrhWi6NhMjR8moZLWAmHHYk13h+qSA3nUeQOsBL1k5s+Wd9nXjjDAfIxIGGm12 mw== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 33cm1x4r5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:33 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 458819A;
        Mon,  7 Sep 2020 18:54:31 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id A567230060F09; Mon,  7 Sep 2020 13:54:30 -0500 (CDT)
Message-ID: <20200907185430.589444060@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:32 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 02/12] x86/platform/uv: Remove SCIR MMR references for UVY systems.
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=904
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UV class systems no longer use System Controller for monitoring of CPU
activity provided by this driver.  Other methods have been developed
for BIOS and the management controller (BMC).  This patch removes that
supporting code.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h   |   46 ++------------------
 arch/x86/kernel/apic/x2apic_uv_x.c |   85 -------------------------------------
 2 files changed, 7 insertions(+), 124 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/uv_hub.h
+++ linux/arch/x86/include/asm/uv/uv_hub.h
@@ -5,7 +5,8 @@
  *
  * SGI UV architectural definitions
  *
- * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  */
 
 #ifndef _ASM_X86_UV_UV_HUB_H
@@ -129,17 +130,6 @@
  */
 #define UV_MAX_NASID_VALUE	(UV_MAX_NUMALINK_BLADES * 2)
 
-/* System Controller Interface Reg info */
-struct uv_scir_s {
-	struct timer_list timer;
-	unsigned long	offset;
-	unsigned long	last;
-	unsigned long	idle_on;
-	unsigned long	idle_off;
-	unsigned char	state;
-	unsigned char	enabled;
-};
-
 /* GAM (globally addressed memory) range table */
 struct uv_gam_range_s {
 	u32	limit;		/* PA bits 56:26 (GAM_RANGE_SHFT) */
@@ -191,16 +181,13 @@ struct uv_hub_info_s {
 struct uv_cpu_info_s {
 	void			*p_uv_hub_info;
 	unsigned char		blade_cpu_id;
-	struct uv_scir_s	scir;
+	void			*reserved;
 };
 DECLARE_PER_CPU(struct uv_cpu_info_s, __uv_cpu_info);
 
 #define uv_cpu_info		this_cpu_ptr(&__uv_cpu_info)
 #define uv_cpu_info_per(cpu)	(&per_cpu(__uv_cpu_info, cpu))
 
-#define	uv_scir_info		(&uv_cpu_info->scir)
-#define	uv_cpu_scir_info(cpu)	(&uv_cpu_info_per(cpu)->scir)
-
 /* Node specific hub common info struct */
 extern void **__uv_hub_info_list;
 static inline struct uv_hub_info_s *uv_hub_info_list(int node)
@@ -297,9 +284,9 @@ union uvh_apicid {
 #define UV3_GLOBAL_MMR32_SIZE		(32UL * 1024 * 1024)
 
 #define UV4_LOCAL_MMR_BASE		0xfa000000UL
-#define UV4_GLOBAL_MMR32_BASE		0xfc000000UL
+#define UV4_GLOBAL_MMR32_BASE		0
 #define UV4_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
-#define UV4_GLOBAL_MMR32_SIZE		(16UL * 1024 * 1024)
+#define UV4_GLOBAL_MMR32_SIZE		0
 
 #define UV_LOCAL_MMR_BASE		(				\
 					is_uv2_hub() ? UV2_LOCAL_MMR_BASE : \
@@ -772,29 +759,6 @@ DECLARE_PER_CPU(struct uv_cpu_nmi_s, uv_
 #define	UV_NMI_STATE_DUMP		2
 #define	UV_NMI_STATE_DUMP_DONE		3
 
-/* Update SCIR state */
-static inline void uv_set_scir_bits(unsigned char value)
-{
-	if (uv_scir_info->state != value) {
-		uv_scir_info->state = value;
-		uv_write_local_mmr8(uv_scir_info->offset, value);
-	}
-}
-
-static inline unsigned long uv_scir_offset(int apicid)
-{
-	return SCIR_LOCAL_MMR_BASE | (apicid & 0x3f);
-}
-
-static inline void uv_set_cpu_scir_bits(int cpu, unsigned char value)
-{
-	if (uv_cpu_scir_info(cpu)->state != value) {
-		uv_write_global_mmr8(uv_cpu_to_pnode(cpu),
-				uv_cpu_scir_info(cpu)->offset, value);
-		uv_cpu_scir_info(cpu)->state = value;
-	}
-}
-
 /*
  * Get the minimum revision number of the hub chips within the partition.
  * (See UVx_HUB_REVISION_BASE above for specific values.)
--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -5,7 +5,8 @@
  *
  * SGI UV APIC functions (note: not an Intel compatible APIC)
  *
- * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  */
 #include <linux/crash_dump.h>
 #include <linux/cpuhotplug.h>
@@ -909,85 +910,6 @@ static __init void uv_rtc_init(void)
 	}
 }
 
-/*
- * percpu heartbeat timer
- */
-static void uv_heartbeat(struct timer_list *timer)
-{
-	unsigned char bits = uv_scir_info->state;
-
-	/* Flip heartbeat bit: */
-	bits ^= SCIR_CPU_HEARTBEAT;
-
-	/* Is this CPU idle? */
-	if (idle_cpu(raw_smp_processor_id()))
-		bits &= ~SCIR_CPU_ACTIVITY;
-	else
-		bits |= SCIR_CPU_ACTIVITY;
-
-	/* Update system controller interface reg: */
-	uv_set_scir_bits(bits);
-
-	/* Enable next timer period: */
-	mod_timer(timer, jiffies + SCIR_CPU_HB_INTERVAL);
-}
-
-static int uv_heartbeat_enable(unsigned int cpu)
-{
-	while (!uv_cpu_scir_info(cpu)->enabled) {
-		struct timer_list *timer = &uv_cpu_scir_info(cpu)->timer;
-
-		uv_set_cpu_scir_bits(cpu, SCIR_CPU_HEARTBEAT|SCIR_CPU_ACTIVITY);
-		timer_setup(timer, uv_heartbeat, TIMER_PINNED);
-		timer->expires = jiffies + SCIR_CPU_HB_INTERVAL;
-		add_timer_on(timer, cpu);
-		uv_cpu_scir_info(cpu)->enabled = 1;
-
-		/* Also ensure that boot CPU is enabled: */
-		cpu = 0;
-	}
-	return 0;
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-static int uv_heartbeat_disable(unsigned int cpu)
-{
-	if (uv_cpu_scir_info(cpu)->enabled) {
-		uv_cpu_scir_info(cpu)->enabled = 0;
-		del_timer(&uv_cpu_scir_info(cpu)->timer);
-	}
-	uv_set_cpu_scir_bits(cpu, 0xff);
-	return 0;
-}
-
-static __init void uv_scir_register_cpu_notifier(void)
-{
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/x2apic-uvx:online",
-				  uv_heartbeat_enable, uv_heartbeat_disable);
-}
-
-#else /* !CONFIG_HOTPLUG_CPU */
-
-static __init void uv_scir_register_cpu_notifier(void)
-{
-}
-
-static __init int uv_init_heartbeat(void)
-{
-	int cpu;
-
-	if (is_uv_system()) {
-		for_each_online_cpu(cpu)
-			uv_heartbeat_enable(cpu);
-	}
-
-	return 0;
-}
-
-late_initcall(uv_init_heartbeat);
-
-#endif /* !CONFIG_HOTPLUG_CPU */
-
 /* Direct Legacy VGA I/O traffic to designated IOH */
 static int uv_set_vga_state(struct pci_dev *pdev, bool decode, unsigned int command_bits, u32 flags)
 {
@@ -1517,8 +1439,6 @@ static void __init uv_system_init_hub(vo
 			uv_hub_info_list(numa_node_id)->pnode = pnode;
 		else if (uv_cpu_hub_info(cpu)->pnode == 0xffff)
 			uv_cpu_hub_info(cpu)->pnode = pnode;
-
-		uv_cpu_scir_info(cpu)->offset = uv_scir_offset(apicid);
 	}
 
 	for_each_node(nodeid) {
@@ -1547,7 +1467,6 @@ static void __init uv_system_init_hub(vo
 
 	uv_nmi_setup();
 	uv_cpu_init();
-	uv_scir_register_cpu_notifier();
 	uv_setup_proc_files(0);
 
 	/* Register Legacy VGA I/O redirection handler: */

