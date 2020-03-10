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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A3C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B729922522
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4tbgodb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCJVjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:39:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36961 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCJVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:39:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id p14so89436pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=vzwzOrISC8AE6Ft8LM/EkNEsA5EmXRG9n4oBptOAC84=;
        b=B4tbgodbmpEw4if6P+g89G1vo8NtdE1LRRFqpf4jl226jISTdzX3Svw0VVSLA8/+Yg
         96cjfZK1I4vhnM3JeLPXB2NI3BtHwOeLYDHQbUmHnxTpr7mzT+95ABi/GxT+ZmxZBeLj
         AUeNP7/DQI0guHcsT+BsZhVY9jHenjA83RyswSovB48KEssZCLYOSKWj2qRSPj48Nacl
         20WfGk9h2ZhBNGF46yFx41faRs5sJYvjhncO3iWFkT6CEDMvHSbs4+tf24mPECaLHe0d
         EUKR1BUR9PIQOobfSAjqPIDG5pAvv5b1LCEsBvQ+oR9V52FJHWBZa6wWOvwwW+jT4UoP
         N0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=vzwzOrISC8AE6Ft8LM/EkNEsA5EmXRG9n4oBptOAC84=;
        b=Y5tPRiK6IQYmXVMGQzpMlRlgYjMgmJmNjMiI9+ZltQeY1ElsjlRX56KEuCM/7d/4r7
         3Mcc+HmwQCSPYBNH960uJbtgTXUxQV3cb6ZtJM/m0I9PsWMC0scAyyZB6cJdTDGvBZJK
         cNISIacZLTETksOwgKv9KgthOsEHMj2V7nhT92GQ9M/CJOvaEX7/wNUnpQCLq2MIRUNO
         UhtiGMEeIz9iUn0ue/v/ZKQPSCinLUnt1h6rmsZfc/XX/KuRbViZ+vCBAt2tOznJ+CM3
         /E5HBSVeCnBOdh6YAcKql0NYno4fgyt+7yLl8uW1t8iPdtynZsW4/F6SENX+6hxOdLHu
         M7cQ==
X-Gm-Message-State: ANhLgQ3KwtRZRMXBhIDv07mgFScf8Iz8wR09w3xKCerm3kM5mxxf8ohl
        7wLJAY8I7O+t3C8o7QbNzmx1cg==
X-Google-Smtp-Source: ADFU+vuI2NxooomqK+7EhwkWpuecOjCyFtdWZeLBT5Dysz/5KuClAiEyVeMPqCHMFXTtTucpEYxUSQ==
X-Received: by 2002:a65:5b49:: with SMTP id y9mr22608048pgr.153.1583876389690;
        Tue, 10 Mar 2020 14:39:49 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m26sm2252920pgc.77.2020.03.10.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:39:49 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:39:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
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

Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
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

Make sure that something ends up actually yielding the processor back to
the victim to allow for memory freeing.  Most appropriate place appears to
be shrink_node_memcgs() where the iteration of all decendant memcgs could
be particularly lengthy.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/vmscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long reclaimed;
 		unsigned long scanned;
 
+		cond_resched();
+
 		switch (mem_cgroup_protected(target_memcg, memcg)) {
 		case MEMCG_PROT_MIN:
 			/*
