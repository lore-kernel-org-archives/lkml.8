Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF8C21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgATPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:39:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33525 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:39:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itZ9I-0002jr-Mg; Mon, 20 Jan 2020 16:39:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 555BE1C1A41;
        Mon, 20 Jan 2020 16:39:32 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:39:32 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove redundant cpu_detect_cache_sizes() call
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <157953477207.396.16207362713509361883.tip-bot2@tip-bot2>
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

Commit-ID:     283bab9809786cf41798512f5c1e97f4b679ba96
Gitweb:        https://git.kernel.org/tip/283bab9809786cf41798512f5c1e97f4b679ba96
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Wed, 15 Jan 2020 16:00:57 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Jan 2020 16:32:35 +01:00

x86/cpu: Remove redundant cpu_detect_cache_sizes() call

Both functions call init_intel_cacheinfo() which computes L2 and L3 cache
sizes from CPUID(4). But then they also call cpu_detect_cache_sizes() a
bit later which computes ->x86_tlbsize and L2 size from CPUID(80000006).

However, the latter call is not needed because

 - on these CPUs, CPUID(80000006).EBX for ->x86_tlbsize is reserved

 - CPUID(80000006).ECX for the L2 size has the same result as CPUID(4)

Therefore, remove the latter call to simplify the code.

 [ bp: Rewrite commit message. ]

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/centaur.c | 2 --
 arch/x86/kernel/cpu/zhaoxin.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 02d99fe..4267925 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -64,8 +64,6 @@ static void init_c3(struct cpuinfo_x86 *c)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 	}
-
-	cpu_detect_cache_sizes(c);
 }
 
 enum {
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 6b2d3b0..df1358b 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -51,8 +51,6 @@ static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
 
 	if (c->x86 >= 0x6)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
-
-	cpu_detect_cache_sizes(c);
 }
 
 static void early_init_zhaoxin(struct cpuinfo_x86 *c)
