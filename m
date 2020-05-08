Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD68208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEHNr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728196AbgEHNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFAC05BD0B;
        Fri,  8 May 2020 06:46:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kh-0001kz-UQ; Fri, 08 May 2020 15:46:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 882FC1C0080;
        Fri,  8 May 2020 15:46:31 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:31 -0000
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Use GFP_ATOMIC under spin lock
Cc:     Marco Elver <elver@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559149.8414.10630539336535979408.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     52785b6ae8eded7ac99d65c92d989b702e5b4376
Gitweb:        https://git.kernel.org/tip/52785b6ae8eded7ac99d65c92d989b702e5b4376
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Fri, 17 Apr 2020 02:58:37 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:10:10 -07:00

kcsan: Use GFP_ATOMIC under spin lock

A spin lock is held in insert_report_filterlist(), so the krealloc()
should use GFP_ATOMIC.  This commit therefore makes this change.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1a08664..023e49c 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -230,7 +230,7 @@ static ssize_t insert_report_filterlist(const char *func)
 		/* initial allocation */
 		report_filterlist.addrs =
 			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_KERNEL);
+				      sizeof(unsigned long), GFP_ATOMIC);
 		if (report_filterlist.addrs == NULL) {
 			ret = -ENOMEM;
 			goto out;
@@ -240,7 +240,7 @@ static ssize_t insert_report_filterlist(const char *func)
 		size_t new_size = report_filterlist.size * 2;
 		unsigned long *new_addrs =
 			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_KERNEL);
+				 new_size * sizeof(unsigned long), GFP_ATOMIC);
 
 		if (new_addrs == NULL) {
 			/* leave filterlist itself untouched */
