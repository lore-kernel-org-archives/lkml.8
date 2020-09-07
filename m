Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C3421473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iNNkv4mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIGJsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:48:54 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:37625 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgIGJsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:48:54 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 9200af26;
        Mon, 7 Sep 2020 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=cQIv0FN/1r4pyfX0hFoYLi9BTW0=; b=iNNkv4mXUOxg5vAaCvKe
        17VL2v+r80MJLDFm3WP9OYei28jMEkzDag0NSDB87wJuc3IIr1u6qoCQKluWu+84
        ILk+6euSGq5OtIxPexizPLhCe/EoWl/dy2WBOhvGdPfydC8GnmJt/NTUHDaypBVF
        72+V5x2PBeIXdoAj83SSQCJJ+IXecBi94rGZ4c5HMdAg5PKE5glcv+ULaa8i57o9
        DOF4LcWOgqEYwYmfnb0G3dQB2hndt6PNdUqgPEuGHjF/XEoBcqvzY4fajqOX60AO
        06j4rkQlSBwdLDQZ6T1yIHwrMxzdnQpdQQta6qdZVG7lmhgPWW3LyFGp1m62wZo3
        nw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01f808c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Sep 2020 09:20:07 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Date:   Mon,  7 Sep 2020 11:48:43 +0200
Message-Id: <20200907094843.1949-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Popular tools, like intel-undervolt, use MSR 0x150 to control the CPU
voltage offset. In fact, evidently the intel_turbo_max_3 driver in-tree
also uses this MSR. So, teach the kernel's MSR list about this, so that
intel-undervolt and other such tools don't spew warnings to dmesg, while
unifying the constant used throughout the kernel.

Fixes: a7e1f67ed29f ("x86/msr: Filter MSR writes")
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/msr-index.h         | 2 ++
 arch/x86/kernel/msr.c                    | 5 ++++-
 drivers/platform/x86/intel_turbo_max_3.c | 6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4f39a8..0bcb3604d0e2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -132,6 +132,8 @@
 #define MSR_IA32_MCU_OPT_CTRL		0x00000123
 #define RNGDS_MITG_DIS			BIT(0)
 
+#define MSR_IA32_OC_MAILBOX		0x00000150
+
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
 #define MSR_IA32_SYSENTER_EIP		0x00000176
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 49dcfb85e773..64f6200681e3 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -86,8 +86,11 @@ static int filter_write(u32 reg)
 	default: break;
 	}
 
-	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
+	switch (reg) {
+	case MSR_IA32_ENERGY_PERF_BIAS:
+	case MSR_IA32_OC_MAILBOX:
 		return 0;
+	}
 
 	pr_err_ratelimited("Write to unrecognized MSR 0x%x by %s\n"
 			   "Please report to x86@kernel.org\n",
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel_turbo_max_3.c
index 892140b62898..991cdbc3295b 100644
--- a/drivers/platform/x86/intel_turbo_max_3.c
+++ b/drivers/platform/x86/intel_turbo_max_3.c
@@ -17,8 +17,8 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
 
-#define MSR_OC_MAILBOX			0x150
 #define MSR_OC_MAILBOX_CMD_OFFSET	32
 #define MSR_OC_MAILBOX_RSP_OFFSET	32
 #define MSR_OC_MAILBOX_BUSY_BIT		63
@@ -41,14 +41,14 @@ static int get_oc_core_priority(unsigned int cpu)
 	value = cmd << MSR_OC_MAILBOX_CMD_OFFSET;
 	/* Set the busy bit to indicate OS is trying to issue command */
 	value |=  BIT_ULL(MSR_OC_MAILBOX_BUSY_BIT);
-	ret = wrmsrl_safe(MSR_OC_MAILBOX, value);
+	ret = wrmsrl_safe(MSR_IA32_OC_MAILBOX, value);
 	if (ret) {
 		pr_debug("cpu %d OC mailbox write failed\n", cpu);
 		return ret;
 	}
 
 	for (i = 0; i < OC_MAILBOX_RETRY_COUNT; ++i) {
-		ret = rdmsrl_safe(MSR_OC_MAILBOX, &value);
+		ret = rdmsrl_safe(MSR_IA32_OC_MAILBOX, &value);
 		if (ret) {
 			pr_debug("cpu %d OC mailbox read failed\n", cpu);
 			break;
-- 
2.28.0

