Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D7CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5067421927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="aNHWx7WM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502354AbgDPOdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441985AbgDPOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:18:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD30C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:18:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i3so1720868pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyOJremCk3EzjpsoU30tfV1XsZhjh2TFfXRegC+y3HU=;
        b=aNHWx7WMCL3pKFz9abn899+tHqiepX+XwwEwwGdmPKekjZeTAnze7RmlacZ/MJneA/
         RNWLU2soROhviQV/QcI3F4TuuhHY//2cY4sYxyWivTrwonrJAd3dkIVV5qQqkEUPJ01y
         HOxl+7u178O+/9Vz+eNoNQ2o/yjoUVK+qdcr784IqnE05VfiYElHZFf4BHJ+c3ACgVtk
         4JStNRBD48DMBlE6Hc6MRo0F7QVeSCoRQ+xILjAXXnARjH7qylOo0M72OnNGphMeKrs7
         WvHGHJKRkuH40YAOEhuu4qtpN9xdm/+uU88yf2Z74/RdnbAu8638q//xy5+LmiWlFPrX
         wsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyOJremCk3EzjpsoU30tfV1XsZhjh2TFfXRegC+y3HU=;
        b=b3jmWlNbI+maMjdLuiX9ZnKkuBQvBNs4EIXWWQn0GWBQg4lndDl8PxKamszlj9YvNx
         mpAUvySwR46rntDswJ/jm1Mzimm0FlmU5L4ho8Zdhu1Ce9a+kiRRzxSlaeCsgQrXa5l2
         4THkf1+6urh6G0+hj5MVgLiK1KWW9VRiACwKj8vcQwm1b4p+Cdn8FiQy7yXSc3Oilbdd
         yMXDZmY20FzSsn1CZbqHfgbyp5dIg3/H7oD6ruSSD4yY1z28n4cHiH8dPzZHK7WbUvBc
         IxnmIOM1S2VeyC11jdp1NrQEJLVObfeEMjHvaVkbowrg8AJibBb3eDzm3cmUb6yGcEX9
         h6gg==
X-Gm-Message-State: AGi0Pub3n6S9ouNnlyTyniklFShxWPKRLx4Azhwe5tQo3fh8/fDnikxo
        YaC4Vb8Rfs/y/oeQd97W6xVBVw==
X-Google-Smtp-Source: APiQypJPiEwkGlvpiMcrn0ZRytjDUeoUJMF2YfxXT7BGQVmAq1Ot1RHWYwnx3DB4fcAV6UPbU/AtqQ==
X-Received: by 2002:a63:1103:: with SMTP id g3mr5762695pgl.206.1587046728061;
        Thu, 16 Apr 2020 07:18:48 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id x16sm3221935pfc.61.2020.04.16.07.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 07:18:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] sched/cpuacct: Fix charge cpuacct.usage_sys incorrently.
Date:   Thu, 16 Apr 2020 22:18:33 +0800
Message-Id: <20200416141833.50663-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user_mode(task_pt_regs(tsk)) always return true for
user thread, and false for kernel thread. So it means that
the cpuacct.usage_sys is the time that kernel thread uses
not the time that thread uses in the kernel mode. We can
use get_irq_regs() instead of task_pt_regs() to fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 6448b0438ffb2..edfc62554648e 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -5,6 +5,7 @@
  * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
  * (balbir@in.ibm.com).
  */
+#include <asm/irq_regs.h>
 #include "sched.h"
 
 /* Time spent by the tasks of the CPU accounting group executing in ... */
@@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
 	int index = CPUACCT_STAT_SYSTEM;
-	struct pt_regs *regs = task_pt_regs(tsk);
+	struct pt_regs *regs = get_irq_regs();
 
 	if (regs && user_mode(regs))
 		index = CPUACCT_STAT_USER;
-- 
2.11.0

