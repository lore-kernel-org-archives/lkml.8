Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9AC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6DD20724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDWTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:42:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43650 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:42:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhjo-0007Ai-2Q; Thu, 23 Apr 2020 13:42:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhjm-0003pV-SR; Thu, 23 Apr 2020 13:42:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
Date:   Thu, 23 Apr 2020 14:39:10 -0500
In-Reply-To: <87ftcv1nqe.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 22 Apr 2020 11:36:41 -0500")
Message-ID: <87368uxa8x.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRhjm-0003pV-SR;;;mid=<87368uxa8x.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19AlV3Q6ga6LG7nofoG7B8nBnQL9mK/87k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 1/2] proc: Use PIDTYPE_TGID in next_tgid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Combine the pid_task and thes test has_group_leader_pid into a single
dereference by using pid_task(PIDTYPE_TGID).

This makes the code simpler and proof against needing to even think
about any shenanigans that de_thread might get up to.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/base.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2868bff1a142..a48b4d4056a9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3360,20 +3360,8 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	pid = find_ge_pid(iter.tgid, ns);
 	if (pid) {
 		iter.tgid = pid_nr_ns(pid, ns);
-		iter.task = pid_task(pid, PIDTYPE_PID);
-		/* What we to know is if the pid we have find is the
-		 * pid of a thread_group_leader.  Testing for task
-		 * being a thread_group_leader is the obvious thing
-		 * todo but there is a window when it fails, due to
-		 * the pid transfer logic in de_thread.
-		 *
-		 * So we perform the straight forward test of seeing
-		 * if the pid we have found is the pid of a thread
-		 * group leader, and don't worry if the task we have
-		 * found doesn't happen to be a thread group leader.
-		 * As we don't care in the case of readdir.
-		 */
-		if (!iter.task || !has_group_leader_pid(iter.task)) {
+		iter.task = pid_task(pid, PIDTYPE_TGID);
+		if (!iter.task) {
 			iter.tgid += 1;
 			goto retry;
 		}
-- 
2.20.1

