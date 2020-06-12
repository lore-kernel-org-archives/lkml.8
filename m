Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25ABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1DB20723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLTuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgFLTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF6C03E96F;
        Fri, 12 Jun 2020 12:50:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jjpgn-0003Pg-A2; Fri, 12 Jun 2020 21:50:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 762901C032F;
        Fri, 12 Jun 2020 21:50:08 +0200 (CEST)
Date:   Fri, 12 Jun 2020 19:50:08 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Make NMI use IDTENTRY_RAW
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
References: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <159199140829.16989.15278153096023573456.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     71ed49d8fb33023f242419a77ecb1141c029cac4
Gitweb:        https://git.kernel.org/tip/71ed49d8fb33023f242419a77ecb1141c029cac4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 Jun 2020 14:02:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Jun 2020 14:15:48 +02:00

x86/entry: Make NMI use IDTENTRY_RAW

For no reason other than beginning brainmelt, IDTENTRY_NMI was mapped to
IDTENTRY_IST.

This is not a problem on 64bit because the IST default entry point maps to
IDTENTRY_RAW which does not any entry handling. The surplus function
declaration for the noist C entry point is unused and as there is no ASM
code emitted for NMI this went unnoticed.

On 32bit IDTENTRY_IST maps to a regular IDTENTRY which does the normal
entry handling. That is clearly the wrong thing to do for NMI.

Map it to IDTENTRY_RAW to unbreak it. The IDTENTRY_NMI mapping needs to
stay to avoid emitting ASM code.

Fixes: 6271fef00b34 ("x86/entry: Convert NMI to IDTENTRY_NMI")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Debugged-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com
---
 arch/x86/include/asm/idtentry.h | 4 ++--
 arch/x86/kernel/nmi.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 2fc6b0c..cf51c50 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -391,8 +391,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
 
-#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_IST
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
+#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
 
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3a98ff3..2de365f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -476,7 +476,7 @@ static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
-DEFINE_IDTENTRY_NMI(exc_nmi)
+DEFINE_IDTENTRY_RAW(exc_nmi)
 {
 	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
 		return;
