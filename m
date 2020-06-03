Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5776E20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSky33M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFCJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFCJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:04:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833AC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:04:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so1108712wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=9sWCLTdS5uEsmG7lyY0LcHC7aWifwOzH6Hy5RTa/15Q=;
        b=ZSky33M9Pa/XChwvvJQdOgel7gA+zLpWMzLOGJFWdS4TtfjkYoe35z8Gpm2xusiwq7
         eKNKu8G0B6vjNx7+rPf9DG7p751qqriivb7X9gpi3mX3j7y0f2qne52ohWRLtURwcdFe
         eSMmHX6EHieZiaUDqJLiPMDj2PWX6i+5xbFJiNKfsRnCbF28fXISbVedKEoNywCJ+WDk
         guOyMsGtMsjhUb1rCUeJxe/Qa7W338P+SXammMbsS2Vdl4x9OdyD3G7cLD7ZY03Svgbv
         kC+ZyuJA8I/gGpmVST9IIY8pNz5I1myFUKGF9vAb51HeBR2bRbGvtltvV5fK4cZV1iBX
         Gj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=9sWCLTdS5uEsmG7lyY0LcHC7aWifwOzH6Hy5RTa/15Q=;
        b=bQFGZbxM2oitGAOtYoQOY4CmUHPjuorJ/ObZrOjg0ygL6/jj9AxZ42/4NkjIb/yEWg
         9dHlcNLkpsHxxxHGGKdBYo1Qqv6AGQuORvx3npqnlc7bsFsCs0wIBrRZPI6Ek6A3e1yv
         sO/vwefCv1BFocsz6ot8mO9dVYiEPiG4OgVVKv3j65/tPv0AtZEOoVfQ7GbYPdR0ZcAu
         zBSdZiIOH4GntWYrLh7WDTl68RLCs4TXMmEyN8rbPDiDnmZKSBJrt180xYbLHl57sD8u
         rRTDDYR+u92hHY1+i05Bm+CPoWPfgMpS/paV7fDTuKnPhuFcOMbffG+JtopJx9ZaJAjV
         lk3g==
X-Gm-Message-State: AOAM530ib+jKZCcewNvN7MLU7JGiTgvdBDBOlfVCKPI6hJAnyJAL+TbD
        CuNkyqo0EfqDX0dF4N0auab5Ww==
X-Google-Smtp-Source: ABdhPJyizEQKkeVn03DCweOQTm6i+F+ct1stmeHj2Ps4GQPGyJ7ZPFtyeb+9CUID3r6ka521UGwZVg==
X-Received: by 2002:a1c:ba86:: with SMTP id k128mr7539659wmf.19.1591175071512;
        Wed, 03 Jun 2020 02:04:31 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id h18sm2321280wru.7.2020.06.03.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:04:30 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:04:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.8
Message-ID: <20200603090429.GN3714@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Enjoy!

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.8

for you to fetch changes up to 479da1f538a2f3547e15f9d5922c611b69ec2fbc:

  backlight: Add backlight_device_get_by_name() (2020-05-11 07:39:16 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Add backlight_device_get_by_name() to the API

- New Device Support
   - Add support for WLED5 to Qualcomm WLED

 - Fix-ups
   - Convert to GPIO descriptors; l4f00242t03
   - Device Tree fix-ups; qcom-wled

 - Bug Fixes
   - Properly disable regulators on .probe() failure

----------------------------------------------------------------
Jon Hunter (1):
      backlight: lp855x: Ensure regulators are disabled on probe failure

Kiran Gunda (3):
      dt-bindings: backlight: qcom-wled: Convert the wled bindings to .yaml format
      backlight: qcom-wled: Add callback functions
      dt-bindings: backlight: qcom-wled: Add WLED5 bindings

Linus Walleij (1):
      backlight: l4f00242t03: Convert to GPIO descriptors

Noralf Trønnes (1):
      backlight: Add backlight_device_get_by_name()

Subbaraman Narayanamurthy (1):
      backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs

 .../bindings/leds/backlight/qcom-wled.txt          | 154 ------
 .../bindings/leds/backlight/qcom-wled.yaml         | 261 +++++++++
 arch/arm/mach-imx/mach-mx27_3ds.c                  |  21 +-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |  24 +-
 drivers/video/backlight/backlight.c                |  21 +
 drivers/video/backlight/l4f00242t03.c              |  45 +-
 drivers/video/backlight/lp855x_bl.c                |  20 +-
 drivers/video/backlight/qcom-wled.c                | 589 ++++++++++++++++++---
 include/linux/backlight.h                          |   1 +
 include/linux/spi/l4f00242t03.h                    |  17 -
 10 files changed, 867 insertions(+), 286 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
 delete mode 100644 include/linux/spi/l4f00242t03.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
