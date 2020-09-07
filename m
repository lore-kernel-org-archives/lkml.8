Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D50C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B770020C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="S2P8Najw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIGS4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:56:22 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:34374 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729354AbgIGSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:08 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IrJ2n015028;
        Mon, 7 Sep 2020 18:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=gQwKqaBUNdpN9iqkrHi3ImowCdraGKXkdyeaxqWeU0U=;
 b=S2P8NajwLvfKsZCSfhBbM4lE8RSwpmGGp10oagXmVkrgJx5ITS5tQJsyuTlSFH+1Ycvh
 KChj23qVNQPtIqBUSxXP68kRy+QhuYpNMvzxPsoZMQ4kaN9VUxU6TQGYyibnYhw6YwrA
 9mcStM4gEjkXdnKPpIN/GD52/yVCG67MVkH810moa0rXwNtAdI3xyYQ9Ud/XzGZHVeop
 9BaDn+8IvI0iJM8m6xvo/sJACVnpethSRE+IayU3w3my7H6VapKf+j8rzSFX9aYFpyjC
 uEBFsjSFeVHglFZOA/Fzn6HZyT5tHpfxbfHq1R+jfYZR97MnotKF1sEbatIOEKJS4kOr 9Q== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 33c1nnj9jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:33 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id C438D62;
        Mon,  7 Sep 2020 18:54:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 0F74A30060F0E; Mon,  7 Sep 2020 13:54:31 -0500 (CDT)
Message-ID: <20200907185430.977855369@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:36 -0500
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
Subject: [PATCH 06/12] x86/platform/uv: Add and Decode Arch Type in UVsystab
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch to add and process the UV Arch Type field in the UVsystab passed
from UV BIOS to the kernel.  This allows the system to be recognized
without relying on the OEM_ID which OEMs want to change.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/bios.h     |   17 +++-
 arch/x86/kernel/apic/x2apic_uv_x.c |  135 +++++++++++++++++++++++++++++++------
 arch/x86/platform/uv/bios_uv.c     |   28 +++++--
 3 files changed, 150 insertions(+), 30 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/bios.h
+++ linux/arch/x86/include/asm/uv/bios.h
@@ -5,8 +5,9 @@
 /*
  * UV BIOS layer definitions.
  *
- *  Copyright (c) 2008-2009 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson <rja@sgi.com>
+ * Copyright (C) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Russ Anderson <rja@sgi.com>
  */
 
 #include <linux/rtc.h>
@@ -71,6 +72,11 @@ struct uv_gam_range_entry {
 	u32	limit;		/* PA bits 56:26 (UV_GAM_RANGE_SHFT) */
 };
 
+#define	UV_AT_SIZE	8	/* 7 character arch type + NULL char */
+struct uv_arch_type_entry {
+	char	archtype[UV_AT_SIZE];
+};
+
 #define	UV_SYSTAB_SIG			"UVST"
 #define	UV_SYSTAB_VERSION_1		1	/* UV2/3 BIOS version */
 #define	UV_SYSTAB_VERSION_UV4		0x400	/* UV4 BIOS base version */
