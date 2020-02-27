Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B45C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BE92469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WDmJP96E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgB0QrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:47:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34411 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgB0QrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:47:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id 11so3810301qkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFn2dzdS2FONUrtgtAocmy3qKEh+mb3t1Wul9aBP/fI=;
        b=WDmJP96EQVcL8LJyJE/a41VStf4qspaoE7H9+nZSkzGvEdwLYyWqSFvURaHwIr4Z8u
         kDTi5ACa/pcbMhYy81M/9X16jSHKvj6fQXoZYGAv8owgSfKB3mlKkxsYhaQfdyhwBRZV
         CuVcWB6aINNTCnPWOjO9R/MPqfeXsMNPKh+y4FnUKTsF5zl6+DNYY59sd2nBwlMCWBg/
         5Alua+1+6UMRenkyzIlTSEhAp4heYuSfgqsmrdbiPLuSuJkrYlKVwSG1S9U5nNgl5+pV
         0EUPlw/Vkjt2CqApD7Ri391p5px1467YRubBcNzpQrnF6CSnHVvbRbKw62x87zxCuXyy
         PLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFn2dzdS2FONUrtgtAocmy3qKEh+mb3t1Wul9aBP/fI=;
        b=XjWN6qLvaxT+6aDuuw6RsBTyt8bQEyA8MwNqArEvB190pRnsN+zfj9H3ZvHehZjuWu
         YlyxZNJh0zVGlL/RqS1MwDAJHKsKmdt/Os0/0Sy8DHx9kWbYN2wiau/cvgraNe+0ehz9
         4ijXh275Nqa/wy9+3mveqIsTGT/w/9zHpZv6CyqbRThiMp6PTAIKWDF+XxxXKwjDUwDB
         sVry3XmvC25F/T/DXRmGR7QVhJ1/Ubg9PncKMWv17iwTR8Hh2QmAXxmZHhqfeXg+EIVb
         FWLtlrDm+eYN9Z/pjmoZjUQgO8nQsmDyXsprhlOrRTYwJ3uZZE8bJRgfxNXW7gj7tE8b
         6ldw==
X-Gm-Message-State: APjAAAURc1MV8uaR1vfgEVwrrg6h40+2bNDcBl4wqLWzBBsc2i3SI/Ch
        nShp7PNzZa32Vi1scYmKuMFdSQ==
X-Google-Smtp-Source: APXvYqz74THGToU1Rx7EshKvZFEUw5h9FBVUg06LD9Pjv8JkbrqoOplHjRQgxrVLeL9YYUMKKO6MBw==
X-Received: by 2002:a05:620a:2282:: with SMTP id o2mr116001qkh.304.1582822026494;
        Thu, 27 Feb 2020 08:47:06 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h9sm3380125qtq.61.2020.02.27.08.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:47:05 -0800 (PST)
Message-ID: <1582822024.7365.139.camel@lca.pw>
Subject: Re: suspicious RCU due to "Prefer using an idle CPU as a migration
 target instead of comparing tasks"
From:   Qian Cai <cai@lca.pw>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Feb 2020 11:47:04 -0500
In-Reply-To: <1582821327.7365.137.camel@lca.pw>
References: <1582812549.7365.134.camel@lca.pw>
         <1582814862.7365.135.camel@lca.pw> <jhjimjsvyoe.mognet@arm.com>
         <1582821327.7365.137.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 11:35 -0500, Qian Cai wrote:
> On Thu, 2020-02-27 at 15:26 +0000, Valentin Schneider wrote:
> > On Thu, Feb 27 2020, Qian Cai wrote:
> > 
> > > On Thu, 2020-02-27 at 09:09 -0500, Qian Cai wrote:
> > > > The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
> > > > migration target instead of comparing tasks") introduced a boot warning,
> > > 
> > > This?
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index a61d83ea2930..ca780cd1eae2 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1607,7 +1607,9 @@ static void update_numa_stats(struct task_numa_env *env,
> > > if (ns->idle_cpu == -1)
> > > ns->idle_cpu = cpu;
> > > 
> > > +rcu_read_lock();
> > > idle_core = numa_idle_core(idle_core, cpu);
> > > +rcu_read_unlock();
> > > }
> > > }
> > > 
> > 
> > 
> > Hmph right, we have
> > numa_idle_core()->test_idle_cores()->rcu_dereference().
> > 
> > Dunno if it's preferable to wrap the entirety of update_numa_stats() or
> > if that fine-grained read-side section is ok.
> 
> I could not come up with a better fine-grained one than this.

Correction -- this one,

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a61d83ea2930..580d56f9c10b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1561,10 +1561,18 @@ numa_type numa_classify(unsigned int imbalance_pct,
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
+	bool idle;
+
 	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	    idle_core >= 0)
 		return idle_core;
 
+	rcu_read_lock();
+	idle = test_idle_cores(cpu, false);
+	rcu_read_unlock();
+
+	if (!idle)
+		return idle_core;
 	/*
 	 * Prefer cores instead of packing HT siblings
 	 * and triggering future load balancing.
