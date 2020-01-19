Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB10C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA7121739
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgASKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:40:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgASKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 05:40:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1it80f-0001hM-Vp; Sun, 19 Jan 2020 11:40:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4F97D1C1A1D;
        Sun, 19 Jan 2020 11:40:48 +0100 (CET)
Date:   Sun, 19 Jan 2020 10:40:48 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] x86/platform/intel/quark: Explicitly include
 linux/io.h for virt_to_phys()
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157475520975.21853.16355518818746065226.tip-bot2@tip-bot2>
References: <157475520975.21853.16355518818746065226.tip-bot2@tip-bot2>
MIME-Version: 1.0
Message-ID: <157943044805.396.14194881165760729202.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     f803e34d4a25e1cf43f89f21e05176ed19223dc1
Gitweb:        https://git.kernel.org/tip/f803e34d4a25e1cf43f89f21e05176ed19223dc1
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 26 Nov 2019 08:00:09 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:15:47 +01:00

x86/platform/intel/quark: Explicitly include linux/io.h for virt_to_phys()

Similarly to the previous patches by Sean Christopherson:

 "Through a labyrinthian sequence of includes, usage of virt_to_phys() is
  dependent on the include of asm/io.h in x86's asm/realmode.h, which is
  included in x86's asm/acpi.h and thus by linux/acpi.h.  Explicitly
  include linux/io.h to break the dependency on realmode.h so that a
  future patch can remove the realmode.h include from acpi.h without
  breaking the build."

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Link: https://lkml.kernel.org/r/157475520975.21853.16355518818746065226.tip-bot2@tip-bot2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/intel-quark/imr.c          | 2 ++
 arch/x86/platform/intel-quark/imr_selftest.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 6dd25dc..e9d97d5 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -29,6 +29,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/imr.h>
 #include <asm/iosf_mbi.h>
+#include <asm/io.h>
+
 #include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/mm.h>
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 42f879b..4307830 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -14,6 +14,8 @@
 #include <asm-generic/sections.h>
 #include <asm/cpu_device_id.h>
 #include <asm/imr.h>
+#include <asm/io.h>
+
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/types.h>
