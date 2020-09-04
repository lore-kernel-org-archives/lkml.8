Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D69BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1153D20C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MLOUcWu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIDQPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIDQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:15:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046C5C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:15:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so7255840wrl.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW8/Gqfl2ygRzhelgm8VgMzXeTrqKEKDiPdSn34tSCE=;
        b=MLOUcWu0MPsrbS2FTQkXUWJ2ueuR/hWyD6JTigcMy8+S7yczFEVDN4sVtXn4Fsmwl5
         QvAIme6XsbyHzM7wfGCpy8xb27TH3PuyZiXVw2Hv6xxjufFaygz433/G1YOUO6xU6pN3
         cUGLJ0Qtyrn2A+li6Z6jyDTLgTEofO5402uUDxU9Pyo3MmAFCWkXhCXbYLOtq+bwbuM6
         7xwxi2TEpadbbP8rn4jr2k+OxTaaKXrf/hO12yEu1rS2eSv7IgymLVUyJgc9/UbuN6ug
         dHNCCfBH168X3KEKAl9zmTol76MXCB3AGAeH41yqsUYnR/cdx6WpEOewjEX7BPm5JJf8
         +WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW8/Gqfl2ygRzhelgm8VgMzXeTrqKEKDiPdSn34tSCE=;
        b=Qz2p0OxAGIpgQbTBQMrmyv78gKyNxr3ZlefPUA1iR+qwIO5lIHYdRs9Nb6/odbdmjz
         0lFpQno1zHQyGwKlVKJCTD3krgMhzAd7OkG6fRA8zSNdMLK1+JKipYY8rJS3Q9MoqZ/1
         D8drR+E2oQTB+2rhKx8LixLDvJGLFvlL4hcF+9i8tS8uZ1mo93d2kbzCbexDB3Z1q3zG
         YVu+7MHmsBlDTxTxFc0mRJEcMsG+1PGak8Gkz0a2yTlI+wghshwodnGHCrhh4cG87HzY
         Arcx/FP7xx7KFm7Lu7kvFcLXop/6/Q0WKK44L9/O6KjoUQCdz/qU9CqNLfNS6w5ZtGQe
         tAdw==
X-Gm-Message-State: AOAM531nwjg5WKSd4/EVUaCsKq7tNCsWjlU0+qi81M5VnoggLUuFiRkF
        v8/ivAkLO0IvyY2pK8/6nzbBFg==
X-Google-Smtp-Source: ABdhPJzBStwPYgSPHPXMrwc0ijPLvHWYZmHpf/4cpLNfKiWOt8MMJHmIYPnwpmV6MkYuzVeqkYlQFw==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr8030854wrs.28.1599236111470;
        Fri, 04 Sep 2020 09:15:11 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d18sm12238160wrm.10.2020.09.04.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:15:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] drm: panel: add support for TDO tl070wsh30 panel
Date:   Fri,  4 Sep 2020 18:15:02 +0200
Message-Id: <20200904161504.23915-1-narmstrong@baylibre.com>
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

Neil Armstrong (2):
  dt-bindings: display: panel: add TDO tl070wsh30 DSI panel bindings
  drm: panel: add TDO tl070wsh30 panel driver

 .../display/panel/tdo,tl070wsh30.yaml         |  58 ++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 263 ++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

-- 
2.22.0

