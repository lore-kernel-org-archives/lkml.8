Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A1C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC7A24687
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA2LdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgA2LdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlaa-0007kJ-GC; Wed, 29 Jan 2020 12:32:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0F581C0095;
        Wed, 29 Jan 2020 12:32:55 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:55 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] kernel/events: Add a missing prototype for
 arch_perf_update_userpage()
Cc:     Benjamin Thiel <b.thiel@posteo.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109131351.9468-1-b.thiel@posteo.de>
References: <20200109131351.9468-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158029757541.396.4238678830980853491.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f1ec3a517b4352e78dbef6b1e591f43202ecb3fe
Gitweb:        https://git.kernel.org/tip/f1ec3a517b4352e78dbef6b1e591f43202ecb3fe
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Thu, 09 Jan 2020 14:13:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:26:44 +01:00

kernel/events: Add a missing prototype for arch_perf_update_userpage()

... in order to fix a -Wmissing-prototype warning.

No functional changes.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200109131351.9468-1-b.thiel@posteo.de
---
 include/linux/perf_event.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22a..52928e0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1544,4 +1544,8 @@ int perf_event_exit_cpu(unsigned int cpu);
 #define perf_event_exit_cpu	NULL
 #endif
 
+extern void __weak arch_perf_update_userpage(struct perf_event *event,
+					     struct perf_event_mmap_page *userpg,
+					     u64 now);
+
 #endif /* _LINUX_PERF_EVENT_H */
