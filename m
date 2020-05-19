Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9748CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CD520849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgESUBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgEST66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B04C08C5C1;
        Tue, 19 May 2020 12:58:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O4-00007z-7L; Tue, 19 May 2020 21:58:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 85F0C1C04D1;
        Tue, 19 May 2020 21:58:41 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:41 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/speculation/mds: Mark
 mds_user_clear_cpu_buffers() __always_inline
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.902709267@linutronix.de>
References: <20200505134340.902709267@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832139.17951.6595527501886095193.tip-bot2@tip-bot2>
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

Commit-ID:     c48dd99ee6c2fe0a5a3e1667eca0cceb57797d21
Gitweb:        https://git.kernel.org/tip/c48dd99ee6c2fe0a5a3e1667eca0cceb57797d21
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Mar 2020 12:49:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:51 +02:00

x86/speculation/mds: Mark mds_user_clear_cpu_buffers() __always_inline

Prevent the compiler from uninlining and creating traceable/probable
functions as this is invoked _after_ context tracking switched to
CONTEXT_USER and rcu idle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.902709267@linutronix.de


---
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d52d1aa..e7752b4 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -262,7 +262,7 @@ DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
  * combination with microcode which triggers a CPU buffer flush when the
  * instruction is executed.
  */
-static inline void mds_clear_cpu_buffers(void)
+static __always_inline void mds_clear_cpu_buffers(void)
 {
 	static const u16 ds = __KERNEL_DS;
 
@@ -283,7 +283,7 @@ static inline void mds_clear_cpu_buffers(void)
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
-static inline void mds_user_clear_cpu_buffers(void)
+static __always_inline void mds_user_clear_cpu_buffers(void)
 {
 	if (static_branch_likely(&mds_user_clear))
 		mds_clear_cpu_buffers();
