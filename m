Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647CEC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4624656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NjPkNW86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgB0Oru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:47:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46307 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgB0Orr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:47:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so3284562qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhqtzi/UsQ+Kabj9geEXwZi4h5VMx6dCe1mfKXvTrM8=;
        b=NjPkNW86o3xQ+Ej2l0NtIwryDFrygqw5hU7ZHKTlvplTpg7blfRjw0k6SNrSWhMQrO
         tKIIWQ2ayUKmP19R5XxBetNxTCZFx9yIiqrN69ICHe+bD13p29LeJA3/U/a3dfYBZlaT
         JjWJp+L7+AQIM1uWPDq5y6jJHeIrIaiY18wS+idfeiFjnRQfgio0I9gXxzp59WTGoePz
         nMB149FEVb+1ImG39UVG2fmwhhTH+AAygvxDVtfizUPTGrx6i68N7M/tTijA727rcZbf
         qitO48xaZIMbzymL4MgDtS1vlD25CZKybAKk0GZSWXbCzCp/0XhQS5u6VUXwpNYEMzuH
         DmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhqtzi/UsQ+Kabj9geEXwZi4h5VMx6dCe1mfKXvTrM8=;
        b=B9A/vhvOtOylbg1dc0AahGTySeSpMCeL6/+bDY32Xq7D2kI/4z0dv9JbO821sza9lk
         oVUwwxBv3vlkUmrUO3P9NTxdgLz/v4cf8HzVPzCdhZ5cTpsM+i/9kzXm2DiqnTNFv8w8
         OVubl7jm0d0h2jNa4kWi82cQMG+TeZfVFFYRY1pjVW94yBJFKt7A3tz30PJRsZmkLQPi
         0rYrlEx3eqpYVVsaPl8D9PjWsJQ8D6aBZ+QgOB7opVDYFbjKPRFdfqA7GMex08FwGZ7o
         QI0vJ8WgrhcXT00fHHnWqPmevJvLPgo+lkjwlNm76xA6SS1Etw8jX7KUnD0YUjG2MBcS
         XTJA==
X-Gm-Message-State: APjAAAXx4HWuqNeWbl8uIAKbZoMnFSo8484Tc8H7Ys2Jt2PuU6Lroqgn
        efQXXzEXvQFBGhZchxG4md+TvQ==
X-Google-Smtp-Source: APXvYqwSvJ2ITk5aaaJGrAFwvrfQSnzqTnrKAFs8KAEdIG3bEtPQ30NnHe1wn/PsRVBGhb1ip3uO4A==
X-Received: by 2002:a37:9a8b:: with SMTP id c133mr5516622qke.132.1582814864835;
        Thu, 27 Feb 2020 06:47:44 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n23sm3178957qtr.87.2020.02.27.06.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 06:47:44 -0800 (PST)
Message-ID: <1582814862.7365.135.camel@lca.pw>
Subject: Re: suspicious RCU due to "Prefer using an idle CPU as a migration
 target instead of comparing tasks"
From:   Qian Cai <cai@lca.pw>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        paulmck@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Feb 2020 09:47:42 -0500
In-Reply-To: <1582812549.7365.134.camel@lca.pw>
References: <1582812549.7365.134.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 09:09 -0500, Qian Cai wrote:
> The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
> migration target instead of comparing tasks") introduced a boot warning,

This?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a61d83ea2930..ca780cd1eae2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1607,7 +1607,9 @@ static void update_numa_stats(struct task_numa_env *env,
                        if (ns->idle_cpu == -1)
                                ns->idle_cpu = cpu;
 
+                       rcu_read_lock();
                        idle_core = numa_idle_core(idle_core, cpu);
+                       rcu_read_unlock();
                }
        }

