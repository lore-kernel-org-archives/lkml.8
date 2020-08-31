Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFBC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8842068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897678;
	bh=Box1kWeVc7CIfTF+goBNe9r4zO+NG/VypJiI1JWoJqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1Ta+KC/hd0Fz/+H73leYiIlAz9xEuN8RiLtYMFYNaup1RthXuQTFa1C2oVxqq8wT
	 /OIyZjMlOsOTGvV7wSn2EeB5OXJ6J6/xilbZYQxdC8NVLbCTFCCwZ/PjjfFHQXPdcb
	 5cJrj6bgAhRLofiikaBLoP5uvT7MVtTNf1ZlHI9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgHaSOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgHaSOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:14:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 579A2214DB;
        Mon, 31 Aug 2020 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897659;
        bh=Box1kWeVc7CIfTF+goBNe9r4zO+NG/VypJiI1JWoJqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht1rfbEdnBdWZjF7Fvey/mpqC+FPpcoC/qwMHWOfcEfg6TM+oYuWymsa3clnxIaiK
         +tWYAn+XGSaVdxh9SBxyzicp02RKjaN5Q1euZY72Rj9nxIUDu26cOV+zVcRw9qcbJ/
         a39+UmDzS/hK+sj1YvxMbdH+S60qHevV7dvcP3uQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH tip/core/rcu 4/4] smp: Make symbol 'csd_bug_count' static
Date:   Mon, 31 Aug 2020 11:14:17 -0700
Message-Id: <20200831181417.1378-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181356.GA1224@paulmck-ThinkPad-P72>
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

kernel/smp.c:107:10: warning:
 symbol 'csd_bug_count' was not declared. Should it be static?

Because variable is not used outside of smp.c, this commit marks it
static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index c5d3188..b25383d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -106,7 +106,7 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
 
 #define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
-atomic_t csd_bug_count = ATOMIC_INIT(0);
+static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
 static void csd_lock_record(call_single_data_t *csd)
-- 
2.9.5

