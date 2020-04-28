Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D02BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4182072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD1V4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:56:47 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47642 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD1V4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:56:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYDe-0006CL-8g; Tue, 28 Apr 2020 15:56:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYDd-0003Kw-J2; Tue, 28 Apr 2020 15:56:46 -0600
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
Date:   Tue, 28 Apr 2020 16:53:31 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87zhav5lb8.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTYDd-0003Kw-J2;;;mid=<87zhav5lb8.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9SFOGLrwqMnM+GMHpEChkArNfTp8VniM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v1 3/4] exec: Remove BUG_ON(has_group_leader_pid)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With the introduction of exchange_tids thread_group_leader and
has_group_leader_pid have become equivalent.  Further at this point in the
code a thread group has exactly two threads, the previous thread_group_leader
that is waiting to be reaped and tsk.  So we know it is impossible for tsk to
be the thread_group_leader.

This is also the last user of has_group_leader_pid so removing this check
will allow has_group_leader_pid to be removed.

So remove the "BUG_ON(has_group_leader_pid)" that will never fire.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9b60f927afd7..6ab1c19d84fa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1176,7 +1176,6 @@ static int de_thread(struct task_struct *tsk)
 		tsk->start_boottime = leader->start_boottime;
 
 		BUG_ON(!same_thread_group(leader, tsk));
-		BUG_ON(has_group_leader_pid(tsk));
 		/*
 		 * An exec() starts a new thread group with the
 		 * TGID of the previous thread group. Rehash the
-- 
2.20.1

