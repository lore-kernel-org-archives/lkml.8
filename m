Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E754C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDDB2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCWI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:28:29 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:50384 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbgCWI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:28:28 -0400
Received: from localhost.localdomain (unknown [120.229.255.251])
        by app1 (Coremail) with SMTP id XAUFCgCXnysVc3he4fcPAA--.9465S3;
        Mon, 23 Mar 2020 16:28:08 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Adit Ranadive <aditr@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishnu DASA <vdasa@vmware.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
Date:   Mon, 23 Mar 2020 16:22:33 +0800
Message-Id: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgCXnysVc3he4fcPAA--.9465S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF45WFy7ZF1rWr4kXrWfGrg_yoW3uFX_Ca
        43XrsrArWjyasI93Z2yr13ZryFy398urn7Zw17trW5JFy7Z3Z3Gr1jqrnxXFyrurZrCF9r
        Jw1DAFW0vw17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NULL vmci_ctx object may pass to vmci_ctx_put() from its callers.
Add a NULL check to prevent NULL pointer dereference.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 16695366ec92..2f4963ab51bd 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -494,7 +494,8 @@ static void ctx_free_ctx(struct kref *kref)
  */
 void vmci_ctx_put(struct vmci_ctx *context)
 {
-	kref_put(&context->kref, ctx_free_ctx);
+	if (context)
+		kref_put(&context->kref, ctx_free_ctx);
 }
 
 /*
-- 
2.7.4

