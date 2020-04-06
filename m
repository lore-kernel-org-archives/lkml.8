Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06983C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87EC2490F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgDFQC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:02:59 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:54559 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDFQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:02:59 -0400
Received: from muedsl-82-207-238-172.citykom.de ([82.207.238.172] helo=x1c.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
        id 1jLUD8-0000BG-Gb; Mon, 06 Apr 2020 18:02:54 +0200
From:   Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
To:     xiaoyao.li@intel.com
Cc:     bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        nivedita@alum.mit.edu, pbonzini@redhat.com, peterz@infradead.org,
        philipp.eppelt@kernkonzept.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org,
        Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Subject: [PATCH v2 1/1] x86/split_lock: check split lock support on initialization
Date:   Mon,  6 Apr 2020 18:02:47 +0200
Message-Id: <20200406160247.208004-1-benjamin.lamowski@kernkonzept.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406155743.206444-1-benjamin.lamowski@kernkonzept.com>
References: <20200406155743.206444-1-benjamin.lamowski@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the sld setup code is run only if the TEST_CTRL MSR is available,
the current sld initialization code unconditionally resets it even on
systems where this architectural MSR is not available.

This commit introduces a new default sld state sld_unsupported, which is
changed in split_lock_setup() only if sld is available; and checks for
split lock detect support before initializing it.

Fixes: dbaba47085b0c ("x86/split_lock: Rework the initialization flow of split lock detection")
Signed-off-by: Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9a26e972cdea..e6aff24e7168 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -34,17 +34,18 @@
 #endif
 
 enum split_lock_detect_state {
-	sld_off = 0,
+	sld_unsupported = 0,
+	sld_off,
 	sld_warn,
 	sld_fatal,
 };
 
 /*
- * Default to sld_off because most systems do not support split lock detection
- * split_lock_setup() will switch this to sld_warn on systems that support
- * split lock detect, unless there is a command line override.
+ * Default to sld_unsupported because most systems do not support split lock
+ * detection. split_lock_setup() will switch this to sld_warn on systems that
+ * support split lock detect, unless there is a command line override.
  */
-static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
+static enum split_lock_detect_state sld_state __ro_after_init = sld_unsupported;
 static u64 msr_test_ctrl_cache __ro_after_init;
 
 /*
@@ -1063,7 +1064,8 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
-	split_lock_verify_msr(sld_state != sld_off);
+	if (sld_state != sld_unsupported)
+		split_lock_verify_msr(sld_state != sld_off);
 }
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
-- 
2.25.1

