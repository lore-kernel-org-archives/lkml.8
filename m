Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90786C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6602C205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYGkMCTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHKHuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgHKHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:50:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:50:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so10520921wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=vkHpnMLl55IQCqrb8fLSJH4E3mUf4XGT4PJFbROHx0c=;
        b=cYGkMCTFb3l7m/RSXtJswRy6I0IK6VIYCJemOL3kzBTJAkvJ1cqavAsGeNdWwmNZbF
         TTet/jR6LVfz1vS/q1ywciRaOCTmruQtAEWcLyOv+Jkz1NNegKd5ELFywMtpr82v/761
         0y/G4NBcS5Q7XMxd8oeS+xJtT72OWUUI4Vvl3V+5jRoo3qP2SX149xcwKOpflw4PN8JE
         taF0GwFuy6AxcvCcWbqIOk5hU2V1xW7LlJ2gK3EFozQW0miWEE7shBrS7dVTPdDcvrwp
         a8E7jlZTmGs6Ctn2dlAT3R+G+ekzb/h7gnsc+VuEKyR/3tN7NMExkIy8Zfp2EM1fhVEL
         sYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=vkHpnMLl55IQCqrb8fLSJH4E3mUf4XGT4PJFbROHx0c=;
        b=nWt7VfADiPdCW8RKH+3LGm5TPtoy3yLcW5bUl0lEeHqneLj0C2EdOrjGJXhNfBcJko
         wJC+fsluQMn/OHedBxMzM49uik1HwNMRMRibhCxEOTb43M4UgntZwDoNkBYso7EknYCp
         uwmauKfUPQ5mgKoMvtNtXDZ+hQd09FRm7xKQdCcPMrU8Dn/qkMRnN4xZFlRSooccmOCg
         H3K3jZKYS8ITQviBUfYx3ov7t66LXzY4PJFVZ8Sw7oJNufZbtfuRk0V3lzI7m5jo3VR+
         r3c9E2K2Uz0XHp/MZ9SP1bHrJENa10khok42fyJ36VzHgjJzpTzN4tsfJg0PCs0Q+rUG
         skPQ==
X-Gm-Message-State: AOAM531CuwpkjCQYxsJt9sSmHEW8OOcFUXnWKxU83/6L9443jlvsKkmr
        HuvVb+8YDre1mxC2GLjZmin/6w==
X-Google-Smtp-Source: ABdhPJwxxmUk3MOp0EQI39PKVL7QrnKW3cUWN07eIEEHOV+8uwU/yROrag3CMgpSv8KmtrmBnYYIqw==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr4790624wrt.20.1597132251934;
        Tue, 11 Aug 2020 00:50:51 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id y203sm3949739wmc.29.2020.08.11.00.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 00:50:51 -0700 (PDT)
Date:   Tue, 11 Aug 2020 08:50:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.9
Message-ID: <20200811075049.GH4411@dell>
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

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.9