@@ -79,10 +85,14 @@ struct uv_gam_range_entry {
 #define	UV_SYSTAB_VERSION_UV4_3		0x403	/* - GAM Range PXM Value */
 #define	UV_SYSTAB_VERSION_UV4_LATEST	UV_SYSTAB_VERSION_UV4_3
 
+#define	UV_SYSTAB_VERSION_UV5		0x500	/* UV5 GAM base version */
+#define	UV_SYSTAB_VERSION_UV5_LATEST	UV_SYSTAB_VERSION_UV5
+
 #define	UV_SYSTAB_TYPE_UNUSED		0	/* End of table (offset == 0) */
 #define	UV_SYSTAB_TYPE_GAM_PARAMS	1	/* GAM PARAM conversions */
 #define	UV_SYSTAB_TYPE_GAM_RNG_TBL	2	/* GAM entry table */
-#define	UV_SYSTAB_TYPE_MAX		3
+#define	UV_SYSTAB_TYPE_ARCH_TYPE	3	/* UV arch type */
+#define	UV_SYSTAB_TYPE_MAX		4
 
 /*
  * The UV system table describes specific firmware
@@ -133,6 +143,7 @@ extern s64 uv_bios_reserved_page_pa(u64,
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
 extern int uv_bios_init(void);
+extern unsigned long get_uv_systab_phys(bool msg);
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -32,7 +32,8 @@ static u64			gru_start_paddr, gru_end_pa
 static union uvh_apicid		uvh_apicid;
 static int			uv_node_id;
 
-/* Unpack OEM/TABLE ID's to be NULL terminated strings */
+/* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
+static u8 uv_archtype[UV_AT_SIZE];
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
@@ -287,20 +288,104 @@ static void __init uv_stringify(int len,
 	strncpy(to, from, len-1);
 }
 
+/* Find UV arch type entry in UVsystab */
+static unsigned long __init early_find_archtype(struct uv_systab *st)
+{
+	int i;
+
+	for (i = 0; st->entry[i].type != UV_SYSTAB_TYPE_UNUSED; i++) {
+		unsigned long ptr = st->entry[i].offset;
+
+		if (!ptr)
+			continue;
+		ptr += (unsigned long)st;
+		if (st->entry[i].type == UV_SYSTAB_TYPE_ARCH_TYPE)
+			return ptr;
+	}
+	return 0;
+}
+
+/* Validate UV arch type field in UVsystab */
+static int __init decode_arch_type(unsigned long ptr)
+{
+	struct uv_arch_type_entry *uv_ate = (struct uv_arch_type_entry *)ptr;
+	int n = strlen(uv_ate->archtype);
+
+	if (n > 0 && n < sizeof(uv_ate->archtype)) {
+		pr_info("UV: UVarchtype received from BIOS\n");
+		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
+		return 1;
+	}
+	return 0;
+}
+
+/* Determine if UV arch type entry might exist in UVsystab */
+static int __init early_get_arch_type(void)
+{
+	unsigned long uvst_physaddr, uvst_size, ptr;
+	struct uv_systab *st;
+	u32 rev;
+	int ret;
+
+	uvst_physaddr = get_uv_systab_phys(0);
+	if (!uvst_physaddr)
+		return 0;
+
+	st = early_memremap_ro(uvst_physaddr, sizeof(struct uv_systab));
+	if (!st) {
+		pr_err("UV: Cannot access UVsystab, remap failed\n");
+		return 0;
+	}
+
+	rev = st->revision;
+	if (rev < UV_SYSTAB_VERSION_UV5) {
+		early_memunmap(st, sizeof(struct uv_systab));
+		return 0;
+	}
+
+	uvst_size = st->size;
+	early_memunmap(st, sizeof(struct uv_systab));
+	st = early_memremap_ro(uvst_physaddr, uvst_size);
+	if (!st) {
+		pr_err("UV: Cannot access UVarchtype, remap failed\n");
+		return 0;
+	}
+
+	ptr = early_find_archtype(st);
+	if (!ptr) {
+		early_memunmap(st, uvst_size);
+		return 0;
+	}
+
+	ret = decode_arch_type(ptr);
+	early_memunmap(st, uvst_size);
+	return ret;
+}
+
 static int __init uv_set_system_type(char *_oem_id)
 {
 	int pnodeid;
 
-	/* Save OEM ID */
+	/* Save OEM_ID passed from ACPI MADT */
 	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
 
-	/* Set hubless type if true */
-	if (strncmp(oem_id, "SGI", 3) != 0) {
-		if (strncmp(oem_id, "NSGI", 4) != 0)
+	/* Check if BIOS sent us a UVarchtype */
+	if (!early_get_arch_type())
+
+		/* If not use OEM ID for UVarchtype */
+		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
+
+	/* Check if not hubbed */
+	if (strncmp(uv_archtype, "SGI", 3) != 0) {
+
+		/* (Not hubbed), check if not hubless */
+		if (strncmp(uv_archtype, "NSGI", 4) != 0)
+
+			/* (Not hubless), not a UV */
 			return 0;
 
 		/* UV4 Hubless: CH */
-		if (strncmp(oem_id, "NSGI4", 5) == 0)
+		if (strncmp(uv_archtype, "NSGI4", 5) == 0)
 			uv_hubless_system = 0x11;
 
 		/* UV3 Hubless: UV300/MC990X w/o hub */
@@ -319,10 +404,10 @@ static int __init uv_set_system_type(cha
 
 	/* Set hubbed type if true */
 	uv_hub_info->hub_revision =
-		!strncmp(oem_id, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
+		!strncmp(uv_archtype, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
+		!strncmp(uv_archtype, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
+		!strncmp(uv_archtype, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
+		!strcmp(uv_archtype, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
 
 	switch (uv_hub_info->hub_revision) {
 	case UV5_HUB_REVISION_BASE:
@@ -393,8 +478,7 @@ static int __init uv_acpi_madt_oem_check
 	return 0;
 
 badbios:
-	pr_err("UV: OEM_ID:%s OEM_TABLE_ID:%s\n", oem_id, oem_table_id);
-	pr_err("UV: Current UV Type or BIOS not supported\n");
+	pr_err("UV: UVarchtype:%s not supported\n", uv_archtype);
 	BUG();
 }
 
@@ -1187,6 +1271,7 @@ static void __init decode_gam_rng_tbl(un
 	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
 }
 
+/* Walk through UVsystab decoding the fields */
 static int __init decode_uv_systab(void)
 {
 	struct uv_systab *st;
@@ -1216,7 +1301,8 @@ static int __init decode_uv_systab(void)
 		if (!ptr)
 			continue;
 
-		ptr = ptr + (unsigned long)st;
+		/* point to payload */
+		ptr += (unsigned long)st;
 
 		switch (st->entry[i].type) {
 		case UV_SYSTAB_TYPE_GAM_PARAMS:
@@ -1226,6 +1312,15 @@ static int __init decode_uv_systab(void)
 		case UV_SYSTAB_TYPE_GAM_RNG_TBL:
 			decode_gam_rng_tbl(ptr);
 			break;
+
+		case UV_SYSTAB_TYPE_ARCH_TYPE:
+			/* already processed in early startup */
+			break;
+
+		default:
+			pr_err("UV:%s:Unrecognized UV_SYSTAB_TYPE:%d, skipped\n",
+				__func__, st->entry[i].type);
+			break;
 		}
 	}
 	return 0;
@@ -1266,7 +1361,7 @@ static void __init build_socket_tables(v
 			pr_info("UV: No UVsystab socket table, ignoring\n");
 			return;
 		}
-		pr_crit("UV: Error: UVsystab address translations not available!\n");
+		pr_err("UV: Error: UVsystab address translations not available!\n");
 		BUG();
 	}
 
@@ -1392,9 +1487,9 @@ static int __maybe_unused proc_hubless_s
 	return 0;
 }
 
-static int __maybe_unused proc_oemid_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
 {
-	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
+	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
 	return 0;
 }
 
@@ -1403,7 +1498,7 @@ static __init void uv_setup_proc_files(i
 	struct proc_dir_entry *pde;
 
 	pde = proc_mkdir(UV_PROC_NODE, NULL);
-	proc_create_single("oemid", 0, pde, proc_oemid_show);
+	proc_create_single("archtype", 0, pde, proc_archtype_show);
 	if (hubless)
 		proc_create_single("hubless", 0, pde, proc_hubless_show);
 	else
@@ -1455,12 +1550,14 @@ static void __init uv_system_init_hub(vo
 
 	map_low_mmrs();
 
-	/* Get uv_systab for decoding: */
+	/* Get uv_systab for decoding, setup UV BIOS calls */
 	uv_bios_init();
 
 	/* If there's an UVsystab problem then abort UV init: */
-	if (decode_uv_systab() < 0)
+	if (decode_uv_systab() < 0) {
+		pr_err("UV: Mangled UVsystab format\n");
 		return;
+	}
 
 	build_socket_tables();
 	build_uv_gr_table();
--- linux.orig/arch/x86/platform/uv/bios_uv.c
+++ linux/arch/x86/platform/uv/bios_uv.c
@@ -2,8 +2,9 @@
 /*
  * BIOS run time interface routines.
  *
- *  Copyright (c) 2008-2009 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson <rja@sgi.com>
+ * Copyright (C) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Russ Anderson <rja@sgi.com>
  */
 
 #include <linux/efi.h>
@@ -169,16 +170,27 @@ int uv_bios_set_legacy_vga_target(bool d
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
 
-int uv_bios_init(void)
+unsigned long get_uv_systab_phys(bool msg)
 {
-	uv_systab = NULL;
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
 	    !uv_systab_phys || efi_runtime_disabled()) {
-		pr_crit("UV: UVsystab: missing\n");
-		return -EEXIST;
+		if (msg)
+			pr_crit("UV: UVsystab: missing\n");
+		return 0;
 	}
+	return uv_systab_phys;
+}
+
+int uv_bios_init(void)
+{
+	unsigned long uv_systab_phys_addr;
+
+	uv_systab = NULL;
+	uv_systab_phys_addr = get_uv_systab_phys(1);
+	if (!uv_systab_phys_addr)
+		return -EEXIST;
 
-	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
+	uv_systab = ioremap(uv_systab_phys_addr, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
@@ -190,7 +202,7 @@ int uv_bios_init(void)
 		int size = uv_systab->size;
 
 		iounmap(uv_systab);
-		uv_systab = ioremap(uv_systab_phys, size);
+		uv_systab = ioremap(uv_systab_phys_addr, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
 			return -EFAULT;

