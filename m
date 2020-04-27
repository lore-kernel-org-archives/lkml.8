Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF12CC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A772070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgD0Uog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0Uof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:44:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74499C0610D5;
        Mon, 27 Apr 2020 13:44:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jTAc9-00006V-U0; Mon, 27 Apr 2020 22:44:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 059CF1C0131;
        Mon, 27 Apr 2020 22:44:29 +0200 (CEST)
Date:   Mon, 27 Apr 2020 20:44:28 -0000
From:   "tip-bot2 for Ethon Paul" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Fix a typo in comment
 "broadacasted"->"broadcasted"
Cc:     Ethon Paul <ethp@qq.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200417164008.6541-1-ethp@qq.com>
References: <20200417164008.6541-1-ethp@qq.com>
MIME-Version: 1.0
Message-ID: <158802026848.28353.13219786488498822850.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     182e073f68a080a29920f6dca796ccf4806b0329
Gitweb:        https://git.kernel.org/tip/182e073f68a080a29920f6dca796ccf4806b0329
Author:        Ethon Paul <ethp@qq.com>
AuthorDate:    Sat, 18 Apr 2020 00:40:04 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Apr 2020 22:42:04 +02:00

cpu/hotplug: Fix a typo in comment "broadacasted"->"broadcasted"

Signed-off-by: Ethon Paul <ethp@qq.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200417164008.6541-1-ethp@qq.com

---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2371292..6a02d44 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -432,7 +432,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	/*
 	 * On x86 it's required to boot all logical CPUs at least once so
 	 * that the init code can get a chance to set CR4.MCE on each
-	 * CPU. Otherwise, a broadacasted MCE observing CR4.MCE=0b on any
+	 * CPU. Otherwise, a broadcasted MCE observing CR4.MCE=0b on any
 	 * core will shutdown the machine.
 	 */
 	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
