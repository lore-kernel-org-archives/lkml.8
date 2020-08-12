Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9744FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723C6206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHLBNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:13:55 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43344 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgHLBNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:13:55 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj9xDQjNfbbgHAA--.4179S2;
        Wed, 12 Aug 2020 09:13:41 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] tools/objtool: Fix unnecessary jumps
Date:   Wed, 12 Aug 2020 09:13:39 +0800
Message-Id: <1597194819-7384-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxj9xDQjNfbbgHAA--.4179S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13Gry3Ww4kJw47Zr1fWFg_yoW8CF47pF
        4ak34UCryYqFWrG3y8Ja1fGF9F9rs7WrWxWrW7ua4xZr4Yvws0qw1ayF1ayFZ3K3yfGa15
        XFWUWFW3CF1j9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_KwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j00PfUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously cleanup() function was called under the out label for both
fatal errors (ret < 0) and warnings.  Now that cleanup() function is
removed, the out label is no longer required. Remove it and return
immediately for the fatal errors with ret as return code and 0 for
warnings.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
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

