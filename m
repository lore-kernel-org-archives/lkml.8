Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62152C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DB522522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymk0sIDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAUIvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:51:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46220 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgAUIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:51:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so1029260pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P5hzbJ/D5OQnnI17N1166eEm61xxCbFsprqagnG+VjE=;
        b=Ymk0sIDLUtRA5jnvN237BnDeocFfzS6hjlNI2fkR9R2D7XqeCNhGmS42rPeLE+RJwo
         qPyqv87g1lmqX77uYKOyUWIFwvqlLLZbMevBPP11jAinnRPdZvFbPwIuTw3d8AKqT4YF
         7Rz92fvubPQePAaLSyYrlgr9NKijk4ZBSj/SRjqXVlxmaGiW0stGv2/brSBtHXX+pMJJ
         mkgqlc8YFY/L7uoEkTbG4ic1nKRP5PC70bBiQ/SynsSOmRMnFLeA3mIx4RASnbokb76F
         RrJIt38wPtRPxu9IOyR+1Jm1Seme2G7dkmIQFG+hjmSTJaTXMkfqEYuKpwXeukmTGlFL
         XYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P5hzbJ/D5OQnnI17N1166eEm61xxCbFsprqagnG+VjE=;
        b=mu7PR8xvnxlZtSp9noszDCSayqPbofAtcv3Q817gUYi+VdIjjS/9poOqNwyXoIsLoy
         5xMi3rL7YZYDIoMxdNnT2N26KczJYOJsRKrP8yrS0ftFGYkcW39ao5BJOQX22a7LSDxW
         06P7PWQpYJa2kOKwueA1pdwxyqsuZ6yTBrlYl6ie3nS76Ma82ZpfxtS0aFdJUJ6ou0zk
         sgXV8vIPzNe06k0sjBM5u+X/4HEYl+643rHLEgOZlI4AZe4g59FSNu/L4j4OcBlPvZXb
         jdfmuVTsr8tSwqppeoaAIWX2XUUjqG7YTk7xOZwBBx42YKKR7JNt/1E62T3GjM/7hNGY
         cMfw==
X-Gm-Message-State: APjAAAWdRPDD6PO8GiQdEVMoQwsYpV2wew62mkb7sOzyGsjR9aYVTkGk
        Rhg9XpdEP/ESJQSgNhDCWiY=
X-Google-Smtp-Source: APXvYqxLNFJNXGhVtmyJxWZmtSEhLCgcKQTy4Zjf+7DPNMokZpP8VYGTA5BWbGEalZpenUbExvlZ5g==
X-Received: by 2002:a17:90a:22a5:: with SMTP id s34mr4226979pjc.8.1579596679316;
        Tue, 21 Jan 2020 00:51:19 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 80sm42820957pfw.123.2020.01.21.00.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jan 2020 00:51:18 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v2 0/6] Add Unisoc's drm kms module
Date:   Tue, 21 Jan 2020 16:50:56 +0800
Message-Id: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeList:
v1:
1. only upstream modeset and atomic at first commit. 
2. remove some unused code;
3. use alpha and blend_mode properties;
3. add yaml support;
4. remove auto-adaptive panel driver;
5. bugfix

v2:
1. add sprd crtc and plane module for KMS, preparing for multi crtc&encoder
2. remove gem drivers, use generic CMA handlers
3. remove redundant "module_init", all the sub modules loading by KMS

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../devicetree/bindings/display/sprd/dphy.yaml     |   78 ++
 .../devicetree/bindings/display/sprd/dpu.yaml      |   85 ++
 .../devicetree/bindings/display/sprd/drm.yaml      |   38 +
 .../devicetree/bindings/display/sprd/dsi.yaml      |  101 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   14 +
 drivers/gpu/drm/sprd/Makefile                      |   17 +
 drivers/gpu/drm/sprd/disp_lib.c                    |  134 ++
 drivers/gpu/drm/sprd/disp_lib.h                    |   24 +
 drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
 drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  626 +++++++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  254 ++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h          |  329 +++++
 drivers/gpu/drm/sprd/dpu/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  886 ++++++++++++
 drivers/gpu/drm/sprd/dsi/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dsi/core/Makefile             |    3 +
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      | 1169 ++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1417 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  375 ++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  544 ++++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   28 +
 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h            | 1102 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_crtc.c                   |  212 +++
 drivers/gpu/drm/sprd/sprd_crtc.h                   |   98 ++
 drivers/gpu/drm/sprd/sprd_dphy.c                   |  246 ++++
 drivers/gpu/drm/sprd/sprd_dphy.h                   |  102 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  458 +++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  122 ++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  305 +++++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   16 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  652 +++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  192 +++
 drivers/gpu/drm/sprd/sprd_plane.c                  |  393 ++++++
 drivers/gpu/drm/sprd/sprd_plane.h                  |   36 +
 37 files changed, 10083 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.yaml
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
 create mode 100644 drivers/gpu/drm/sprd/disp_lib.c
 create mode 100644 drivers/gpu/drm/sprd/disp_lib.h
 create mode 100644 drivers/gpu/drm/sprd/dphy/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dphy/pll/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c
 create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c
 create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h
 create mode 100644 drivers/gpu/drm/sprd/dpu/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_crtc.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_crtc.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_plane.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_plane.h

-- 
2.7.4

