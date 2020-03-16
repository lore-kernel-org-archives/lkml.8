Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352DFC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB1B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgCPQhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:37:50 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:51684 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732074AbgCPQht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:37:49 -0400
Received: from localhost.localdomain (unknown [61.129.42.58])
        by app1 (Coremail) with SMTP id XAUFCgC3vztNq29eD6P2BA--.11495S3;
        Tue, 17 Mar 2020 00:37:34 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Vishnu DASA <vdasa@vmware.com>, Xin Tan <tanxin.ctf@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: [PATCH] VMCI: Fix potential NULL pointer dereference when acquire a lock
Date:   Tue, 17 Mar 2020 00:36:47 +0800
Message-Id: <1584376610-11979-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgC3vztNq29eD6P2BA--.11495S3
X-Coremail-Antispam: 1UD129KBjvdXoWruFy3Gry8Wr13KF4UZw17GFg_yoWfJrX_C3
        4rZrsrJrW5CF9F9wnFyrnxZr9Yy395ZrnagwnFyrW3JFy7u3WxJr1vqFnxXay3urZrCF9x
        Jr1q9ayIyasFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
        0xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUVWlDUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NULL pointer can be returned by vmci_ctx_get(). Thus add a
corresponding check so that a NULL pointer dereference will
be avoided when acquire a lock in spin_lock.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 16695366ec92..a20878fba374 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -898,6 +898,8 @@ void vmci_ctx_rcv_notifications_release(u32 context_id,
 					bool success)
 {
 	struct vmci_ctx *context = vmci_ctx_get(context_id);
+	if (context == NULL)
+		return;
 
 	spin_lock(&context->lock);
 	if (!success) {
-- 
2.7.4

