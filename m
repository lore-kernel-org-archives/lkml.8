Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AED720657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgENSfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbgENSfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:35:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1406DC061A0C;
        Thu, 14 May 2020 11:35:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZIha-0005aR-Fv; Thu, 14 May 2020 20:35:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 08AAA1C0243;
        Thu, 14 May 2020 20:35:26 +0200 (CEST)
Date:   Thu, 14 May 2020 18:35:25 -0000
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/split_lock: Add Icelake microserver CPU model
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1588290395-2677-1-git-send-email-fenghua.yu@intel.com>
References: <1588290395-2677-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158948132586.17726.4500141435426378376.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     0ed7bf1d92eafc37bb9eb7c8692a8e44d24f9b99
Gitweb:        https://git.kernel.org/tip/0ed7bf1d92eafc37bb9eb7c8692a8e44d24f9b99
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Thu, 30 Apr 2020 16:46:35 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 May 2020 19:25:10 +02:00

x86/split_lock: Add Icelake microserver CPU model

Icelake microserver CPU supports split lock detection while it doesn't
have the split lock enumeration bit in IA32_CORE_CAPABILITIES.

Enumerate the feature by model number.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1588290395-2677-1-git-send-email-fenghua.yu@intel.com
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a19a680..b59bc4a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1135,6 +1135,7 @@ void switch_to_sld(unsigned long tifn)
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
