Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0CCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531F922BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1YOoHlD5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/G+MS7m8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHTIhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:37:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45558 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgHTIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:36:50 -0400
Date:   Thu, 20 Aug 2020 08:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597912607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxiFZ88cdDuMggCWLh0tFCrSR07PJLB8m8525tLeOM4=;
        b=1YOoHlD5BU59rb1K8mI7fQ+JeQvD5XtELtf62RCIVC7fKldKwrcbn8izhZ4xNqgipf02+g
        3ggxw2mHQZWKEsUaAGPDYdTSdSGosONqmSb6pqwtWZCp/WJ3QPh1X6ZpGwP3so2BRZBg4m
        CJbGik1qPk0RuOyB0czhw4odNHU7GcbIfjalAAZAoI6Pk+H9hSqswaXKJ2yiTYTAeojtt+
        CRdrAp/rX4f3H7tXef/IrH5FsIRFrq4IoCII/f7L7TGnCIpnMGxXyfF8x3vZJFcKjGEgXe
        48qlACxUp3GalnzTk5gK2qMSxNJwaQBMczMlq2S07Zwjj+L+LT8NKOHWQ4Jpfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597912607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxiFZ88cdDuMggCWLh0tFCrSR07PJLB8m8525tLeOM4=;
        b=/G+MS7m8QbLSlqyV9dBfnAwZtjH2zFE1DgexQCmXuSmXRw+VZnoH5LPe8wrZcveFejIpJC
        TcuH+CN693uBX2AA==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/mce_amd: Remove struct smca_hwid.xec_bitmap
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
References: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <159791260608.3192.6917808025380283740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     368d1887200d68075c064a62a9aa191168cf1eed
Gitweb:        https://git.kernel.org/tip/368d1887200d68075c064a62a9aa191168cf1eed
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 20 Jul 2020 14:53:53 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 20 Aug 2020 10:34:38 +02:00

x86/MCE/AMD, EDAC/mce_amd: Remove struct smca_hwid.xec_bitmap

The Extended Error Code Bitmap (xec_bitmap) for a Scalable MCA bank type
was intended to be used by the kernel to filter out invalid error codes
on a system. However, this is unnecessary after a few product releases
because the hardware will only report valid error codes. Thus, there's
no need for it with future systems.

Remove the xec_bitmap field and all references to it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200720145353.43924-1-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |  1 +-
 arch/x86/kernel/cpu/mce/amd.c | 44 +++++++++++++++++-----------------
 drivers/edac/mce_amd.c        |  4 +---
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf50382..6adced6 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -328,7 +328,6 @@ enum smca_bank_types {
 struct smca_hwid {
 	unsigned int bank_type;	/* Use with smca_bank_types for easy indexing. */
 	u32 hwid_mcatype;	/* (hwid,mcatype) tuple */
-	u32 xec_bitmap;		/* Bitmap of valid ExtErrorCodes; current max is 21. */
 	u8 count;		/* Number of instances. */
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 99be063..0c6b02d 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -132,49 +132,49 @@ static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 }
 
 static struct smca_hwid smca_hwid_mcatypes[] = {
-	/* { bank_type, hwid_mcatype, xec_bitmap } */
+	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
-	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
+	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0)	},
 
 	/* ZN Core (HWID=0xB0) MCA types */
-	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFFF },
-	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10), 0xFFFFFF },
-	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
-	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2), 0xF },
-	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3), 0x1FF },
+	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0)	},
+	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10)	},
+	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1)	},
+	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2)	},
+	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3)	},
 	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
-	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5), 0xFFF },
-	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6), 0x7F },
-	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7), 0xFF },
+	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5)	},
+	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6)	},
+	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7)	},
 
 	/* Data Fabric MCA types */
-	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0), 0x1FF },
-	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0x1F },
-	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2), 0x3FFF },
+	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
+	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
+	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
 
 	/* Unified Memory Controller MCA type */
-	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0xFF },
+	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
 
 	/* Parameter Block MCA type */
-	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0), 0x1 },
+	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
 
 	/* Platform Security Processor MCA type */
-	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0), 0x1 },
-	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1), 0x3FFFF },
+	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0)	},
+	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1)	},
 
 	/* System Management Unit MCA type */
-	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0), 0x1 },
-	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1), 0x7FF },
+	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0)	},
+	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1)	},
 
 	/* Microprocessor 5 Unit MCA type */
-	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2), 0x3FF },
+	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2)	},
 
 	/* Northbridge IO Unit MCA type */
-	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0), 0x1F },
+	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
 	/* PCI Express Unit MCA type */
-	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0), 0x1F },
+	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 325aedf..d4168c4 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -990,10 +990,8 @@ static void decode_smca_error(struct mce *m)
 	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
 
 	/* Only print the decode of valid error codes */
-	if (xec < smca_mce_descs[bank_type].num_descs &&
-			(hwid->xec_bitmap & BIT_ULL(xec))) {
+	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
-	}
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
 		decode_dram_ecc(cpu_to_node(m->extcpu), m);
