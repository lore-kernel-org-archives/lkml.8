Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF06CC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD54020720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f549fH1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgEHENW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgEHENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:13:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6BC05BD43;
        Thu,  7 May 2020 21:13:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so284192pfg.2;
        Thu, 07 May 2020 21:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n63i3r0L2IRpeGMKN7qKGLKSiEkxvDfFBuN0D82sIKo=;
        b=f549fH1riIbuo8ah1TTsCCpm1ZZXn7S2OPcoVIKseqS3u3naNxt2u5u2yue9ia4f35
         aukn+x9RoVtzRotGy89BFThqOsN+8Hvz0BiPwBjQEETQ9gD+zhB0cqzrEvTxKYQDvgwF
         ZZ3vzEx4Edbtr92ALNFDitl/XcwHHmoK6aBBirRzTJb2giYxmR8LHalrm8FHTOBuhSD6
         hR6zDTJluoRElYuNmnpxzdsWrJvQ2QN2cyG5asOiU16f9ANpVcSJF4/7QDMMFK9+ZPgV
         k0NVAlaHzH3PUoYp+3/40hIKX2qcANGDt4gxjc+LWJBv7LnVGgOCTAESa5PmQ5zQMZyR
         da5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n63i3r0L2IRpeGMKN7qKGLKSiEkxvDfFBuN0D82sIKo=;
        b=Ds+lXQrCmrgAZHpx/fO4+YMg01cQsOPhUP1Ce+jdx2VKw3NQf0yce5fzeT/xjsYsmk
         qPXXN2ZGKNDFow0YsO0JAEVQ2GZU2MpxjgF7vnJDjFexh1uzjzD908HnLpSB7TJYGWBf
         RHeIM9h05Iac6GRXeK9raKMHSSNj2PbtrSw5wd7exK1QUTN1vMTd2vdTsD+n+nsk3EjR
         WgGAYYF8nWiHYigNZiDOeUi1ZZa+3skEgnzQrrG7yZib9Ad/Bl0zu7MSOMB1HiUel8/T
         GZXbis6AblJcDUcN7NqUa2pVwdQWHwHhNSoWbkA+rHAEZcJVg3VbYUi1KoiYG+KYN9nh
         goSw==
X-Gm-Message-State: AGi0PuZW+D1S/MoeYIEa6/wfT7bv5IflcWO0Nov1yNJdPUcqFjyJVGLr
        jKprtNZXmAQf9N1GWGmUmJU=
X-Google-Smtp-Source: APiQypKy7XAhc6hawzdj77Xs0oeZFyq8G/VpqAn061VrqG5U+MNUQKe6OKJlyeRDZxXp18aM4MdX/g==
X-Received: by 2002:a63:da49:: with SMTP id l9mr508966pgj.432.1588911200789;
        Thu, 07 May 2020 21:13:20 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id h12sm314868pfq.176.2020.05.07.21.13.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 21:13:20 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 0/5] Enable ilitek ili9341 on stm32f429-disco board
Date:   Fri,  8 May 2020 12:13:09 +0800
Message-Id: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset have following changes

V2: verify ilitek,ili9341.yaml with make O=../linux-stm32 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

V1:
    add ili9341 drm panel driver
    add ltdc, spi5 controller for stm32f429-disco
    add ltdc, spi5 pin map for stm32f429-disco
    add docs about ili9341
    fix ltdc driver loading hang in clk set rate bug

dillon min (5):
  ARM: dts: stm32: Add pin map for ltdc, spi5 on stm32f429-disco board
  ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco
    board
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  clk: stm32: Fix stm32f429 ltdc driver loading hang in clk set rate.
    keep ltdc     clk running after kernel startup
  drm/panel: add panel driver for Ilitek ili9341 panels

 .../bindings/display/panel/ilitek,ili9341.yaml     |  68 +++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  67 +++
 arch/arm/boot/dts/stm32f429-disco.dts              |  40 ++
 drivers/clk/clk-stm32f4.c                          |   5 +-
 drivers/gpu/drm/panel/Kconfig                      |   8 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 561 +++++++++++++++++++++
 7 files changed, 748 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

