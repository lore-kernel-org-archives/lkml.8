Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1731C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C2B2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbfbpQQD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZ59no4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgGVJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGVJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:27 -0400
Date:   Wed, 22 Jul 2020 09:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33vlhfoXAvi92zjdyqBNFRkNoHys63suSf2USBDLYXQ=;
        b=tbfbpQQDP0Ztro2l29E5OPD5121XmWoA8fhw16YU/SFA5BaN9ldzZny6b7tBs/PaJXyq8B
        kyjaX/aXetXw2SvRXkMYmKPthqi1NdXMLbwsyWKgM9kWARJyIjgwNvQxbbOWqy1Wli5ZiI
        Kfwko3X1uV2XflKfYFDnagFbvgmnebjry/z1G1QQc7/PtirArsyWVT17PUGJcB6N9vdWgO
        TICQw+PLjtgHi01+eu/GqqyitjbQv+L5S4lTZoc+3J9bQmCQ7meLG5cQW4Tf25dxilLeNN
        8Uk0ZzorEk9efp9tTl7LcK3wo3yfNTnsxl3M2AQMHXRiu/JgtPD4g6otSUoWYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33vlhfoXAvi92zjdyqBNFRkNoHys63suSf2USBDLYXQ=;
        b=AZ59no4pS29XZKisNZoZYMFOuO8Soib6upttg9E7VamohVfR4JbixGhD/7xKpTS+2XNg0b
        bmlpxdfYb3WxH6Cg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200712165917.9168-3-valentin.schneider@arm.com>
References: <20200712165917.9168-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159540914411.4006.17518831755080064888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     98eb401d09301d8a38c31cc8851ba95ac9385c8f
Gitweb:        https://git.kernel.org/tip/98eb401d09301d8a38c31cc8851ba95ac9385c8f
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Sun, 12 Jul 2020 17:59:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:06 +02:00

sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry

As Russell pointed out [1], this option is severely lacking in the
documentation department, and figuring out if one has the required
dependencies to benefit from turning it on is not straightforward.

Make it non user-visible, and add a bit of help to it. While at it, make it
depend on CPU_FREQ_THERMAL.

[1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200712165917.9168-3-valentin.schneider@arm.com
---
 init/Kconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0498af5..0a97d85 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -492,8 +492,21 @@ config HAVE_SCHED_AVG_IRQ
 	depends on SMP
 
 config SCHED_THERMAL_PRESSURE
-	bool "Enable periodic averaging of thermal pressure"
+	bool
 	depends on SMP
+	depends on CPU_FREQ_THERMAL
+	help
+	  Select this option to enable thermal pressure accounting in the
+	  scheduler. Thermal pressure is the value conveyed to the scheduler
+	  that reflects the reduction in CPU compute capacity resulted from
+	  thermal throttling. Thermal throttling occurs when the performance of
+	  a CPU is capped due to high operating temperatures.
+
+	  If selected, the scheduler will be able to balance tasks accordingly,
+	  i.e. put less load on throttled CPUs than on non/less throttled ones.
+
+	  This requires the architecture to implement
+	  arch_set_thermal_pressure() and arch_get_thermal_pressure().
 
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
