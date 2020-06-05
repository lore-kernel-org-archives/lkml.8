Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422EAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117982075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q/hodN43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgFERSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:18:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1625 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFERSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:18:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eda7e730000>; Fri, 05 Jun 2020 10:18:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jun 2020 10:18:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jun 2020 10:18:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 17:18:54 +0000
Received: from krypton.plattnerplace.us.com (172.20.13.39) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server id
 15.0.1473.3 via Frontend Transport; Fri, 5 Jun 2020 17:18:54 +0000
From:   Aaron Plattner <aplattner@nvidia.com>
To:     Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        "Jaroslav Kysela" <perex@perex.cz>
CC:     <linux-kernel@vger.kernel.org>, Nikhil Mahale <nmahale@nvidia.com>,
        "Aaron Plattner" <aplattner@nvidia.com>
Subject: [PATCH] ALSA: hda: Add NVIDIA codec IDs 9a & 9d through a0 to patch table
Date:   Fri, 5 Jun 2020 10:17:07 -0700
Message-ID: <20200605171707.8587-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591377523; bh=4vKiQC0k5/Y1e+l/fdi2Rbr4+Z932FCpGYPw+w3DM5A=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=Q/hodN43vB/JJ3Z1HVP78W2LrW5ptEfI+AadaKDc98LaW/DiCjP/X48fLbvxNQf6E
         lOnUqFXJMV0BlEToT4paVoVM8Zg6Y5HvBw1e14Ij1qW59tpzaed6KTbqCBIpCjunnn
         5uBt5oYjSpphbY4BuomJA8jA6G5EZaPse5Oz0B14z8o/VM4dZdW7lz1FnHgXkNsgtV
         nzfZJYjcpuIw+39Z/8HQt//wqMvbVlhGONGc4a8BocC1/zTXnjHDZIvO8KzLwntH4v
         mmBBkwq+T3GUsMyNq+95h9hTfKyp48+2e4UOtmoGcv7ZSohl1aRHP4/RiMFMqyz8XG
         9axOYzYUtpHtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

