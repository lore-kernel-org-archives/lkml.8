Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDDDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255612072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591860992;
	bh=CT+nRSifJ5/9M5ZQn6QlYcpQ4iRZi29gzGIoAgD+MZM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=byj3ddMmPOleo2kryCRM+te9RD1fJiqanouKzQ9mNQtlqOfcSmUOdmkrBPwtuz5tI
	 Gqq6uQqlYP0vSysBUQpHntzlhWXiI8Fx5wWpODgumb28mLuL8FCeLu5GSjsX3Cz47+
	 4FWfIKdgKw+amp9emcHT8xCKuNlpr69x4S/yimb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgFKHga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:36:29 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E482072F;
        Thu, 11 Jun 2020 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591860989;
        bh=CT+nRSifJ5/9M5ZQn6QlYcpQ4iRZi29gzGIoAgD+MZM=;
        h=From:To:Cc:Subject:Date:From;
        b=S+lwhGFMHF8QODVcZLdDK/U+v7Ga920A6/87j+vPNfJuwRiXv9Fs3zDVKdoMAva8S
         XKJjzVp1SoW9HzslsDxFUiFZJpv+nq0XZmySUXxYagmvyWiMQuFJnC1UBPTvTHAOrb
         dkSw4xEnTonrpYLTgXgxvhDbH30fQqSwpzU0Fbpo=
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v2 0/3] Add LT9611 DSI to HDMI bridge
Date:   Thu, 11 Jun 2020 13:06:08 +0530
Message-Id: <20200611073611.1446562-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds driver and bindings for Lontium LT9611 bridge chip which
takes MIPI DSI as input and HDMI as output.

This chip can be found in 96boards RB3 platform [1] commonly called DB845c.

[1]: https://www.96boards.org/product/rb3-platform/

Changes in v2:
 - Add acks by Rob
 - Fix comments reported by Emil and rename the file to lontium-lt9611.c
 - Fix comments reported by Laurent on binding and driver
 - Add HDMI audio support

Vinod Koul (3):
  dt-bindings: vendor-prefixes: Add Lontium vendor prefix
  dt-bindings: display: bridge: Add documentation for LT9611
  drm/bridge: Introduce LT9611 DSI to HDMI bridge

 .../display/bridge/lontium,lt9611.yaml        |  176 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/gpu/drm/bridge/Kconfig                |   13 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611.c       | 1219 +++++++++++++++++
 5 files changed, 1411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611.c

-- 
2.26.2

