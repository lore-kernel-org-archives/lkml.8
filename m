Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E00C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E0620792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEBycbG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgG1KIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:08:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCFEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b186so366853pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6pnYi/HD22gxfMIrYpoWCdqjauq8xDIlRTS9jIu4jxc=;
        b=vEBycbG1l3OT9RX+RP0ZyiU66Bomzxc3SgIXTDI7pWABjsrrCJKCHN0f4Udo0vaJEh
         psMFWJDYAaUFeDNRyzpKzQmztrquuGF0L0tDnENBHsxK9cSJagJp0/RF4D1m11A+WRFh
         uFBcOJYl9q3pxd54q9fEULYzvIM4/MaDVk4c9QCBdJGaGzLrTQNWxXxnnVY1qnLe5gn8
         tctnsa0rZ0SFe8ipFqlne8viVIR3xB+2hz6XHu115IVmp6CVJLFyr7tWfek43m5NbKWZ
         ZuFl4BDsZs6vB3ObWzWlN5c+TcGCIVQhZNPQ8m80AXoZ7pnb8gICJiuN9/TFOFVeH6jR
         uVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6pnYi/HD22gxfMIrYpoWCdqjauq8xDIlRTS9jIu4jxc=;
        b=sF1yFfc28pn3wMw5aDj581NeCinf3DZIZbFRRGi7fLgdQFGoH4UDbNEn1hBk4hT8U3
         XoO6MMRA5prdMxzPoJitPMyyUyc5kgFDFn9gIKTHKztgGb1fYyzIwPjajqdcUxKtfRx0
         0z97RxjkVEdEZQ1WG3xVyJ/hEZvcU+yzRnYS9z8gp9sy4OvI79aO3MqaCrq6RkwMPEd5
         7mQnNPIATxqW9b8c6eKNub2d5w2CC2eR64d4qAAD/LAo01Jl094+ueV+lIwP2d6Lwp8d
         t+01Uwcf2cmkxHDxWMNhhsRylf3MqPyNsx5vkrybDs8py2xcvnT3RFTSGq/ywavltUU7
         q0XA==
X-Gm-Message-State: AOAM530aYBX5ip/8fBaDPg1oS06jw1ZkKfBsZGFrPftaU9qLPa1H1IzD
        tpUpB3NQ4OTYxiegrNMq/X8=
X-Google-Smtp-Source: ABdhPJwGtgElydyMgzqwVqtrPlGsyNkiYOYoKvQqE3jhGJN4y5rezPq+S1JIS34p1ZhoibtWWzdcLg==
X-Received: by 2002:a63:541e:: with SMTP id i30mr24150160pgb.47.1595930885544;
        Tue, 28 Jul 2020 03:08:05 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e76sm1704593pfh.108.2020.07.28.03.08.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 03:08:04 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v6 0/6] Add Unisoc's drm kms module
Date:   Tue, 28 Jul 2020 18:07:53 +0800
Message-Id: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

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

v5:
1. optimize encoder and connector code implementation
2. use "platform_get_irq" and "platform_get_resource"
3. drop useless function return type, drop unless debug log
4. custom properties should be separate, so drop it
5. use DRM_XXX replase pr_xxx
6. drop dsi&dphy hal callback ops
7. drop unless callback ops checking
8. add comments for sprd dpu structure

v6:
1. Access registers via readl/writel
2. Checking for unsupported KMS properties (format, rotation, blend_mode, etc) on plane_check ops
3. Remove always true checks for dpu core ops

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../devicetree/bindings/display/sprd/dphy.yaml     |   75 +
 .../devicetree/bindings/display/sprd/dpu.yaml      |   82 ++
 .../devicetree/bindings/display/sprd/drm.yaml      |   36 +
 .../devicetree/bindings/display/sprd/dsi.yaml      |   98 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   12 +
 drivers/gpu/drm/sprd/Makefile                      |   13 +
 drivers/gpu/drm/sprd/disp_lib.c                    |   57 +
 drivers/gpu/drm/sprd/disp_lib.h                    |   16 +
 drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
 drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  473 +++++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  201 +++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.h          |   22 +
 drivers/gpu/drm/sprd/dpu/Makefile                  |    3 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  503 +++++++
 drivers/gpu/drm/sprd/dsi/Makefile                  |    8 +
 drivers/gpu/drm/sprd/dsi/core/Makefile             |    4 +
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      |  964 +++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1477 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  328 +++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.h  |   32 +
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  590 ++++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   26 +
 drivers/gpu/drm/sprd/sprd_dphy.c                   |  209 +++
 drivers/gpu/drm/sprd/sprd_dphy.h                   |   50 +
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  668 +++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  190 +++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  227 +++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   18 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  571 ++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  108 ++
 33 files changed, 7074 insertions(+)
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
 create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.h
 create mode 100644 drivers/gpu/drm/sprd/dpu/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.h
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h
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

