Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3098207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgGANQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:16:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45788 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgGANQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:16:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 58DE42A56A6
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 0/6] Hantro low-hanging cleanups
Date:   Wed,  1 Jul 2020 10:16:01 -0300
Message-Id: <20200701131607.121988-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Second iteration, just addressing Philipp's and Robin's
feedback on patch 3.

Thanks,
Ezequiel

Ezequiel Garcia (6):
  hantro: h264: Remove unused macro definition
  hantro: h264: Rename scaling list handling function
  hantro: Rework how encoder and decoder are identified
  hantro: Move hantro_enc_buf_finish to JPEG codec_ops.done
  hantro: Remove unused bytesused argument
  hantro: Make sure we don't use post-processor on an encoder

 drivers/staging/media/hantro/hantro.h         | 13 +---
 drivers/staging/media/hantro/hantro_drv.c     | 65 +++++--------------
 .../staging/media/hantro/hantro_h1_jpeg_enc.c | 17 +++++
 drivers/staging/media/hantro/hantro_h264.c    |  6 +-
 drivers/staging/media/hantro/hantro_hw.h      |  5 +-
 drivers/staging/media/hantro/hantro_v4l2.c    | 28 ++++----
 drivers/staging/media/hantro/imx8m_vpu_hw.c   |  2 +-
 drivers/staging/media/hantro/rk3288_vpu_hw.c  |  8 +--
 drivers/staging/media/hantro/rk3399_vpu_hw.c  |  7 +-
 9 files changed, 64 insertions(+), 87 deletions(-)

-- 
2.26.0.rc2

