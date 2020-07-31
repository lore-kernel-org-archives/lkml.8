Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B610722CA1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkz3Fgal";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7xf1e6Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbgGaJYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbgGaJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:27 -0400
Date:   Fri, 31 Jul 2020 09:23:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZG5b5Bc522c+MoOW4BJXPvTS+0ThLYJ9U9DTEsrVPHE=;
        b=nkz3FgaldZdrS2A1dtj8nrd5HF1JF9z7o5uA7zmYz/i0nwi5ly3Sn5fbQNzZklnsemDBly
        UxZPmgu70jzSMGKiu9ELflQxeLrjk42Ks2lnnxfSlog3qxsfRnH9CyXG1xgHIsdgYl1L0d
        kPhKU5kAI2WqmFabg4wzwLGV3A5WgplucK3+YouGWrvgAiZez1t6OD5OZ3U/X0tOr7fV5g
        MVdnohK5+GtDyIb0iJkTN/RP9NTatBgI3OeWqcsCDnHixDwsqgoXVZqnn5J6UW3Qkyxwc9
        LiDAxMUiQgeDeoluc/fWseVKYOUAjIAvdAGGDEAnBXlQ7XiT9YCVTy1jfk9iPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZG5b5Bc522c+MoOW4BJXPvTS+0ThLYJ9U9DTEsrVPHE=;
        b=7xf1e6NulzK0nfBy4dr6YXmhlMm0MVhdXC/dif4cervJhZHAOn5Oirz7A90FCy8M0xuf+q
        afxrNYENd6i7zWCQ==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix a kernel-doc warnings for "count"
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740523.4006.12597891813891208346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e11690d2f5a9823d66f68918c3986b4e9e160ab
Gitweb:        https://git.kernel.org/tip/8e11690d2f5a9823d66f68918c3986b4e9e160ab
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Mon, 04 May 2020 14:35:00 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:24 -07:00

rcu: Fix a kernel-doc warnings for "count"

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'

This commit therefore moves the comment for "count" to the kernel-doc
markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6c6569e..ba4c477 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3004,6 +3004,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3019,7 +3020,6 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
-	// Number of objects for which GP not started
 	int count;
 };
 
