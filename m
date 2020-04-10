Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC8AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC61A20692
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJBuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:50:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgDJBuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:50:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71FFCA70CB02D760F021;
        Fri, 10 Apr 2020 09:50:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Apr 2020 09:50:30 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
        <james.morse@arm.com>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: panic on synchronous external abort in kernel context
Date:   Fri, 10 Apr 2020 09:52:45 +0800
Message-ID: <20200410015245.23230-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should panic even panic_on_oops is not set, when we can't recover
from synchronous external abort in kernel context.

Othervise, there are two issues:
1) fallback to do_exit() in exception context, cause this core hung up.
   do_sea()
   -> arm64_notify_die
      -> die
         -> do_exit
2) errors may propagated.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Cc: Xiaofei Tan <tanxiaofei@huawei.com>
---
 arch/arm64/include/asm/esr.h | 12 ++++++++++++
 arch/arm64/kernel/traps.c    |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index cb29253ae86b..acfc71c6d148 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -326,6 +326,18 @@ static inline bool esr_is_data_abort(u32 esr)
 	return ec == ESR_ELx_EC_DABT_LOW || ec == ESR_ELx_EC_DABT_CUR;
 }
 
+static inline bool esr_is_inst_abort(u32 esr)
+{
+	const u32 ec = ESR_ELx_EC(esr);
+
+	return ec == ESR_ELx_EC_IABT_LOW || ec == ESR_ELx_EC_IABT_CUR;
+}
+
+static inline bool esr_is_ext_abort(u32 esr)
+{
+	return esr_is_data_abort(esr) || esr_is_inst_abort(esr);
+}
+
 const char *esr_get_class_string(u32 esr);
 #endif /* __ASSEMBLY */
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..08f7f7688d5b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -202,6 +202,8 @@ void die(const char *str, struct pt_regs *regs, int err)
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception");
+	if (esr_is_ext_abort(err))
+		panic("Synchronous external abort in kernel context");
 
 	raw_spin_unlock_irqrestore(&die_lock, flags);
 
-- 
2.20.1

