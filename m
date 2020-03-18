Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6273CC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC7320767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EwWYVnyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCRBMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:12:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45915 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgCRBL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493919; x=1616029919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9mZeJ6XPAWepkvNCNb1GTiizBSn2rBfLcZ6CwOjh81U=;
  b=EwWYVnySA33cYV8CurqxEDX6cE6j8RJ9YB4jmjuQj1vaZLPLrwHrC5DJ
   FmJcNuh+2Hd1zEqT/4K1Y3wnWLIw0m6Sra4FF2esp9GQgY1MH2iAaPeOI
   /kctciQs/4Swm0dfnzYGr77OMY/uXCKdqsv4+gxxNLuV1YDKPlESk0yjv
   w0WyuB+MPOL69kodW7zvX77Arat4i6FWYLCCjv0nPe0GmEo+26A33pQGK
   b5NVEBJUtSWCZWPQvlXXqTsQa2ZncR4T/EN1DDoZmYlUyCTy3TGwyc0J1
   pJQMhhdIc2iAqxXWlQhhAhOS5sJo42lN52Zy+whnlDaFhZUP1ARPWwH7E
   g==;
IronPort-SDR: pCbZLZ4A7cwSAzroStt3tYjNM+/MDGsG4ZxDkDcd+B/sPMmxvriZXyWMjfRotFgQ/PYhWT1+z3
 JWo360cdmXWmWVuME00IHEdrvzDVPiW/yGwRenNnjEk6NSv7TmH/3QngkGtnrhg8GJtyyFmxMR
 TqlD+gMWqwnRZLStzQM/eKLY8jxHwa+DlHX5PglO4WA1MPX/O5/UOzjquFiNNk/Rj6Wnlw46o3
 TiTbb0l0fQniIrI9J2opAkR6Zh04za9kYVf2JovpKE94QhKf7/DYqZ9l6fNfAjmBmwYwFOHbjL
 MOI=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241512"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:11:58 +0800
IronPort-SDR: wGNmqq+ngXroO9MSuVs9+b/uOGV6l+j8898fwiJCo1wUnDbv4ljrmV3XW5p0Su63/vxeSkQC88
 zD/FlC8KXidMBpy1gzS8s0YMjdI8FTv0th8WozvQFyijzxYCffOGC9jE9045fbzowAI7ktxFlt
 q0PH82LZRZUWyPoE8qX1CFqWNOGM4BvAc+mYWNVgImYL7otvMtVwRsxkOcfFvcFKeh5hWDV79c
 aPhZtP7ZjcMUjDGfELgWpYm9WWjQqBJQ09Yda0rAbep46+q4DQJM5cDuKiI26UvRRiyGeGTr9E
 fEHMFVo26KMpHDlWj0o4yP3l
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:49 -0700
IronPort-SDR: l/nFptKcHTLuei5noque9l5OZX3s6f/sCypBvp2c+D3UHtTmV24L3nu/S5fy7PLz6dib85At0+
 XTN/ruEKSEPVyR73L1jM8aOgHxmW7yh8ZjbH27RH7neHD3brzEh5gbXM2xM7juev7PV5qAPLHC
 iBfll11F9RrZ2qDf0zSZoW+OxHtImd3vE0hWMZtdJrNeu6CrRXimQQ4xkEE4tpkZ4w3WhnyPZT
 2GCn3DLKTASPH931udyZgURsIEym5pWCwlzmqJdT1BOsBgjKnbS/YZ/yj7xqhxeAfzcXVc3oDQ
 b+w=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:11:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v11 05/11] RISC-V: Implement new SBI v0.2 extensions
Date:   Tue, 17 Mar 2020 18:11:38 -0700
Message-Id: <20200318011144.91532-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
References: <20200318011144.91532-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few v0.1 SBI calls are being replaced by new SBI calls that follows v0.2
calling convention.

