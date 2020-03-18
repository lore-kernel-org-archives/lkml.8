Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697CCC43332
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFA320752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bE09/JGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCRWD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:03:56 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34018 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCRWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:03:56 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so1495966pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/9wz4K28LAWC7NirvuQCrwV33aT0PUzfnYZQGhi4Hlc=;
        b=bE09/JGP0nFOJl4NicZNT+WoaEKdFXVjqoww2q1tQvXBWFpwHjwf50C6qjErbHugg5
         mNEaNVdU5zBo8sTuRUOrgZ10KUXDa2n+MGdGLt6YEh6baJASYuafJBmTTsV1tD4skcbi
         ZZ8U/ee3X1jUtfAhmeJDYrPuh2NfK/sqYTMvJOw87fMMoFUe+DGBkZdb10AENNq8wKNZ
         azFOLtmMIHIrOkgDtvadTDUS1xxbRN4LlSQSDBbNKy0Zyfcg1YkU7f9E1+QLBOdPEzER
         nd1mBwQxyZX9RUteWlQmgT07J6uGqkZXd8t0Br1DN2nmIXXlD5t3Q0NUd4qB4YwwQHUM
         Z/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/9wz4K28LAWC7NirvuQCrwV33aT0PUzfnYZQGhi4Hlc=;
        b=lEfLafRIJLIUYIktU9MFrQBS0AnzYEXmxL2NXW+e5YiYvTUPgspMH2Q2joafdjQ9rI
         rrBoWRBuSOaGxM+0qkuBa2oyiJvPmlh4l5EM4NQ802yfvs5G7WZDXMNYhumrWnzGL2AJ
         N+2yrvsbGO8bhpaAZnvcP5Kl1EdKpDHgXkWSJ/oxM0Iyc+qFjTER8YVcoDtYTrFxAqDO
         LpcoJyZdVRf/nksdfMOHx+oRW7i19Px60WYwmw6MKqLF6sdiGDRVJdb/mV3z3F2sku6H
         FK1rdCmI96pGS75arOiqPkXjtvFiHCtSOcMduPl/BtgD5AREwEiFeQF9SGn1GndOftjt
         ObDA==
X-Gm-Message-State: ANhLgQ1jyIV1R9/fz6D1tc/2unS5THjPLmyHVNBc9Kf1UZHskXCMEbHF
        sLrJ613bYEk1D0kiOgKB1olDYg==
X-Google-Smtp-Source: ADFU+vtBDkETxunCzgQe26kKBNILm+Derdb82r7qdm8kcwr3IpF+l9jrHQVfBJm5/faZTii+JYfafA==
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr349975pjo.108.1584569034517;
        Wed, 18 Mar 2020 15:03:54 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r14sm2687pjj.48.2020.03.18.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:03:53 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:03:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch v3] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <alpine.DEB.2.21.2003181437270.70237@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003181458100.70237@chino.kir.corp.google.com>
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com> <202003170318.02H3IpSx047471@www262.sakura.ne.jp> <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003171752030.115787@chino.kir.corp.google.com> <20200318094219.GE21362@dhcp22.suse.cz> <alpine.DEB.2.21.2003181437270.70237@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process is oom killed as a result of memcg limits and the victim
is waiting to exit, nothing ends up actually yielding the processor back
to the victim on UP systems with preemption disabled.  Instead, the
charging process simply loops in memcg reclaim and eventually soft
lockups.

For example, on an UP system with a memcg limited to 100MB, if three 
processes each charge 40MB of heap with swap disabled, one of the charging 
processes can loop endlessly trying to charge memory which starves the oom 
victim.

Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, 
anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB 
oom_score_adj:0
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
RIP: 0010:shrink_lruvec+0x4e9/0xa40
...
Call Trace:
 shrink_node+0x40d/0x7d0
 do_try_to_free_pages+0x13f/0x470
 try_to_free_mem_cgroup_pages+0x16d/0x230
 try_charge+0x247/0xac0
 mem_cgroup_try_charge+0x10a/0x220
 mem_cgroup_try_charge_delay+0x1e/0x40
 handle_mm_fault+0xdf2/0x15f0
 do_user_addr_fault+0x21f/0x420
 page_fault+0x2f/0x40

Make sure that once the oom killer has been called that we forcibly yield 
if current is not the chosen victim regardless of priority to allow for 
memory freeing.  The same situation can theoretically occur in the page 
allocator, so do this after dropping oom_lock there as well.

We used to have a short sleep after oom killing, but commit 9bfe5ded054b
("mm, oom: remove sleep from under oom_lock") removed it because sleeping
inside the oom_lock is dangerous. This patch restores the sleep outside of
the lock.

Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Tested-by: Robert Kolchmeyer <rkolchmeyer@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/memcontrol.c | 6 ++++++
 mm/page_alloc.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1576,6 +1576,12 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	ret = should_force_charge() || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
+        /*
+         * Give a killed process a good chance to exit before trying to
+         * charge memory again.
+         */
+	if (ret)
+		schedule_timeout_killable(1);
 	return ret;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3861,6 +3861,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	}
 out:
 	mutex_unlock(&oom_lock);
+	/*
+	 * Give a killed process a good chance to exit before trying to
+	 * allocate memory again.
+	 */
+	if (*did_some_progress)
+		schedule_timeout_killable(1);
 	return page;
 }
 
