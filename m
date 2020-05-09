Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4460FC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E920A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=48.io header.i=@48.io header.b="cYEODrpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgEIL1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728359AbgEIL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:27:02 -0400
Received: from pruto.48.io (48.io [IPv6:2a01:430:17:1::ffff:361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B9C061A0C;
        Sat,  9 May 2020 04:27:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pruto.48.io (Postfix) with ESMTPSA id 7F64194A35;
        Sat,  9 May 2020 13:18:42 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 7F64194A35
Authentication-Results: pruto.48.io; dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
        t=1589023122; bh=rQmJ3VZbaNqR1Alm9ewytRFpWRVzT3bSjw86Qk2N+54=;
        h=From:To:Cc:Subject:Date;
        b=cYEODrpRKCVHjb09MmTrrjw7uMeQ7CpwSZt+CPRFqhFbsVaf4pU0q5NvWPWHYU6xJ
         QywQWnnRsmlsnsI9D089FXG68rV4mJ+kax4ObiNIXLQqhddvpSQX/4Ijl6fiXdGFAo
         ehBA/Jlkctf6It+4KEUL/zzurg3sJPD+v+m22g7g=
From:   srk@48.io
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Marko <srk@48.io>,
        Marek Vasut <marex@denx.de>, Sean Cross <xobs@kosagi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 0/2] Novena laptop panel
Date:   Sat,  9 May 2020 13:18:32 +0200
Message-Id: <20200509111834.26335-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Marko <srk@48.io>

Contains updated patches I've received from Marek with the following
changes:

- yaml docs migration
- fixed Fabios email
- panel commit split into two according to checkpatch request
- added connector for panel

Last review also requested more details for panel like timings and
bus format but these are marked as TBD (timings) in panel datasheet
and the bridge datasheet is not helpful either.

Tested on a Kosagi Novena laptop with imx6 display controller.

Based on v5.7-rc2, applies to drm-misc-next 5e6ed29d72d2

CC: Marek Vasut <marex@denx.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

Sean Cross (2):
  dt-bindings: n133hse-ea1: Add Innolux N133HSE panel
  drm/panel: simple: Add Innolux N133HSE panel support

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 27 +++++++++++++++++++
 2 files changed, 29 insertions(+)

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.25.1

