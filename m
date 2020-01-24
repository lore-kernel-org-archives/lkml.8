Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B6C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 00:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84832087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 00:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPl7gh8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgAXA2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:28:16 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:53659 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgAXA2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 19:28:15 -0500
Received: by mail-pj1-f74.google.com with SMTP id h6so281387pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=VU8CQ+7tyXbPwB/MfaFBdifEaVqhq62dpGmbsWu0ENU=;
        b=bPl7gh8jS00llZ0eEa5mBTSGBetDXcShMlyhJLdfpefUnpZ4/ASQH4TFHzq6w0bwgr
         a+8TeHx0y61jYbl32SSTqHF+HC5AzWKMYz16cUfBqhaE2X3HtWsrAiFW3TVdMnqqwxDj
         IxASL4pfRS02MeAXjRwXIx/FUu9EMMd+LMSs1K9zOM3NXRRp5lxSGUJ0YfjVpq0ax/pZ
         PxPBdIYMbxbHE0AmXI3t7kb/Ax4NPD7g+xyVeQZlpqNiTJDyD/gllFgfFt7jwAosw6bE
         dNngBFdgmw2moyQXaPORh8iKsz8X65v2tv0ozUG1tH6A2TfXpu0E40GhM5dLCtd4EV9U
         BZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=VU8CQ+7tyXbPwB/MfaFBdifEaVqhq62dpGmbsWu0ENU=;
        b=IYSa9Og8/lSVUOlWPPOHUxSJtC5Qj0Fc6xCZ4S9WEtZrmX3dHzL3Cq75KUK6T1cmEC
         zh62LGTtOJd6QWUhCXvBbZ5ez0G/FkrobiaxSlL7VeuLef4O+oJ2Z0JGF35mJwzC/D30
         YYoWLERS9wJQyzJjZHR8IKS4TvZmpD7PctN0J7RlrXDUX4WFA3eSGF3Rw6+ruXeNWCGg
         VYIwrpAXapIDGq7sMmO7NVaLK8Aq1ymN+VwuWRX/BbXSTxRASQavoRg8ZjqsfH6wjAkJ
         ybtSdqQteH/YpGKcXw0C3UrTYoiGQHcHE7WRb/C+PmulnPmVsQkn4QpsuReEJtJQ7Duk
         LeMg==
X-Gm-Message-State: APjAAAVFf8TIzn2Wjj9rmm5aJnXQxBZW4TQziptnSnsbxNO/NrsxF0yu
        Vm5r0ghFW5F5LuLheMzP0y+KkeU=
X-Google-Smtp-Source: APXvYqxaSVsQSLY8QyXbQBvfUJ/MbO43rzgkc6v2uQ5AApjHQbopWAl2epZN67D8EUiyjsGwL5wmaPs=
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr1118542pgb.315.1579825694644;
 Thu, 23 Jan 2020 16:28:14 -0800 (PST)
Date:   Thu, 23 Jan 2020 16:28:10 -0800
Message-Id: <20200124002811.228334-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        chris.redpath@arm.com, qperret@google.com,
        Wei Wang <wvw@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently iowait doesn't distinguish background/foreground tasks.
This may not be a problem in servers but could impact devices that
are more sensitive on energy consumption. [1]
In Android world, we have seen many cases where device run to high and
inefficient frequency unnecessarily when running some background task
which are interacting I/O.

The ultimate goal is to only apply iowait boost on UX related tasks and
leave the rest for EAS scheduler for better efficiency.

This patch limits iowait boost for tasks which are associated with boost
signal from user land. On Android specifically, those are foreground or
top app tasks.

[1] ANDROID discussion:
https://android-review.googlesource.com/c/kernel/common/+/1215695

Signed-off-by: Wei Wang <wvw@google.com>
---
 kernel/sched/fair.c  |  4 +++-
 kernel/sched/sched.h | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba749f579714..221c0fbcea0e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5220,8 +5220,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
 	 * passed.
+	 * If CONFIG_ENERGY_MODEL and CONFIG_UCLAMP_TASK are both configured,
+	 * only boost for tasks set with non-null min-clamp.
 	 */
-	if (p->in_iowait)
+	if (iowait_boosted(p))
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..a13d49d835ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2341,6 +2341,18 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 }
 #endif /* CONFIG_UCLAMP_TASK */
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK)
+static inline bool iowait_boosted(struct task_struct *p)
+{
+	return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;
+}
+#else /* defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK) */
+static inline bool iowait_boosted(struct task_struct *p)
+{
+	return p->in_iowait;
+}
+#endif /* defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK) */
+
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
 #  define arch_scale_freq_invariant()	true
-- 
2.25.0.341.g760bfbb309-goog

