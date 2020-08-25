Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776A420782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/QGmMDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHYSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:46:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25465 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726158AbgHYSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598381183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hnzV/kN/xqPpoOor9QkIbP7zA8CppIvbXByIibfpm1o=;
        b=N/QGmMDmYQuX/cJ9HM3aVVJx9fAmvovC7/YSndWfh9tvUawNxPsr8vAadc1xC3RBbW5QQf
        SxhXLYsaF5YlibYCW6WSuvIGuakiXLHOcuL8gsh5RmlCTFVTaVyCbe5Q1hSmTvhOmk7ndr
        lH96ZWduWAnmR2WZZx5Pmx/pYE6ZPbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-uhiai4ZCNs6kwjkwHww5iQ-1; Tue, 25 Aug 2020 14:46:21 -0400
X-MC-Unique: uhiai4ZCNs6kwjkwHww5iQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B93498030A0;
        Tue, 25 Aug 2020 18:46:20 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-10.gru2.redhat.com [10.97.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7186C19C4F;
        Tue, 25 Aug 2020 18:46:20 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3896C409D614; Tue, 25 Aug 2020 15:44:50 -0300 (-03)
Message-ID: <20200825184414.486721471@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 25 Aug 2020 15:41:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [patch 2/2] nohz: try to avoid IPI when setting tick dependency for task
References: <20200825184147.948670309@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
performed (to re-read the dependencies and possibly not re-enter
nohz_full on a given CPU).

A common case is for applications that run on nohz_full= CPUs
to not use POSIX timers (eg DPDK).

This patch optimizes tick_nohz_dep_set_task to avoid kicking
all nohz_full= CPUs in case the task allowed mask does not
intersect with nohz_full= CPU mask,
when going through tick_nohz_dep_set_task.

This reduces interruptions to nohz_full= CPUs.

---
 kernel/time/tick-sched.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -383,11 +383,16 @@ void tick_nohz_dep_set_task(struct task_
 			tick_nohz_full_kick();
 			preempt_enable();
 		} else {
+			unsigned long flags;
+
 			/*
 			 * Some future tick_nohz_full_kick_task()
-			 * should optimize this.
+			 * should further optimize this.
 			 */
-			tick_nohz_full_kick_all();
+			raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+			if (cpumask_intersects(&tsk->cpus_mask, tick_nohz_full_mask))
+				tick_nohz_full_kick_all();
+			raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
 		}
 	}
 }


