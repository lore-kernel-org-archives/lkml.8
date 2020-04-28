Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FCBC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE562072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD1V7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:59:41 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42936 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1V7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:59:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYGR-0000Tk-EL; Tue, 28 Apr 2020 15:59:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYGQ-0003k8-Pl; Tue, 28 Apr 2020 15:59:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <20200428180540.GB29960@redhat.com>
        <87mu6v70in.fsf_-_@x220.int.ebiederm.org>
Date:   Tue, 28 Apr 2020 16:56:24 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87pnbr5l6f.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTYGQ-0003k8-Pl;;;mid=<87pnbr5l6f.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/RFDt7kKDsm8z1PG360s6aH2eNeEKiKPE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v4 4/4] signal: Remove has_group_leader_pid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After the introduction of exchange_tids has_group_leader_pid is
equivalent to thread_group_leader.  After the last couple of cleanups
has_group_leader_pid has no more callers.

So remove the now unused and redundant has_group_leader_pid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3e5b090c16d4..0ee5e696c5d8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -654,17 +654,6 @@ static inline bool thread_group_leader(struct task_struct *p)
 	return p->exit_signal >= 0;
 }
 
-/* Do to the insanities of de_thread it is possible for a process
- * to have the pid of the thread group leader without actually being
- * the thread group leader.  For iteration through the pids in proc
- * all we care about is that we have a task with the appropriate
- * pid, we don't actually care if we have the right task.
- */
-static inline bool has_group_leader_pid(struct task_struct *p)
-{
-	return task_pid(p) == task_tgid(p);
-}
-
 static inline
 bool same_thread_group(struct task_struct *p1, struct task_struct *p2)
 {
-- 
2.20.1

