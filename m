Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0471C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D212065D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHJEGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:06:19 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41100 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgHJEGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:06:19 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx2MW2xzBfIqoGAA--.995S2;
        Mon, 10 Aug 2020 12:06:14 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tools/objtool: Fix unnecessary jumps
Date:   Mon, 10 Aug 2020 12:06:14 +0800
Message-Id: <1597032374-7936-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx2MW2xzBfIqoGAA--.995S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW7XrWfCr18AFyfCF4xtFb_yoW8Gw18pF
        sak34UGryFgFWrGa4xtanxGF9FkrZ7WrW7Wry7C3W7Zr4Yvws8tw1ayF1ayF4fG3yfGa1U
        XF43WFZrCF12kaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gryl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUs1xRDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to jump to the "out" tag when "ret < 0", just return
directly to "ret".

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 tools/objtool/check.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f..94b166d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2799,7 +2799,7 @@ int check(const char *_objname, bool orc)
 
 	ret = decode_sections(&file);
 	if (ret < 0)
-		goto out;
+		return ret;
 	warnings += ret;
 
 	if (list_empty(&file.insn_list))
@@ -2808,7 +2808,7 @@ int check(const char *_objname, bool orc)
 	if (vmlinux && !validate_dup) {
 		ret = validate_vmlinux_functions(&file);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		warnings += ret;
 		goto out;
@@ -2823,35 +2823,35 @@ int check(const char *_objname, bool orc)
 
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
+			return ret;
 	}
 
 out:
-- 
2.1.0

