Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A00C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6058F206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgENQlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:41:31 -0400
Received: from mail1.windriver.com ([147.11.146.13]:60432 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgENQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:41:31 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 04EGfBWT014068
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 14 May 2020 09:41:11 -0700 (PDT)
Received: from yow-pgortmak-d4.wrs.com (128.224.56.60) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Thu, 14 May 2020 09:41:10 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] timers/nohz: fix implicit dependency on "struct rq"
Date:   Thu, 14 May 2020 12:40:54 -0400
Message-ID: <1589474454-56323-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backports to older v5.x kernels revealed a recently introduced
implicit dependency on struct rq that makes the nohz.h header
no longer stand alone.  This is most easily demonstrated as:

   $ echo '#include <linux/sched/nohz.h>' > init/main.c
   $ echo 'void foo(void) {}' >> init/main.c
   $ make init/main.o
     CC      init/main.o
   In file included from init/main.c:1:0:
   ./include/linux/sched/nohz.h:18:35: warning: ‘struct rq’ declared inside parameter list [enabled by default]
    void calc_load_nohz_remote(struct rq *rq);
                                      ^
   ./include/linux/sched/nohz.h:18:35: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Fixes: ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/sched/nohz.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a5af6b..67a105b3dd82 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -6,6 +6,8 @@
  * This is the interface between the scheduler and nohz/dynticks:
  */
 
+struct rq;
+
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
-- 
1.9.1

