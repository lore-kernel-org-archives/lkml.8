Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0069C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2999222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgCJNRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:17:40 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:48830 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731291AbgCJNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:17:37 -0400
X-IronPort-AV: E=Sophos;i="5.70,537,1574089200"; 
   d="scan'208";a="41284250"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2020 22:17:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 01B764290415;
        Tue, 10 Mar 2020 22:17:33 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/3] media: i2c: imx219: Feature enhancements
Date:   Tue, 10 Mar 2020 13:17:06 +0000
Message-Id: <1583846229-6799-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following:
1: Makes sure the sensor is LP11 state on power up
2: Adds support for RAW8
3: Adds support for 640x480 resolution

Changes for v4:
1: Fixed review comments for patch 2/2 as request by Sakari.

Changes for v3:
1: Only patch 3/3 was posted for review.

Changes for v2:
1: Dropped setting the format in probe to coax the sensor to enter LP11
   state.
2: Fixed switching between RAW8/RAW10 modes.
3: Fixed fps setting for 640x480 and switched to auto mode.

Lad Prabhakar (3):
  media: i2c: imx219: Fix power sequence
  media: i2c: imx219: Add support for RAW8 bit bayer format
  media: i2c: imx219: Add support for cropped 640x480 resolution

 drivers/media/i2c/imx219.c | 235 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 202 insertions(+), 33 deletions(-)

-- 
2.7.4

