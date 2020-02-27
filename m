Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51645C3F365
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A29421D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RSuMg1/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgB0O1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:27:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33735 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbgB0OJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:09:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so2364430qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=9sHNYCMRsxADkGSjVbCT6b025lDyO8Q/yZNoNrxhi5s=;
        b=RSuMg1/H+0UdYXCSPMsmAGiOUBV3MXkGthzkVQDTWgjVxl6YN6fCSIV0V2nB+fxBa+
         gNyiQwi8HCsVh/0m6Gx0LcxFLfQFhkgTJ2wX9DF5maw1UoV8073jWnbmvOEeVrWDvp+D
         Vipno+VAnEz6xE2CFFzymN7AmRns2MQNnOIN6hv/bLOtVSH83Gw2ROeOujhiSbLcoxJ9
         Dm/Z1M1oien6Td7ZJdHUFAzctD4veB7FPAUgEhLV5UceqpFE/H8jh1Pb9sfuNtrptlGQ
         kXyNsTi4IIr1ja92yWrwpcN4QEVxbHJQK6BoCXZC5cXbbcqpzUDk9zz+zpjLQcZkQJ4n
         9pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=9sHNYCMRsxADkGSjVbCT6b025lDyO8Q/yZNoNrxhi5s=;
        b=k9SF/JNeYu0PrBG558U6l5nQxEfgj0YYshkecz93aICdnUaey4Sq592STXR+N0rtSh
         CUAUI0c+Ky/fMdQmI7dW4UyL7fv7fDdE2GCrcmKiPOhpCaEXsVJ7DzlLTQOdCCbx6Qbh
         HD6NQzGVbhDaEsb4yroGIZLheL4PQ4WgetWHOqWcBB2XBT9vN9NvoEqYTZunvhuvIxBx
         ZzFCUqQ61LW9WugnXJEq0+NY3p8w7xLUjHAPnenrlUmh+EfgmNrwY4zRFbWy6Dezx6uo
         KUpcNm7rRqfY4cYkCeOVqY580PvWyjgejiYrPHgJTavsC1LpntswaIr2+m+U9KUGz3eM
         t72A==
X-Gm-Message-State: APjAAAUVT+w4f1z5pvSpP/GksCxxstZJ31s57i2Ri0tFFczFtKcZ/2i+
        Zaeu6lFSEQFhEh21nh12xVO0vw==
X-Google-Smtp-Source: APXvYqzJ2WDpJLg/LNaEQZaws5TC4ARi8PN3PrWC1qFv6jc2HU+mK8qoVwcw4ZyA/4FP4BLENeA08g==
X-Received: by 2002:ac8:4b6f:: with SMTP id g15mr5462709qts.196.1582812550856;
        Thu, 27 Feb 2020 06:09:10 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p92sm3106904qtd.14.2020.02.27.06.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 06:09:10 -0800 (PST)
Message-ID: <1582812549.7365.134.camel@lca.pw>
Subject: suspicious RCU due to "Prefer using an idle CPU as a migration
 target instead of comparing tasks"
From:   Qian Cai <cai@lca.pw>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        paulmck@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Feb 2020 09:09:09 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
migration target instead of comparing tasks") introduced a boot warning,

[   86.520534][    T1] WARNING: suspicious RCU usage
[   86.520540][    T1] 5.6.0-rc3-next-20200227 #7 Not tainted
[   86.520545][    T1] -----------------------------
[   86.520551][    T1] kernel/sched/fair.c:5914 suspicious
rcu_dereference_check() usage!
[   86.520555][    T1] 
[   86.520555][    T1] other info that might help us debug this:
[   86.520555][    T1] 
[   86.520561][    T1] 
[   86.520561][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   86.520567][    T1] 1 lock held by systemd/1:
[   86.520571][    T1]  #0: ffff8887f4b14848 (&mm->mmap_sem#2){++++}, at:
do_page_fault+0x1d2/0x998
[   86.520594][    T1] 
[   86.520594][    T1] stack backtrace:
[   86.520602][    T1] CPU: 1 PID: 1 Comm: systemd Not tainted 5.6.0-rc3-next-
20200227 #7
[   86.520607][    T1] Hardware name: HP ProLiant XL450 Gen9 Server/ProLiant
XL450 Gen9 Server, BIOS U21 05/05/2016
[   86.520612][    T1] Call Trace:
[   86.520623][    T1]  dump_stack+0xa0/0xea
[   86.520634][    T1]  lockdep_rcu_suspicious+0x102/0x10b
lockdep_rcu_suspicious at kernel/locking/lockdep.c:5648
[   86.520641][    T1]  update_numa_stats+0x577/0x710
test_idle_cores at kernel/sched/fair.c:5914
(inlined by) numa_idle_core at kernel/sched/fair.c:1565
(inlined by) update_numa_stats at kernel/sched/fair.c:1610
[   86.520649][    T1]  ? rcu_read_lock_held+0xac/0xc0
[   86.520657][    T1]  task_numa_migrate+0x4aa/0xdb0
[   86.520664][    T1]  ? task_numa_find_cpu+0x1010/0x1010
[   86.520677][    T1]  ? migrate_pages+0x29c/0x17c0
[   86.520683][    T1]  task_numa_fault+0x607/0xd90
[   86.520691][    T1]  ? task_numa_free+0x230/0x230
[   86.520698][    T1]  ? __kasan_check_read+0x11/0x20
[   86.520704][    T1]  ? do_raw_spin_unlock+0xa8/0x140
[   86.520712][    T1]  do_numa_page+0x33f/0x450
[   86.520720][    T1]  __handle_mm_fault+0xb81/0xb90
[   86.520727][    T1]  ? copy_page_range+0x420/0x420
[   86.520736][    T1]  handle_mm_fault+0xdc/0x2e0
[   86.520742][    T1]  do_page_fault+0x2c7/0x998
[   86.520752][    T1]  page_fault+0x34/0x40
[   86.520758][    T1] RIP: 0033:0x7f95faf63c53
[   86.520766][    T1] Code: 00 41 00 3d 00 00 41 00 74 3d 48 8d 05 d6 5a 2d 00
8b 00 85 c0 75 61 b8 01 01 00 00 0f 05 48 3d 00 f0 ff ff 0f 87 a5 00 00 00 <48>
8b 4c 24 38 64 48 33 0c 25 28 00 00 00 0f 85 ba 00 00 00 48 83
[   86.520771][    T1] RSP: 002b:00007ffdda737790 EFLAGS: 00010207
[   86.520778][    T1] RAX: 0000000000000024 RBX: 0000562a594b9fd0 RCX:
00007f95faf63c47
[   86.520783][    T1] RDX: 00000000002a0000 RSI: 0000562a594b9fd1 RDI:
0000000000000023
[   86.520788][    T1] RBP: 00007ffdda7379c0 R08: 00007f95fc734e30 R09:
00007ffdda737d60
[   86.520793][    T1] R10: 0000000000000000 R11: 0000000000000246 R12:
0000562a59459fb4
[   86.520798][    T1] R13: 0000000000000000 R14: 0000000000000001 R15:
0000000000000000
