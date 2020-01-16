Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9AC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116A52075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbgAPVCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:02:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53389 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPVCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:02:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCHk-00013P-E9; Thu, 16 Jan 2020 22:02:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F0BB91C18C0;
        Thu, 16 Jan 2020 22:02:35 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:02:35 -0000
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/amd_nb: Add Family 19h PCI IDs
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110015651.14887-4-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <157920855582.396.16470693063688916445.tip-bot2@tip-bot2>
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

Commit-ID:     b3f79ae45904ae987a7c06a9e8d6084d7b73e67f
Gitweb:        https://git.kernel.org/tip/b3f79ae45904ae987a7c06a9e8d6084d7b73e67f
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 10 Jan 2020 01:56:49 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 16 Jan 2020 17:09:18 +01:00

x86/amd_nb: Add Family 19h PCI IDs

Add the new PCI Device 18h IDs for AMD Family 19h systems. Note that
Family 19h systems will not have a new PCI root device ID.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200110015651.14887-4-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 3 +++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 251c795..69aed0e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -22,6 +22,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
+#define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -52,6 +53,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{}
 };
 EXPORT_SYMBOL_GPL(amd_nb_misc_ids);
@@ -66,6 +68,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2302d13..352c0d7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -549,6 +549,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
