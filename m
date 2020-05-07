Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2362C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF6620857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEGPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727794AbgEGPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:51:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F6C05BD43;
        Thu,  7 May 2020 08:51:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWioR-0005UQ-42; Thu, 07 May 2020 17:51:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A10BC1C0451;
        Thu,  7 May 2020 17:51:50 +0200 (CEST)
Date:   Thu, 07 May 2020 15:51:50 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add a X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro
Cc:     Borislav Petkov <bp@suse.de>, Mark Gross <mgross@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200506071516.25445-3-bp@alien8.de>
References: <20200506071516.25445-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158886671062.8414.14200405175060421500.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d8422f6bb052b44db923a28afd8ceaef63d38d26
Gitweb:        https://git.kernel.org/tip/d8422f6bb052b44db923a28afd8ceaef63d38d26
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 05 May 2020 19:25:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 May 2020 13:48:05 +02:00

x86/cpu: Add a X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro

... to match Intel family 6 CPUs with steppings.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Link: https://lkml.kernel.org/r/20200506071516.25445-3-bp@alien8.de
---
 arch/x86/include/asm/cpu_device_id.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 10426cd..eb8fced 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -160,6 +160,10 @@
 #define X86_MATCH_INTEL_FAM6_MODEL(model, data)				\
 	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
 
+#define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
+	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+						     steppings, X86_FEATURE_ANY, data)
+
 /*
  * Match specific microcode revisions.
  *
