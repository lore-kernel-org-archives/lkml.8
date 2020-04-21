Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215C1C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47F92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXn5QwDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUKTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:19:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgDUKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587464349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nl0oOv7PP8XI+oE2HMT1ZSGDBT22U9zpXC0YWqChw/0=;
        b=aXn5QwDs44pAu9UR3Qva2rK/8qU5tlsjuyCckSXrEZQ3qxPPxt4O1befljE6a0Gr0AtmOM
        SYOBEVb9nHfkYLq0KwiO9IFxgpMLUAQTOPa/aK+QE2v+sdMgzt5SAN1Un17auL2TgOTRFT
        zqvYUqWmCopYcfrQLlS2T4TS93RTg4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Zv4dFOB-PYmOa3kwQNgOig-1; Tue, 21 Apr 2020 06:19:07 -0400
X-MC-Unique: Zv4dFOB-PYmOa3kwQNgOig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEBC61400;
        Tue, 21 Apr 2020 10:19:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89C3E76E68;
        Tue, 21 Apr 2020 10:19:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Apr 2020 12:19:06 +0200 (CEST)
Date:   Tue, 21 Apr 2020 12:19:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [PATCH] remove the no longer needed pid_alive() check in
 __task_pid_nr_ns()
Message-ID: <20200421101904.GA9358@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421090426.GA6787@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421090426.GA6787@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
task->group_leader, we can remove the pid_alive() check.

pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
unnecessary confusion.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index bc21c0fb26d8..47221db038e2 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -475,8 +475,7 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
 	rcu_read_lock();
 	if (!ns)
 		ns = task_active_pid_ns(current);
-	if (likely(pid_alive(task)))
-		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
+	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
 	rcu_read_unlock();
 
 	return nr;
-- 
2.25.1.362.g51ebf55


