Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E39C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6965E2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SHXWde4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgCPPHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:07:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbgCPPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:07:19 -0400
Received: from zn.tnic (p200300EC2F06AB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0CFA1EC0CD0;
        Mon, 16 Mar 2020 16:07:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584371237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=GD2Ahrn2R5rUUvAa4JTLz4UOPMAsrHi8CDaz4s4yJSI=;
        b=SHXWde4fDvWxBfVwik+iIXFlwqSwyFi9wb8Ysb5mMzITlhOyWeBCsXaD4rXksEukZi4a+N
        alU2DEpPFyp2ipQRe5IX8a2/gP3yuxmLbgNH0PFR9q0lXEJ3ma6j3kleNaYAj8VHtRxPMX
        mCwclVqLEcimypLTbgvdcqbReUybTew=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/amd_nb, char/amd64-agp: Use amd_nb_num() accessor
Date:   Mon, 16 Mar 2020 16:07:25 +0100
Message-Id: <20200316150725.925-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... to find whether there are northbridges present on the system.
This converts the last forgotten user and therefore, unexport
amd_nb_misc_ids[] too.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Michal Kubecek <mkubecek@suse.cz>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_nb.h | 1 -
 arch/x86/kernel/amd_nb.c      | 4 +---
 drivers/char/agp/amd64-agp.c  | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 1ae4e5791afa..c7df20e78b09 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -12,7 +12,6 @@ struct amd_nb_bus_dev_range {
 	u8 dev_limit;
 };
 
-extern const struct pci_device_id amd_nb_misc_ids[];
 extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
 
 extern bool early_is_amd_nb(u32 value);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 69aed0ebbdfc..b6b3297851f3 100644
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
index 594aee281977..b40edae32817 100644
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
-- 
2.21.0

