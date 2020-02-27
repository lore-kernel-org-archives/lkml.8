Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FAC4BA3A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A2924687
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgB0CsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:48:03 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44290 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgB0CsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:48:02 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 21D861A017C;
        Thu, 27 Feb 2020 03:48:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EF8DE1A15E1;
        Thu, 27 Feb 2020 03:47:53 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C964402AD;
        Thu, 27 Feb 2020 10:47:44 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] ASoC: Add new module driver for new ASRC
Date:   Thu, 27 Feb 2020 10:41:54 +0800
Message-Id: <cover.1582770784.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module driver for new ASRC in i.MX8MN

Shengjiu Wang (4):
  ASoC: fsl_asrc: Change asrc_width to asrc_format
  ASoC: fsl_asrc: Move common definition to fsl_asrc_common
  ASoC: dt-bindings: fsl_easrc: Add document for EASRC
  ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers

changes in v3
- add new commit "ASoC: fsl_asrc: Change asrc_width to asrc_format"
- modify binding doc to yaml format
- remove fsl_easrc_dma.c, make fsl_asrc_dma.c useable for easrc.

changes in v2
- change i.MX815 to i.MX8MN
- Add changes in Kconfig and Makefile

 .../devicetree/bindings/sound/fsl,easrc.yaml  |   96 +
 sound/soc/fsl/Kconfig                         |   11 +
 sound/soc/fsl/Makefile                        |    2 +
 sound/soc/fsl/fsl_asrc.c                      |  104 +-
 sound/soc/fsl/fsl_asrc.h                      |   74 +-
 sound/soc/fsl/fsl_asrc_common.h               |  105 +
 sound/soc/fsl/fsl_asrc_dma.c                  |   27 +-
 sound/soc/fsl/fsl_easrc.c                     | 2119 +++++++++++++++++
 sound/soc/fsl/fsl_easrc.h                     |  651 +++++
 9 files changed, 3067 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
 create mode 100644 sound/soc/fsl/fsl_asrc_common.h
 create mode 100644 sound/soc/fsl/fsl_easrc.c
 create mode 100644 sound/soc/fsl/fsl_easrc.h

-- 
2.21.0

