Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E3C352A3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D992086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QCm27dC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgBLBwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:52:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60368 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgBLBv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472317; x=1613008317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1HeLrodGOFdZtxytsnxaWhw187K4Ea3d/+LDZfjUZL4=;
  b=QCm27dC/7GvbB5LECXQjsMto156GDeEXRTiNYGyET+2zzZQNmqn2/+si
   4YPozgHkaYR2E/8HFo1+epUZAPgdQddx//CvBGEnFJWirEWcp/a12dSrk
   De8PSL+7P60H0vjzB0YR3uYw6ldzerLwxMi2nLRqHnnJJZDpR2aTVtTnJ
   QdKuEql3WjDwMPfBWxR8lS50phrTC+sEk+JDGh0qJJYe4DaSWLBc2Vefl
   NkrVrk4edKHDC92m3Zb87egGHbhR+0RMWi17rpDnM2E3Qf6POSyaCKp6X
   Q4TKvRzDSfG4M2osjj4TCMKEchH/xndj0b1SWka/fTDv/r1tOTzhVkVtv
   w==;
IronPort-SDR: D2H1zjPQWLZYMjznn9eWtsEKw2B9jXGi283DodyOR2uROZVMrc/he97TBxmm1PtybY6ckMqVSp
 8f1RPzuCvefMpFsyuNELefZu5YRA2unRVnYU29Uyy0M8wOyg9gxHqY12LZ5OBbIa54rPOaYxS+
 Xmp+tT7z/UeF4iKfYkyuIF7++ZHOHaZpH1vgrlK3E3YS8glJT5G8FmhUnyi8bPdcYWLOLB04Ly
 xML4g2uYXiekOGTyXxd0MdInZCU/lXhPQs9TqnKC/9tyF8dDqU6OJ2ZWzdx1zyP4FElt1OBGlX
 2KU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648952"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:56 +0800
IronPort-SDR: jpXRQNXAXvRiz4NbkKeJ3MAbOrWnFukueg5TRxieEBTLrVum23UoNRol70ks4RhA96SstVkYn7
 I2XU4s8+YEvntb/u/Ylgp9GBxD8uY5JJFzgy++xFHsI2Ic7kBZjzatrQD43+mgEv2+2G87I510
 sJxFXgkDpiRCFkBOksqMWEYLzagkqNJLnk+nW+nkLaek1LQrTZ4THRw79ZFrEAN/lXQASC7AwA
 KNMaVOaDg7DyD6IRz5b1tzBgOjeR/6nzX6Nbp79q5Pzer6/g4O2A4q8sMXthFX86qg5+I6xGdk
 +YXmiYo17O9buWbJMDqiAiE3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:46 -0800
IronPort-SDR: i4ACyt6r8IbxBuEzVyp5U/fLIyUJy0RnYoH4e3Bdt8gku+4JVeINRgrA5Ok6dbb/n93gYxA0VC
 fKJv/n+m3NaPXIUvjpI3fLGCu5n1qPR/v48O6CoQFRME56iKZaDZPqxWngVFlrU2ZKQjpkL01G
 uK74udGZ6hKWa5djsZprleP8i3DkZj8v1794sslt8UFGnTYNzqb9WEm1mwUGayDh6L0u3g7Jah
 iUjb4twK+FTv2bSdVsYK6KXPZ8e4sFECLp5ciaiQUKadDFiWbX1CKoLNqOeD88GZzXjj7ruooH
 QGY=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:56 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
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
Subject: [PATCH v8 08/11] RISC-V: Add SBI HSM extension
Date:   Tue, 11 Feb 2020 17:48:19 -0800
Message-Id: <20200212014822.28684-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
References: <20200212014822.28684-1-atish.patra@wdc.com>
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
 arch/riscv/include/asm/sbi.h    | 15 +++++++++++
 arch/riscv/kernel/Makefile      |  3 +++
 arch/riscv/kernel/cpu_ops_sbi.c | 48 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c         |  3 ++-
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d55d8090ab5c..0981a0c97eda 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -26,6 +26,7 @@ enum sbi_ext_id {
 	SBI_EXT_TIME = 0x54494D45,
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
+	SBI_EXT_HSM = 0x48534D,
 };
 
 enum sbi_ext_base_fid {
@@ -56,6 +57,19 @@ enum sbi_ext_rfence_fid {
 	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
 };
 
+enum sbi_ext_hsm_fid {
+	SBI_EXT_HSM_HART_START = 0,
+	SBI_EXT_HSM_HART_STOP,
+	SBI_EXT_HSM_HART_STATUS,
+};
+
+enum sbi_hsm_hart_status {
+	SBI_HSM_HART_STATUS_AVAILABLE = 0,
+	SBI_HSM_HART_STATUS_NOT_AVAILABLE,
+	SBI_HSM_HART_STATUS_START_PENDING,
+	SBI_HSM_HART_STATUS_STOP_PENDING,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -130,6 +144,7 @@ static inline unsigned long sbi_minor_version(void)
 {
 	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
 }
+int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
 void sbi_set_timer(uint64_t stime_value);
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f81a6ff88005..a0be34b96846 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -44,5 +44,8 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+ifeq ($(CONFIG_RISCV_SBI), y)
+obj-$(CONFIG_SMP) += cpu_ops_sbi.o
+endif
 
 clean:
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
new file mode 100644
index 000000000000..9bdb60e0a4df
--- /dev/null
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HSM extension and cpu_ops implementation.
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <asm/sbi.h>
+#include <asm/smp.h>
+
+static int sbi_hsm_hart_stop(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STOP, 0, 0, 0, 0, 0, 0);
+
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return 0;
+}
+
+static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
+		       unsigned long priv)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_START,
+			      hartid, saddr, priv, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return 0;
+}
+
+static int sbi_hsm_hart_get_status(unsigned long hartid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STATUS,
+			      hartid, 0, 0, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return ret.value;
+}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index cd0f68aeac70..45ad49269f2c 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -47,7 +47,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 }
 EXPORT_SYMBOL(sbi_ecall);
 
-static int sbi_err_map_linux_errno(int err)
+int sbi_err_map_linux_errno(int err)
 {
 	switch (err) {
 	case SBI_SUCCESS:
@@ -64,6 +64,7 @@ static int sbi_err_map_linux_errno(int err)
 		return -ENOTSUPP;
 	};
 }
+EXPORT_SYMBOL(sbi_err_map_linux_errno);
 
 #ifdef CONFIG_RISCV_SBI_V01
 /**
-- 
2.24.0

