Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC2FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5C02072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgAJOMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:12:03 -0500
Received: from olimex.com ([184.105.72.32]:33323 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgAJOMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:12:02 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:11:56 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 0/2] Add support for sun4i HDMI audio
Date:   Fri, 10 Jan 2020 16:11:38 +0200
Message-Id: <20200110141140.28527-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for HDMI audio for sun4i HDMI encored.
The code uses some parts from the Allwinners's BSP kernel.

Currently cyclic DMA transfers are disabled. The first patch permits them
as they are required for the audio.

The patch is tested on A20 chip. For the other chips, only the addresses
of the registers are checked.

Stefan Mavrodiev (2):
  dmaengine: sun4i: Add support for cyclic requests with dedicated DMA
  drm: sun4i: hdmi: Add support for sun4i HDMI encoder audio

 drivers/dma/sun4i-dma.c                  |  45 +--
 drivers/gpu/drm/sun4i/Kconfig            |   1 +
 drivers/gpu/drm/sun4i/Makefile           |   1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi.h       |  30 ++
 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c | 375 +++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c   |   4 +
 6 files changed, 435 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c

-- 
2.17.1
