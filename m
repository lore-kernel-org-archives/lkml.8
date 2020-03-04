Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3B62465D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Y0ZI57gA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbgCDRAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42382 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388343AbgCDRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id r6so1871453qtt.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WX34EM5R6q+w0JyseRKh/JKvNCBA83Nyol6s9Rl8Wt0=;
        b=Y0ZI57gAUe6PJAtHNOMJVhMaC/VqGWBK5buecu3VxqU3OrkDD9xK5A2OLDuIdrBPCY
         f4E+O68ku+6btp3hVdAGxzK1B2xahEDUEudkrpLADFHpDHCx8K4baNk/4SgdvIVcRPrc
         IEd1FmO6EBF6UbQTKMUh72L0aF/9Qe8xyKlCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WX34EM5R6q+w0JyseRKh/JKvNCBA83Nyol6s9Rl8Wt0=;
        b=QkfTNPzExoiixF5xj044nCJPRp+WQF+KNjnIRIJrQlJ0zxqgqFWys+w8S5ic/1EMTQ
         5wVuEmAOxgMI8Wad43TYRIvmPRfpMtb1iIfUJ724f5pY5//fHnijLaKtAPey7WoHdUZ5
         SStNL+Zqz+uKmYN/fEp0SBGeMArLdwlSTIu64DEbYij+i1BQJCkrtNbURGM23A1rn/LK
         XvHEdRK1TqN/P9KG5iI5KbmPT/QRavpSpm7fe4Z4C9cGhKe2D8OAZdL8HK61MH+ox8Mi
         YxAKSyfoDBK5UZqXj9HErLjIOh7fJ6+GNXYH57phD3KyM6ky0pAWzP+Jz99X1FBquHvf
         OPbQ==
X-Gm-Message-State: ANhLgQ1jW9VWKoQWGY//TcDMJVFcdudBuL73SfGrST+Y3dDOMlE+AjI0
        S1/ze/vhqmyfY/zdJwFTSJYICA==
X-Google-Smtp-Source: ADFU+vvttfmrN4ddzS4Vivy3RWJmvtM6yMWl52foOVT1dM4PPWLM+fd0qpBQIXw/td2BpyKGsn1ARQ==
X-Received: by 2002:ac8:6f48:: with SMTP id n8mr3341042qtv.295.1583341211209;
        Wed, 04 Mar 2020 09:00:11 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id n8sm14198792qke.37.2020.03.04.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:10 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: [RFC PATCH 04/13] sched/fair: Add a few assertions
Date:   Wed,  4 Mar 2020 16:59:54 +0000
Message-Id: <505107c66d1954c59d151164941ca83e72df981d.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eaaf0c4d9ad..cffc59a8b481 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5886,6 +5886,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
@@ -6332,8 +6337,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6344,6 +6347,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
 
-- 
2.17.1

