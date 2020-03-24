Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B594208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgCXOYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45067 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCXOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGkTE-0006z6-7e; Tue, 24 Mar 2020 15:23:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D28B1C0451;
        Tue, 24 Mar 2020 15:23:55 +0100 (CET)
Date:   Tue, 24 Mar 2020 14:23:55 -0000
From:   "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Use bool type for vmw_sched_clock
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323195707.31242-6-amakhalov@vmware.com>
References: <20200323195707.31242-6-amakhalov@vmware.com>
MIME-Version: 1.0
Message-ID: <158505983520.28353.190987036145128922.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     8fefe9dacdb0a1347d3dac871bb1bba3cbc32945
Gitweb:        https://git.kernel.org/tip/8fefe9dacdb0a1347d3dac871bb1bba3cbc32945
Author:        Alexey Makhalov <amakhalov@vmware.com>
AuthorDate:    Mon, 23 Mar 2020 19:57:07 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 10:29:22 +01:00

x86/vmware: Use bool type for vmw_sched_clock

To be aligned with other bool variables.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323195707.31242-6-amakhalov@vmware.com
---
 arch/x86/kernel/cpu/vmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index e885f73..9b6fafa 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -122,14 +122,14 @@ static unsigned long vmware_get_tsc_khz(void)
 
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
-static int vmw_sched_clock __initdata = 1;
+static bool vmw_sched_clock __initdata = true;
 static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, vmw_steal_time) __aligned(64);
 static bool has_steal_clock;
 static bool steal_acc __initdata = true; /* steal time accounting */
 
 static __init int setup_vmw_sched_clock(char *s)
 {
-	vmw_sched_clock = 0;
+	vmw_sched_clock = false;
 	return 0;
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
