Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18841C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB92A206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgCQJ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:29:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53696 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:29:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jE8Xg-0004vw-2R; Tue, 17 Mar 2020 10:29:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57B081C224C;
        Tue, 17 Mar 2020 10:29:43 +0100 (CET)
Date:   Tue, 17 Mar 2020 09:29:42 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/amd_nb, char/amd64-agp: Use amd_nb_num() accessor
Cc:     Borislav Petkov <bp@suse.de>, Michal Kubecek <mkubecek@suse.cz>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200316150725.925-1-bp@alien8.de>
References: <20200316150725.925-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158443738293.28353.8644910767364715065.tip-bot2@tip-bot2>
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

Commit-ID:     19d33357ecdf6f4d591b4c17f119bacd6ae834eb
Gitweb:        https://git.kernel.org/tip/19d33357ecdf6f4d591b4c17f119bacd6ae834eb
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 16 Mar 2020 13:23:21 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 10:25:58 +01:00

x86/amd_nb, char/amd64-agp: Use amd_nb_num() accessor

... to find whether there are northbridges present on the
system. Convert the last forgotten user and therefore, unexport
amd_nb_misc_ids[] too.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Michal Kubecek <mkubecek@suse.cz>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20200316150725.925-1-bp@alien8.de
---
 arch/x86/include/asm/amd_nb.h | 1 -
 arch/x86/kernel/amd_nb.c      | 4 +---
 drivers/char/agp/amd64-agp.c  | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 1ae4e57..c7df20e 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -12,7 +12,6 @@ struct amd_nb_bus_dev_range {
 	u8 dev_limit;
 };
 
-extern const struct pci_device_id amd_nb_misc_ids[];
 extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
 
 extern bool early_is_amd_nb(u32 value);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 69aed0e..b6b3297 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -36,10 +36,9 @@ static const struct pci_device_id amd_root_ids[] = {
 	{}
 };
 
-
 #define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
 
-const struct pci_device_id amd_nb_misc_ids[] = {
+static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
@@ -56,7 +55,6 @@ const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{}
 };
-EXPORT_SYMBOL_GPL(amd_nb_misc_ids);
 
 static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 594aee2..b40edae 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -775,7 +775,7 @@ int __init agp_amd64_init(void)
 		}
 
 		/* First check that we have at least one AMD64 NB */
-		if (!pci_dev_present(amd_nb_misc_ids)) {
+		if (!amd_nb_num()) {
 			pci_unregister_driver(&agp_amd64_pci_driver);
 			return -ENODEV;
 		}
