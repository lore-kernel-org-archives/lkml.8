Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581DAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B64C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgEKU7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731375AbgEKU7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C939C05BD09;
        Mon, 11 May 2020 13:59:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW9-0005fo-7g; Mon, 11 May 2020 22:59:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD2111C0494;
        Mon, 11 May 2020 22:59:16 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:16 -0000
From:   "tip-bot2 for Jason Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make rcu_fwds and rcu_fwd_emergency_stop static
Cc:     Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075682.390.12246694601760269827.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     afbc1574f1da13d2fd2b30a96090b37c5933f957
Gitweb:        https://git.kernel.org/tip/afbc1574f1da13d2fd2b30a96090b37c5933f957
Author:        Jason Yan <yanaijie@huawei.com>
AuthorDate:    Thu, 09 Apr 2020 19:42:38 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

rcutorture: Make rcu_fwds and rcu_fwd_emergency_stop static

This commit fixes the following sparse warning:

kernel/rcu/rcutorture.c:1695:16: warning: symbol 'rcu_fwds' was not declared. Should it be static?
kernel/rcu/rcutorture.c:1696:6: warning: symbol 'rcu_fwd_emergency_stop' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3d47dca..c7b7594 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1721,8 +1721,8 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
-struct rcu_fwd *rcu_fwds;
-bool rcu_fwd_emergency_stop;
+static struct rcu_fwd *rcu_fwds;
+static bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 {
