Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0629221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHGJpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:45:11 -0400
Received: from mail.loongson.cn ([114.242.206.163]:50028 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbgHGJpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:45:11 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxG+SIIi1fvqkFAA--.1496S2;
        Fri, 07 Aug 2020 17:44:41 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/debug: Fix spelling mistake in debug_core.c
Date:   Fri,  7 Aug 2020 17:44:40 +0800
Message-Id: <1596793480-22559-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9BxG+SIIi1fvqkFAA--.1496S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy5Ar1DGr1kCw4fWF1UGFg_yoWDtFg_Kw
        n2yws5Ca1UJ345Ar4UCw1rXFnY9w4UZFZ8Ar1agrZF9a4Dt34UXwsYqF1kGFWrWrWDXr9x
        Ar9avr4ayr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUID73DUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo: "notifiter" --> "notifier"
	  "overriden" --> "overridden"

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kernel/debug/debug_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b16dbc1..3eeee0a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -80,7 +80,7 @@ static int			exception_level;
 struct kgdb_io		*dbg_io_ops;
 static DEFINE_SPINLOCK(kgdb_registration_lock);
 
-/* Action for the reboot notifiter, a global allow kdb to change it */
+/* Action for the reboot notifier, a global allow kdb to change it */
 static int kgdbreboot;
 /* kgdb console driver is loaded */
 static int kgdb_con_registered;
@@ -163,7 +163,7 @@ early_param("nokgdbroundup", opt_nokgdbroundup);
 
 /*
  * Weak aliases for breakpoint management,
- * can be overriden by architectures when needed:
+ * can be overridden by architectures when needed:
  */
 int __weak kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
-- 
2.1.0

