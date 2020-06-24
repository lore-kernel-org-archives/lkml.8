Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A55FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791EF206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpwRXiIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404089AbgFXPHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbgFXPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o8so2649466wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQtVmqfMypGrk3tVAU8yj9wN9Ngmltk19ZhimPNRVF8=;
        b=dpwRXiIeegS1OUrHliGUYM/HFbgn6RUn2COIlSHV86r8/CtI36lGc+D/qhm1yJm6Z4
         7BLcvAvliHXyiN4pRQtQazAdCMYmCQkgd1/MfvbS3idQzeuTvt7fV3+tSx0HWmVGj5pB
         UCXTxhKF2jaLY4JZgM+2R/dFxHJrCsoLtafBB+Y1hW/sJZ5NZGu+E5cZmSdhj9qhBVUB
         MSeD8ZUPRVJwFe2NAbOmOxmkrPgkmRCcmXfMV84o/qgJ/J0/58kdfqPtqTVcMu7mUsBm
         /htdnisViMsWS8nwFzO2HNzshQaLWWBwaG3ALePsbzncO3SRdlLX6G8umGtYrGmdRRpH
         5KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQtVmqfMypGrk3tVAU8yj9wN9Ngmltk19ZhimPNRVF8=;
        b=nMN5k50TQNfeh8YQe34MeoyK9bqUfr5E2Aej9bYfuOYshyrWvbl1YV7tA1c8W7dM5l
         Tmer6G7QMjsiXGuLV+IivxpZDZ1dO2QdGD6Of3dsz2caBSZUhKabqntk71XD/UhJc7+W
         SKqGL0fDqgDsA9K+mtri8iEjn0yUoTDd88HvN7MJkIjE+bHKIazQDK2aZHJNIVY5O3mJ
         lPTVHQD+kNv765pBXmHlHLSjcwVxa7zpSOHfOPohvosDwAaGfuutcBc6c0y8UV2QS5oG
         WchV7sAnLSXLYjoleyvZbmF1JJnhj1zowXBHL3SonXJO32I+Qe4RWMaqqdn5VjsC0pUb
         xqUA==
X-Gm-Message-State: AOAM533limnIOTf8T0ava+WlVwXGs8bQV9LGdqeDuBuWxQ3jGwcMc0di
        wZnlys2l66qQSPuk0NW020JnSCQlY2g=
X-Google-Smtp-Source: ABdhPJwdubJb8nmYTJqPiA2HRWouQbP/sLR/VAPY4Vda0giOWhnJptb8gzhUA5uKvnOrsKDbR8RxGQ==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr22003350wmb.122.1593011231611;
        Wed, 24 Jun 2020 08:07:11 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Fix a bunch of W=1 warnings in MFD
Date:   Wed, 24 Jun 2020 16:06:54 +0100
Message-Id: <20200624150704.2729736-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (10):
  mfd: twl4030-irq: Fix incorrect type in assignment warning
  mfd: twl4030-irq: Fix cast to restricted __le32 warning
  mfd: tps6586x: Fix cast to restricted __le32 warning
  mfd: altera-sysmgr: Fix physical address storing hacks
  mfd: sprd-sc27xx-spi: Fix symbol 'sprd_pmic_detect_charger_type' was
    not declared warning
  mfd: ab3100-core: Fix incompatible types in comparison expression
    warning
  mfd: ab8500-debugfs: Fix incompatible types in comparison expression
    issue
  mfd: tc3589x: Remove invalid use of kerneldoc syntax
  mfd: wm8400-core: Supply description for
    wm8400_reset_codec_reg_cache's arg
  mfd: wm831x-core: Supply description wm831x_reg_{un}lock args

 drivers/mfd/ab3100-core.c     |  2 +-
 drivers/mfd/ab8500-debugfs.c  |  2 +-
 drivers/mfd/altera-sysmgr.c   | 16 ++++++----------
 drivers/mfd/sprd-sc27xx-spi.c |  1 +
 drivers/mfd/tc3589x.c         |  2 +-
 drivers/mfd/tps6586x.c        |  7 ++++---
 drivers/mfd/twl4030-irq.c     |  4 ++--
 drivers/mfd/wm831x-core.c     |  4 ++++
 drivers/mfd/wm8400-core.c     |  2 ++
 9 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.25.1

