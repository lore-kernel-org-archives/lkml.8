Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E61C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E10920842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCDFXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:23:35 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59444 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgCDFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:23:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MVJ-00082y-7k; Tue, 03 Mar 2020 22:23:33 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MV6-0003OP-Vb; Tue, 03 Mar 2020 22:23:33 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20200304004336.960-1-cai@lca.pw>
Date:   Tue, 03 Mar 2020 23:21:11 -0600
In-Reply-To: <20200304004336.960-1-cai@lca.pw> (Qian Cai's message of "Tue, 3
        Mar 2020 19:43:36 -0500")
Message-ID: <877e00hf08.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9MV6-0003OP-Vb;;;mid=<877e00hf08.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+dbHGiv/ztm3INrbnp2Mweg4CvI0F3KI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH timers/core] posix-cpu-timers: Put the task_struct in posix_cpu_timers_create
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Qian Cai <cai@lca.pw> writes:
> The recent commit removed put_task_struct() in posix_cpu_timer_del()
> results in many memory leaks like this,
>
> unreferenced object 0xc0000016d9b44480 (size 8192):
>   comm "timer_create01", pid 57749, jiffies 4295163733 (age 6159.670s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000056aca129>] copy_process+0x26c/0x18e0
>     alloc_task_struct_node at kernel/fork.c:169
>     (inlined by) dup_task_struct at kernel/fork.c:877
>     (inlined by) copy_process at kernel/fork.c:1929
>     [<00000000bdbbf9f8>] _do_fork+0xac/0xb20
>     [<00000000dcb1c445>] __do_sys_clone+0x98/0xe0
>     __do_sys_clone at kernel/fork.c:2591
>     [<000000006c059205>] ppc_clone+0x8/0xc
>     ppc_clone at arch/powerpc/kernel/entry_64.S:479
>

I forgot that get_task_for_clock called by posix_cpu_timer_create
returns a reference to a task_struct.  Put that reference
to avoid the leak.

Link: https://lore.kernel.org/lkml/20200304004336.960-1-cai@lca.pw/
Fixes: 672ebe8eb017a5 ("posix-cpu-timers: Store a reference to a pid not a task")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 1c21f2fd3d9b..cd88c1217224 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -405,6 +405,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
+	put_task_struct(p);
 	return 0;
 }
 
-- 
2.20.1

