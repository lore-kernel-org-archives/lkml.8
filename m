Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE37C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1712166E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgCXJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgCXJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg0-00084Q-Vc; Tue, 24 Mar 2020 10:16:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A82071C048C;
        Tue, 24 Mar 2020 10:16:41 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:41 -0000
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix spelling mistake "leval" -> "level"
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140134.28353.294557610514832568.tip-bot2@tip-bot2>
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

Commit-ID:     aa96a93ba2bbad5e1b24706daffa14c4f1c50d2a
Gitweb:        https://git.kernel.org/tip/aa96a93ba2bbad5e1b24706daffa14c4f1c50d2a
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 12 Dec 2019 17:36:43 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:20 -08:00

rcu: Fix spelling mistake "leval" -> "level"

This commit fixes a spelling mistake in a pr_info() message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4d4637c..0765784 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -57,7 +57,7 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (qlowmark != DEFAULT_RCU_QLOMARK)
 		pr_info("\tBoot-time adjustment of callback low-water mark to %ld.\n", qlowmark);
 	if (qovld != DEFAULT_RCU_QOVLD)
-		pr_info("\tBoot-time adjustment of callback overload leval to %ld.\n", qovld);
+		pr_info("\tBoot-time adjustment of callback overload level to %ld.\n", qovld);
 	if (jiffies_till_first_fqs != ULONG_MAX)
 		pr_info("\tBoot-time adjustment of first FQS scan delay to %ld jiffies.\n", jiffies_till_first_fqs);
 	if (jiffies_till_next_fqs != ULONG_MAX)