Implement the replacement extensions and few additional new SBI function calls
that makes way for a better SBI interface in future.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/sbi.h |  14 ++
 arch/riscv/include/asm/smp.h |   7 +
 arch/riscv/kernel/sbi.c      | 253 ++++++++++++++++++++++++++++++++++-
 3 files changed, 270 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d712b61f8dbc..29ce2c494386 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -96,6 +96,20 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid);
+int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size);
+int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long vmid);
+int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size);
+int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long asid);
 int sbi_probe_extension(int ext);
 
 /* Check if current SBI specification version is 0.1 or not */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a83451d73a4e..023f74fb8b3b 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -61,5 +61,12 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
 	return boot_cpu_hartid;
 }
 
+static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
+					      struct cpumask *out)
+{
+	cpumask_clear(out);
+	cpumask_set_cpu(boot_cpu_hartid, out);
+}
+
 #endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1368da62ec82..1cc0052e1b63 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <asm/sbi.h>
+#include <asm/smp.h>
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
@@ -191,6 +192,153 @@ static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
 }
 #endif /* CONFIG_RISCV_SBI_V01 */
 
+static void __sbi_set_timer_v02(uint64_t stime_value)
+{
+#if __riscv_xlen == 32
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value,
+		  stime_value >> 32, 0, 0, 0, 0);
+#else
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value, 0,
+		  0, 0, 0, 0);
+#endif
+}
+
+static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
+{
+	unsigned long hartid, hmask_val, hbase;
+	struct cpumask tmask;
+	struct sbiret ret = {0};
+	int result;
+
+	if (!hart_mask || !(*hart_mask)) {
+		riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
+		hart_mask = cpumask_bits(&tmask);
+	}
+
+	hmask_val = 0;
+	hbase = 0;
+	for_each_set_bit(hartid, hart_mask, NR_CPUS) {
+		if (hmask_val && ((hbase + BITS_PER_LONG) <= hartid)) {
+			ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
+					hmask_val, hbase, 0, 0, 0, 0);
+			if (ret.error)
+				goto ecall_failed;
+			hmask_val = 0;
+			hbase = 0;
+		}
+		if (!hmask_val)
+			hbase = hartid;
+		hmask_val |= 1UL << (hartid - hbase);
+	}
+
+	if (hmask_val) {
+		ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
+				hmask_val, hbase, 0, 0, 0, 0);
+		if (ret.error)
+			goto ecall_failed;
+	}
+
+	return 0;
+
+ecall_failed:
+	result = sbi_err_map_linux_errno(ret.error);
+	pr_err("%s: hbase = [%lu] hmask = [0x%lx] failed (error [%d])\n",
+	       __func__, hbase, hmask_val, result);
+	return result;
+}
+
+static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask_val,
+				 unsigned long hbase, unsigned long start,
+				 unsigned long size, unsigned long arg4,
+				 unsigned long arg5)
+{
+	struct sbiret ret = {0};
+	int ext = SBI_EXT_RFENCE;
+	int result = 0;
+
+	switch (fid) {
+	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, 0, 0, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
+				size, arg4, 0);
+		break;
+
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
+				size, arg4, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
+		ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
+				size, arg4, 0);
+		break;
+	default:
+		pr_err("unknown function ID [%lu] for SBI extension [%d]\n",
+		       fid, ext);
+		result = -EINVAL;
+	}
+
+	if (ret.error) {
+		result = sbi_err_map_linux_errno(ret.error);
+		pr_err("%s: hbase = [%lu] hmask = [0x%lx] failed (error [%d])\n",
+		       __func__, hbase, hmask_val, result);
+	}
+
+	return result;
+}
+
+static int __sbi_rfence_v02(int fid, const unsigned long *hart_mask,
+			    unsigned long start, unsigned long size,
+			    unsigned long arg4, unsigned long arg5)
+{
+	unsigned long hmask_val, hartid, hbase;
+	struct cpumask tmask;
+	int result;
+
+	if (!hart_mask || !(*hart_mask)) {
+		riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
+		hart_mask = cpumask_bits(&tmask);
+	}
+
+	hmask_val = 0;
+	hbase = 0;
+	for_each_set_bit(hartid, hart_mask, NR_CPUS) {
+		if (hmask_val && ((hbase + BITS_PER_LONG) <= hartid)) {
+			result = __sbi_rfence_v02_call(fid, hmask_val, hbase,
+						       start, size, arg4, arg5);
+			if (result)
+				return result;
+			hmask_val = 0;
+			hbase = 0;
+		}
+		if (!hmask_val)
+			hbase = hartid;
+		hmask_val |= 1UL << (hartid - hbase);
+	}
+
+	if (hmask_val) {
+		result = __sbi_rfence_v02_call(fid, hmask_val, hbase,
+					       start, size, arg4, arg5);
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
@@ -266,6 +414,85 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
 
+/**
+ * sbi_remote_hfence_gvma() - Execute HFENCE.GVMA instructions on given remote
+ *			   harts for the specified guest physical address range.
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the guest physical address
+ * @size: Total size of the guest physical address range.
+ *
+ * Return: None
+ */
+int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
+			    hart_mask, start, size, 0, 0);
+}
+EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
+
+/**
+ * sbi_remote_hfence_gvma_vmid() - Execute HFENCE.GVMA instructions on given
+ * remote harts for a guest physical address range belonging to a specific VMID.
+ *
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the guest physical address
+ * @size: Total size of the guest physical address range.
+ * @vmid: The value of guest ID (VMID).
+ *
+ * Return: 0 if success, Error otherwise.
+ */
+int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long vmid)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
+			    hart_mask, start, size, vmid, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_gvma_vmid);
+
+/**
+ * sbi_remote_hfence_vvma() - Execute HFENCE.VVMA instructions on given remote
+ *			     harts for the current guest virtual address range.
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the current guest virtual address
+ * @size: Total size of the current guest virtual address range.
+ *
+ * Return: None
+ */
+int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
+			    hart_mask, start, size, 0, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_vvma);
+
+/**
+ * sbi_remote_hfence_vvma_asid() - Execute HFENCE.VVMA instructions on given
+ * remote harts for current guest virtual address range belonging to a specific
+ * ASID.
+ *
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the current guest virtual address
+ * @size: Total size of the current guest virtual address range.
+ * @asid: The value of address space identifier (ASID).
+ *
+ * Return: None
+ */
+int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long asid)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+			    hart_mask, start, size, asid, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -332,11 +559,29 @@ int __init sbi_init(void)
 	if (!sbi_spec_is_0_1()) {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
+		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
+			__sbi_set_timer = __sbi_set_timer_v02;
+			pr_info("SBI v0.2 TIME extension detected\n");
+		} else {
+			__sbi_set_timer = __sbi_set_timer_v01;
+		}
+		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
+			__sbi_send_ipi	= __sbi_send_ipi_v02;
+			pr_info("SBI v0.2 IPI extension detected\n");
+		} else {
+			__sbi_send_ipi	= __sbi_send_ipi_v01;
+		}
+		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
+			__sbi_rfence	= __sbi_rfence_v02;
+			pr_info("SBI v0.2 RFENCE extension detected\n");
+		} else {
+			__sbi_rfence	= __sbi_rfence_v01;
+		}
+	} else {
+		__sbi_set_timer = __sbi_set_timer_v01;
+		__sbi_send_ipi	= __sbi_send_ipi_v01;
+		__sbi_rfence	= __sbi_rfence_v01;
 	}
 
-	__sbi_set_timer = __sbi_set_timer_v01;
-	__sbi_send_ipi	= __sbi_send_ipi_v01;
-	__sbi_rfence	= __sbi_rfence_v01;
-
 	return 0;
 }
-- 
2.25.1

