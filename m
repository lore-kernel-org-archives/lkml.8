Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADFFC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208A2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slxenHyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCJVzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:55:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46322 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:55:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id w12so50209pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=NcbwCXxUWslIYcC/IMvtiJA7e1LVai6+WIY+FfCtsI4=;
        b=slxenHycS43HvwTp9eEVzF+wztjB8QJFeQRxOro/81jxR6ZI4o6+LapbIyCB8fRRLR
         KPEIY41GPcjQtfWMgJCB7ByvRSqed1vi7SuyNTZNjachFGHzpq0SQTd420m76wNe4eeQ
         oQrLii1+vos27HHOvdTTamlWHA4TKmXCxLw5dCEhrNKBypII22+RT46KwfQsChwkFiN9
         iepDf+3sdOvSL9QvwpyZmxg0YM6umlPgMpcV6CIKdqeqTEBtYg4lGXSQtZu2zlRipmiv
         eb6Vv6YD+CNCqy4Pco2nmd3bcgii1HrJPO2796aUFhj9lJ8Lr8wE/oQ2TeADCDj9drFr
         TPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=NcbwCXxUWslIYcC/IMvtiJA7e1LVai6+WIY+FfCtsI4=;
        b=psY6Efck0sqCx3U9rpADG97x4MeFrvenja7GYFDLrCv9hBlu+UD3nzjonZRSLjFQWj
         2EXr4ZbFRIWGRyyWuTt+h0b6p4aMbnv+R2PryusyUjm8HIdSMp+4VL7cpVVk3+1qHsG7
         4yT+loj6dS7ZnS9SNgqv9ONr9O/D2BaHTXteAg9dybJC4YDecLE+Rcil9V5VVyhjDhLS
         NhYTwaMSBkBZOMBBBXdtM2MnnRozmWWL2UYw4BIOxVJeR6Z6OqN4anXf2yflCZj0EUc3
         9wN+qGnXXduEGAMcmjd6SHOU0saFb3XhY0Ezhr/OrDCtP1IxfU73XeJzciSUniwkd/xS
         7T8A==
X-Gm-Message-State: ANhLgQ0uftlz2BrUIiNxZx95Mc867fOa9d6XWINzThZOzzsujiV+Csto
        ZRiXVjUP0p6vvG3wo57iTZtlhA==
X-Google-Smtp-Source: ADFU+vugU09Jze4dd0S5K5zWLDJJTy74D0sfUDWhtwZo6IZIK7WLHp/D87fNZyQUWPZ2k+5vqd3JQw==
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr7plq.343.1583877352222;
        Tue, 10 Mar 2020 14:55:52 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u14sm30006734pgg.67.2020.03.10.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:55:51 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:55:50 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
Message-ID: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Killing a user process as a result of hitting memcg limits is a serious
decision that is unfortunately needed only when no forward progress in
reclaiming memory can be made.

Deciding the appropriate oom victim can take a sufficient amount of time
that allows another process that is exiting to actually uncharge to the
same memcg hierarchy and prevent unnecessarily killing user processes.

An example is to prevent *multiple* unnecessary oom kills on a system
with two cores where the oom kill occurs when there is an abundance of
free memory available:

Memory cgroup out of memory: Killed process 628 (repro) total-vm:41944kB, anon-rss:40888kB, file-rss:496kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:0
<immediately after>
repro invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
CPU: 1 PID: 629 Comm: repro Not tainted 5.6.0-rc5+ #130
Call Trace:
 dump_stack+0x78/0xb6
 dump_header+0x55/0x240
 oom_kill_process+0xc5/0x170
 out_of_memory+0x305/0x4a0
 try_charge+0x77b/0xac0
 mem_cgroup_try_charge+0x10a/0x220
 mem_cgroup_try_charge_delay+0x1e/0x40
 handle_mm_fault+0xdf2/0x15f0
 do_user_addr_fault+0x21f/0x420
 async_page_fault+0x2f/0x40
memory: usage 61336kB, limit 102400kB, failcnt 74

Notice the second memcg oom kill shows usage is >40MB below its limit of
100MB but a process is still unnecessarily killed because the decision has
already been made to oom kill by calling out_of_memory() before the
initial victim had a chance to uncharge its memory.

Make a last minute check to determine if an oom kill is really needed to
prevent unnecessary oom killing.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            |  2 +-
 mm/oom_kill.c              | 16 +++++++++++++---
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -445,6 +445,8 @@ void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 int mem_cgroup_scan_tasks(struct mem_cgroup *,
 			  int (*)(struct task_struct *, void *), void *);
 
+unsigned long mem_cgroup_margin(struct mem_cgroup *memcg);
+
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	if (mem_cgroup_disabled())
@@ -945,6 +947,11 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return 0;
 }
 
+static inline unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1286,7 +1286,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
  * Returns the maximum amount of memory @mem can be charged with, in
  * pages.
  */
-static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
+unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
 {
 	unsigned long margin = 0;
 	unsigned long count;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -972,9 +972,6 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	task_unlock(victim);
 
-	if (__ratelimit(&oom_rs))
-		dump_header(oc, victim);
-
 	/*
 	 * Do we need to kill the entire memory cgroup?
 	 * Or even one of the ancestor memory cgroups?
@@ -982,6 +979,19 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 */
 	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
 
+	if (is_memcg_oom(oc)) {
+		cond_resched();
+
+		/* One last check: do we *really* need to kill? */
+		if (mem_cgroup_margin(oc->memcg) >= (1 << oc->order)) {
+			put_task_struct(victim);
+			return;
+		}
+	}
+
+	if (__ratelimit(&oom_rs))
+		dump_header(oc, victim);
+
 	__oom_kill_process(victim, message);
 
 	/*
