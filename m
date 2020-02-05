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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB9EC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D780217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng9RIwUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBEQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:23:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41778 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBEQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:23:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so1449306pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tce+wxjIMbP1aBJd+9E6qNp6uBiu269F8hsx89rAEMQ=;
        b=Ng9RIwUoZeB4aHfpO+Tb3lYtoc5hWrPfBnInlWr5WYNzfKZ/Zvdt3OMzxTgW18UQnP
         I7VPGuSbciereltyvGY4UrNiOBbZ1OFTMxwTuqbKZMVIaMurcVaaOIV6dqkPv88U5hL+
         zCEJk9dGaUZL57IMf6ZlKSnmASpz6TxNCT+wHFoHtBOLivj8NNwVv6E35byBhy8myeMx
         An5Cg+z6QcCXldbyeElha85nYyherOButvsO0TPW0plpBeFbNtQLrnHFPbxdCSrdetRS
         aZGgg9aIu+Y00QQQpo43dGRXhy8l7FgUKxXRlzthdjuACqVGJtiavszTfdfZSeVIU79L
         oEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tce+wxjIMbP1aBJd+9E6qNp6uBiu269F8hsx89rAEMQ=;
        b=WP5yGxsE1pLSvmnTgnsd+9eLi1pOBhg2XA/ASARdBzXpbEaEPadkF9d2kCZoUzIsQZ
         DZMkf7jcOm3/ra778sG5X71AdJvRz/WRJ9XmhfX9QFbeObK/Bc0acU2hkx7Af5BkFP+m
         EtCPF9aZr+YokS3t4gW5M7ayxAn9c5Pv1FtA6SJ9Hey7iOQTzV/hcDLMQAJj8Z36z/+C
         MWLY+YK5iivYCAxVjM9eFam0op4g3GsiBFC10qwaJdE7nV4WNEk+QMYCZb2lOE1SIytM
         2/lZlc+GsZBNgC0h4qzuf4tG4OUjx78HeSlV2ygxcuaLBry9czu1wpXVcixwM3siJCes
         Bc+A==
X-Gm-Message-State: APjAAAVwxSmPjGDbkAWGeLP5viIzguEtvfBa+nT+mxykfSnPFx6HMqyK
        bDsoNMjTOELQQRTCeMhSpA==
X-Google-Smtp-Source: APXvYqwPz03t/tZOqTHtQoK9t5yZGyu2CKqVzPPZ0H3B+hjFBBVmOLAEZg+s41V/DdpNMd8CU4EPiw==
X-Received: by 2002:a63:f04c:: with SMTP id s12mr37284336pgj.408.1580919812193;
        Wed, 05 Feb 2020 08:23:32 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:542:9945:9d58:40ca:c55a:7c02])
        by smtp.gmail.com with ESMTPSA id v9sm269016pja.26.2020.02.05.08.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:23:31 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     ebiederm@xmission.com, oleg@redhat.com,
        christian.brauner@ubuntu.com, guro@fb.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] signal.c: Fix sparse warnings
Date:   Wed,  5 Feb 2020 21:53:19 +0530
Message-Id: <20200205162319.28263-1-madhuparnabhowmik10@gmail.com>
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
index 9ad8dea93dbb..3d59e5652d94 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * correct to rely on this
 	 */
 	rcu_read_lock();
-	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
-	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
+	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_access_pointer(tsk->parent)));
+	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_access_pointer(tsk->parent), user_ns),
 				       task_uid(tsk));
 	rcu_read_unlock();
 
-- 
2.17.1

