Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567E2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E424689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAVNCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:02:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAVNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:02:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuFea-0003nU-8Q; Wed, 22 Jan 2020 14:02:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A11061C1A46;
        Wed, 22 Jan 2020 14:02:39 +0100 (CET)
Date:   Wed, 22 Jan 2020 13:02:39 -0000
From:   "tip-bot2 for Mateusz Nosek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/tsc: Remove redundant assignment
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200118171143.25178-1-mateusznosek0@gmail.com>
References: <20200118171143.25178-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Message-ID: <157969815944.396.7323567000945686325.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4144fddbd3932b59370e6e279002991c3e2b2fc6
Gitweb:        https://git.kernel.org/tip/4144fddbd3932b59370e6e279002991c3e2b2fc6
Author:        Mateusz Nosek <mateusznosek0@gmail.com>
AuthorDate:    Sat, 18 Jan 2020 18:11:43 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Jan 2020 13:52:42 +01:00

x86/tsc: Remove redundant assignment

Previously, the assignment to the local variable 'now' took place
before the for loop. The loop is unconditional so it will be entered
at least once. The variable 'now' is reassigned in the loop and is not
used before reassigning. Therefore, the assignment before the loop is
unnecessary and can be removed.

No code changed:

  # arch/x86/kernel/tsc_sync.o:

   text    data     bss     dec     hex filename
   3569     198      44    3811     ee3 tsc_sync.o.before
   3569     198      44    3811     ee3 tsc_sync.o.after

md5:
   36216de29b208edbcd34fed9fe7f7b69  tsc_sync.o.before.asm
   36216de29b208edbcd34fed9fe7f7b69  tsc_sync.o.after.asm

 [ bp: Massage commit message. ]

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200118171143.25178-1-mateusznosek0@gmail.com
---
 arch/x86/kernel/tsc_sync.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index b8acf63..32a8187 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -233,7 +233,6 @@ static cycles_t check_tsc_warp(unsigned int timeout)
 	 * The measurement runs for 'timeout' msecs:
 	 */
 	end = start + (cycles_t) tsc_khz * timeout;
-	now = start;
 
 	for (i = 0; ; i++) {
 		/*
