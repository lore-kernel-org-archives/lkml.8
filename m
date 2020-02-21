Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED09C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAFD206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwwv8UHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgBUIrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:47:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgBUHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:49:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so568176pgl.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OK5QR972nKe83ja7vFw4PScqgofVWYqnjcZMFqqtFHM=;
        b=mwwv8UHF7HJf5WY4yLevMY3IG6ENI49aercwQ2Yl9FFyzEDARpP7dhT4blU8nwEfcg
         GjKxyz9Tn4VfGausA9k7XmZ0fqLQ/tuQRuvzy+lCCXIBALIlCbpcqBO+Vgdc+D/Zh52j
         LcbzVd+AM8RwMnEi1Cam6hURXU3eh4/X9N59I8Ah/BO6jCmAqKbp1kJOh7EXyQOPY59W
         wUU316emL1Nxm5RWYuHrgnVDRpPCQjgrKDnXqFan371heERGeMHwij5P21GLA75T6FuC
         bfxDILU7m+0O6LhKh9uGE88BSFT4ri3cJ0Sxrl4ZWk2efWEjwmsDLoANOsJe2a1iUhFD
         L9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OK5QR972nKe83ja7vFw4PScqgofVWYqnjcZMFqqtFHM=;
        b=mS3t1LgBIHt4G0ibbpU0taolJxu0u3LYpHdjnzi5qBxtqT8rLczJjUbgy5XvCx5Gmh
         SNkv7wBFqz+ZXbWGAaumnjTB2ycSIofY6nR7dvvR4ADEIEi+CzRTam9NR3BQc/m1Kv16
         I/v4/Sme5/jZxfYgcIsEd6QGYGMIyRmcJ/mmhKPBNvIAkv433ipYdp+Y57lfN1xCFka1
         xqHtJbLvtKzerEsYLswFAHdg5jtOZNXrtkbYtRMmciMsZpZ9UKlapj9KbznTYcgW0XZd
         gwj0SZ2xxHj0UQLw7MivmSdFfQfGVC4Y/Pm+F/iFTfj4oXXI43XaQbEf3CIsSohrRgZR
         8nZw==
X-Gm-Message-State: APjAAAUrOrQMHFIIE0fIPDso+QUdxTgTElzxxInFcs1GilCqOVul9OEj
        1SUl5Np1r/zsB4ml3O9sDOA5pMU9
X-Google-Smtp-Source: APXvYqyVK4MW60zAdN5pTw3l6mI8blbOp0QqUPIeROkNy2b6AlXliCMgxdpShbHsfXfYjio7fSpifQ==
X-Received: by 2002:aa7:96b7:: with SMTP id g23mr35201332pfk.108.1582271343499;
        Thu, 20 Feb 2020 23:49:03 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d1sm1444653pgj.79.2020.02.20.23.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 23:49:03 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v3 0/6] Add Unisoc's drm kms module
Date:   Fri, 21 Feb 2020 15:48:50 +0800
Message-Id: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
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

v3:
1. multi crtc&encoder design have problem, so rollback to v1

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
 drivers/gpu/drm/sprd/Makefile                      |   15 +
 drivers/gpu/drm/sprd/disp_lib.c                    |   59 +
 drivers/gpu/drm/sprd/disp_lib.h                    |   21 +
 drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
 drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  628 +++++++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  254 ++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h          |  329 +++++
 drivers/gpu/drm/sprd/dpu/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  787 +++++++++++
 drivers/gpu/drm/sprd/dsi/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dsi/core/Makefile             |    3 +
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      | 1169 ++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1417 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  375 ++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  544 ++++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   28 +
 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h            | 1102 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dphy.c                   |  225 ++++
 drivers/gpu/drm/sprd/sprd_dphy.h                   |   99 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  678 ++++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  130 ++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  295 ++++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   20 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  655 +++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  192 +++
 33 files changed, 9368 insertions(+)
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
 create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h

-- 
2.7.4

