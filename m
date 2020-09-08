Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5091021D46
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IlKLM/V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIHHyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgIHHy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:54:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB36C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:54:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so16145958wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXyuP55k/txQU8Qavag22Z7+e0rUydKfwB7MhziBkWA=;
        b=IlKLM/V4WVAAF5C6UBwIZKBIE1WSziNp6P465eu0YCqj+PNnmuZbxxVhsmyBd6cNUj
         59ZYQBae1qOET3I8/xl5AGZZfHhN2Ej3aRPCrK4Yx8hvozgLjAfKMOpm6sDYPkx390zA
         fIw0Qco5ymgedDcLO2EXv7D5DI6mkaucPTDs2/EBwprlcv5SieAKUg/MKBnCwIILiz5P
         DejpAcCYm3bCdcqLqz9+gJ+WZUGigRshU/TchCBG2i7ZBQZke93uo/ECMY8bPaqYNZDZ
         p5hXe8xG/2dj6g99vR8C3pphhOUjcA8MsJc2SQ3GYSUYYdwAN3mFNqvBCqe76a8lPEGN
         z0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXyuP55k/txQU8Qavag22Z7+e0rUydKfwB7MhziBkWA=;
        b=TtLK6+BdIHbZdqQbvOon7quz48wGlAZGS1a3391UZLZHE4ux6Ojj5Biy6klWQyRSzh
         H6AbilqdPxNV8GQ0NHTQjlg6C41LL0iQ5mrgHVEJAGwM/DY0nL1xqR+3xYshk1BatZi+
         UQhAal9PydDbBDDkZAKDBkM9n7rw2XUAox9Zni/S7KTzjJa4GKwb00na8CDDauJiKYce
         qLB9L9dwQlhLWKIYRe+iR5s3f5J0PwqYTaa7tzWtasC1t85JYvr2b7UDqCLlRMMKoA67
         uq0Saz6aE1QkVZpxDMA9SFVes+Vn6QVzhvRuVx3w7Z6938acPMimso0F3Q7KeKPhe93a
         5QuA==
X-Gm-Message-State: AOAM532fzxdkWtLzGovUYsi3sQrxSto+MbYDnKzzCw0zUZxVw5dkiCE/
        yKb02wC9jQ15bhT8KK9KxrGYZQ==
X-Google-Smtp-Source: ABdhPJwDh1eoKWZjAIC9Lu2S/bF0Q1t8OpRqNst9tAsHP3ivthW9uML4FgowbJDYclYeWq08p24mYA==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr3009443wmj.36.1599551666927;
        Tue, 08 Sep 2020 00:54:26 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id f14sm33788291wrv.72.2020.09.08.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:54:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/4] drm: panel: add support for TDO tl070wsh30 panel
Date:   Tue,  8 Sep 2020 09:54:17 +0200
Message-Id: <20200908075421.17344-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support bindings and support for the TDO TL070WSH30 TFT-LCD panel
module shipped with the Amlogic S400 Development Kit.
The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
It provides a MIPI DSI interface to the host, a built-in LED backlight
and touch controller.

Changes since v2 at [2]:
- added reset gpio to panel-simple-dsi bindings
- moved bindings to panel-simple
- re-ordered prepare/unprepare
- added back refresh print
- moved regulator/reset handling in prepare/unprepare
- aligned remove/shutdown with panel-simple
- added sentinel comment into dt match table

Changes since v1 at [1]:
- added missing vendor-prefixes patch
- removed vrefresh
- fixed warning on add_panel return
- removed DRM logging

[1] https://patchwork.freedesktop.org/series/81376/#rev1
[2] https://patchwork.freedesktop.org/series/81376/#rev2

Neil Armstrong (4):
  dt-bindings: vendor-prefixes: Add Shanghai Top Display
    Optolelectronics vendor prefix
  dt-bindings: display: panel-simple-dsi: add optional reset gpio
  dt-bindings: display: panel-simple-dsi: add TDO TL070WSH30 DSI panel
    bindings
  drm: panel: add TDO tl070wsh30 panel driver

 .../display/panel/panel-simple-dsi.yaml       |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 250 ++++++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

-- 
2.22.0

