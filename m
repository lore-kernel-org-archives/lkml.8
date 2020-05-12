Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EAC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E865A2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgELOhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbgELOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF511C061A0E;
        Tue, 12 May 2020 07:37:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1o-0005qT-CV; Tue, 12 May 2020 16:37:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D47B91C0494;
        Tue, 12 May 2020 16:36:58 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:58 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] linux/compiler.h: Remove redundant '#else'
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-19-will@kernel.org>
References: <20200511204150.27858-19-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421876.390.5641049290756529509.tip-bot2@tip-bot2>
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

Commit-ID:     8367aadcd83d2570fd4ce4af40ae7aec7c2bfcb7
Gitweb:        https://git.kernel.org/tip/8367aadcd83d2570fd4ce4af40ae7aec7c2bfcb7
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:11 +02:00

linux/compiler.h: Remove redundant '#else'

The '#else' clause after checking '#ifdef __KERNEL__' is empty in
linux/compiler.h, so remove it.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200511204150.27858-19-will@kernel.org

---
 include/linux/compiler.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cce2c92..9bd0f76 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -331,7 +331,6 @@ unsigned long read_word_at_a_time(const void *addr)
 		kcsan_enable_current();                                        \
 		__val;                                                         \
 	})
-#else
 
 #endif /* __KERNEL__ */
 
