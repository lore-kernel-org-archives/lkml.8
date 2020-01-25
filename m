Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9141C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBCC206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAYMCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 07:02:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44487 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAYMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 07:02:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivK8V-0001Ra-2G; Sat, 25 Jan 2020 13:01:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A0E01C1A7C;
        Sat, 25 Jan 2020 13:01:58 +0100 (CET)
Date:   Sat, 25 Jan 2020 12:01:58 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/CPU/AMD: Remove amd_get_topology_early()
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200123165811.5288-1-bp@alien8.de>
References: <20200123165811.5288-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157995371825.396.10029580328827655787.tip-bot2@tip-bot2>
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

Commit-ID:     3c749b81ee99ef1a01d342ee5e4bc01e4332eb75
Gitweb:        https://git.kernel.org/tip/3c749b81ee99ef1a01d342ee5e4bc01e4332eb75
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 23 Jan 2020 17:54:33 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 25 Jan 2020 12:59:46 +01:00

x86/CPU/AMD: Remove amd_get_topology_early()

... and fold its function body into its single call site.

No functional changes:

  # arch/x86/kernel/cpu/amd.o:

   text    data     bss     dec     hex filename
   5994     385       1    6380    18ec amd.o.before
   5994     385       1    6380    18ec amd.o.after

md5:
   99ec6daa095b502297884e949c520f90  amd.o.before.asm
   99ec6daa095b502297884e949c520f90  amd.o.after.asm

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200123165811.5288-1-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 90f75e5..8a88d3f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -319,13 +319,6 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
 	c->cpu_core_id %= cus_per_node;
 }
 
-
-static void amd_get_topology_early(struct cpuinfo_x86 *c)
-{
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-}
-
 /*
  * Fixup core topology information for
  * (1) AMD multi-node processors
@@ -717,7 +710,8 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 		}
 	}
 
-	amd_get_topology_early(c);
+	if (cpu_has(c, X86_FEATURE_TOPOEXT))
+		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)
