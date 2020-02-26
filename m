Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE8C4BA2C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D42B24656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RE/bfNHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBZWCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45025 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgBZWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754543; x=1614290543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b47bT/wG0NLrh0JcPFk1Y46QOIeyaTd0c1vGrbI4riw=;
  b=RE/bfNHXHVUg5fp1gJG9syMmoLXomm+ms12AEfktNTVwxmgbPjkR3LG/
   yfP+B6Y4AKx17cuNW6Ivf2klcZh68/A+JsOY9Xky/iTTZ9WJhlrJCkJyM
   PxPzmZK/hk2B2QhQVyoxiSMiDVeDM28jUzlgH91exWVBzNJZ1JqGZhRTN
   t3V8JoiVeWE84+pzBZOBkkyHOPEUvJwyqUIjr0vptblHgvFHbtS/GPkN2
   xI7z97zp8QfkrU7/clDHCQREvwwsFb0Qr/HPBEJebBc9DKJR97iCv05lU
   4WladrBz890iOD4tVRydp8B+AOfGNpjBuRB4HDKXIGh3boUcjvO8oxKF8
   w==;
IronPort-SDR: oRQ3L1V1Uw5k83y1nxmMwsScd/Th0V98112cUFEjmlLGUFcjCh52QDwlqzBM5/0zjxtA5vH9uV
 Mj2WVntVZRxfz7tMSEMN3OQX78EkBHWymBHxj4mCZwdtSM9wPa83zK/ZtOu6bYuQP45KbrXsNh
 OPvAojSBzk8YoReI2JRku5V/WqMN19Dxq8HClJ6PTGUMpVuNuzAlbIQnLKaQoDtDPgoalZ7QYm
 AL80I6yZA03rO4ipK0fkgXF2idayc6RAHdygjdbSv/9m0xz6TX0I4pfq+SLbJp5KXkuJsLkpDY
 BhE=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290725"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:23 +0800
IronPort-SDR: CKyoiHdOrUFR1J6Q28FbQ2DGPWxbf+jj/M46xugqNE3OgM1sErtbshA1+wrHWqGNygkeC2u7It
 Z8SenaDMI5v+/QQL1eUFPM49xExjkX78ZBXEQiFr8tFiYvvAXax8ba0oMu+tz3gyocwAbJKII5
 lIaWCZnB2ualOcyvUI0rr2saivu2VjcDxtFmySgAagZMFXrOthydHCOqpZGcQfUjWZG4EeCgWh
 r3eZ5hLPP+50ZSQ4h6Fu587V2+sx8v1Q0+NtyDgtysnSXQTyZBpRAZbtekz5uZ++EWddJs8BFK
 ASVXzViCPh/3D4mgrrrFcRZp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:47 -0800
IronPort-SDR: nFZO6kux3qFB/hhkLLJ7Me6Ys1ZlKA/gxlhM1HSKLWdb28QmPmnp4NhS29U1QRV6QW49mHtgyr
 pHAnNF5VRRAtwl4EoL4uK+SYiqBtyovj1CW8vtARsT2gQclnQlNCz8r8vsncpK9UX+cKRVgqdL
 3BaPaIVjCKmHbGsNn0c/K6/YAG5Glo1D4OyQPfKeuNlQzlQIAPUGlBHjoDH5QVjEHGUSOwJo+E
 WDWcyOiBs9pFnZ03x9u5bVga3hc6dvrVq2qadv8ChXsdQ6J9vAFTtK8kcFzXB50OvsBruk6sJt
 Rcg=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:22 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 05/12] RISC-V: Implement new SBI v0.2 extensions
Date:   Wed, 26 Feb 2020 14:02:06 -0800
Message-Id: <20200226220213.27423-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/sbi.c      | 246 ++++++++++++++++++++++++++++++++++-
 3 files changed, 263 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index be634be78551..8766f6af9eb8 100644
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
index 599d922d4ff3..932b23272be5 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <asm/sbi.h>
+#include <asm/smp.h>
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
@@ -189,6 +190,149 @@ static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
 }
 #endif /* CONFIG_RISCV_SBI_V01 */
 
+static void __sbi_set_timer_v02(uint64_t stime_value)
+{
+#if __riscv_xlen == 32
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value,
+			  stime_value >> 32, 0, 0, 0, 0);
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
+	hmask_val = hbase = 0;
+	for_each_set_bit(hartid, hart_mask, NR_CPUS) {
+		if (hmask_val && ((hbase + BITS_PER_LONG) <= hartid)) {
+			ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
+					hmask_val, hbase, 0, 0, 0, 0);
+			if (ret.error)
+				goto ecall_failed;
+			hmask_val = hbase = 0;
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
+		__func__, hbase, hmask_val, result);
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
+			fid, ext);
+		result = -EINVAL;
+	}
+
+	if (ret.error) {
+		result = sbi_err_map_linux_errno(ret.error);
+		pr_err("%s: hbase = [%lu] hmask = [0x%lx] failed (error [%d])\n",
+			__func__, hbase, hmask_val, result);
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
+	hmask_val = hbase = 0;
+	for_each_set_bit(hartid, hart_mask, NR_CPUS) {
+		if (hmask_val && ((hbase + BITS_PER_LONG) <= hartid)) {
+			result = __sbi_rfence_v02_call(fid, hmask_val, hbase,
+						       start, size, arg4, arg5);
+			if (result)
+				return result;
+			hmask_val = hbase = 0;
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
@@ -265,6 +409,85 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
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
+					 unsigned long start,
+					 unsigned long size)
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
+					      unsigned long start,
+					      unsigned long size,
+					      unsigned long vmid)
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
+					 unsigned long start,
+					 unsigned long size)
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
+					      unsigned long start,
+					      unsigned long size,
+					      unsigned long asid)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+			    hart_mask, start, size, asid, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -331,11 +554,26 @@ int __init sbi_init(void)
 	if (!sbi_spec_is_0_1()) {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
+		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
+			__sbi_set_timer = __sbi_set_timer_v02;
+			pr_info("SBI v0.2 TIME extension detected\n");
+		} else
+			__sbi_set_timer = __sbi_set_timer_v01;
+		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
+			__sbi_send_ipi	= __sbi_send_ipi_v02;
+			pr_info("SBI v0.2 IPI extension detected\n");
+		} else
+			__sbi_send_ipi	= __sbi_send_ipi_v01;
+		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
+			__sbi_rfence	= __sbi_rfence_v02;
+			pr_info("SBI v0.2 RFENCE extension detected\n");
+		} else
+			__sbi_rfence	= __sbi_rfence_v01;
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
2.25.0

