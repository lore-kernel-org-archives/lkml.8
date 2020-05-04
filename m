Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569C4206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HdfD/OL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgEDIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:16:49 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10304 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEDIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:16:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafcf640000>; Mon, 04 May 2020 01:16:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 01:16:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 May 2020 01:16:49 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 08:16:48 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 May 2020 08:16:48 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eafcf6d0000>; Mon, 04 May 2020 01:16:48 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/3] ALSA: hda/tegra: correct number of SDO lines for Tegra194
Date:   Mon, 4 May 2020 13:46:14 +0530
Message-ID: <1588580176-2801-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
References: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588580196; bh=+t6kfCjvQiDL8r1qJvd+8QlpafsTcpsPq6mZIgSZ3b0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=HdfD/OL36bhYPiDNI63wTPpBKDNmqOQe+eT5Pjd3/NGNjEPNpjdCRA6TcO1Ncqef0
         ep4/e3E5hFrfxS3YJlnJMU0ib1NMw2khzw3IByMzYjXOSU0ikQzW4NMWE33by5OBDs
         bjRBjSJdaKgeHsscXR3BvjobO1kaGp+a04BIMgNHDYMzJ35k0PYW+5z9Kp/m5+C8sc
         UlAkP5p1aK9X1zh0TkOAUoKmMP1mXisziko4bL7dU+M2+hy4pknuDkn7lrivuTqOXu
         b+Fl7G/CKKXp4xtPC6PzT5ZofrzOo/ggiPyDp8+YbAqnXSWMTPbDMgPbC65hcnR9za
         h7ysBosqw7dhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 supports 4 SDO lines but GCAP register indicates 2 lines. Thus it
does not reflect the true capability of the HW. This patch presents a
workaround by updating NSDO value accordingly in T_AZA_DBG_CFG_2 register.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 773992a..45dc544 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -52,10 +52,21 @@
 #define HDA_IPFS_INTR_MASK        0x188
 #define HDA_IPFS_EN_INTR          (1 << 16)
 
+/* FPCI */
+#define FPCI_DBG_CFG_2		  0x10F4
+#define FPCI_GCAP_NSDO_SHIFT	  18
+#define FPCI_GCAP_NSDO_MASK	  (0x3 << FPCI_GCAP_NSDO_SHIFT)
+
 /* max number of SDs */
 #define NUM_CAPTURE_SD 1
 #define NUM_PLAYBACK_SD 1
 
+/*
+ * Tegra194 does not reflect correct number of SDO lines. Below macro
+ * is used to update the GCAP register to workaround the issue.
+ */
+#define TEGRA194_NUM_SDO_LINES	  4
+
 struct hda_tegra {
 	struct azx chip;
 	struct device *dev;
@@ -275,6 +286,7 @@ static int hda_tegra_init_clk(struct hda_tegra *hda)
 
 static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 {
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 	struct hdac_bus *bus = azx_bus(chip);
 	struct snd_card *card = chip->card;
 	int err;
@@ -298,6 +310,26 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	bus->irq = irq_id;
 	card->sync_irq = bus->irq;
 
+	/*
+	 * Tegra194 has 4 SDO lines and the STRIPE can be used to
+	 * indicate how many of the SDO lines the stream should be
+	 * striped. But GCAP register does not reflect the true
+	 * capability of HW. Below workaround helps to fix this.
+	 *
+	 * GCAP_NSDO is bits 19:18 in T_AZA_DBG_CFG_2,
+	 * 0 for 1 SDO, 1 for 2 SDO, 2 for 4 SDO lines.
+	 */
+	if (of_device_is_compatible(np, "nvidia,tegra194-hda")) {
+		u32 val;
+
+		dev_info(card->dev, "Override SDO lines to %u\n",
+			 TEGRA194_NUM_SDO_LINES);
+
+		val = readl(hda->regs + FPCI_DBG_CFG_2) & ~FPCI_GCAP_NSDO_MASK;
+		val |= (TEGRA194_NUM_SDO_LINES >> 1) << FPCI_GCAP_NSDO_SHIFT;
+		writel(val, hda->regs + FPCI_DBG_CFG_2);
+	}
+
 	gcap = azx_readw(chip, GCAP);
 	dev_dbg(card->dev, "chipset global capabilities = 0x%x\n", gcap);
 
@@ -408,6 +440,7 @@ static int hda_tegra_create(struct snd_card *card,
 
 static const struct of_device_id hda_tegra_match[] = {
 	{ .compatible = "nvidia,tegra30-hda" },
+	{ .compatible = "nvidia,tegra194-hda" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hda_tegra_match);
-- 
2.7.4

