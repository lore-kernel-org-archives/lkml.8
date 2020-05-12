Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F03C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD36A206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhsgIyTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgELHDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgELHDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:03:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3BC061A0C;
        Tue, 12 May 2020 00:03:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so5006473plr.0;
        Tue, 12 May 2020 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mipxNW7wlMfxMGzhO28Zqov8GTbtGeGtVOGitUJWy1g=;
        b=jhsgIyTPnDqRWSwbXSvTHyprY40KS9vAbW6rcrOxqvOdnjjSCNpBTwLTElgpNEzgCv
         B/hU4Z8wkqrvGJHq59AS0U9JQ6yXrwGMFmB8kBkBvf7nXAqmNJ0jZaejbMa5GQZuvEBS
         eLoZmX4dAQxHnMwTz0F++g+Q9cMlfwGAGLMmpOWVa6HNkUWlnh6e16A5ZPiiELLtULyY
         z563mUjwWwpWancdRnp0L6fRRlwklxrRA5iRY5cvzd2FlBcT9lSknFeoiEuJJfdTgctn
         X/bMM/ECf64aLI5IcgeQibHurIkmnmOFetTDvjvalW3B8d+rNzxbwXeZHB3ykoTPHH3C
         BXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mipxNW7wlMfxMGzhO28Zqov8GTbtGeGtVOGitUJWy1g=;
        b=UFr7yaIu0YjZIBuRKLeuhVtj51nywKQxPcmurcM7ayCMbA3aq8ZC/QGhDRfzymoO9y
         /Yl447E8IvjnUrOgYjbslZTYyZvYRA9P6adjABWMVH86X1b1VioJAmhPFsYhh7KnCZbq
         n55YbyQDarYIL/5xAIOVxz1SQvfDphatVfSheNVUxChdNLnJdZoowIAXcPYY5l582h+g
         jqzm8jGA38enQVLhauUbsPtHU2sInyiyy4cb8RoohInKCrwiOFTXw95adXWk+uAQHeVf
         7wqMbdlyeVwHcfZOAs+BBa5JOqj/hbtUGpNVMLSWq4HCJFT7Tl8HOlKklQuA5OZU+N6o
         7QpA==
X-Gm-Message-State: AGi0PuanuOCLTGecuwhgUMTRhHkBvby+Vmsc0R4AjWCIt3IzcYcT91fb
        s+E8bWpfya+feAs4pohjOYjdBK1zo/U=
X-Google-Smtp-Source: APiQypKGhdYXmj/mC8uQ3bBGAeu+OpMtK+0m3u5lxy4OVl4GniR0xQaSDQxS0oHIcUIBNStrnMsqkg==
X-Received: by 2002:a17:90a:db53:: with SMTP id u19mr25689708pjx.41.1589267023718;
        Tue, 12 May 2020 00:03:43 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 62sm11016369pfu.181.2020.05.12.00.03.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:03:43 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon.minfei@gmail.com
Subject: [PATCH v3 0/5] Enable ilitek ili9341 on stm32f429-disco board
Date:   Tue, 12 May 2020 15:03:32 +0800
Message-Id: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset has following changes:

V3:
    merge original tiny/ili9341.c driver to panel/panel-ilitek-ili9341.c
    to support serial spi & parallel rgb interface in one driver.
    update ilitek,ili9341.yaml dts binding documentation.
    update stm32f429-disco dts binding

V2: 
    verify ilitek,ili9341.yaml with make O=../linux-stm32 dt_binding_check
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/
    ilitek,ili9341.yaml

V1:
    add ili9341 drm panel driver
    add ltdc, spi5 controller for stm32f429-disco
    add ltdc, spi5 pin map for stm32f429-disco
    add docs about ili9341
    fix ltdc driver loading hang in clk set rate bug

dillon min (5):
  ARM: dts: stm32: Add pin map for ltdc, spi5 on stm32f429-disco board
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco
    board
  clk: stm32: Fix stm32f429 ltdc driver loading hang in clk set rate.
    keep ltdc     clk running after kernel startup
  drm/panel: Add ilitek ili9341 driver

 .../bindings/display/panel/ilitek,ili9341.yaml     |  68 ++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  67 ++
 arch/arm/boot/dts/stm32f429-disco.dts              |  39 ++
 drivers/clk/clk-stm32f4.c                          |   5 +-
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 700 +++++++++++++++++++++
 7 files changed, 890 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

