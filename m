Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A316C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7DB2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CmcxRlPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgGLK2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:28:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6132 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgGLK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:28:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ae5750000>; Sun, 12 Jul 2020 03:27:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:28:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 Jul 2020 03:28:52 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:28:49 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:28:49 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0ae5df0000>; Sun, 12 Jul 2020 03:28:48 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] usb: tegra: Fix zero length memory allocation
Date:   Sun, 12 Jul 2020 11:28:37 +0100
Message-ID: <20200712102837.24340-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200712102837.24340-1-jonathanh@nvidia.com>
References: <20200712102837.24340-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594549621; bh=ZoGMMAgPdCQ+9lKQI487OtNuIjExZed4DaQcSTv6vb8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CmcxRlPKDKNc8FKcehiRqGG1fSHBnH4zmy2cyNlha7W8NiDmQ8czSUvsX9PGryX1S
         3ptARPa2ujNeBdyX6tqNphzz1JdEr5S6NEgtbGhoMOtsvkD5NtebE3LvaY/uICQric
         mqbuwt2WUFF+HdALPBdfO2vNvq33ZGJXrfUx2uvwfh1/zK42rluDFFgg5JwmkaG6CQ
         //wMmn1RinaO+Ux2YWhFAuII3q/P7iWNAquEo7uYhTts73PcXBU1nmVs5rVtukfQ9C
         r6kSe6c5I66+QEgnmMPm3CnrmiQmQiDzXmfbl5W238tz4DjZu9CLm7EBLrx96GRYOU
         lJdC1wumLlSMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit cad064f1bd52 ("devres: handle zero size in devm_kmalloc()")
was added system suspend started failing on Tegra186. The kernel log
showed that the Tegra XHCI driver was crashing on entry to suspend when
attemptin the save the USB context. The problem is caused because we
are trying to allocate a zero length array for the IPFS context on
Tegra186 and following commit cad064f1bd52 ("devres: handle zero size
in devm_kmalloc()") this now causes a NULL pointer deference crash
when we try to access the memory. Fix this by only allocating memory
for both the IPFS and FPCI contexts when required.

Cc: stable@vger.kernel.org

Fixes: 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB context save/restore")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 014d79334f50..b2e4e1c128b0 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -851,15 +851,21 @@ static int tegra_xusb_init_context(struct tegra_xusb *tegra)
 {
 	const struct tegra_xusb_context_soc *soc = tegra->soc->context;
 
-	tegra->context.ipfs = devm_kcalloc(tegra->dev, soc->ipfs.num_offsets,
-					   sizeof(u32), GFP_KERNEL);
-	if (!tegra->context.ipfs)
-		return -ENOMEM;
+	if (soc->ipfs.num_offsets > 0) {
+		tegra->context.ipfs = devm_kcalloc(tegra->dev,
+						   soc->ipfs.num_offsets,
+						   sizeof(u32), GFP_KERNEL);
+		if (!tegra->context.ipfs)
+			return -ENOMEM;
+	}
 
-	tegra->context.fpci = devm_kcalloc(tegra->dev, soc->fpci.num_offsets,
-					   sizeof(u32), GFP_KERNEL);
-	if (!tegra->context.fpci)
-		return -ENOMEM;
+	if (soc->fpci.num_offsets > 0) {
+		tegra->context.fpci = devm_kcalloc(tegra->dev,
+						   soc->fpci.num_offsets,
+						   sizeof(u32), GFP_KERNEL);
+		if (!tegra->context.fpci)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.17.1

