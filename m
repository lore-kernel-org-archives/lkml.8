Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54A1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C0A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbgEKU7j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731852AbgEKU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CFC05BD09;
        Mon, 11 May 2020 13:59:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWB-0005gv-Fg; Mon, 11 May 2020 22:59:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 211C61C04CC;
        Mon, 11 May 2020 22:59:19 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:19 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture.c: Fix if-statement empty body warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075904.390.15986284865630012571.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     be44ae62431196ac2a55198c0855028fff3ccfb4
Gitweb:        https://git.kernel.org/tip/be44ae62431196ac2a55198c0855028fff3ccfb4
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 25 Feb 2020 21:09:19 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:05:13 -07:00

locktorture.c: Fix if-statement empty body warnings

When using -Wextra, gcc complains about torture_preempt_schedule()
when its definition is empty (i.e., when CONFIG_PREEMPTION is not
set/enabled).  Fix these warnings by adding an empty do-while block
for that macro when CONFIG_PREEMPTION is not set.
Fixes these build warnings:

../kernel/locking/locktorture.c:119:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:166:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:337:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:490:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:528:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:553:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

I have verified that there is no object code change (with gcc 7.5.0).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
---
 include/linux/torture.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 6241f59..629b66e 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -89,7 +89,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #ifdef CONFIG_PREEMPTION
 #define torture_preempt_schedule() preempt_schedule()
 #else
-#define torture_preempt_schedule()
+#define torture_preempt_schedule()	do { } while (0)
 #endif
 
 #endif /* __LINUX_TORTURE_H */
