Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559152224E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDRKy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 06:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgDRKy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:54:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104FC061A0F;
        Sat, 18 Apr 2020 03:54:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPl7c-0007eg-C9; Sat, 18 Apr 2020 12:54:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ACC9E1C0330;
        Sat, 18 Apr 2020 12:54:50 +0200 (CEST)
Date:   Sat, 18 Apr 2020 10:54:50 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/split_lock: Add Tremont family CPU models
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416205754.21177-4-tony.luck@intel.com>
References: <20200416205754.21177-4-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158720729021.28353.6622662138639985599.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8b9a18a9f2494144fe23fe630d0734310fa65301
Gitweb:        https://git.kernel.org/tip/8b9a18a9f2494144fe23fe630d0734310fa65301
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 16 Apr 2020 13:57:54 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 18 Apr 2020 12:48:44 +02:00

x86/split_lock: Add Tremont family CPU models

Tremont CPUs support IA32_CORE_CAPABILITIES bits to indicate whether
specific SKUs have support for split lock detection.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200416205754.21177-4-tony.luck@intel.com

---
 arch/x86/kernel/cpu/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c23ad48..a19a680 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1135,6 +1135,9 @@ void switch_to_sld(unsigned long tifn)
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
 	{}
 };
 
