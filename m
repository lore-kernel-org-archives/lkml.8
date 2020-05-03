Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4590C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECF02075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 08:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeUBmeun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgECIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 04:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgECIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 04:34:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4CC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 01:34:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so5536578plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xq7ysiUAMlkm14lElNH6IyCeagfNa1BwRcWSHMY71S4=;
        b=WeUBmeunP+BaYBQxSQXOd3ZqZuEHFwx/eav9KYkB6G+cFG3yYWvzN9vlYFQAzLYNo8
         cR6czhtUjgQ3opUhVVKLx1ZL8mOG443lxlYfeuiTyhoklpHQ2Zn0mDrfrvGxClJ4UUk4
         q5pIwtyXKoU1mLbVgYh37z6V+LQmjbREiN8AztXlw8GCyzGg0GenaciXp9R7neU0XsF3
         fHx/4v9clzIEry9iM5v06A8pH7QiCQkMb6K16ucVyHPPLaLbPEwCbnImzmY1+J13f55q
         6xhnPZ4p5EgcGuWU+YtHnu7GXYXDmxH9YqKwF/QRorFKAoqefPIHG40VYNMnfJziiy8e
         JBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xq7ysiUAMlkm14lElNH6IyCeagfNa1BwRcWSHMY71S4=;
        b=q2UN7sWIx3ovWiIGHj8tB6is4CyFMpk0FHdZwuatVqbCNBp/V64cwy3wSpkVphFqBJ
         FZs1koOdZLEkEK3Ql6aqRHDnEwVNRkJ9q7V4WWojPzWFuiX+WKXTqtJTn1vE9Jcgu7m2
         JjB0yQd31OUQVH2TVEeZFDlOE8xowEN8xCpi6Xc3+x8dtPXXvlGpccPihJEUGcPRv+KK
         cYjGXMdKqopKWyqB37weibalUCF4ydPQLenExjeW2izWIFSKms2EdOcCozqyekRRea9j
         QAN8h9Lsc1vQ+gcca7HiTKn1Djhe726axSQqgHYMr9yElk7btTCPJ6AJSdHZ6d4DAlGW
         JBpg==
X-Gm-Message-State: AGi0Pubd/NUeBpBSeLd+WYaB5AUlyTfsTh5flyNJq1jOmDXIHe9z9rNP
        8JS+ez7oGmWujVh2LNDOhN5ltrG7
X-Google-Smtp-Source: APiQypJO3EZy7/S0wFJJ/b4666fqBIXDHaAH5LcWvHXW2i3iJu3ria6PZYZPmYVTY2Sa/Rd4BpqGkg==
X-Received: by 2002:a17:90a:2b8f:: with SMTP id u15mr10739930pjd.137.1588494852331;
        Sun, 03 May 2020 01:34:12 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id p62sm6002043pfb.93.2020.05.03.01.34.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 01:34:11 -0700 (PDT)
Date:   Sun, 3 May 2020 16:34:07 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, iwtbavbm@gmail.com
Subject: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")
During idle load balance, this_cpu(ilb) do load balance for the other
idle CPUs, also gather the earliest (nohz.)next_balance.

Since commit:
  'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'

We update nohz.next_balance like this:

  _nohz_idle_balance() {
      for_each_cpu(nohz.idle_cpus_mask) {
    	  rebalance_domains() {
      	      update nohz.next_balance <-- compare and update
    	  }
      }
      rebalance_domains(this_cpu) {
	  update nohz.next_balance <-- compare and update
      }
      update nohz.next_balance <-- unconditionally update
  }

For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
cpu5. After the above loop we could gather the earliest *next_balance*
among {cpu2,3,8}, then rebalance_domains(this_cpu) update
nohz.next_balance with this_rq->next_balance, but finally overwrite
nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
we may end up with not getting the earliest next_balance.

Since we can gather all the updated rq->next_balance, including this_cpu,
in _nohz_idle_balance(), it's safe to remove the extra lines in
rebalance_domains() which are originally intended for this_cpu. And
finally the updating only happen in _nohz_idle_balance().

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..1d0cf33fefad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9943,22 +9943,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	 * When the cpu is attached to null domain for ex, it will not be
 	 * updated.
 	 */
-	if (likely(update_next_balance)) {
+	if (likely(update_next_balance))
 		rq->next_balance = next_balance;
-
-#ifdef CONFIG_NO_HZ_COMMON
-		/*
-		 * If this CPU has been elected to perform the nohz idle
-		 * balance. Other idle CPUs have already rebalanced with
-		 * nohz_idle_balance() and nohz.next_balance has been
-		 * updated accordingly. This CPU is now running the idle load
-		 * balance for itself and we need to update the
-		 * nohz.next_balance accordingly.
-		 */
-		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
-			nohz.next_balance = rq->next_balance;
-#endif
-	}
 }
 
 static inline int on_null_domain(struct rq *rq)
@@ -10321,9 +10307,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		has_blocked_load |= this_rq->has_blocked_load;
 	}
 
-	if (flags & NOHZ_BALANCE_KICK)
+	if (flags & NOHZ_BALANCE_KICK) {
 		rebalance_domains(this_rq, CPU_IDLE);
 
+		if (time_after(next_balance, this_rq->next_balance)) {
+			next_balance = this_rq->next_balance;
+			update_next_balance = 1;
+		}
+	}
+
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
-- 
2.17.1

