Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B183BC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A3F24682
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xt++/MG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgA1C2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:28:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43171 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgA1C2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580178491; x=1611714491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wOT0GpSheCPVLbOmRrlnI5gyIs5vHfMHgSdRZXC7csg=;
  b=Xt++/MG37b4/Fci7+gwAWrpoIjUSVZQcie9O90oL2JB9TxBqPniUKugD
   R0Mc1dGtwBekZlw+Tcfg4L94L2IPVUf34qmXIEoYAJPOkNZB8zDsbx+vL
   4thBxJZm/d9gAR3fSSnzJWgyeMqDpezwXp86R+BzeIT76ldyEHqZLXBbz
   4YQzJrGZFeK4xL5mBlOOcmlx1rLKMO7wXlucFagYnmAXdFyuwi+UoCMBl
   37OlbWz/uw+8McwMxAHqmuYiDCUY/uOZCVWm41odUcwQmMa2sgDdw4Nht
   46TDkwoWN38J2YtAuxNuwpdxHSNPtBdrJB2hCtt9oZHMkyBsh5r4oZb+N
   g==;
IronPort-SDR: mQ1LlaevmqKTejr43j8v8pxEdPATWgl7cCFt7/fbirYGD60xO3d4ELbYICoBg3m311fRf/tzkw
 /6n3AjIn+tmn3RmFJul69oLjmcrlBm+RY3UWh0SGBn6YJYgREJm57pJhfCau/NNPKgp0S8MeYf
 uofOiDTy9xZolYwC9yY6BvFA5N7VHyrdyzQBe1+uQWoKXUFUQrkvXoYHV1PmKb3DeLOpv99IPN
 XM/IV8I9mEzBD3N7IDZiwqzBgjQFI82/VZ6P6bKENYfYOu07M43GUV3nbY27TATah1XRv0hcVd
 QlA=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132899426"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 10:28:11 +0800
IronPort-SDR: QWZE+bZ9YQRIjzvkMwLTKeQ9LXwNroPVuPzVZJDrfq9RK7JLABqSDLJQBui9RB4bhdgtmvtrEw
 vdzD230X1STHK70F3Ztr98lsww8QvMZMZnC6GZBCTZiLFNzjgA3/XKqMJFfHPWVy+Z7wprvqLN
 wN9tN1w0Dezrt4+Z+QYVAG8VNn42MNK31V6JzENr2r+uW+9tvqaVRl3u+ebpWxD2S6rS9ZYMtR
 O/gAeyZF494uxsdjQ19WjO4UVJNxNvRGLAHyTjlz110PvPbE2St7ATzq5PvfMsU+QE5WqKMt/3
 OXUmCZI9D7/P3Lm1ij7NUjiu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 18:21:26 -0800
IronPort-SDR: KmBB4o+GAva8xuNpVPdKmg65LCOZCD/n8DiFz2BxNyWv3O6SWMjKzwx94nCo2d3GXdUotTm5YN
 OOCOjBieAvzw8XA4Z5yUk3+wKeNW8uXXAD/uujTEogCOh9P7ICby1x/t06efknvXq/Dyn2GNm9
 Ewc5cNkS4ubdzlVCa47lbpNZpiT9CrzHfgjHQiduuHmeipXr0fiGJl69Rg45Bjc0tYQoJNt7Mn
 PKFt6QjdUnW/U2Yq3dfDk4KDhLUOCyi/dqbkVP2MxlByk4YYdBIVIC2gdTo63hw0lSxoU0i63S
 zus=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 18:28:11 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>, abner.chang@hpe.com,
        clin@suse.com, nickhu@andestech.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v7 08/10] RISC-V: Add SBI HSM extension
Date:   Mon, 27 Jan 2020 18:27:35 -0800
Message-Id: <20200128022737.15371-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128022737.15371-1-atish.patra@wdc.com>
References: <20200128022737.15371-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI specification defines HSM extension that allows to start/stop a hart
by a supervisor anytime. The specification is available at

https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc

Implement SBI HSM extension.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 22 ++++++++++++++++
 arch/riscv/kernel/sbi.c      | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d55d8090ab5c..bed6fa26ec84 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -26,6 +26,7 @@ enum sbi_ext_id {
 	SBI_EXT_TIME = 0x54494D45,
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
+	SBI_EXT_HSM = 0x48534D,
 };
 
 enum sbi_ext_base_fid {
@@ -56,6 +57,12 @@ enum sbi_ext_rfence_fid {
 	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
 };
 
+enum sbi_ext_hsm_fid {
+	SBI_EXT_HSM_HART_START = 0,
+	SBI_EXT_HSM_HART_STOP,
+	SBI_EXT_HSM_HART_STATUS,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -70,6 +77,7 @@ enum sbi_ext_rfence_fid {
 #define SBI_ERR_INVALID_ADDRESS -5
 
 extern unsigned long sbi_spec_version;
+extern bool sbi_hsm_avail;
 struct sbiret {
 	long error;
 	long value;
@@ -110,8 +118,18 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid);
+int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
+		       unsigned long priv);
+int sbi_hsm_hart_stop(void);
+int sbi_hsm_hart_get_status(unsigned long hartid);
+
 int sbi_probe_extension(int ext);
 
+static inline bool sbi_hsm_is_available(void)
+{
+	return sbi_hsm_avail;
+}
+
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
 {
@@ -137,5 +155,9 @@ void sbi_clear_ipi(void);
 void sbi_send_ipi(const unsigned long *hart_mask);
 void sbi_remote_fence_i(const unsigned long *hart_mask);
 void sbi_init(void);
+static inline bool sbi_hsm_is_available(void)
+{
+	return false;
+}
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 3c34aba30f6f..9bdc9801784d 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -12,6 +12,8 @@
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
+bool sbi_hsm_avail;
+
 EXPORT_SYMBOL(sbi_spec_version);
 
 static void (*__sbi_set_timer)(uint64_t stime);
@@ -496,6 +498,54 @@ static void sbi_power_off(void)
 	sbi_shutdown();
 }
 
+int sbi_hsm_hart_stop(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STOP, 0, 0, 0, 0, 0, 0);
+
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+EXPORT_SYMBOL(sbi_hsm_hart_stop);
+
+int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
+		       unsigned long priv)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_START,
+			      hartid, saddr, priv, 0, 0, 0);
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+EXPORT_SYMBOL(sbi_hsm_hart_start);
+
+int sbi_hsm_hart_get_status(unsigned long hartid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STATUS,
+			      hartid, 0, 0, 0, 0, 0);
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+EXPORT_SYMBOL(sbi_hsm_hart_get_status);
+
+void __init sbi_hsm_ext_init(void)
+{
+	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
+		pr_info("SBI v0.2 HSM extension detected\n");
+		sbi_hsm_avail = true;
+	}
+}
+
 int __init sbi_init(void)
 {
 	int ret;
@@ -532,5 +582,6 @@ int __init sbi_init(void)
 		__sbi_rfence	= __sbi_rfence_v01;
 	}
 
+	sbi_hsm_ext_init();
 	return 0;
 }
-- 
2.24.0

