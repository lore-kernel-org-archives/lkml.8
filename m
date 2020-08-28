Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77E6208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="K7ZC8PYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH1Twp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH1Tw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F8C061233
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p25so685576qkp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tn4ongR5av/ZVksbmHeScnC6bsRHerZuDHUu1t78kZY=;
        b=K7ZC8PYgdyJsp9vx1G1VzeOo4pDPiuxp49AN0q4A9Z/h0ynAX7a5G73iXZGZ5EvbJ/
         r0yLmFhlYEbUKQvGDT6BOGUQSxDDjcvaIsrK+a9uIn679ujNLWqprksgl7Y+ohWxFB95
         Ws19jbfPGlD8u04/JjhEsaZ+ZZm/XWfPPQb1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tn4ongR5av/ZVksbmHeScnC6bsRHerZuDHUu1t78kZY=;
        b=Ly9SFCCerl/0CSPHmSqOZZDtttWMFRSg2OD2tn3IhTatAyzkaXPa3yRn7w7WbXe+Ne
         7fd/wkl8mLREKJMbpotKP9U6sDz4G9JOesPZhqO3cFgH/51L3eJR+TdYY0tpEWgBbaXA
         fau21H85UUGtZFsq3lqhKQbMmPd7BP+grSkKh9HP/WdN9EG4TWlit+DOchfrQNe69FP/
         2Xr8UKO6O5vdstZnr/sUWt/wIttXWFoYcrR7ImeRRsdIkYa9QQm+elvl7L+3DQjTqWX2
         IizVwZdyBscCBEjCynxGsLKHP/XhRC3fsXfCWqTEib2ppe42DB7VfZ8pNIYvO4Y9PtOJ
         iJOg==
X-Gm-Message-State: AOAM531D/gl+z8dgoUMdlOn5udFtjnNFHr+KQwf/i2gf2Ft5UD+zRelB
        kiY2wALQtNnFUvNJ3WMNy3C4ng==
X-Google-Smtp-Source: ABdhPJxoxTni9y7YzCWhmakfmB2guPilz+HQVoO9DgbcA/BRVyt51TOWLiXtMxgZpS8AgbAo8ThrlQ==
X-Received: by 2002:a37:7207:: with SMTP id n7mr702654qkc.375.1598644345080;
        Fri, 28 Aug 2020 12:52:25 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:24 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 04/23] sched/fair: Add a few assertions
Date:   Fri, 28 Aug 2020 15:51:05 -0400
Message-Id: <094f561e8d059b365c34bc3c7d9674b304ebffd8.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
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
index 1a1bf726264a..af8c40191a19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6223,6 +6223,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	}
 
 symmetric:
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
@@ -6664,8 +6669,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6676,6 +6679,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
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

