Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C9C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00EA2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or3mYO8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBZJqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:46:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBZJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:46:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so1199177pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ihmazS6FA8NlQMyYSt3ZHDuscdnVGkc2tP1SlK96WcY=;
        b=Or3mYO8uKP5gTn6ZgHRzsms0A3/mLaWqltKWi+srMGY9gJRlqZcGWFoO5r/AQ9oHPi
         xM6dxZ0Poe7hMpEEFfB/bOZU6q2pqDKScFqSDAhbr4Oj4s82Yb0bY+943ZZvkFQXvwrE
         uSQjuaFZixipMlyHMLheqywGJZPOeT2lGF22hrHnPM6C+Miu6vnZxTUHkWk604zivr90
         sgb1NP5iNr1cxXXe8tN39Wut5JhqynLLZ1OrHAEIWcPf0Ie5MtuzXr1IBGx1wWW4DWBW
         48FkGMaTtfbuHYgr3XCE6ThLWL6K81Kt4dZ+w86i10NCpTawWDRX9dah0KEKc6rxVhQT
         Tnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ihmazS6FA8NlQMyYSt3ZHDuscdnVGkc2tP1SlK96WcY=;
        b=nLMeYpErPli6SkvPAHSSV7P8QeCMaIkvQmppzRDVpSpF3XGUuT6JHr824Fgmd4ZG3e
         L/emGAcassX6qssVTIVFCODbv2w4zczfSdlwzsjbiMRC0g8sVJQbAGfM2WZqBEPJyjfD
         ao4bC6/C8+tNAsR/rX4jKUeTL+xfo3Ve5OXfXWNgGnCohLP2u+IDXmxpSuUjYe4PlnGu
         xeGjtWAwXFoXr5x96AW7lrZncLQj2T/oTjl3+kO9hD93oMN8M2U+lBLjIzfzr2zykKFx
         f/6gjHRYCnzhjxVmDB1CXpLcDW1CdVxRu8qZnp6+jy0vUBz5vbdsYoS/HawZDy2bbmfF
         ihtA==
X-Gm-Message-State: APjAAAVQo1m910lJDuveC/9os1E+uQ77i/hdFO+80rJZp9BO4dE443Ha
        aHrIP1XQCy7aNBpyE5WqY8Y=
X-Google-Smtp-Source: APXvYqxFrqq+0J3GIx4Pjg5FjumEFxiCG7KEagBzHD1rri59mFZInlMFq0qaURhf2dHnKH4jphdhXQ==
X-Received: by 2002:aa7:84c6:: with SMTP id x6mr3290375pfn.181.1582710387459;
        Wed, 26 Feb 2020 01:46:27 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h185sm2276518pfg.135.2020.02.26.01.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 01:46:27 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v4 0/6] Add Unisoc's drm kms module
Date:   Wed, 26 Feb 2020 17:46:11 +0800
Message-Id: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
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

v4:
1. update to gcc-linaro-7.5.0
2. update to Linux 5.6-rc3
3. remove pm_runtime support
4. add COMPILE_TEST, remove unused kconfig
5. "drm_dev_put" on drm_unbind
6. fix some naming convention issue
7. remove semaphore lock for crtc flip
8. remove static variables

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../devicetree/bindings/display/sprd/dphy.yaml     |   75 ++
 .../devicetree/bindings/display/sprd/dpu.yaml      |   82 ++
 .../devicetree/bindings/display/sprd/drm.yaml      |   36 +
 .../devicetree/bindings/display/sprd/dsi.yaml      |   98 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   12 +
 drivers/gpu/drm/sprd/Makefile                      |   13 +
 drivers/gpu/drm/sprd/disp_lib.c                    |   59 +
 drivers/gpu/drm/sprd/disp_lib.h                    |   21 +
 drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
 drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  628 +++++++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  254 ++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h          |  329 +++++
 drivers/gpu/drm/sprd/dpu/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  770 +++++++++++
 drivers/gpu/drm/sprd/dsi/Makefile                  |    8 +
 drivers/gpu/drm/sprd/dsi/core/Makefile             |    4 +
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      | 1169 ++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1417 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  375 ++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  544 ++++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   28 +
 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h            | 1102 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dphy.c                   |  224 ++++
 drivers/gpu/drm/sprd/sprd_dphy.h                   |   99 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  611 +++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  130 ++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  229 ++++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   20 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  628 +++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  193 +++
 33 files changed, 9178 insertions(+)
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

