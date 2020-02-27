Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA6AC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B8B246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W7eppzcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgB0Qfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:35:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42093 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgB0Qfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:35:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id o28so3705311qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EcJEm7tEH8INLM7JNMv3OyedRCfQV//rBTfRfYkoCE=;
        b=W7eppzcT8/LhiMK5N8+vjgRpaO0XeAO/RoUdqO9b4Bh7Ty9nmIksCIMUyGs82yGA5L
         TEAMbosWcRnAMXM7MEjnQW8ATs3l/KsrJyiLNMYm89ueEmHCGEAUBQHVpt7+MF7hHKVx
         D9ffAR01uxLGN5A5C71BWk8MosCttKh/xzU+nasKMPNUGlQfgReYD5YcEguO6LIBYwwf
         MSkni/phAkzEjCcezYn5bGr+uWYRXG/i8mf/OWpRUlVHp1elQtm4TO2iUpBDxx62TPiv
         oQBkHdlIMx8jCHBfzuINVmblNBWHD2lPqmveO7m2iM+3z0C+j+HkYWmaUtD/fjtNgkDi
         D3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EcJEm7tEH8INLM7JNMv3OyedRCfQV//rBTfRfYkoCE=;
        b=nj6Aex0Q5uWKCiluXyGlB0tmJjpwW8XnYZsle8nEnrHNw6zUqhr+PW6Paug31i1xa8
         MXGL5FRiPHmsZuWTufczM30vMD6PTi+FOyDpEV+PjDgYP8AN6/U5uVNfHbFSbPQ6G5uG
         6j15wvtVHNxqDlj3FKo0HSTUNFL5e9uc37YZP6pxS+xPkw2w/25hS4sFDAqaDJMdfKvU
         6jCXU/WabM3m09JI2NDqW/euW9LeepQilv7hGflGec6lcri7QJfhBqwmKZ9rsyNVhX5L
         wF2VQrjT+HSdmZLCR2bVsQQl6GUIKfR7wIT5JV4UQjUj1Boxk+A4IQaygJHdMlT9vXQZ
         aGcQ==
X-Gm-Message-State: APjAAAWamFHM2/KN6Opy98GD4A7UaKvrcMzo0xX/QoVP1gRIUbhz8N0g
        n+TZb9VKSXaaSnELhbgWOztrYA==
X-Google-Smtp-Source: APXvYqwQykSPMiBQziGbNSR9rIUFQ2tNyCmHwFJRHfv7N+R1zOTB0fKNcoEBL4OThpHA6RJlb/FHGw==
X-Received: by 2002:a05:620a:957:: with SMTP id w23mr6823627qkw.473.1582821329986;
        Thu, 27 Feb 2020 08:35:29 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j127sm3392559qkc.36.2020.02.27.08.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:35:29 -0800 (PST)
Message-ID: <1582821327.7365.137.camel@lca.pw>
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
Date:   Thu, 27 Feb 2020 11:35:27 -0500
In-Reply-To: <jhjimjsvyoe.mognet@arm.com>
References: <1582812549.7365.134.camel@lca.pw>
         <1582814862.7365.135.camel@lca.pw> <jhjimjsvyoe.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 15:26 +0000, Valentin Schneider wrote:
> On Thu, Feb 27 2020, Qian Cai wrote:
> 
> > On Thu, 2020-02-27 at 09:09 -0500, Qian Cai wrote:
> > > The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
> > > migration target instead of comparing tasks") introduced a boot warning,
> > 
> > This?
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a61d83ea2930..ca780cd1eae2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1607,7 +1607,9 @@ static void update_numa_stats(struct task_numa_env *env,
> > if (ns->idle_cpu == -1)
> > ns->idle_cpu = cpu;
> > 
> > +rcu_read_lock();
> > idle_core = numa_idle_core(idle_core, cpu);
> > +rcu_read_unlock();
> > }
> > }
> > 
> 
> 
> Hmph right, we have
> numa_idle_core()->test_idle_cores()->rcu_dereference().
> 
> Dunno if it's preferable to wrap the entirety of update_numa_stats() or
> if that fine-grained read-side section is ok.

I could not come up with a better fine-grained one than this.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a61d83ea2930..980d03fa157c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1562,9 +1562,16 @@ static inline int numa_idle_core(int idle_core, int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
-		return idle_core;
+	    idle_core >= 0) {
+		bool idle;
 
+		rcu_read_lock();
+		idle = test_idle_cores(cpu, false);
+		rcu_read_unlock();
+
+		if (!idle)
+			return idle_core;
+	}
 	/*
 	 * Prefer cores instead of packing HT siblings
 	 * and triggering future load balancing.
