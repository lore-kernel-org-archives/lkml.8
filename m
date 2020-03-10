Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2647E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCJJP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:15:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCJJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:15:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jBazO-00025d-Hq; Tue, 10 Mar 2020 10:15:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C3E781C21F0;
        Tue, 10 Mar 2020 10:15:49 +0100 (CET)
Date:   Tue, 10 Mar 2020 09:15:49 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/Kconfig: Drop vendor dependency for X86_UMIP
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <158383174941.28353.575378555250987688.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bdb04a1abbf92c998f1afb5f00a037f2edaec1f7
Gitweb:        https://git.kernel.org/tip/bdb04a1abbf92c998f1afb5f00a037f2edaec1f7
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Mon, 09 Mar 2020 14:06:30 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 10 Mar 2020 10:10:53 +01:00

x86/Kconfig: Drop vendor dependency for X86_UMIP

Some Centaur family 7 CPUs and Zhaoxin family 7 CPUs support the UMIP
feature too. The text size growth which UMIP adds is ~1K and distro
kernels enable it anyway so remove the vendor dependency.

 [ bp: Rewrite commit message. ]

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea770..cb3633d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1875,7 +1875,6 @@ config X86_SMAP
 
 config X86_UMIP
 	def_bool y
-	depends on CPU_SUP_INTEL || CPU_SUP_AMD
 	prompt "User Mode Instruction Prevention" if EXPERT
 	---help---
 	  User Mode Instruction Prevention (UMIP) is a security feature in
