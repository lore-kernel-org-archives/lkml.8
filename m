Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618220866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgCDXZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:25:35 -0500
Received: from mailoutvs4.siol.net ([185.57.226.195]:47879 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388476AbgCDXZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:25:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 48B575235DD;
        Thu,  5 Mar 2020 00:25:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EXGg_K0T1SsA; Thu,  5 Mar 2020 00:25:32 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id F060252273A;
        Thu,  5 Mar 2020 00:25:31 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 749F35235DD;
        Thu,  5 Mar 2020 00:25:29 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/bridge: dw-hdmi: Various updates
Date:   Thu,  5 Mar 2020 00:25:08 +0100
Message-Id: <20200304232512.51616-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes multiple issues I found out.
Patch 1 fixes reporting colorimetry in AVI frame.
Patch 2 sets scan mode to underscan which is in line with most other
hdmi drivers.
Patch 3 aligns RGB quantization to CEA 861 standard.
Patch 4 reworks is_color_space_conversion(). Now it checks only if
color space conversion is required. Patch adds separate function for
checking if any kind of conversion is required.

Please take a look.

Best regards,
Jernej

Changes from v2:
- added tags
- replaced patch 2 with patch 4
- renamed rgb conversion matrix and make hex lowercase
- move logic for checking if rgb full to limited range conversion is
  needed to is_color_space_conversion()
- reworked logic for csc matrix selection

Jernej Skrabec (3):
  drm/bridge: dw-hdmi: fix AVI frame colorimetry
  drm/bridge: dw-hdmi: Add support for RGB limited range
  drm/bridge: dw-hdmi: rework csc related functions

Jonas Karlman (1):
  drm/bridge: dw-hdmi: do not force "none" scan mode

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 132 ++++++++++++++--------
 1 file changed, 88 insertions(+), 44 deletions(-)

--=20
2.25.1

