Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A60C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42220873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgB2QbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:31:04 -0500
Received: from mailoutvs57.siol.net ([185.57.226.248]:46030 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbgB2QbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:31:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 5554A5234DF;
        Sat, 29 Feb 2020 17:31:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LRxk0qdFBi8A; Sat, 29 Feb 2020 17:31:01 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id F2C455235D9;
        Sat, 29 Feb 2020 17:31:00 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 37AEE5234DF;
        Sat, 29 Feb 2020 17:30:59 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/bridge: dw-hdmi: Various updates
Date:   Sat, 29 Feb 2020 17:30:39 +0100
Message-Id: <20200229163043.158262-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes multiple issues I found out.
Patch 1 fixes reporting colorimetry in AVI frame.
Patch 2 fixes color space conversion detection. At the moment it doesn't
change anything, but it would needlessly enable CSC unit when conversion
is not needed.
Patch 3 sets scan mode to underscan which is in line with most other hdmi
drivers.
Patch 4 aligns RGB quantization to CEA 861 standard.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (3):
  drm/bridge: dw-hdmi: fix AVI frame colorimetry
  drm/bridge: dw-hdmi: Fix color space conversion detection
  drm/bridge: dw-hdmi: Add support for RGB limited range

Jonas Karlman (1):
  drm/bridge: dw-hdmi: do not force "none" scan mode

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 87 ++++++++++++++++-------
 1 file changed, 62 insertions(+), 25 deletions(-)

--=20
2.25.1

