Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94214C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1352085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5MDteHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEHDbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 23:31:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727777AbgEHDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588908678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8MHh9dyvpe8bslvZNsUP5j2B3v4NSqfl6A+NT0wxD4=;
        b=D5MDteHktG1i3bz2gYtC3qf1C6AEBEapWTzSbNOgJdqEUgEEbrCBVvqvVK5RhPi8tegJVs
        QR3+udP/fAQlysk2N8bOqI5bdQEvpiM5v0zaW2Gs9phgyDcqm5Wo5xAwM9YkQstBOc+UsC
        +AwUHc0POYmPdqVRFwBLf24HuvntIck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-kwm_sW8LPE6l4dM0Y68Z0w-1; Thu, 07 May 2020 23:31:13 -0400
X-MC-Unique: kwm_sW8LPE6l4dM0Y68Z0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6762D107ACCA;
        Fri,  8 May 2020 03:31:11 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-199.bne.redhat.com [10.64.54.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 783242E052;
        Fri,  8 May 2020 03:31:03 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
Subject: [PATCH RFCv2 8/9] kernel/sched: Add cpu_rq_is_locked()
Date:   Fri,  8 May 2020 13:29:18 +1000
Message-Id: <20200508032919.52147-9-gshan@redhat.com>
In-Reply-To: <20200508032919.52147-1-gshan@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds API cpu_rq_is_locked() to check if the CPU's runqueue has been
locked or not. It's used in the subsequent patch to determine the task
wakeup should be executed immediately or delayed.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..e68882443da7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1691,6 +1691,7 @@ extern struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *n
  */
 extern struct task_struct *find_get_task_by_vpid(pid_t nr);
 
+extern bool cpu_rq_is_locked(int cpu);
 extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..30f4a8845495 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -73,6 +73,14 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+bool cpu_rq_is_locked(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return raw_spin_is_locked(&rq->lock) ? true :  false;
+}
+EXPORT_SYMBOL_GPL(cpu_rq_is_locked);
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
-- 
2.23.0

