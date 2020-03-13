Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF05206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICsrXM2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCMNW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:22:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46645 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:22:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id w12so4239862pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B+9gQRKH0r6cXrfSn2IAMlVbz7jd8cPpe3Mc+AzVAAg=;
        b=ICsrXM2dNwzQtNfxw6Ct49D3FdvkapjvgQxEsIe7DVVUinaTsw+rGzqbQ4/OMqE1qV
         ZYOzVfKlz3hXZ5adK1jLKTXrLPLuszdauaU67pYT4zoIi466tMYkjeDTsbsp9YJC1y55
         45xvl6QuxMv82/jxVlwEP9XAgaC0rPvV1I0Nl9mIeumsrAsNx70jOqJ1jVnyVwpOZRgD
         UIeMUH+H3xHn8oNKmAtOIzpZUguWpHx254IGabDmHMoQtJ6qpgv1GNbXD2L03ylfJ54+
         PfEl37h1IR84SeFCsoRPYmSIlqV14N5c45Fxf1zc06NIm5A2KjksBAH2nMAKpeBXQPcn
         GFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B+9gQRKH0r6cXrfSn2IAMlVbz7jd8cPpe3Mc+AzVAAg=;
        b=kRrbtXfdnoQefuanuTLNkqG+0wU2n65o5jVNrclwjlL1/wW/0e6gocRyIQRqi5mQTS
         Hgv6KXPgNZ7Oqr4zaV3SFV4CVGv/VJisE8+IpDCt2pUCzmgFkiTOF5Mit4fzEDkG1NTI
         W1bUcxmQrr+MKOswq7RgAPZopdhA8f/YQXdNzfvIzY9fdzGoZamUbfb03m3Oaie7tOpy
         +UkYg+NbR1vFfHjJSkT1hcAWlJdDxkAeKCljUuHoViT4nw0Y9Tk8WaEoxG8VzfD3K+CK
         O2SkqlpdStpfaflJQWKC7dKkDj3dd2m0Is4VNPd2a/o6OA6tm1wJUN+DqZ628Rt8+6I2
         y0Og==
X-Gm-Message-State: ANhLgQ0IOrwkRT52FZr1x8trgkbqjTKtY/yzlYu8NUkMIXR45v2muorT
        xmkM0jflNwTH3mwaNu5+cwk=
X-Google-Smtp-Source: ADFU+vvkNmSROGv02RNoyVIvfloDQHMJsqZVJr1oCEoJL9YjYVrt/guXHtKUwzoma+CRCV+oP87w4A==
X-Received: by 2002:a17:90a:1697:: with SMTP id o23mr9762300pja.62.1584105775598;
        Fri, 13 Mar 2020 06:22:55 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y9sm21490296pgo.80.2020.03.13.06.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2020 06:22:54 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v5 0/6] Add Unisoc's drm kms module
Date:   Fri, 13 Mar 2020 21:22:41 +0800
Message-Id: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com>
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

v5:
1. optimize encoder and connector code implementation
2. use "platform_get_irq" and "platform_get_resource"
3. drop useless function return type, drop unless debug log
4. custom properties should be separate, so drop it
5. use DRM_XXX replase pr_xxx
6. drop dsi&dphy hal callback ops
7. drop unless callback ops checking
8. add comments for sprd dpu structure

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
 drivers/gpu/drm/sprd/dpu/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  750 ++++++++++
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
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  526 +++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  173 +++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  227 +++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   18 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  571 ++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  108 ++
 33 files changed, 7166 insertions(+)
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

