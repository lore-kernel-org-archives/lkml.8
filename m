Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9643EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7394E21D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDRL1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 07:27:11 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:7731 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:27:10 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 2E18E6640D6;
        Sat, 18 Apr 2020 19:27:07 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     gxt@pku.edu.cn, linux-kernel@vger.kernel.org, wangqing@vivo.com
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] unicore32: fixed backtrace when task running on another cpu
Date:   Sat, 18 Apr 2020 19:27:02 +0800
Message-Id: <1587209222-5951-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VDTkNCQkJMSUJKTk1PQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBw6Hgw*CTg1Eg0wKlEhURcx
        ExowCzpVSlVKTkNMSUtCSUlMSEpDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUpOT0g3Bg++
X-HM-Tid: 0a718d0acbee9373kuws2e18e6640d6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP when the task is currently running on another CPU,
in this case, current stack is printed instead of the task.
Also, thread_saved_fp() is the last time the task was switched out,
we should not use too.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/unicore32/kernel/traps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index e24f672..3b9472a 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -151,6 +151,9 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	} else if (tsk != current) {
 		fp = thread_saved_fp(tsk);
 		mode = 0x10;
+	} else if (task_curr(tsk))
+		printk("tsk is running on another CPU, not trace!\n");
+		fp = 0;
 	} else {
 		asm("mov %0, fp" : "=r" (fp) : : "cc");
 		mode = 0x10;
-- 
2.7.4

