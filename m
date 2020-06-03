Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3A72074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgFCJTe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgFCJTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:19:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F6C05BD43;
        Wed,  3 Jun 2020 02:19:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgPYW-0005nE-T5; Wed, 03 Jun 2020 11:19:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6A4061C0081;
        Wed,  3 Jun 2020 11:19:28 +0200 (CEST)
Date:   Wed, 03 Jun 2020 09:19:28 -0000
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] rcuperf: Fix printk format warning
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159117596821.17951.14565757458666669715.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61
Gitweb:        https://git.kernel.org/tip/b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Fri, 17 Apr 2020 12:02:45 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 02 Jun 2020 08:41:37 -07:00

rcuperf: Fix printk format warning

Using "%zu" to fix following warning,
kernel/rcu/rcuperf.c: In function ‘kfree_perf_init’:
include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6..9eb39c2 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -723,7 +723,7 @@ kfree_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
