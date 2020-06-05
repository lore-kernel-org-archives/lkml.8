Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6D9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E1E2065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ki1mWzQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgFENWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFENW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:22:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64EBC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:22:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so9726151wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Wd49qJJfphbkQd0zc5Sg32oNGChg1bIC5PBSadN6hM=;
        b=Ki1mWzQUC6JcLvWE/8DkDtIIdjhYtPuZOCRYcToxv8LWR6pRb4lGurJyBIOkPuorTR
         Bsi8zComYX+iO1sRCteKaKGKyFUrV6SX6hjPxqnASoH0k1DXUJXEKyc3HGx2ueMIE2qb
         uywx8D1qZVnXSdiKKLdwXvNKLMNFIU9Bu8JHD5HLksHo/nlTZTGo8jsu+Ah8CXeONqWi
         hvJhuA1ziakt2ACYLpIUSNY1wMXCd97jniit9A4a3KTg0apr2Lf0h7yCyZefMoacoO2C
         9q2d2vkvbL2DdSsZcTpTomTgUQeXMVAHG5xrferfVgiIys/NkQQv1KlcJViHEKl8u1a0
         kXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Wd49qJJfphbkQd0zc5Sg32oNGChg1bIC5PBSadN6hM=;
        b=dZ3/2jhWKvQ8UFu4s8+bC8Q9nJ7EX16su47DkKFGeA+5yVjtb3D1son6ve7D5kcub5
         Sr4i4MLNFj0ws0VP7QTWE2Up43gBRYilVke2oFsxUH0unwtbZWkLtOLyk4ZKrl6PcF58
         JeelVsCzMVhtIYeYFffnylKmCM5mrUOmmkON9BGptpwpCZTkDfgP9Vluo0HTtJo3HHgQ
         Uz+kkXdBAR40NNBxdn8D2dIRMI8hg7qfjQaWu99M2frhAvgDrPXAFDv1XSK32pp3fufX
         Ztax8/fv1CFcHqgfGO4mtzIIZ4fUIzlw20kMm3Ve9qeh73WAdN+PICsltSXqxEvL/qkr
         yLcw==
X-Gm-Message-State: AOAM532TWt3GiRrMx6o/o4k1Nk6JVS/p6cUCqDMR1YJ9hukYlEbLgzyN
        3wAknMQPiaFz9Q2qJHBMGMy+0w==
X-Google-Smtp-Source: ABdhPJzpXOyKm+//aW91zcmMraLFE6hXoKeh/4G6ONWrnUgxSkq+Twz2EbRA9faf1wyV0IhllSZGdQ==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr9434014wrq.310.1591363344584;
        Fri, 05 Jun 2020 06:22:24 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 1sm11419211wmz.13.2020.06.05.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:22:24 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [RFC PATCH 2/4] kgdb: Use the kprobe blacklist to limit single stepping
Date:   Fri,  5 Jun 2020 14:21:28 +0100
Message-Id: <20200605132130.1411255-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200605132130.1411255-1-daniel.thompson@linaro.org>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are running in a part of the kernel that dislikes breakpoint
debugging then it is very unlikely to be safe to single step. Add
some safety rails to prevent stepping through anything on the kprobe
blacklist.

As part of this kdb_ss() will no longer set the DOING_SS flags when it
requests a step. This is safe because this flag is already redundant,
returning KDB_CMD_SS is all that is needed to request a step (and this
saves us from having to unset the flag if the safety check fails).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h        |  1 +
 kernel/debug/debug_core.c   | 13 +++++++++++++
 kernel/debug/gdbstub.c      | 10 +++++++++-
 kernel/debug/kdb/kdb_bp.c   |  8 ++------
 kernel/debug/kdb/kdb_main.c | 10 ++++++++--
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index c62d76478adc..93b612d81714 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -213,6 +213,7 @@ extern void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc);
 
 /* Optional functions. */
 extern int kgdb_validate_break_address(unsigned long addr);
+extern int kgdb_validate_single_step_address(unsigned long addr);
 extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
 extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
 
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 81f56d616e04..4a2df4509fe1 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -215,6 +215,18 @@ int __weak kgdb_validate_break_address(unsigned long addr)
 	return err;
 }
 
+int __weak kgdb_validate_single_step_address(unsigned long addr)
+{
+	/*
+	 * Disallow stepping when we are executing code that is marked
+	 * as unsuitable for kprobing.
+	 */
+	if (within_kprobe_blacklist(addr))
+		return -EINVAL;
+
+	return 0;
+}
+
 unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
@@ -1192,6 +1204,7 @@ noinline void kgdb_breakpoint(void)
 	atomic_dec(&kgdb_setting_breakpoint);
 }
 EXPORT_SYMBOL_GPL(kgdb_breakpoint);
+NOKPROBE_SYMBOL(kgdb_breakpoint);
 
 static int __init opt_kgdb_wait(char *str)
 {
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 4b280fc7dd67..beb73a61a16d 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1041,8 +1041,16 @@ int gdb_serial_stub(struct kgdb_state *ks)
 			if (tmp == 0)
 				break;
 			/* Fall through - on tmp < 0 */
-		case 'c': /* Continue packet */
 		case 's': /* Single step packet */
+			error = kgdb_validate_single_step_address(
+					kgdb_arch_pc(ks->ex_vector,
+						     ks->linux_regs));
+			if (error != 0) {
+				error_packet(remcom_out_buffer, error);
+				break;
+			}
+			fallthrough;
+		case 'c': /* Continue packet */
 			if (kgdb_contthread && kgdb_contthread != current) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index ec4940146612..4853c413f579 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -507,18 +507,14 @@ static int kdb_bc(int argc, const char **argv)
  *	None.
  * Remarks:
  *
- *	Set the arch specific option to trigger a debug trap after the next
- *	instruction.
+ *	KDB_CMD_SS is a command that our caller acts on to effect the step.
  */
 
 static int kdb_ss(int argc, const char **argv)
 {
 	if (argc != 0)
 		return KDB_ARGCOUNT;
-	/*
-	 * Set trace flag and go.
-	 */
-	KDB_STATE_SET(DOING_SS);
+
 	return KDB_CMD_SS;
 }
 
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index ec190569f690..4b277c066f48 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1189,7 +1189,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		     kdb_dbtrap_t db_result)
 {
 	char *cmdbuf;
-	int diag;
+	int diag, res;
 	struct task_struct *kdb_current =
 		kdb_curr_task(raw_smp_processor_id());
 
@@ -1346,10 +1346,16 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		}
 		if (diag == KDB_CMD_GO
 		 || diag == KDB_CMD_CPU
-		 || diag == KDB_CMD_SS
 		 || diag == KDB_CMD_KGDB)
 			break;
 
+		if (diag == KDB_CMD_SS) {
+			res = kgdb_validate_single_step_address(instruction_pointer(regs));
+			if (res == 0)
+				break;
+			diag = res;
+		}
+
 		if (diag)
 			kdb_cmderror(diag);
 	}
-- 
2.25.4

