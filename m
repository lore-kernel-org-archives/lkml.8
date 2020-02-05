Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8266BC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1FE21927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqmHy6Fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBERYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:24:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52664 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgBERYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:24:48 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so1256848pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O6f8gSgy3dUNcsUeRgZv0meSXKvjWlJqGpm0K3VBOCs=;
        b=pqmHy6FlDFSnQTIoMyzxnCIO3vTFZBIJD8KS7Z+9fLKfInJEp4+siGb96YZdi2U/vq
         gpiTIcphcC5tJSNHywZtP46vitKr8JYlaNWJ+5mLDRVSs8rPMPp9HCd80OUajqkZjXoU
         tpz6igUy92z8T7nMp/mMC+LvlqhQH0pIdYrctucWZBrqgxUWcyRGfj+3oNNyjIA6Nwrn
         6Q6NM6A53DtEBINqLyR/FdVA0ub5Hvb8ArLEu98csLwjFBC0Fvy3goCT4AMlAMRfBstr
         viyAPXhdj3bu2kYouTvGwfut6IFdzzoUMjNl6YfyBeMOR7MWyCmHTHNyUWXScbQ9f8Sq
         0RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O6f8gSgy3dUNcsUeRgZv0meSXKvjWlJqGpm0K3VBOCs=;
        b=WgfdX4LlQ2tZ+hjlheJcof46MbGxIQ63ZeczVAnh3roNq+sJyznrADwBWBIFLkx1l7
         QN7uCUi7XB+wYZbSXQigHc17iCAOGFgSm8lMZ3R7mhFD+/y11LBcXuDQVzlrkjOXu3u+
         ooKqAiTIzD9soCwtu8x5YZeg3tf5uHJyr8kjCbtFdkcOEbY45CavRHGijRhMNdl52c8z
         8hUzQbmtHkPxpO4Bqe4VKlapucjqrkl587WGpN0D2x71b5jIaWFzRcee2uDNwCgBqL9Y
         iQ3NltUkObtZ0YtcjP4dQgge2LABzxUK2LUAyY0YP6LJkWVAWo/KSS1YXMSWXfmSSEqG
         8YyA==
X-Gm-Message-State: APjAAAXjtdBQfTn5X4A3whG9l1k8t8y216EOlxDv8mNyeDaf3WVx5arv
        Gg0OHc5edXRwKyw3WQg//w==
X-Google-Smtp-Source: APXvYqxtTBOgoPDcxh6PIkSnVx/zJCV3zhZwsNOWrF+JuOTPHDX4FolSZAmV6z8eyurcnom2FdvQ2A==
X-Received: by 2002:a17:90a:7303:: with SMTP id m3mr6915519pjk.62.1580923486794;
        Wed, 05 Feb 2020 09:24:46 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:542:9945:9d58:40ca:c55a:7c02])
        by smtp.gmail.com with ESMTPSA id w11sm106767pfn.4.2020.02.05.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:24:46 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     ebiederm@xmission.com, oleg@redhat.com,
        christian.brauner@ubuntu.com, guro@fb.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] signal.c: Fix sparse warnings
Date:   Wed,  5 Feb 2020 22:54:37 +0530
Message-Id: <20200205172437.10113-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following two sparse warnings caused due to
accessing RCU protected pointer tsk->parent without rcu primitives.

kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:1948:65:    expected struct task_struct *tsk
kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:1949:40:    expected void const volatile *p
kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:1949:40:    expected void const volatile *p
kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ad8dea93dbb..8227058ea8c4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * correct to rely on this
 	 */
 	rcu_read_lock();
-	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
-	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
+	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_dereference(tsk->parent)));
+	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_dereference(tsk->parent), user_ns),
 				       task_uid(tsk));
 	rcu_read_unlock();
 
-- 
2.17.1

