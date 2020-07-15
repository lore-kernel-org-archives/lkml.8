Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E04C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8EF2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGOONv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:13:51 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49468 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgGOONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:13:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F20651A0467;
        Wed, 15 Jul 2020 16:13:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE3491A01F3;
        Wed, 15 Jul 2020 16:13:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E5028402DF;
        Wed, 15 Jul 2020 22:13:36 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] ASoC: fsl-asoc-card: Support hp and mic detection
Date:   Wed, 15 Jul 2020 22:09:36 +0800
Message-Id: <1594822179-1849-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support hp and mic detection.
Add a parameter for asoc_simple_init_jack.

Shengjiu Wang (3):
  ASoC: simple-card-utils: Support configure pin_name for
    asoc_simple_init_jack
  ASoC: bindings: fsl-asoc-card: Support hp-det-gpio and mic-det-gpio
  ASoC: fsl-asoc-card: Support Headphone and Microphone Jack detection

changes in v2:
- Add more comments in third commit
- Add Acked-by Nicolin.

 .../bindings/sound/fsl-asoc-card.txt          |  3 +
 include/sound/simple_card_utils.h             |  6 +-
 sound/soc/fsl/Kconfig                         |  1 +
 sound/soc/fsl/fsl-asoc-card.c                 | 77 ++++++++++++++++++-
 sound/soc/generic/simple-card-utils.c         |  7 +-
 5 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.27.0

