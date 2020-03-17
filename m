Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D91C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106FE20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgCQGcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:32:41 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:37198 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgCQGcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:32:41 -0400
Received: from localhost.localdomain (unknown [120.229.255.71])
        by app2 (Coremail) with SMTP id XQUFCgCnrzvabnBermxTBQ--.3835S3;
        Tue, 17 Mar 2020 14:31:57 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vishnu DASA <vdasa@vmware.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: [PATCH] VMCI: Fix NULL pointer dereference on context ptr
Date:   Tue, 17 Mar 2020 14:29:57 +0800
Message-Id: <1584426607-89366-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgCnrzvabnBermxTBQ--.3835S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur15JF1fAF1rArWfGw17Jrb_yoW8tFW7pr
        ZxWFWxAF18JF42va9Fy3WjvF15Ww1FqFyjk34Dt345Z34fAFyDWr1UGa4Yvrn3XFyrZr12
        vr1Ut3W3uan0kF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refcount wrapper function vmci_ctx_get() may return NULL
context ptr. Thus, we need to add a NULL pointer check
before its dereference.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c    |  2 ++
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 17 +++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

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
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 8531ae781195..2ecb22d08692 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -1575,11 +1575,14 @@ static int qp_broker_attach(struct qp_broker_entry *entry,
 		 */
 
 		create_context = vmci_ctx_get(entry->create_id);
-		supports_host_qp = vmci_ctx_supports_host_qp(create_context);
-		vmci_ctx_put(create_context);
+		if (!create_context) {
+			supports_host_qp =
+				vmci_ctx_supports_host_qp(create_context);
+			vmci_ctx_put(create_context);
 
-		if (!supports_host_qp)
-			return VMCI_ERROR_INVALID_RESOURCE;
+			if (!supports_host_qp)
+				return VMCI_ERROR_INVALID_RESOURCE;
+		}
 	}
 
 	if ((entry->qp.flags & ~VMCI_QP_ASYMM) != (flags & ~VMCI_QP_ASYMM_PEER))
@@ -1808,7 +1811,8 @@ static int qp_alloc_host_work(struct vmci_handle *handle,
 		pr_devel("queue pair broker failed to alloc (result=%d)\n",
 			 result);
 	}
-	vmci_ctx_put(context);
+	if (context)
+		vmci_ctx_put(context);
 	return result;
 }
 
@@ -1859,7 +1863,8 @@ static int qp_detatch_host_work(struct vmci_handle handle)
 
 	result = vmci_qp_broker_detach(handle, context);
 
-	vmci_ctx_put(context);
+	if (context)
+		vmci_ctx_put(context);
 	return result;
 }
 
-- 
2.7.4

