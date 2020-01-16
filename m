Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2113C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B986F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbgAPVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:02:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:02:42 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCHl-00013g-0y; Thu, 16 Jan 2020 22:02:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7F7901C0E70;
        Thu, 16 Jan 2020 22:02:36 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:02:36 -0000
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit McaType
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110015651.14887-2-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <157920855629.396.3345590993818919194.tip-bot2@tip-bot2>
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

Commit-ID:     89a76171bf50bd20d44338408b8c09433c302956
Gitweb:        https://git.kernel.org/tip/89a76171bf50bd20d44338408b8c09433c302956
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 10 Jan 2020 01:56:47 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 16 Jan 2020 17:09:02 +01:00

x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit McaType

Add support for a new version of the Load Store unit bank type as
indicated by its McaType value, which will be present in future SMCA
systems.

Add the new (HWID, MCATYPE) tuple. Reuse the same name, since this is
logically the same to the user.

Also, add the new error descriptions to edac_mce_amd.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200110015651.14887-2-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |  1 +
 arch/x86/kernel/cpu/mce/amd.c |  2 ++
 drivers/edac/mce_amd.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c8ff6f6..4359b95 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -290,6 +290,7 @@ extern void apei_mce_report_mem_error(int corrected,
 /* These may be used by multiple smca_hwid_mcatypes */
 enum smca_bank_types {
 	SMCA_LS = 0,	/* Load Store */
+	SMCA_LS_V2,	/* Load Store */
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5167bd2..36211b9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -78,6 +78,7 @@ struct smca_bank_name {
 
 static struct smca_bank_name smca_names[] = {
 	[SMCA_LS]	= { "load_store",	"Load Store Unit" },
+	[SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
 	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
 	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
 	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
@@ -138,6 +139,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* ZN Core (HWID=0xB0) MCA types */
 	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFFF },
+	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10), 0xFFFFFF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
 	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2), 0xF },
 	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3), 0x1FF },
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ea622c6..aa6ea53 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -175,6 +175,33 @@ static const char * const smca_ls_mce_desc[] = {
 	"L2 Fill Data error",
 };
 
+static const char * const smca_ls2_mce_desc[] = {
+	"An ECC error was detected on a data cache read by a probe or victimization",
+	"An ECC error or L2 poison was detected on a data cache read by a load",
+	"An ECC error was detected on a data cache read-modify-write by a store",
+	"An ECC error or poison bit mismatch was detected on a tag read by a probe or victimization",
+	"An ECC error or poison bit mismatch was detected on a tag read by a load",
+	"An ECC error or poison bit mismatch was detected on a tag read by a store",
+	"An ECC error was detected on an EMEM read by a load",
+	"An ECC error was detected on an EMEM read-modify-write by a store",
+	"A parity error was detected in an L1 TLB entry by any access",
+	"A parity error was detected in an L2 TLB entry by any access",
+	"A parity error was detected in a PWC entry by any access",
+	"A parity error was detected in an STQ entry by any access",
+	"A parity error was detected in an LDQ entry by any access",
+	"A parity error was detected in a MAB entry by any access",
+	"A parity error was detected in an SCB entry state field by any access",
+	"A parity error was detected in an SCB entry address field by any access",
+	"A parity error was detected in an SCB entry data field by any access",
+	"A parity error was detected in a WCB entry by any access",
+	"A poisoned line was detected in an SCB entry by any access",
+	"A SystemReadDataError error was reported on read data returned from L2 for a load",
+	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
+	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
+	"A hardware assertion error was reported",
+	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
+};
+
 static const char * const smca_if_mce_desc[] = {
 	"Op Cache Microtag Probe Port Parity Error",
 	"IC Microtag or Full Tag Multi-hit Error",
@@ -378,6 +405,7 @@ struct smca_mce_desc {
 
 static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_LS]	= { smca_ls_mce_desc,	ARRAY_SIZE(smca_ls_mce_desc)	},
+	[SMCA_LS_V2]	= { smca_ls2_mce_desc,	ARRAY_SIZE(smca_ls2_mce_desc)	},
 	[SMCA_IF]	= { smca_if_mce_desc,	ARRAY_SIZE(smca_if_mce_desc)	},
 	[SMCA_L2_CACHE]	= { smca_l2_mce_desc,	ARRAY_SIZE(smca_l2_mce_desc)	},
 	[SMCA_DE]	= { smca_de_mce_desc,	ARRAY_SIZE(smca_de_mce_desc)	},
