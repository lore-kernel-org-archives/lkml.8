Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AD5208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgE0MQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:16:58 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:48188 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgE0MQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:16:58 -0400
X-IronPort-AV: E=Sophos;i="5.73,441,1583161200"; 
   d="scan'208";a="48154563"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 May 2020 21:16:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 22FED42BA9EB;
        Wed, 27 May 2020 21:16:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 0/3] media: rcar-vin: Enable MEDIA_BUS_FMT_SRGGB8_1X8 format
Date:   Wed, 27 May 2020 13:16:47 +0100
Message-Id: <1590581810-19317-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds support for MEDIA_BUS_FMT_SRGGB8_1X8 format for vin

Cheers,
Prabhakar

Changes for v5:
* Made sure raw mbus fmt results in raw pixel format for
  MEDIA_BUS_FMT_SRGGB8_1X8

Changed for v4:
* patch 1/3 is new patch which adds a check for conversion from input to
  output.
* patch 2/3 added a comment while setting VNIS_REG for RAW format as
  suggested by Niklas

Changes for v3:
* Dropped patch 1/1 from v2 as this handled neatly by patches
  https://patchwork.linuxtv.org/project/linux-media/list/?series=1974
* Included Ack from Niklas for patch 2/2
* Updated commit message for patch 1/1.

Changes for v2:
* Added support for matching fwnode against endpoints/nodes.
* Separated patch for rcar-vin and rcar-csi2.c which added
  MEDIA_BUS_FMT_SRGGB8_1X8.

Lad Prabhakar (3):
  media: rcar-vin: Invalidate pipeline if conversion is not possible on
    input formats
  media: rcar-vin: Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format
  media: rcar-csi2: Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format

 drivers/media/platform/rcar-vin/rcar-csi2.c |  1 +
 drivers/media/platform/rcar-vin/rcar-dma.c  | 21 +++++++++++++++++++--
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 15 ++++++++++++---
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.17.1