for you to fetch changes up to 7eb99a39ef767644bbfd2b3f12f139d13e3ee8b3:

  video: backlight: cr_bllcd: Remove unused variable 'intensity' (2020-07-21 15:45:45 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Trivial: Code refactoring
   - New API backlight_is_blank()
   - New API backlight_get_brightness()
   - Additional/reworked documentation
   - Remove 'extern' labels from prototypes
   - Drop backlight_put()
   - Staticify of_find_backlight()

 - Driver Removal
   - Removal of unused OT200 driver
   - Removal of unused Generic Backlight driver

 - Fix-ups
   - Bunch of W=1 warning fixes
   - Convert to GPIO descriptors; sky81452
   - Move platform data handling into driver; sky81452
   - Remove superfluous code; lms501kf03
   - Many instances of using new APIs

----------------------------------------------------------------
Lee Jones (10):
      backlight: lms501kf03: Remove unused const variables
      backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
      backlight: ili922x: Add missing kerneldoc descriptions for CHECK_FREQ_REG() args
      backlight: ili922x: Remove invalid use of kerneldoc syntax
      backlight: ili922x: Add missing kerneldoc description for ili922x_reg_dump()'s arg
      backlight: backlight: Supply description for function args in existing Kerneldocs
      backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
      backlight: qcom-wled: Remove unused configs for LED3 and LED4
      video: backlight: sky81452-backlight: Fix some kerneldoc issues
      video: backlight: cr_bllcd: Remove unused variable 'intensity'

Linus Walleij (4):
      backlight: sky81452: Convert to GPIO descriptors
      backlight: sky81452: Privatize platform data
      backlight: Delete the OT200 backlight driver
      backlight: lms501kf03: Drop unused include

Sam Ravnborg (19):
      backlight: backlight: Refactor fb_notifier_callback()
      backlight: backlight: Add backlight_is_blank()
      backlight: backlight: Improve backlight_ops documentation
      backlight: backlight: Improve backlight_properties documentation
      backlight: backlight: Improve backlight_device documentation
      backlight: backlight: Document inline functions in backlight.h
      backlight: backlight: Document enums in backlight.h
      backlight: generic_bl: Remove this driver as it is unused
      backlight: backlight: Drop extern from prototypes
      backlight: backlight: Add overview and update existing doc
      doc-rst: Wire-up Backlight kernel-doc documentation
      backlight: backlight: Introduce backlight_get_brightness()
      backlight: as3711_bl: Simplify update_status
      backlight: cr_bllcd: Introduce gpio-backlight semantics
      backlight: gpio_backlight: Simplify update_status()
      backlight: jornada720_bl: Introduce backlight_is_blank()
      backlight: Use backlight_get_brightness() throughout
      backlight: backlight: Drop backlight_put()
      backlight: backlight: Make of_find_backlight static

Wang Qing (1):
      backlight: lm3533_bl: Use kobj_to_dev() instead

 Documentation/gpu/backlight.rst                  |  12 +
 Documentation/gpu/index.rst                      |   1 +
 drivers/mfd/sky81452.c                           |   2 -
 drivers/video/backlight/88pm860x_bl.c            |  13 +-
 drivers/video/backlight/Kconfig                  |  15 -
 drivers/video/backlight/Makefile                 |   2 -
 drivers/video/backlight/adp5520_bl.c             |  10 +-
 drivers/video/backlight/adp8860_bl.c             |  10 +-
 drivers/video/backlight/adp8870_bl.c             |  10 +-
 drivers/video/backlight/as3711_bl.c              |  11 +-
 drivers/video/backlight/backlight.c              | 206 +++++++-----
 drivers/video/backlight/bd6107.c                 |   7 +-
 drivers/video/backlight/corgi_lcd.c              |   8 +-
 drivers/video/backlight/cr_bllcd.c               |  26 +-
 drivers/video/backlight/da903x_bl.c              |  13 +-
 drivers/video/backlight/ep93xx_bl.c              |   8 +-
 drivers/video/backlight/generic_bl.c             | 110 -------
 drivers/video/backlight/gpio_backlight.c         |  17 +-
 drivers/video/backlight/hp680_bl.c               |   6 +-
 drivers/video/backlight/ili922x.c                |   8 +-
 drivers/video/backlight/jornada720_bl.c          |   2 +-
 drivers/video/backlight/kb3886_bl.c              |   6 +-
 drivers/video/backlight/lcd.c                    |   1 +
 drivers/video/backlight/led_bl.c                 |   7 +-
 drivers/video/backlight/lm3533_bl.c              |  10 +-
 drivers/video/backlight/lm3630a_bl.c             |   4 +-
 drivers/video/backlight/lms501kf03.c             |   9 -
 drivers/video/backlight/locomolcd.c              |   6 +-
 drivers/video/backlight/lv5207lp.c               |   7 +-
 drivers/video/backlight/max8925_bl.c             |  13 +-
 drivers/video/backlight/ot200_bl.c               | 162 ---------
 drivers/video/backlight/pwm_bl.c                 |   7 +-
 drivers/video/backlight/qcom-wled.c              |  15 +-
 drivers/video/backlight/sky81452-backlight.c     |  52 +--
 drivers/video/backlight/tps65217_bl.c            |  10 +-
 drivers/video/backlight/wm831x_bl.c              |  13 +-
 include/linux/backlight.h                        | 399 ++++++++++++++++++-----
 include/linux/mfd/sky81452.h                     |   2 -
 include/linux/platform_data/sky81452-backlight.h |  35 --
 39 files changed, 538 insertions(+), 717 deletions(-)
 create mode 100644 Documentation/gpu/backlight.rst
 delete mode 100644 drivers/video/backlight/generic_bl.c
 delete mode 100644 drivers/video/backlight/ot200_bl.c
 delete mode 100644 include/linux/platform_data/sky81452-backlight.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
