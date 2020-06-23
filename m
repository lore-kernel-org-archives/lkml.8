Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD278C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B991620656
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgFWPeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:34:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E4C061573;
        Tue, 23 Jun 2020 08:34:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jnkw5-0004ii-3F; Tue, 23 Jun 2020 17:34:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 99A671C0244;
        Tue, 23 Jun 2020 17:34:08 +0200 (CEST)
Date:   Tue, 23 Jun 2020 15:34:08 -0000
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce, EDAC/mce_amd: Print PPIN in machine check records
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200623130059.8870-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200623130059.8870-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <159292644833.16989.6633406941442474349.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     bb2de0adca217a114ce023489426e24152e4bfcf
Gitweb:        https://git.kernel.org/tip/bb2de0adca217a114ce023489426e24152e4bfcf
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Tue, 23 Jun 2020 08:00:59 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 23 Jun 2020 17:27:53 +02:00

x86/mce, EDAC/mce_amd: Print PPIN in machine check records

Print the Protected Processor Identification Number (PPIN) on processors
which support it.

 [ bp: Massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200623130059.8870-1-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 2 ++
 drivers/edac/mce_amd.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce9120c..0865349 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -244,6 +244,8 @@ static void __print_mce(struct mce *m)
 		pr_cont("ADDR %llx ", m->addr);
 	if (m->misc)
 		pr_cont("MISC %llx ", m->misc);
+	if (m->ppin)
+		pr_cont("PPIN %llx ", m->ppin);
 
 	if (mce_flags.smca) {
 		if (m->synd)
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2b5401d..325aedf 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1094,6 +1094,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (m->status & MCI_STATUS_ADDRV)
 		pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", m->addr);
 
+	if (m->ppin)
+		pr_emerg(HW_ERR "PPIN: 0x%016llx\n", m->ppin);
+
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
