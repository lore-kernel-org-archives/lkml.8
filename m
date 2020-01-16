Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71DC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFABD2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbgAPVCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:02:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53375 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbgAPVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:02:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCHk-00013O-Ce; Thu, 16 Jan 2020 22:02:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BB9E61C1886;
        Thu, 16 Jan 2020 22:02:35 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:02:35 -0000
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Add family ops for Family 19h Models 00h-0Fh
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110015651.14887-5-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-5-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <157920855560.396.17119230849166470415.tip-bot2@tip-bot2>
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

Commit-ID:     2eb61c91c3e2738218e55f2eaf7e78a4435c233d
Gitweb:        https://git.kernel.org/tip/2eb61c91c3e2738218e55f2eaf7e78a4435c233d
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 10 Jan 2020 01:56:50 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 16 Jan 2020 17:09:23 +01:00

EDAC/amd64: Add family ops for Family 19h Models 00h-0Fh

Add family ops to support AMD Family 19h systems. Existing Family 17h
functions can be used. Also, add Family 19h to the list of families to
automatically load the module.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200110015651.14887-5-Yazen.Ghannam@amd.com
---
 drivers/edac/amd64_edac.c | 17 +++++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 428ce98..2488cbf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2336,6 +2336,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F19_CPUS] = {
+		.ctl_name = "F19h",
+		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
+		.max_mcs = 8,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3368,6 +3378,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			family_types[F17_CPUS].ctl_name = "F18h";
 		break;
 
+	case 0x19:
+		fam_type	= &family_types[F19_CPUS];
+		pvt->ops	= &family_types[F19_CPUS].ops;
+		family_types[F19_CPUS].ctl_name = "F19h";
+		break;
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return NULL;
@@ -3626,6 +3642,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x19, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 9be3168..abbf3c2 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -122,6 +122,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
+#define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
+#define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
 
 /*
  * Function 1 - Address Map
@@ -292,6 +294,7 @@ enum amd_families {
 	F17_M10H_CPUS,
 	F17_M30H_CPUS,
 	F17_M70H_CPUS,
+	F19_CPUS,
 	NUM_FAMILIES,
 };
 
