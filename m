Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A5CC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F196720842
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJXy5wGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgBLBwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:52:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60368 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBLBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472316; x=1613008316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EI214Daz6yEX7hNgoff6RHMTkq7kjXcuwun22exIH/A=;
  b=AJXy5wGSUCtqnl8yvTh5BJhNEs9MH59boyACbeOiTZNprTj4r1a7Bdyk
   TRAF7H2Nut7+U14wLMAlIfiyC0Q5GSGjs6T3dnUmvdavncgMk1UTUt7Og
   qdVbYLHtg6xs211+w8wcHWPIBgbpErc+DxJMRplm+kji1OvOMDE29q9Wh
   5PVVZAiBeVAQueWBOE+ZP/WD+vGaHzgGBXxaQY5L7JO/GgpFxu4Ao7TVK
   DvTkgJlNERlVFWWf9rODm/xk8BTH69uF3/osu2ne7qCCxbRFwlJGYkYi6
   DbJhciufsQd8TShbfyedVyGn83NVfGno/zLAiBXXylwGmhGbsKUHoqgLd
   w==;
IronPort-SDR: p6SMORf7IWBxixKqVwiCoT7xP6wQjbK+mwXkbqGkAQ32XamLXwSSmS9XRs8Py7TpJJGQk6oUrn
 LARi6IFpuDdpL1XRHsrCt9S0Zn2lC+nJNpPQVDOfz7gUojDmtggznnuBgBU+EWeaC1HgHky/7e
 P6mQcevSc34MQqxBNDnzLdN5Kl5dlzK0jPmqz5l9VvJQ+0AFutt3yYrDQZKVrvH44rJ7M6d0AP
 anJRqrlpP9a7QR3PWOMkzAO+M12D2Jd56EGXhWogVr3cZ8Sw0f5K8Gl3Lma+bU4khV690i3P+K
 UbM=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648947"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:55 +0800
IronPort-SDR: FGLUJaq54o3xqEk8PgXn1l/08yJt/ZNlD44fDxgsQEyWp3F/Y8wpP7TlWB6TbwrYD1T9vYahFK
 cF7YzFuFqdKyRdrkK3AFoxPITtm0zX4cayl5G6ITica8OZ+G9TCQkr95OiIgio6t4NM/Vs9WZR
 mqC4+JsspjUcEIKlvkVskPMT5+Eu8lpogza0nAk5HrMloJQ5M/oeXgYh51ADdmvCvpB0BvSBJQ
 hLKe5dhv8egZXJREjwdCayQXKeO7Aq0tdkUiawjLaONDDsf8s7dEwl2DKu2U4Z11jLZck5HfhO
 RhBDW4hN01/8yMeIn9W+tztD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:45 -0800
IronPort-SDR: G55p9Qe6uI5ynk64T3WxY1QCHO1NKp3b05xIZQs3HIVla7k1J7FFBHpNVHqhQMdGmO4RL3MPJg
 U2Ib9kpPZ6Hs4a4RGPNDi+Jb//c88tEy/7BPSJlrP2X08aGLGcb2F4euXAzBJMZ2y95FADSyMZ
 x+qfrimqoGk4byCpkeVmKgC2T6YdB4rygMJOJ8SxxBcU52quLIruK4BWH4abNKImaQ2hIgtI9n
 kCDKSefziQUWAChrP78jPBCSFZ+5aSbrDDtryJo3zPzk+e9ZRua4QNXEdDEwRBwbUakmgZHxOw
 AbM=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:55 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v8 05/11] RISC-V: Implement new SBI v0.2 extensions
Date:   Tue, 11 Feb 2020 17:48:16 -0800
Message-Id: <20200212014822.28684-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
References: <20200212014822.28684-1-atish.patra@wdc.com>
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
 arch/riscv/include/asm/sbi.h |  14 +++
 arch/riscv/include/asm/smp.h |   7 ++
 arch/riscv/kernel/sbi.c      | 199 ++++++++++++++++++++++++++++++++++-
 3 files changed, 216 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 4d67bef8f894..d55d8090ab5c 100644
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
index 265637cb5eb0..cd0f68aeac70 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <asm/sbi.h>
+#include <asm/smp.h>
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
@@ -193,6 +194,102 @@ static int __sbi_rfence_v01(int fid,
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
+	unsigned long hmask_val;
+	struct cpumask tmask;
+	struct sbiret ret = {0};
+	int result;
+
+	if (!hart_mask) {
+		riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
+		hmask_val = *(cpumask_bits(&tmask));
+	} else
+		hmask_val = *hart_mask;
+
+	ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI, hmask_val,
+			0, 0, 0, 0, 0);
+	if (ret.error) {
+		result = sbi_err_map_linux_errno(ret.error);
+		pr_err("%s: failed with error [%d]\n", __func__, result);
+	} else
+		result = 0;
+
+	return result;
+}
+
+static int __sbi_rfence_v02(int fid, const unsigned long *hart_mask,
+			    unsigned long hbase, unsigned long start,
+			    unsigned long size, unsigned long arg4,
+			    unsigned long arg5)
+{
+	unsigned long hmask_val;
+	struct cpumask tmask;
+	struct sbiret ret = {0};
+	int ext = SBI_EXT_RFENCE;
+	int result;
+
+	if (!hart_mask) {
+		riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
+		hmask_val = *(cpumask_bits(&tmask));
+	} else
+		hmask_val = *hart_mask;
+
+	switch (fid) {
+	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, 0, 0, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, arg4, 0);
+		break;
+	/*TODO: Handle non zero hbase cases */
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, arg4, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, arg4, 0);
+		break;
+	default:
+		pr_err("unknown function ID [%d] for SBI extension [%d]\n",
+			fid, ext);
+		result = -EINVAL;
+	}
+
+	if (ret.error) {
+		result = sbi_err_map_linux_errno(ret.error);
+		pr_err("%s: failed with error [%d]\n", __func__, result);
+	} else
+		result = 0;
+
+	return result;
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
@@ -269,6 +366,85 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
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
+			    hart_mask, 0, start, size, 0, 0);
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
+			    hart_mask, 0, start, size, vmid, 0);
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
+			    hart_mask, 0, start, size, 0, 0);
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
+			    hart_mask, 0, start, size, asid, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -335,11 +511,26 @@ int __init sbi_init(void)
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
2.24.0

