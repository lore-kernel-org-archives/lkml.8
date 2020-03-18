Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11FCC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903FF20738
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtFxEZ1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCRAzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:55:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41090 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCRAzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:55:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so12909858pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 17:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qphLOGPy6WLUhsMBU8OI5qX+iRggfdyjjgGh+WRxITI=;
        b=qtFxEZ1tEfyhjZbnoCgzo2KFHjYTGvQbyI/GaTKSU/Rff4KJsQ3n3ogaKhZYh+UU88
         AusapqIj2GUNUFJoPJvxqaYi8WKTm4c9VO18BCUGX7VzJzO6v88iKiICtlFqw4iSHLo5
         p6A/a+RGqkDmGWMKMx4PhEL9AS6cZWgx5RASsxA4t1sy5RqohSdkI1UgLgcDHhNFuhui
         oaIjooqb3AEk5y0ndnpsid5p/iZVw3Huvm/sVmpiyFIKvuaqk0OK/Gc7IxzuETa9FQm2
         z/xqK794DS3AzyQd/eHNnSqp390NKPpgEYSfgumfPKn6pYfuKTB+ac73FnBBIrMUgxNh
         04YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qphLOGPy6WLUhsMBU8OI5qX+iRggfdyjjgGh+WRxITI=;
        b=bJEldjwajksLWGDEqIjKoz1wKug943FwVzPEVDX6M1CRfl+C6QSt0R4Y7s5CNEBD8T
         XzcJhOyflE90YJZWfpwBt0kxhew0R4QlHtq9vn+nyNA8x2vRD6L7iC6/GvGeVpx6Y2/x
         XJXmaaBCtd/cE/w2YYnAqr6LJfVi1GPwIsDtCZmwcqbXTWT5J84t/NGPVC1JOw6dtweB
         QiNMLrynNJk+WKTDJytfGY1q2w6PVFtXLPt5fvXLWZcAxbGKxqGKt28M3+VmBM0qLabZ
         RDCdCf3GyocZEmUC/NjJqOYaZ6ATp1hRc1se76RLIF5ZJDevv4rmhsDerAQSTnbYayrG
         QsIQ==
X-Gm-Message-State: ANhLgQ0hs50UDt9lyQo69H18++J5+w1LPRA51csi1ceC2DFEK8Hr3Cdm
        p6CocfjS+V6vxMfqMyjBxSNivw==
X-Google-Smtp-Source: ADFU+vtQBxL6vqci+cLw5OR67p9pEL3mCFri1YWV9aBD17Zc1SJcCsF17VbdCUEKbvqTUVZBiXjPuw==
X-Received: by 2002:aa7:8d82:: with SMTP id i2mr1596369pfr.179.1584492905844;
        Tue, 17 Mar 2020 17:55:05 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 25sm4276095pfn.190.2020.03.17.17.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:55:05 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:55:04 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch v2] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003171752030.115787@chino.kir.corp.google.com>
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com> <202003170318.02H3IpSx047471@www262.sakura.ne.jp> <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
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

Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Tested-by: Robert Kolchmeyer <rkolchmeyer@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/memcontrol.c | 2 ++
 mm/page_alloc.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1576,6 +1576,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	ret = should_force_charge() || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
+	if (!fatal_signal_pending(current))
+		schedule_timeout_killable(1);
 	return ret;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3861,6 +3861,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	}
 out:
 	mutex_unlock(&oom_lock);
+	if (!fatal_signal_pending(current))
+		schedule_timeout_killable(1);
 	return page;
 }
 
