Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74089C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1632120709
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QmBXtZsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgIGLZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgIGLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:23:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AEC0617B1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:10:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so15416121wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyfLckJhiZ5sjHjg6KN13DoyRvqbjPb2/1GNLHUTQ18=;
        b=QmBXtZscSFhFSWmsqbWRggCLAvMzSVGeAB6uNwTdM11fep54tfrxptBj+Rd04GjKwU
         ZO/seRoLaVJDlrcn5Y6Q0GrKitqT9URFvyE7524RsQd0UKxWpDkp5+3VoKjiIB03A7kN
         7KaO/TzW3UYcLcuzYXkfNpJnYtgbkKkfMJaq2ZGjOvKxpsb8egJGHVNPLx/+YZ7D7HIL
         X/prO/CU2BMymmOCgs45XbqHNZlv10+915vQvZBs5+UG6V2+a6HZ/qTz0X/nGD7UNIn8
         wJApzbh0qn5frSxnTrjUygmG6ePUI1fgFhcZ7gy0KmuLbmJ8Kiy1rQVx+IG4GypJQfeZ
         LOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyfLckJhiZ5sjHjg6KN13DoyRvqbjPb2/1GNLHUTQ18=;
        b=WRweKPvZ0JBTXiTjP1UGzey3TbOqpDDM0yoBgbyXn8X75pDRKFHE4JGZoxgTdrCNo7
         ar+Eoxilg0LbypPisFF4hcHEppwqKRZBQI75GbDBbnnLA8XNLpuMDJtIvWFQ1hIweJXU
         rXOUtvDCVXDIaAm/AxmQvE/R/nH/7Fupt1pwctYkRXY1+I4R7Rb0FqaeRwA8fB94Taak
         EDbW3kbSGZ4ObshTJCDjymjNx9P0fgJRNa/boakep2knSAVBY3LHk+YNaO1tHmrGj/Lm
         V58Q47V8S9z5JEgz8JU7LuuMugSD91Y5hS/Hr6qzOzlS+p5pMkFjVjif1X5nIgDp1AkC
         zfLw==
X-Gm-Message-State: AOAM530sS9kXQjSRBEE4wbcIuzWuqJM+UGBFYw/74uqD8kvldO5wvA+D
        XlDH82Z7YeZItIKG0PMg5mJRQQ==
X-Google-Smtp-Source: ABdhPJydVdSsCLGHaYXiDQPPFXJqDlI3Gq8+/+6752E5DlDac2zDdha6cnWoGI5J0cNDYNsz91bj7A==
X-Received: by 2002:adf:9bc9:: with SMTP id e9mr20751383wrc.123.1599477030165;
        Mon, 07 Sep 2020 04:10:30 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id u13sm19922111wrm.77.2020.09.07.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:10:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] drm: panel: add support for TDO tl070wsh30 panel
Date:   Mon,  7 Sep 2020 13:10:24 +0200
Message-Id: <20200907111027.21933-1-narmstrong@baylibre.com>
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

Changes since v1 at [1]:
- added missing vendor-prefixes patch
- removed vrefresh
- fixed warning on add_panel return
- removed DRM logging

[1] https://patchwork.freedesktop.org/series/81376/#rev1

Neil Armstrong (3):
  dt-bindings: vendor-prefixes: Add Shanghai Top Display
    Optolelectronics vendor prefix
  dt-bindings: display: panel: add TDO tl070wsh30 DSI panel bindings
  drm: panel: add TDO tl070wsh30 panel driver

 .../display/panel/tdo,tl070wsh30.yaml         |  58 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 256 ++++++++++++++++++
 5 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

-- 
2.22.0

