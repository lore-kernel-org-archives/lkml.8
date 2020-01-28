Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AB0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FB924681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgA1OHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:07:03 -0500
Received: from olimex.com ([184.105.72.32]:58579 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgA1OG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:06:57 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 06:06:52 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v3 0/1] Add support for sun4i HDMI audio
Date:   Tue, 28 Jan 2020 16:06:41 +0200
Message-Id: <20200128140642.8404-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for HDMI audio for sun4i HDMI encored.
The code uses some parts from the Allwinners's BSP kernel.

In the previous patch series there was additional patch enabling the
cyclic DMA transfers. It was accepted, so it's omitted here.

The patch is tested on A20 chip. For the other chips, only the addresses
of the registers are checked.

Changes for v3:
 - Dropped the patch which enable the cyclic DMA transfers
 - In v2, a separate platform_driver was created. However this is not
   practical and the idea is dropped.
 - Since this module depends on SND_SOC, a new Kconfig entry is added. When
   SND_SOC is not enabled, the audio part is not initialized.
 - The "big" issue with v1 was that snd_soc_register_card() overwrites
   the driver_data pointer. To resolve this issue, the original pointer is
   stored as drvdata of the card. Then before card unregistering, the
   pointer is restored. This is done by calling additional destroy function.

Changes for v2:
 - Create a new platform driver instead of using the HDMI encoder
 - Expose a new kcontrol to the userspace holding the ELD data
 - Wrap all macro arguments in parentheses

Stefan Mavrodiev (1):
  drm: sun4i: hdmi: Add support for sun4i HDMI encoder audio

 drivers/gpu/drm/sun4i/Kconfig            |  11 +
 drivers/gpu/drm/sun4i/Makefile           |   3 +
 drivers/gpu/drm/sun4i/sun4i_hdmi.h       |  37 ++
 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c | 450 +++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c   |  14 +
 5 files changed, 515 insertions(+)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c

-- 
2.17.1
