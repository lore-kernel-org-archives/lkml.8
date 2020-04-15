Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC716C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B486320775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408436AbgDOJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895885AbgDOJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E82EC061A0E;
        Wed, 15 Apr 2020 02:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg1-0005sp-BK; Wed, 15 Apr 2020 11:49:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE5841C0081;
        Wed, 15 Apr 2020 11:49:48 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:48 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-4-tony.luck@intel.com>
References: <20200214222720.13168-4-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
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

Commit-ID:     1de08dccd383482a3e88845d3554094d338f5ff9
Gitweb:        https://git.kernel.org/tip/1de08dccd383482a3e88845d3554094d338f5ff9
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:16 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:58:43 +02:00

x86/mce: Add a struct mce.kflags field

There can be many different subsystems register on the mce handler
chain. Add a new bitmask field and define values so that handlers can
indicate whether they took any action to log or otherwise handle an
error.

The default handler at the end of the chain can use this information to
decide whether to print to the console log.

Boris suggested a generic name and leaving plenty of spare bits for
possible future use.

 [ bp: Move flag bits to the internal mce.h header and use BIT_ULL(). ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-4-tony.luck@intel.com
---
 arch/x86/include/asm/mce.h      | 8 ++++++++
 arch/x86/include/uapi/asm/mce.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 689ac6e..5f04a24 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -129,6 +129,14 @@
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
+/* mce.kflags flag bits for logging etc. */
+#define	MCE_HANDLED_CEC		BIT_ULL(0)
+#define	MCE_HANDLED_UC		BIT_ULL(1)
+#define	MCE_HANDLED_EXTLOG	BIT_ULL(2)
+#define	MCE_HANDLED_NFIT	BIT_ULL(3)
+#define	MCE_HANDLED_EDAC	BIT_ULL(4)
+#define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 955c2a2..5b59d80 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,6 +35,7 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
+	__u64 kflags;		/* Internal kernel use. See below */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
