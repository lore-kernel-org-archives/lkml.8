Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7C207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFLHsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:48:51 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50570 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgFLHst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:48:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77AE61A0B5F;
        Fri, 12 Jun 2020 09:48:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8EB311A0B5E;
        Fri, 12 Jun 2020 09:48:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3FBAA402D3;
        Fri, 12 Jun 2020 15:48:36 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 0/4] Reuse the dma channel if available in Back-End
Date:   Fri, 12 Jun 2020 15:37:47 +0800
Message-Id: <cover.1591947428.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the dma channel if available in Back-End

Shengjiu Wang (4):
  ASoC: soc-card: export snd_soc_lookup_component_nolocked
  ASoC: dmaengine_pcm: export soc_component_to_pcm
  ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
  ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA

changes in v3:
- update according to Nicolin's comments
- split previous 0003 patch to two patches

changes in v2:
- update according to Mark's comments and split the patch

 include/sound/dmaengine_pcm.h         | 11 +++++++
 include/sound/soc.h                   |  2 ++
 sound/soc/fsl/fsl_asrc_common.h       |  2 ++
 sound/soc/fsl/fsl_asrc_dma.c          | 47 +++++++++++++++++++--------
 sound/soc/soc-core.c                  |  3 +-
 sound/soc/soc-generic-dmaengine-pcm.c | 12 -------
 6 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.21.0

