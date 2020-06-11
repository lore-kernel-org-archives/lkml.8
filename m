Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09FEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27A3206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qo9rJTEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFKSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:08:57 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10771 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:08:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee272db0000>; Thu, 11 Jun 2020 11:07:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Jun 2020 11:08:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Jun 2020 11:08:56 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Jun
 2020 18:08:56 +0000
Received: from krypton.plattnerplace.us.com (10.124.1.5) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server id
 15.0.1473.3 via Frontend Transport; Thu, 11 Jun 2020 18:08:56 +0000
From:   Aaron Plattner <aplattner@nvidia.com>
To:     Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        "Jaroslav Kysela" <perex@perex.cz>
CC:     <linux-kernel@vger.kernel.org>, Nikhil Mahale <nmahale@nvidia.com>,
        "Aaron Plattner" <aplattner@nvidia.com>
Subject: [PATCH v2] ALSA: hda: Add NVIDIA codec IDs 9a & 9d through a0 to patch table
Date:   Thu, 11 Jun 2020 11:08:45 -0700
Message-ID: <20200611180845.39942-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <s5hftb1eqgv.wl-tiwai@suse.de>
References: <s5hftb1eqgv.wl-tiwai@suse.de>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591898843; bh=rm+GjnPU8lOpFbupdg69GElGbE3u5xiSIV8BSqvs+GI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=qo9rJTEz3DVg2f8fWh+nGcpFveWbP/jse78tRkKCkntNCxlo5tgU7UoNeDPQBAC8R
         eHXXrZcFd+721D8AVW+XS0XMZOOC9/lGwC6tL9/BfNVROTu/Gba/tghJV2H1E3vrfX
         ntRvieMq0ButdQIZouEBXdGDBCPm8n2afooHJZ9yjZQtdqChb4dDIrm2d8dl9/1Q//
         NK7F434ZmuU31zPcuZ6CxNxBo4tZth5GFi3+OnhyY646UtqP9XoS5FDh9w9TEz94iQ
         7SufgR+qoiqgAPJzOrI6zEiKF/qoqz81/myx2Ym2PEMzMJ0o9itz+5U94B6ToZS9/f
         qKnEvdbjoLiLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These IDs are for upcoming NVIDIA chips with audio functions that are large=
ly
similar to the existing ones.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index fbd7cc6026d8..e2b21ef5d7d1 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4145,6 +4145,11 @@ HDA_CODEC_ENTRY(0x10de0095, "GPU 95 HDMI/DP",	patch_=
nvhdmi),
 HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0098, "GPU 98 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0099, "GPU 99 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009a, "GPU 9a HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
--=20
2.27.0

