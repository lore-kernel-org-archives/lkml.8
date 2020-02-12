Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A90C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707AA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBLOvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:51:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgBLOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:51:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1tLl-0006ic-Tu; Wed, 12 Feb 2020 15:50:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89A1D1C202C;
        Wed, 12 Feb 2020 15:50:49 +0100 (CET)
Date:   Wed, 12 Feb 2020 14:50:49 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Warn when checking alignment of
 disabled xfeatures
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109211452.27369-4-yu-cheng.yu@intel.com>
References: <20200109211452.27369-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158151904924.411.12474197700112093867.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e70b100806d63fb79775858ea92e1a716da46186
Gitweb:        https://git.kernel.org/tip/e70b100806d63fb79775858ea92e1a716da46186
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Thu, 09 Jan 2020 13:14:52 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 12 Feb 2020 15:43:34 +01:00

x86/fpu/xstate: Warn when checking alignment of disabled xfeatures

An XSAVES component's alignment/offset is meaningful only when the
feature is enabled. Return zero and WARN_ONCE on checking alignment of
disabled features.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200109211452.27369-4-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index edcaacd..73fe597 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -325,6 +325,13 @@ static int xfeature_is_aligned(int xfeature_nr)
 	u32 eax, ebx, ecx, edx;
 
 	CHECK_XFEATURE(xfeature_nr);
+
+	if (!xfeature_enabled(xfeature_nr)) {
+		WARN_ONCE(1, "Checking alignment of disabled xfeature %d\n",
+			  xfeature_nr);
+		return 0;
+	}
+
 	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
 	/*
 	 * The value returned by ECX[1] indicates the alignment