> 
> [   86.520534][    T1] WARNING: suspicious RCU usage
> [   86.520540][    T1] 5.6.0-rc3-next-20200227 #7 Not tainted
> [   86.520545][    T1] -----------------------------
> [   86.520551][    T1] kernel/sched/fair.c:5914 suspicious
> rcu_dereference_check() usage!
> [   86.520555][    T1] 
> [   86.520555][    T1] other info that might help us debug this:
> [   86.520555][    T1] 
> [   86.520561][    T1] 
> [   86.520561][    T1] rcu_scheduler_active = 2, debug_locks = 1
> [   86.520567][    T1] 1 lock held by systemd/1:
> [   86.520571][    T1]  #0: ffff8887f4b14848 (&mm->mmap_sem#2){++++}, at:
> do_page_fault+0x1d2/0x998
> [   86.520594][    T1] 
> [   86.520594][    T1] stack backtrace:
> [   86.520602][    T1] CPU: 1 PID: 1 Comm: systemd Not tainted 5.6.0-rc3-next-
> 20200227 #7
> [   86.520607][    T1] Hardware name: HP ProLiant XL450 Gen9 Server/ProLiant
> XL450 Gen9 Server, BIOS U21 05/05/2016
> [   86.520612][    T1] Call Trace:
> [   86.520623][    T1]  dump_stack+0xa0/0xea
> [   86.520634][    T1]  lockdep_rcu_suspicious+0x102/0x10b
> lockdep_rcu_suspicious at kernel/locking/lockdep.c:5648
> [   86.520641][    T1]  update_numa_stats+0x577/0x710
> test_idle_cores at kernel/sched/fair.c:5914
> (inlined by) numa_idle_core at kernel/sched/fair.c:1565
> (inlined by) update_numa_stats at kernel/sched/fair.c:1610
> [   86.520649][    T1]  ? rcu_read_lock_held+0xac/0xc0
> [   86.520657][    T1]  task_numa_migrate+0x4aa/0xdb0
> [   86.520664][    T1]  ? task_numa_find_cpu+0x1010/0x1010
> [   86.520677][    T1]  ? migrate_pages+0x29c/0x17c0
> [   86.520683][    T1]  task_numa_fault+0x607/0xd90
> [   86.520691][    T1]  ? task_numa_free+0x230/0x230
> [   86.520698][    T1]  ? __kasan_check_read+0x11/0x20
> [   86.520704][    T1]  ? do_raw_spin_unlock+0xa8/0x140
> [   86.520712][    T1]  do_numa_page+0x33f/0x450
> [   86.520720][    T1]  __handle_mm_fault+0xb81/0xb90
> [   86.520727][    T1]  ? copy_page_range+0x420/0x420
> [   86.520736][    T1]  handle_mm_fault+0xdc/0x2e0
> [   86.520742][    T1]  do_page_fault+0x2c7/0x998
> [   86.520752][    T1]  page_fault+0x34/0x40
> [   86.520758][    T1] RIP: 0033:0x7f95faf63c53
> [   86.520766][    T1] Code: 00 41 00 3d 00 00 41 00 74 3d 48 8d 05 d6 5a 2d 00
> 8b 00 85 c0 75 61 b8 01 01 00 00 0f 05 48 3d 00 f0 ff ff 0f 87 a5 00 00 00 <48>
> 8b 4c 24 38 64 48 33 0c 25 28 00 00 00 0f 85 ba 00 00 00 48 83
> [   86.520771][    T1] RSP: 002b:00007ffdda737790 EFLAGS: 00010207
> [   86.520778][    T1] RAX: 0000000000000024 RBX: 0000562a594b9fd0 RCX:
> 00007f95faf63c47
> [   86.520783][    T1] RDX: 00000000002a0000 RSI: 0000562a594b9fd1 RDI:
> 0000000000000023
> [   86.520788][    T1] RBP: 00007ffdda7379c0 R08: 00007f95fc734e30 R09:
> 00007ffdda737d60
> [   86.520793][    T1] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000562a59459fb4
> [   86.520798][    T1] R13: 0000000000000000 R14: 0000000000000001 R15:
> 0000000000000000
