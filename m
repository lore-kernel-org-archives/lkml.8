Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B6AC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412A920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eK6sY+50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgDXMoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDXMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:44:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0AAC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:44:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so10294756wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqrR8RcK3jQJ7N6BJUpZZzAOlag+e4M/HVsKVtYGanM=;
        b=eK6sY+5096Up6Tuo/atZU75DoQn0eb/5SeL9gtwXHBOMdu1C77ORcvObcdRc5/s1cj
         G3NWka3kjRFf6NbThNWmpC38Lu0XwjP8QX3yYdDcPnXdrCK4fnp0DmI9EINtqraDs0yK
         neHsIpC4yO8+Jgzb3kGiu0u0KUcINz9NZCCozQlfSyg9qh6xwe1eU8Ogd9PbQhivuUyK
         X1BeqLMNSEncfAv0krblxEA+pTXhZwJ9mX3cORgsF8OQf5k4FPl/sIfUUXK2DFX3Hsfp
         IaCHrq+BYg5kEXj/XmLNbzHI5BQBMyT0RVYG1MGdpAFT4BHvCvzPXIQB+/G1l3FQyIeA
         Juxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqrR8RcK3jQJ7N6BJUpZZzAOlag+e4M/HVsKVtYGanM=;
        b=Ie2eKkvt2LUy2x+vTQHJJNzvTaZE7n4gVYEIL1SQlO+d4Tq+ZuOhPAwkwmaTVs09D+
         7NBtDYsSGLpNQmKNMyOMRgbIy4otbENeF4uwBN9dI1kTJhryL+h+gZY0yDIvgVF0F9Pw
         Lf3Khak4aAvA9i/hSujMRtNW4O6qhINcts3IBqZXha+wYuRWpUaFrFqHafZYM07ZLbj1
         z0/rT2qSE+pOeIbpINOZuhiDfz4xUJ6LLntQyR9K1NvjKqjmBvFt5a252dmS+WdZPuS9
         4wBUbdVypQwHTlako4JB/nkT8bBO5g/ZBKPMMHqiB2WqNpSnfWyZCkL2g0DVcoPxJ3dT
         fqSg==
X-Gm-Message-State: AGi0PuZ+qRb+vr4+2mThSN6539o5B5fk7Mh7ucz/MG7KjrMbQQqmJg7P
        /+Jc2jGqjKVkkWU1tHYjQL0Mog==
X-Google-Smtp-Source: APiQypKxnci1OIVtsyUwDnRvBaRtP0SdCtKIlKTF+ChQS3TlaLeRLU0KtKZ/IOUbIu+Q2WHUYH9qQQ==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr10514947wmf.189.1587732251350;
        Fri, 24 Apr 2020 05:44:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id q184sm2692689wma.25.2020.04.24.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 05:44:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm64: meson-sm1: add support for Hardkernel ODROID-C4
Date:   Fri, 24 Apr 2020 14:44:04 +0200
Message-Id: <20200424124406.13870-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds support for the Hardkernel Odroid-C4 single board computer.

The Odroid-C4 is the Odroid-C2 successor with same form factor, but using
a modern Amlogic S905X3 (SM1) SoC and 4x USB3 ports.

Fully functionnal:
- USB2+USB3
- USB2 OTG
- eMMC
- SDCard
- HDMI
- DVFS
- Gigabit Ethernet with RTL8211F PHY
- ADC
- Debug UART

Missing:
- HDMI audio

Dongjin Kim (1):
  arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4

Neil Armstrong (1):
  dt-bindings: arm: amlogic: add odroid-c4 bindings

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 399 ++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts

-- 
2.22.0

