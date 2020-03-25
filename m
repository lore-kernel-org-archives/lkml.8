Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FBAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E534F207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCYMGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nK-0000iV-5D; Wed, 25 Mar 2020 13:06:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AD8ED1C0470;
        Wed, 25 Mar 2020 13:06:01 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:01 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] firmware: psci: Replace cpu_up/down() with add/remove_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-15-qais.yousef@arm.com>
References: <20200323135110.30522-15-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796137.28353.17348529799855169682.tip-bot2@tip-bot2>
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

Commit-ID:     20fb50295b139494754964d7d005b5a2f465ef08
Gitweb:        https://git.kernel.org/tip/20fb50295b139494754964d7d005b5a2f465ef08
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:07 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:37 +01:00

firmware: psci: Replace cpu_up/down() with add/remove_cpu()

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down().

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface of the CPU subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Link: https://lkml.kernel.org/r/20200323135110.30522-15-qais.yousef@arm.com

---
 drivers/firmware/psci/psci_checker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 6a44539..873841a 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -84,7 +84,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 
 	/* Try to power down all CPUs in the mask. */
 	for_each_cpu(cpu, cpus) {
-		int ret = cpu_down(cpu);
+		int ret = remove_cpu(cpu);
 
 		/*
 		 * cpu_down() checks the number of online CPUs before the TOS
@@ -116,7 +116,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 
 	/* Try to power up all the CPUs that have been offlined. */
 	for_each_cpu(cpu, offlined_cpus) {
-		int ret = cpu_up(cpu);
+		int ret = add_cpu(cpu);
 
 		if (ret != 0) {
 			pr_err("Error occurred (%d) while trying "
