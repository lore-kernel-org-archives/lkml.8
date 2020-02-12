Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBAC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1212082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgBLOvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:51:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgBLOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:51:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1tLm-0006ig-KN; Wed, 12 Feb 2020 15:50:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 42B951C202C;
        Wed, 12 Feb 2020 15:50:50 +0100 (CET)
Date:   Wed, 12 Feb 2020 14:50:50 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Fix last_good_offset in
 setup_xstate_features()
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109211452.27369-2-yu-cheng.yu@intel.com>
References: <20200109211452.27369-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158151905003.411.10979205277016627753.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c12e13dcd814023a903399ec5ac2e7082d664b8b
Gitweb:        https://git.kernel.org/tip/c12e13dcd814023a903399ec5ac2e7082d664b8b
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Thu, 09 Jan 2020 13:14:50 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 11 Feb 2020 19:54:04 +01:00

x86/fpu/xstate: Fix last_good_offset in setup_xstate_features()

The function setup_xstate_features() uses CPUID to find each xfeature's
standard-format offset and size.  Since XSAVES always uses the compacted
format, supervisor xstates are *NEVER* in the standard-format and their
offsets are left as -1's.  However, they are still being tracked as
last_good_offset.

Fix it by tracking only user xstate offsets.

 [ bp: Use xfeature_is_supervisor() and save an indentation level. Drop
   now unused xfeature_is_user(). ]

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200109211452.27369-2-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a180659..fe67cab 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -120,11 +120,6 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
-static bool xfeature_is_user(int xfeature_nr)
-{
-	return !xfeature_is_supervisor(xfeature_nr);
-}
-
 /*
  * When executing XSAVEOPT (or other optimized XSAVE instructions), if
  * a processor implementation detects that an FPU state component is still
@@ -265,21 +260,25 @@ static void __init setup_xstate_features(void)
 
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
+		xstate_sizes[i] = eax;
+
 		/*
-		 * If an xfeature is supervisor state, the offset
-		 * in EBX is invalid. We leave it to -1.
+		 * If an xfeature is supervisor state, the offset in EBX is
+		 * invalid, leave it to -1.
 		 */
-		if (xfeature_is_user(i))
-			xstate_offsets[i] = ebx;
+		if (xfeature_is_supervisor(i))
+			continue;
+
+		xstate_offsets[i] = ebx;
 
-		xstate_sizes[i] = eax;
 		/*
-		 * In our xstate size checks, we assume that the
-		 * highest-numbered xstate feature has the
-		 * highest offset in the buffer.  Ensure it does.
+		 * In our xstate size checks, we assume that the highest-numbered
+		 * xstate feature has the highest offset in the buffer.  Ensure
+		 * it does.
 		 */
 		WARN_ONCE(last_good_offset > xstate_offsets[i],
-			"x86/fpu: misordered xstate at %d\n", last_good_offset);
+			  "x86/fpu: misordered xstate at %d\n", last_good_offset);
+
 		last_good_offset = xstate_offsets[i];
 	}
 }
