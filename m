Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08418C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD1820788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgCXOYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCXOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGkTE-0006z7-BF; Tue, 24 Mar 2020 15:23:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0085F1C0470;
        Tue, 24 Mar 2020 15:23:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 14:23:55 -0000
From:   "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Enable steal time accounting
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323195707.31242-5-amakhalov@vmware.com>
References: <20200323195707.31242-5-amakhalov@vmware.com>
MIME-Version: 1.0
Message-ID: <158505983568.28353.2778877006076369432.tip-bot2@tip-bot2>
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

Commit-ID:     e73a8f38f82dd1c41b70a06556bea7dc250cc384
Gitweb:        https://git.kernel.org/tip/e73a8f38f82dd1c41b70a06556bea7dc250cc384
Author:        Alexey Makhalov <amakhalov@vmware.com>
AuthorDate:    Mon, 23 Mar 2020 19:57:06 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 10:06:27 +01:00

x86/vmware: Enable steal time accounting

Set paravirt_steal_rq_enabled if steal clock present.
paravirt_steal_rq_enabled is used in sched/core.c to adjust task
progress by offsetting stolen time. Use 'no-steal-acc' off switch (share
same name with KVM) to disable steal time accounting.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323195707.31242-5-amakhalov@vmware.com
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/kernel/cpu/vmware.c                    | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d..863b37d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3174,7 +3174,7 @@
 			[X86,PV_OPS] Disable paravirtualized VMware scheduler
 			clock and use the default one.
 
-	no-steal-acc	[X86,KVM,ARM64] Disable paravirtualized steal time
+	no-steal-acc	[X86,PV_OPS,ARM64] Disable paravirtualized steal time
 			accounting. steal time is computed, but won't
 			influence scheduler behaviour
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index cc60461..e885f73 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -125,6 +125,7 @@ static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static int vmw_sched_clock __initdata = 1;
 static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, vmw_steal_time) __aligned(64);
 static bool has_steal_clock;
+static bool steal_acc __initdata = true; /* steal time accounting */
 
 static __init int setup_vmw_sched_clock(char *s)
 {
@@ -133,6 +134,13 @@ static __init int setup_vmw_sched_clock(char *s)
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
+static __init int parse_no_stealacc(char *arg)
+{
+	steal_acc = false;
+	return 0;
+}
+early_param("no-steal-acc", parse_no_stealacc);
+
 static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
@@ -306,8 +314,11 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
 
 static __init int activate_jump_labels(void)
 {
-	if (has_steal_clock)
+	if (has_steal_clock) {
 		static_key_slow_inc(&paravirt_steal_enabled);
+		if (steal_acc)
+			static_key_slow_inc(&paravirt_steal_rq_enabled);
+	}
 
 	return 0;
 }
