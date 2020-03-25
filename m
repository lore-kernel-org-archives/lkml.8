Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10282C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA1120789
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZdvaLsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCYToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:44:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60599 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJdAQ2063178;
        Wed, 25 Mar 2020 19:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=PHR+S204wQatVpnu6nDzZ9t2Ic9q0O5p1Tpkpx0+1TA=;
 b=lZdvaLsJhSf2Us+HfcMpQa75md62Gd37BjL3s2arIFgVO1X1s5vzZ1A1Rmo1gzRS52Sn
 8PItodRmXM3GT+qnePbSHbHtSNruZH5wMpN+vFL8gFh7iTwjzXqHsFpGY/QhN7fIdBYZ
 wwzh1RQNj74mz5z6QoZ1pzAKAGTrxLqi9MIwL2uq8/2hlYV+3Qx1Ax1hY6h4IoejkSvl
 wfXnsw7Frk225zh8d5egfZ3Mzu69E7kkvS3VrVS+EUf3C/ZEl6J/BsgTfasiqM82hzb0
 hbcnGeSR2QUwO2TpJlOzgjsjn/5kf2GkXDVMrBd76WdDJ0zB6gKpI/mvz3IWmsy6qLlc kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavmbs8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJh3oO073414;
        Wed, 25 Mar 2020 19:43:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30073b1u76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PJhXub024757;
        Wed, 25 Mar 2020 19:43:33 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:33 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 08/12] x86: Secure Launch kernel late boot stub
Date:   Wed, 25 Mar 2020 15:43:13 -0400
Message-Id: <20200325194317.526492-9-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine slaunch_setup is called out of the x86 specific setup_arch
routine during early kernel boot. After determining what platform is
present, various operations specific to that platform occur. This
includes finalizing setting for the platform late launch and verifying
that memory protections are in place.

For TXT, this code also reserves the original compressed kernel setup
area where the APs were left looping so that this memory cannot be used.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile  |   1 +
 arch/x86/kernel/setup.c   |   3 +
 arch/x86/kernel/slaunch.c | 451 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dmar.c      |   4 +
 4 files changed, 459 insertions(+)
 create mode 100644 arch/x86/kernel/slaunch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6175e370ee4a..f0a12037c682 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
 obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cedfe2077a69..acf351592078 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -73,6 +73,7 @@
 #include <linux/jiffies.h>
 #include <linux/mem_encrypt.h>
 #include <linux/sizes.h>
+#include <linux/slaunch.h>
 
 #include <linux/usb/xhci-dbgp.h>
 #include <video/edid.h>
@@ -1073,6 +1074,8 @@ void __init setup_arch(char **cmdline_p)
 	early_gart_iommu_check();
 #endif
 
