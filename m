Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62DD208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgFPTkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgFPTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:40:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360CC061573;
        Tue, 16 Jun 2020 12:40:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlHRw-0007o7-3Z; Tue, 16 Jun 2020 21:40:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 619811C0095;
        Tue, 16 Jun 2020 21:40:47 +0200 (CEST)
Date:   Tue, 16 Jun 2020 19:40:47 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add pr_fmt() to debug macros
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200615175315.17301-1-bp@alien8.de>
References: <20200615175315.17301-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <159233644713.16989.15410679000166153913.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     1b2e335ebfa2243517e09f99653c78d1936cb6d2
Gitweb:        https://git.kernel.org/tip/1b2e335ebfa2243517e09f99653c78d1936cb6d2
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 15 Jun 2020 19:49:46 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 16 Jun 2020 20:34:16 +02:00

x86/alternatives: Add pr_fmt() to debug macros

... in order to have debug output prefixed with the pr_fmt text "SMP
alternatives:" which allows easy grepping:

  $ dmesg | grep "SMP alternatives"
  [    0.167783] SMP alternatives: alt table ffffffff8272c780, -> ffffffff8272fd6e
  [    0.168620] SMP alternatives: feat: 3*32+16, old: (x86_64_start_kernel+0x37/0x73 \
		  (ffffffff826093f7) len: 5), repl: (ffffffff8272fd6e, len: 5), pad: 0
  [    0.170103] SMP alternatives: ffffffff826093f7: old_insn: e8 54 a8 da fe
  [    0.171184] SMP alternatives: ffffffff8272fd6e: rpl_insn: e8 cd 3e c8 fe
  ...

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200615175315.17301-1-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff..9e7dc37 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -53,7 +53,7 @@ __setup("noreplace-smp", setup_noreplace_smp);
 #define DPRINTK(fmt, args...)						\
 do {									\
 	if (debug_alternative)						\
-		printk(KERN_DEBUG "%s: " fmt "\n", __func__, ##args);	\
+		printk(KERN_DEBUG pr_fmt(fmt) "\n", ##args);		\
 } while (0)
 
 #define DUMP_BYTES(buf, len, fmt, args...)				\
@@ -64,7 +64,7 @@ do {									\
 		if (!(len))						\
 			break;						\
 									\
-		printk(KERN_DEBUG fmt, ##args);				\
+		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
 		for (j = 0; j < (len) - 1; j++)				\
 			printk(KERN_CONT "%02hhx ", buf[j]);		\
 		printk(KERN_CONT "%02hhx\n", buf[j]);			\
