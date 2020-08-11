Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE584206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHKESi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:18:38 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34500 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgHKESh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:18:37 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT98RHDJfjTcHAA--.3497S2;
        Tue, 11 Aug 2020 12:18:26 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] tools/objtool: Fix unnecessary jumps
Date:   Tue, 11 Aug 2020 12:18:25 +0800
Message-Id: <1597119505-8038-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxT98RHDJfjTcHAA--.3497S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxJF4rWF47ZrWfAF1fZwb_yoW8WrWxpF
        sIk34UGryYqFWrG3y8JwsxGF9FkrZ3WrWxWrW7Ca4xZr4Yvws8tw1ayFnIyFWfG3yfGr4U
        XF45GFZxCFnF9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyvb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0U8n5UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to jump to the "out" tag when "ret < 0", just return
directly to "ret".

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 tools/objtool/check.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f..b9bfcb5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2799,19 +2799,19 @@ int check(const char *_objname, bool orc)
 
 	ret = decode_sections(&file);
 	if (ret < 0)
-		goto out;
+		return ret;
 	warnings += ret;
 
 	if (list_empty(&file.insn_list))
-		goto out;
+		return ret;
 
 	if (vmlinux && !validate_dup) {
 		ret = validate_vmlinux_functions(&file);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		warnings += ret;
-		goto out;
+		return 0;
 	}
 
 	if (retpoline) {
@@ -2823,45 +2823,35 @@ int check(const char *_objname, bool orc)
 
 	ret = validate_functions(&file);
 	if (ret < 0)
-		goto out;
+		return ret;
 	warnings += ret;
 
 	ret = validate_unwind_hints(&file, NULL);
 	if (ret < 0)
-		goto out;
+		return ret;
 	warnings += ret;
 
 	if (!warnings) {
 		ret = validate_reachable_instructions(&file);
 		if (ret < 0)
-			goto out;
+			return ret;
 		warnings += ret;
 	}
 
 	if (orc) {
 		ret = create_orc(&file);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		ret = create_orc_sections(&file);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	if (file.elf->changed) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
-			goto out;
-	}
-
-out:
-	if (ret < 0) {
-		/*
-		 *  Fatal error.  The binary is corrupt or otherwise broken in
-		 *  some way, or objtool itself is broken.  Fail the kernel
-		 *  build.
-		 */
-		return ret;
+			return ret;
 	}
 
 	return 0;
-- 
2.1.0

