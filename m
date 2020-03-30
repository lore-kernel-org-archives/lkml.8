Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA945C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E858206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Hh9Gj3cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgC3Vad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:30:33 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35211 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgC3Vad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:30:33 -0400
Received: by mail-qv1-f65.google.com with SMTP id q73so9809574qvq.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujlgDVeN5WyrhvReWMSTseHg6eFfL+O6R8lZN6GeKTM=;
        b=Hh9Gj3cjpAEvef4tflsauVD4dbbVc+yk4Aml3cvvrfQro5VAcFEtrSB4KE8ManSdfD
         THxmy22AdlPLQjCHWdsbQZVFUqS/IKWpxWKuX0ofapv2cddfTHHq56tMRWhfLtRgYTDb
         n5Rix9EJBGmjk+QHAnixLL1bER0FH7qMYwtd0m3NI+bpxp01r73tAivtFSicTRhnFS8Z
         AL4B4YZI5lAlDLXKl68w2hbZzRpIk5VZp2eualX7vJF6AL1voR3hUyC8xN1a7ANmD2RG
         G1nQR/tpRBkm/5Xaveh6g8OmIi3pLr78b/CtQEyZ14nT83jWLfXfiwD1/yREzDognI48
         2pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujlgDVeN5WyrhvReWMSTseHg6eFfL+O6R8lZN6GeKTM=;
        b=uYcFGZ10Oj2R2RhIrlre8vy9RqUqANPqYwtzpL3VcIodLjr58gjmCTi5PCLWXiC3oa
         FEBUG/IuVHoZdePjlByjesYzmh130Qt39WXxdARJdqi6g8l91+3EV6Q+QIH3SUfd6JBe
         3nWvxW4/vfRyK0UW9FVBGRpHkY8FlnPnXTDnYcGJOaG+4pPVqiOanuxzu+if9CMHISZP
         B4sII/YXRU/+jzZVlUIlml3PP1eUanazypCt0a+GCipWrJDU1XmKDBmpT20mkuc2MAnF
         ipo2CQKMLGxeKBU6aDNjLZF+vi16J0Y2KcL7+aqMfjpSUxILAw7JGHy1sTz6yU3VhKPS
         m+Fw==
X-Gm-Message-State: ANhLgQ3jfawLNnW0QpPP9fGrjcie/a7OFElcDHGiWx2+Ywh9bFU2EgT1
        AQsd9tkmoRFpt+APx3neu5tSiA==
X-Google-Smtp-Source: ADFU+vtUbDg0A+atghZynr7NWxbJSLnJ1NzuOveWDW+Bue0PEFUbXdkQR+ayO1N1b0P2hqN3LYPyNA==
X-Received: by 2002:a05:6214:11ec:: with SMTP id e12mr14079090qvu.89.1585603831347;
        Mon, 30 Mar 2020 14:30:31 -0700 (PDT)
Received: from ovpn-66-6.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l42sm11916908qtf.51.2020.03.30.14.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 14:30:30 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     will@kernel.org, dbueso@suse.de, juri.lelli@redhat.com,
        longman@redhat.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] locking/percpu-rwsem: fix a task_struct refcount
Date:   Mon, 30 Mar 2020 17:30:02 -0400
Message-Id: <20200330213002.2374-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 7f26482a872c ("locking/percpu-rwsem: Remove the embedded
rwsem") introduced some task_struct memory leaks due to messing up with
a task_struct refcount. At the beginning of
percpu_rwsem_wake_function(), it calls get_task_struct(), but if the
trylock failed, it will remain in the waitqueue. However, it will run
percpu_rwsem_wake_function() again with get_task_struct() to increase
the refcount but then only call put_task_struct() once the trylock
succeeded.

Fix it by adjusting percpu_rwsem_wake_function() a bit to guard against
when percpu_rwsem_wait() observing !private, terminating the wait and
doing a quick exit() while percpu_rwsem_wake_function() then doing
wake_up_process(p) as a use-after-free.

Fixes: 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/percpu-rwsem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a008a1ba21a7..8bbafe3e5203 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -118,14 +118,15 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 				      unsigned int mode, int wake_flags,
 				      void *key)
 {
-	struct task_struct *p = get_task_struct(wq_entry->private);
 	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
 	struct percpu_rw_semaphore *sem = key;
+	struct task_struct *p;
 
 	/* concurrent against percpu_down_write(), can get stolen */
 	if (!__percpu_rwsem_trylock(sem, reader))
 		return 1;
 
+	p = get_task_struct(wq_entry->private);
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
 
-- 
2.21.0 (Apple Git-122.2)

