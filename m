Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4747EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2652320748
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHGKUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:20:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbgHGKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:20:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4114BBCFA8119EC0047F;
        Fri,  7 Aug 2020 18:20:04 +0800 (CST)
Received: from linux_supse12sp4_workstation.huawei.com (10.67.189.177) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 7 Aug 2020 18:19:56 +0800
From:   chenzefeng <chenzefeng2@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <christophe.leroy@c-s.fr>,
        <tglx@linutronix.de>, <chenzefeng2@huawei.com>,
        <bigeasy@linutronix.de>, <npiggin@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <zengweilin@huawei.com>
Subject: [PATCH] powerpc:entry_32: correct the path and function name in the comment
Date:   Fri, 7 Aug 2020 18:19:56 +0800
Message-ID: <20200807101956.67454-1-chenzefeng2@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment for file's directory and function name changed.

Fixes: facd04a904ff ("powerpc: convert to copy_thread_tls")
Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in arch/powerpc.")

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
---
 arch/powerpc/kernel/entry_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8420abd4ea1c..9937593d3a33 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -696,8 +696,8 @@ handle_dabr_fault:
  * to the "_switch" path.  If you change this , you'll have to
  * change the fork code also.
  *
- * The code which creates the new task context is in 'copy_thread'
- * in arch/ppc/kernel/process.c
+ * The code which creates the new task context is in 'copy_thread_tls'
+ * in arch/powerpc/kernel/process.c
  */
 _GLOBAL(_switch)
 	stwu	r1,-INT_FRAME_SIZE(r1)
-- 
2.12.3

