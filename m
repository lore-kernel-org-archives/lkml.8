Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000FCC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFCC2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgEHNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728164AbgEHNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9CEC05BD0A;
        Fri,  8 May 2020 06:46:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kk-0001nA-P2; Fri, 08 May 2020 15:46:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 62B111C03AB;
        Fri,  8 May 2020 15:46:34 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:34 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] objtool, kcsan: Add explicit check functions to
 uaccess whitelist
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559434.8414.13833858647716980506.tip-bot2@tip-bot2>
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

Commit-ID:     9967683ce5d4ce21829bbc807e006ee33cc68725
Gitweb:        https://git.kernel.org/tip/9967683ce5d4ce21829bbc807e006ee33cc68725
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 25 Mar 2020 17:41:57 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 13 Apr 2020 17:18:12 -07:00

objtool, kcsan: Add explicit check functions to uaccess whitelist

Add explicitly invoked KCSAN check functions to objtool's uaccess
whitelist. This is needed in order to permit calling into
kcsan_check_scoped_accesses() from the fast-path, which in turn calls
__kcsan_check_access().  __kcsan_check_access() is the generic variant
of the already whitelisted specializations __tsan_{read,write}N.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6da413..b6a573d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -468,8 +468,10 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
 	/* KCSAN */
+	"__kcsan_check_access",
 	"kcsan_found_watchpoint",
 	"kcsan_setup_watchpoint",
+	"kcsan_check_scoped_accesses",
 	/* KCSAN/TSAN */
 	"__tsan_func_entry",
 	"__tsan_func_exit",
