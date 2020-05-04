Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4104C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12AA206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iE1BOjs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgEDIRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:17:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6462 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEDIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:17:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafcf060000>; Mon, 04 May 2020 01:15:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 01:17:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 May 2020 01:17:10 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 08:17:09 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 May 2020 08:17:09 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eafcf820000>; Mon, 04 May 2020 01:17:09 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/3] ALSA: hda/tegra: workaround playback failure on Tegra194
Date:   Mon, 4 May 2020 13:46:16 +0530
Message-ID: <1588580176-2801-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
References: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588580103; bh=WNT88ANDIHC0JWxzH3jGujojpL78mvTrgwyTiOJDzHA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=iE1BOjs4MsfbgnJJXVqSCvBcCWZ7kRUSBO9KUsZugi6pdT1Cnv2kJcQcN+2pwFuki
         VicfiYFOER0/UcBXqbQqHFI3CYdlbFG/7jIEkZMj75zUjZzgkmLwKUcB1KKBtUKcWG
         8h1omVv+9qRoe2LFbOanfUu20/NCn7dNePSByZUAS88NY+wNG7XaGpNxIlE8ywMxVs
         0CwSXJXIg4brwAztFjZGTHJl7pIotCb0sEy5pQ0vXDUCzSJmxa7bvEXOIH8iw3PIYR
         v9VxUQAFYpBq73NYQzSb523Xb1M6vc3MC/cdjxhLEzJns6jsLg0vTTJIJrrupE7UQb
         co604IpzEzDjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 has 4 SDO lines and with this configuration playback fails
for 44.1K/48K, 2-channel and 16-bps. It results in below print,
  "aplay: pcm_write:2011: write error: Input/output error"

Below relation is used to derive stripe control and is referenced
from HD Audio Specification: Revision 1.0a.
  { ((num_channels * bits_per_sample) / number of SDOs) >= 8 }

Due to a legacy HW design problem, playback issue is hit while using
a stripe value resulting from above formula when ratio is '8'. Thus
it is recommended that the ratio must be greater than '8'. Since the
number of SDO lines is in powers of 2, next available ratio '16' is
used as a limiting factor on Tegra194 to workaround the problem.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 45dc544..0cc5fad 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -364,6 +364,23 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	/* initialize chip */
 	azx_init_chip(chip, 1);
 
+	/*
+	 * Playback (for 44.1K/48K, 2-channel, 16-bps) fails with
+	 * 4 SDO lines due to legacy design limitation. Following
+	 * is, from HD Audio Specification (Revision 1.0a), used to
+	 * control striping of the stream across multiple SDO lines
+	 * for sample rates <= 48K.
+	 *
+	 * { ((num_channels * bits_per_sample) / number of SDOs) >= 8 }
+	 *
+	 * Due to legacy design issue it is recommended that above
+	 * ratio must be greater than 8. Since number of SDO lines is
+	 * in powers of 2, next available ratio is 16 which can be
+	 * used as a limiting factor here.
+	 */
+	if (of_device_is_compatible(np, "nvidia,tegra194-hda"))
+		chip->bus.core.sdo_limit = 16;
+
 	/* codec detection */
 	if (!bus->codec_mask) {
 		dev_err(card->dev, "no codecs found!\n");
-- 
2.7.4

