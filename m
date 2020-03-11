Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59680C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A74D2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmneJE/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgCKTvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:51:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39700 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbgCKTvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:51:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id s2so1757679pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bEbLn60MatMY03Vz8TeE0dyBSEdNX1ebEYntbweJuus=;
        b=kmneJE/E/emo/Td6UCnKU/32NDvRw/nBoZicVqzuxBCWpm5iG8fX02sFQBI0JvB3+J
         aqHGUFrXMVFIn6B8JgGNHHQj/rdtI+g/cgqFZiH5mloGj1OHyBnTjoA9VumS3J5wRE1Q
         WEwWrbo/RBVh3B2ko8HDeuFYcziESr7cZl+8nRI/wVqVRd904yac66ZYjZWCLn17i+31
         +gKjNbkoQJ4wthQTQ7uKLN6ht8ZcSRQaQSvaYi5RcuYNkP4+fxT+RUKxOPo9XoqCdeCJ
         3W6hblO2KQdXVy0mcu9wi+9NST0m55Hjm+NeANKDMATlMN6Q+AOZEZrRh8tFtpOgLH+C
         NeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bEbLn60MatMY03Vz8TeE0dyBSEdNX1ebEYntbweJuus=;
        b=jN2r4e031/7PcRuqaapcSzKGQm2Zn+foLVcxHZefJ7zNwmDCBFgeQEKniKNSNqZXmV
         D++ykEKryeqpxETK8+fWoVb+0VeY8iXa9K9dZa0ODk+bROkmeIoYL2w8xZB7ClH59fz0
         yX9qW6QbB3789V2wjSojtzMFSNqHsW+uI/5L0yMkEjBy/l18SyFA/qMOrBLM60TITiOO
         edFTVWND9czXKKJeMyZdah55Wd4mqMiZYYTLmuMNRPmkXu+eWPqAxEPNXysznQv1BRF0
         iNsmuRQx/HXvwsj1Bx3ZI7WH5gItL+VON/A0QiMDEVGOVByF39zN/KAchYUt3wzyUlz5
         SmYQ==
X-Gm-Message-State: ANhLgQ0PdmmkjllhWSrRAeepYd/cpEBHy65mpongLqu4r91LVRohe4/r
        IHWIDYq8xe6o08cTHuuzfab2ew==
X-Google-Smtp-Source: ADFU+vvGMdQQLQxm0XcO/IMv0j89hOM1EAvpHbUo1Jp3dwwCwmeE7+Eohjtm5Si4J6N350GGvOyM7w==
X-Received: by 2002:a63:8343:: with SMTP id h64mr4182670pge.73.1583956272565;
        Wed, 11 Mar 2020 12:51:12 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a3sm29260287pfi.161.2020.03.11.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:51:11 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:51:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
In-Reply-To: <54d56b12-3f75-1382-cc12-a8e63e24ce1f@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.2003111248250.171292@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com> <20200310221938.GF8447@dhcp22.suse.cz> <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com> <54d56b12-3f75-1382-cc12-a8e63e24ce1f@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Tetsuo Handa wrote:

> > The patch certainly prevents unnecessary oom kills when there is a pending 
> > victim that uncharges its memory between invoking the oom killer and 
> > finding MMF_OOM_SKIP in the list of eligible tasks and its much more 
> > common on systems with limited cpu cores.
> 
> I think that it is dump_header() which currently spends much time (due to
> synchronous printing) enough to make "the second memcg oom kill shows usage
> is >40MB below its limit of 100MB" happen. Shouldn't we call dump_header()
> and then do the last check and end with "but did not kill anybody" message?
> 

Lol, I actually did that for internal testing as well :)  I didn't like 
how it spammed the kernel log and then basically said "just kidding, 
nothing was oom killed."

But if you think this would helpful I can propose it as v2.
---
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            |  2 +-
 mm/oom_kill.c              | 14 +++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

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
@@ -934,7 +934,6 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	mmdrop(mm);
 	put_task_struct(victim);
 }
-#undef K
 
 /*
  * Kill provided task unless it's secured by setting
@@ -982,6 +981,18 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 */
 	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
 
+	/* One last check: do we *really* need to kill? */
+	if (is_memcg_oom(oc)) {
+		unsigned long margin = mem_cgroup_margin(oc->memcg);
+
+		if (unlikely(margin >= (1 << oc->order))) {
+			put_task_struct(victim);
+			pr_info("Suppressed oom kill, %lukB of memory can be charged\n",
+				K(margin));
+			return;
+		}
+	}
+
 	__oom_kill_process(victim, message);
 
 	/*
@@ -994,6 +1005,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 		mem_cgroup_put(oom_group);
 	}
 }
+#undef K
 
 /*
  * Determines whether the kernel must panic because of the panic_on_oom sysctl.
