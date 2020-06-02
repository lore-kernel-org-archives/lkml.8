Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A07206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:41:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E1C061A0E;
        Tue,  2 Jun 2020 04:41:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jg5Hr-000499-3z; Tue, 02 Jun 2020 13:40:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8CB2B1C01BB;
        Tue,  2 Jun 2020 13:40:54 +0200 (CEST)
Date:   Tue, 02 Jun 2020 11:40:54 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Fix RAPL config variable bug
Cc:     Ingo Molnar <mingo@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528201614.250182-1-eranian@google.com>
References: <20200528201614.250182-1-eranian@google.com>
MIME-Version: 1.0
Message-ID: <159109805436.17951.2430178152420855778.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     16accae3d97f97d7f61c4ee5d0002bccdef59088
Gitweb:        https://git.kernel.org/tip/16accae3d97f97d7f61c4ee5d0002bccdef59088
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Thu, 28 May 2020 13:16:14 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Jun 2020 11:52:56 +02:00

perf/x86/rapl: Fix RAPL config variable bug

This patch fixes a bug introduced by:

  fd3ae1e1587d6 ("perf/x86/rapl: Move RAPL support to common x86 code")

The Kconfig variable name was wrong. It was missing the CONFIG_ prefix.

Signed-off-by: Stephane Eranian <eraniangoogle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200528201614.250182-1-eranian@google.com
---
 arch/x86/events/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 12c42eb..9933c0e 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o
-obj-$(PERF_EVENTS_INTEL_RAPL)		+= rapl.o
+obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