+	slaunch_setup();
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
new file mode 100644
index 000000000000..083fa72bd9f9
--- /dev/null
+++ b/arch/x86/kernel/slaunch.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *     Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <asm/boot.h>
+#include <asm/msr.h>
+#include <asm/tlbflush.h>
+#include <asm/processor-flags.h>
+#include <asm/asm-offsets.h>
+#include <asm/e820/api.h>
+#include <asm/bootparam.h>
+#include <asm/setup.h>
+#include <linux/slaunch.h>
+
+#define PREFIX	"SLAUNCH: "
+
+static u32 sl_flags;
+static struct sl_ap_wake_info ap_wake_info;
+
+/* This should be plenty of room */
+static u8 txt_dmar[PAGE_SIZE] __aligned(16);
+
+u32 slaunch_get_flags(void)
+{
+	return sl_flags;
+}
+EXPORT_SYMBOL(slaunch_get_flags);
+
+struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
+{
+	return &ap_wake_info;
+}
+
+struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
+{
+	/* The DMAR is only stashed and provided via TXT on Intel systems */
+	if (memcmp(txt_dmar, "DMAR", 4))
+		return dmar;
+
+	return (struct acpi_table_header *)(&txt_dmar[0]);
+}
+
+static void __init slaunch_txt_reset(void __iomem *txt,
+				     const char *msg, u64 error)
+{
+	u64 one = 1, val;
+
+	pr_err("%s", msg);
+
+	/*
+	 * This performs a TXT reset with a sticky error code. The reads of
+	 * TXT_CR_E2STS act as barriers.
+	 */
+	memcpy_toio(txt + TXT_CR_ERRORCODE, &error, sizeof(u64));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(u64));
+	memcpy_toio(txt + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(u64));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(u64));
+	memcpy_toio(txt + TXT_CR_CMD_RESET, &one, sizeof(u64));
+
+	asm volatile ("hlt");
+}
+
+/*
+ * The TXT heap is too big to map all at once with early_ioremap
+ * so it is done a table at a time.
+ */
+static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
+					     u32 bytes)
+{
+	void *heap;
+	u64 base, size, offset = 0;
+	int i;
+
+	if (type > TXT_SINIT_MLE_DATA_TABLE)
+		slaunch_txt_reset(txt,
+			"Error invalid table type for early heap walk\n",
+			SL_ERROR_HEAP_WALK);
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(u64));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(u64));
+
+	/* Iterate over heap tables looking for table of "type" */
+	for (i = 0; i < type; i++) {
+		base += offset;
+		heap = early_memremap(base, sizeof(u64));
+		if (!heap)
+			slaunch_txt_reset(txt,
+				"Error early_memremap of heap for heap walk\n",
+				SL_ERROR_HEAP_WALK);
+
+		offset = *((u64 *)heap);
+
+		/*
+		 * After the first iteration, any offset of zero is invalid and
+		 * implies the TXT heap is corrupted.
+		 */
+		if (!offset)
+			slaunch_txt_reset(txt,
+				"Error invalid 0 offset in heap walk\n",
+				SL_ERROR_HEAP_ZERO_OFFSET);
+
+		early_memunmap(heap, sizeof(u64));
+	}
+
+	/* Skip the size field at the head of each table */
+	base += sizeof(u64);
+	heap = early_memremap(base, bytes);
+	if (!heap)
+		slaunch_txt_reset(txt,
+				  "Error early_memremap of heap section\n",
+				  SL_ERROR_HEAP_MAP);
+
+	return heap;
+}
+
+/*
+ * TXT uses a special set of VTd registers to protect all of memory from DMA
+ * until the IOMMU can be programmed to protect memory. There is the low
+ * memory PMR that can protect all memory up to 4G. The high memory PRM can
+ * be setup to protect all memory beyond 4Gb. Validate that these values cover
+ * what is expected.
+ */
+static void __init slaunch_verify_pmrs(void __iomem *txt)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	unsigned long last_pfn;
+	u32 field_offset, err = 0;
+	const char *errmsg = "";
+
+	field_offset = offsetof(struct txt_os_sinit_data, lcp_po_base);
+	os_sinit_data = txt_early_get_heap_table(txt, TXT_OS_SINIT_DATA_TABLE,
+						 field_offset);
+
+	last_pfn = e820__end_of_ram_pfn();
+
+	/*
+	 * First make sure the hi PMR covers all memory above 4G. In the
+	 * unlikely case where there is < 4G on the system, the hi PMR will
+	 * not be set.
+	 */
+	if (os_sinit_data->vtd_pmr_hi_base != 0x0ULL) {
+		if (os_sinit_data->vtd_pmr_hi_base != 0x100000000ULL) {
+			err = SL_ERROR_HI_PMR_BASE;
+			errmsg =  "Error hi PMR base\n";
+			goto out;
+		}
+
+		if (last_pfn << PAGE_SHIFT >
+		    os_sinit_data->vtd_pmr_hi_base +
+		    os_sinit_data->vtd_pmr_hi_size) {
+			err = SL_ERROR_HI_PMR_SIZE;
+			errmsg = "Error hi PMR size\n";
+			goto out;
+		}
+	}
+
+	/* Lo PMR base should always be 0 */
+	if (os_sinit_data->vtd_pmr_lo_base != 0x0ULL) {
+		err = SL_ERROR_LO_PMR_BASE;
+		errmsg = "Error lo PMR base\n";
+		goto out;
+	}
+
+	/*
+	 * Check that if the kernel was loaded below 4G, that it is protected
+	 * by the lo PMR.
+	 */
+	if ((__pa_symbol(_end) < 0x100000000ULL) &&
+	    (__pa_symbol(_end) > os_sinit_data->vtd_pmr_lo_size)) {
+		err = SL_ERROR_LO_PMR_MLE;
+		errmsg = "Error lo PMR does not cover MLE kernel\n";
+		goto out;
+	}
+
+	/* Check that the AP wake block is protected by the lo PMR. */
+	if (ap_wake_info.ap_wake_block + PAGE_SIZE >
+	    os_sinit_data->vtd_pmr_lo_size) {
+		err = SL_ERROR_LO_PMR_MLE;
+		errmsg = "Error lo PMR does not cover AP wake block\n";
+	}
+
+out:
+	early_memunmap(os_sinit_data, field_offset);
+
+	if (err)
+		slaunch_txt_reset(txt, errmsg, err);
+}
+
+static int __init slaunch_txt_reserve_range(u64 base, u64 size)
+{
+	int type;
+
+	type = e820__get_entry_type(base, base + size - 1);
+	if (type == E820_TYPE_RAM) {
+		e820__range_update(base, size, E820_TYPE_RAM,
+				   E820_TYPE_RESERVED);
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * For Intel, certain reqions of memory must be marked as reserved in the e820
+ * memory map if they are not already. This includes the TXT HEAP, the ACM area,
+ * the TXT private register bank. Normally these are properly reserved by
+ * firmware but if it was not done, do it now.
+ *
+ * Also the Memory Descriptor Ranges that are passed to the MLE (see TXT
+ * specification) may need to be reserved depeding on their type.
+ */
+static void __init slaunch_txt_reserve(void __iomem *txt)
+{
+	struct txt_sinit_memory_descriptor_record *mdr;
+	struct txt_sinit_mle_data *sinit_mle_data;
+	void *mdrs;
+	u64 base, size;
+	u32 field_offset, mdrnum, mdroffset, mdrslen, i;
+	int updated = 0;
+
+	base = TXT_PRIV_CONFIG_REGS_BASE;
+	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
+	updated += slaunch_txt_reserve_range(base, size);
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(u64));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(u64));
+	updated += slaunch_txt_reserve_range(base, size);
+
+	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(u64));
+	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(u64));
+	updated += slaunch_txt_reserve_range(base, size);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				sinit_vtd_dmar_table_size);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					field_offset);
+
+	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
+	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
+
+	early_memunmap(sinit_mle_data, field_offset);
+
+	if (!mdrnum)
+		goto out;
+
+	mdrslen = (mdrnum * sizeof(struct txt_sinit_memory_descriptor_record));
+
+	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					mdroffset + mdrslen - 8);
+
+	mdr = (struct txt_sinit_memory_descriptor_record *)
+			(mdrs + mdroffset - 8);
+
+	for (i = 0; i < mdrnum; i++, mdr++) {
+		/* Spec says some entries can have length 0, ignore them */
+		if (mdr->type > 0 && mdr->length > 0)
+			updated += slaunch_txt_reserve_range(mdr->address,
+							     mdr->length);
+	}
+
+	early_memunmap(mdrs, mdroffset + mdrslen - 8);
+
+out:
+	if (updated) {
+		e820__update_table(e820_table);
+		pr_info("TXT altered physical RAM map:\n");
+		e820__print_table("TXT-reserve");
+	}
+}
+
+/*
+ * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
+ * It is stored in the TXT heap. Fetch it from there and make it available
+ * to the IOMMU driver.
+ */
+static void __init slaunch_copy_dmar_table(void __iomem *txt)
+{
+	struct txt_sinit_mle_data *sinit_mle_data;
+	void *dmar;
+	u32 field_offset, dmar_size, dmar_offset;
+
+	memset(&txt_dmar, 0, PAGE_SIZE);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				processor_scrtm_status);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
+	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
+
+	early_memunmap(sinit_mle_data, field_offset);
+
+	if (!dmar_size || !dmar_offset)
+		slaunch_txt_reset(txt,
+				  "Error invalid DMAR table values\n",
+				  SL_ERROR_HEAP_INVALID_DMAR);
+
+	if (unlikely(dmar_size > PAGE_SIZE))
+		slaunch_txt_reset(txt,
+				  "Error DMAR too big to store\n",
+				  SL_ERROR_HEAP_DMAR_SIZE);
+
+
+	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					dmar_offset + dmar_size - 8);
+	if (!dmar)
+		slaunch_txt_reset(txt,
+				  "Error early_ioremap of DMAR\n",
+				  SL_ERROR_HEAP_DMAR_MAP);
+
+	memcpy(&txt_dmar[0], dmar + dmar_offset - 8, dmar_size);
+
+	early_memunmap(dmar, dmar_offset + dmar_size - 8);
+}
+
+/*
+ * The location of the safe AP wake code block is stored in the TXT heap.
+ * Fetch it here in the early init code for later use in SMP startup.
+ */
+static void __init slaunch_fetch_ap_wake_block(void __iomem *txt)
+{
+	struct txt_os_mle_data *os_mle_data;
+	u8 *jmp_offset;
+	u32 field_offset;
+
+	field_offset = offsetof(struct txt_os_mle_data, event_log_buffer);
+	os_mle_data = txt_early_get_heap_table(txt, TXT_OS_MLE_DATA_TABLE,
+					       field_offset);
+
+	ap_wake_info.ap_wake_block = os_mle_data->ap_wake_block;
+
+	jmp_offset = ((u8 *)&os_mle_data->mle_scratch)
+			+ SL_SCRATCH_AP_JMP_OFFSET;
+	ap_wake_info.ap_jmp_offset = *((u32 *)jmp_offset);
+
+	early_memunmap(os_mle_data, field_offset);
+}
+
+/*
+ * Intel specific late stub setup and validation.
+ */
+static void __init slaunch_setup_intel(void)
+{
+	void __iomem *txt;
+	u64 val = 0x1ULL;
+
+	/*
+	 * First see if SENTER was done and not by TBOOT by reading the status
+	 * register in the public space.
+	 */
+	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt) {
+		/* This is really bad, no where to go from here */
+		panic("Error early_ioremap of TXT pub registers\n");
+	}
+
+	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(u64));
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	/* Was SENTER done? */
+	if (!(val & TXT_SENTER_DONE_STS))
+		return;
+
+	/* Was it done by TBOOT? */
+	if (boot_params.tboot_addr)
+		return;
+
+	/* Now we want to use the private register space */
+	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt) {
+		/* This is really bad, no where to go from here */
+		panic("Error early_ioremap of TXT priv registers\n");
+	}
+
+	/*
+	 * Try to read the Intel VID from the TXT private registers to see if
+	 * TXT measured launch happened properly and the private space is
+	 * available.
+	 */
+	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(u64));
+	if ((u16)(val & 0xffff) != 0x8086) {
+		/*
+		 * Can't do a proper TXT reset since it appears something is
+		 * wrong even though SENTER happened and it should be in SMX
+		 * mode.
+		 */
+		panic("Invalid TXT vendor ID, not in SMX mode\n");
+	}
+
+	/* Set flags so subsequent code knows the status of the launch */
+	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT);
+
+	/*
+	 * Reading the proper DIDVID from the private register space means we
+	 * are in SMX mode and private registers are open for read/write.
+	 */
+
+	/* On Intel, have to handle TPM localities via TXT */
+	val = 0x1ULL;
+	memcpy_toio(txt + TXT_CR_CMD_SECRETS, &val, sizeof(u64));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(u64));
+	val = 0x1ULL;
+	memcpy_toio(txt + TXT_CR_CMD_OPEN_LOCALITY1, &val, sizeof(u64));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(u64));
+
+	slaunch_fetch_ap_wake_block(txt);
+
+	slaunch_verify_pmrs(txt);
+
+	slaunch_txt_reserve(txt);
+
+	slaunch_copy_dmar_table(txt);
+
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	pr_info("Intel TXT setup complete\n");
+}
+
+void __init slaunch_setup(void)
+{
+	u32 vendor[4];
+
+	/* Get manufacturer string with CPUID 0 */
+	cpuid(0, &vendor[0], &vendor[1], &vendor[2], &vendor[3]);
+
+	/* Only Intel TXT is supported at this point */
+	if (vendor[1] == INTEL_CPUID_MFGID_EBX &&
+	    vendor[2] == INTEL_CPUID_MFGID_ECX &&
+	    vendor[3] == INTEL_CPUID_MFGID_EDX)
+		slaunch_setup_intel();
+}
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 3acfa6a25fa2..667a5be83e58 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/numa.h>
+#include <linux/slaunch.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
@@ -623,6 +624,9 @@ parse_dmar_table(void)
 	 */
 	dmar_tbl = tboot_get_dmar_table(dmar_tbl);
 
+	/* If Secure Launch is active, it has similar logic */
+	dmar_tbl = slaunch_get_dmar_table(dmar_tbl);
+
 	dmar = (struct acpi_table_dmar *)dmar_tbl;
 	if (!dmar)
 		return -ENODEV;
-- 
2.25.1

