Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E861C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09347206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgFBNKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:10:04 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60794 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgFBNKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:10:00 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2l+T9Zepas8AA--.2541S2;
        Tue, 02 Jun 2020 21:09:18 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 1/2] kernel/panic.c: Make oops_may_print() return bool
Date:   Tue,  2 Jun 2020 21:09:17 +0800
Message-Id: <1591103358-32087-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz2l+T9Zepas8AA--.2541S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4xXF1xtrWUCw18urykXwb_yoWkuFg_Ca
        43Xw18Gw43ArWavw18tw4xZr98tw40qF40va1UXFZrG34qya45tw4rGF98CF48WF1kCr9x
        ZrsIgF9FyrnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5GwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUeuWdUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of oops_may_print() is true or false, so change its type
to reflect that.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/kernel.h | 2 +-
 kernel/panic.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9b7a8d7..69c7fa4 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -322,7 +322,7 @@ void nmi_panic(struct pt_regs *regs, const char *msg);
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
-extern int oops_may_print(void);
+extern bool oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e..064d80f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -490,7 +490,7 @@ static void do_oops_enter_exit(void)
  * Return true if the calling CPU is allowed to print oops-related info.
  * This is a bit racy..
  */
-int oops_may_print(void)
+bool oops_may_print(void)
 {
 	return pause_on_oops_flag == 0;
 }
-- 
2.1.0

