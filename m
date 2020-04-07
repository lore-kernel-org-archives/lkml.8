Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3DCC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C520644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrYNqemH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgDGJj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:39:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37967 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:39:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id f20so1091782wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=9dSzOnMI8C9ai8r9cTrwks+NM0hS9maBvGrhJYbcAfI=;
        b=lrYNqemHTN4TJkymt2xZMdOeiWnTWzQ0l0Py4J1Je9L7R8uEtWPFdHTIjmuLamTcUw
         g5apNFVILM3+Kj8o7kv2KLAMi1T5zTnrjttttyfCBl6iPxNisbF5oca6flSXgO1fi8nh
         IvokwzZmaWm7EuqF2EVAvfYsWmt+NN0g2HahBLHIJF0diCqRG4QkUxK1vRZkVIi/y5Hx
         W5ovuVbosBb2PGKu5q1Gep4D8cU7s4ITCORfBJExJ9ioV7ewDsUKsDqGkWbap/TQrFYd
         BUvRnQ+m1pPZB9dBUOwGetD+06KE4sonC/HJ5GUpfwc4nAFT2UaXRO6rpFwb36MQqrv8
         SKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=9dSzOnMI8C9ai8r9cTrwks+NM0hS9maBvGrhJYbcAfI=;
        b=G7840VsFWbZAlrxGprAH0naqeAnYyggKwIto9CToy6BfYAWYAQisSkixZBa5M1QKds
         Sg0q9u9GBHv5CEEO+kCojmMp8+dd/nOsOpI0+a6vh/0dfOlPVED6fvxvPttrIG+6Ifz0
         MbP1HMTtS/E549ga9TFwhqDaiDaIsMP9ddUwMuisGpjaDBOXYC1PGjDx1Zpzw9Vw6xeC
         168uSJVDx9qv6CZeWoIRZSW4kmMWQiLLBiUjcfDDnMoDtwFMHsi0AMGlMCbvXy19yl9o
         qpgbtepqAncxeLrP+hIwyy7DKrbo/2CB91Co7dVbni/Gsq/Ib6/8akT0wglRg6YFPpWI
         I2kQ==
X-Gm-Message-State: AGi0PuYHtQjXNU6AM1fStfSrfIIJuvorF+SCAzR1XYkvog3RXsU5NWl/
        0chc7aUXGcMh3mTH0ZdZTU8YshwTg/k=
X-Google-Smtp-Source: APiQypI7+sMTDw4kc5AsfJb1or2TBmgWZsoPvrHq7SrQwzlBYJp+pG2ZoMzIgETgyyP/x5BR7Bj7xA==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr1491339wmc.153.1586252365569;
        Tue, 07 Apr 2020 02:39:25 -0700 (PDT)
Received: from dell ([2.31.167.253])
        by smtp.gmail.com with ESMTPSA id 106sm20276758wrc.46.2020.04.07.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:39:24 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:40:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.7
Message-ID: <20200407094021.GG30614@dell>
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

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.7

for you to fetch changes up to ee0c8e494cc3c135350cd5c4752e82af3feae1ab:

  backlight: corgi: Convert to use GPIO descriptors (2020-03-25 09:30:46 +0000)

----------------------------------------------------------------
 - Fix-ups
   - Switch to GPIO descriptor; pwm_bl, corgi_lcd

----------------------------------------------------------------
Linus Walleij (2):
      backlight: pwm_bl: Switch to full GPIO descriptor
      backlight: corgi: Convert to use GPIO descriptors

 arch/arm/mach-pxa/cm-x300.c               |  1 -
 arch/arm/mach-pxa/colibri-pxa270-income.c |  1 -
 arch/arm/mach-pxa/corgi.c                 | 12 +++++-
 arch/arm/mach-pxa/ezx.c                   |  1 -
 arch/arm/mach-pxa/hx4700.c                |  1 -
 arch/arm/mach-pxa/lpd270.c                |  1 -
 arch/arm/mach-pxa/magician.c              |  1 -
 arch/arm/mach-pxa/mainstone.c             |  1 -
 arch/arm/mach-pxa/mioa701.c               |  1 -
 arch/arm/mach-pxa/palm27x.c               |  1 -
 arch/arm/mach-pxa/palmtc.c                | 11 ++++-
 arch/arm/mach-pxa/palmte2.c               |  1 -
 arch/arm/mach-pxa/pcm990-baseboard.c      |  1 -
 arch/arm/mach-pxa/spitz.c                 | 34 ++++++++++++----
 arch/arm/mach-pxa/tavorevb.c              |  2 -
 arch/arm/mach-pxa/viper.c                 |  1 -
 arch/arm/mach-pxa/z2.c                    |  2 -
 arch/arm/mach-pxa/zylonite.c              |  1 -
 arch/arm/mach-s3c24xx/mach-h1940.c        |  1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c       |  1 -
 arch/arm/mach-s3c64xx/dev-backlight.c     |  3 --
 arch/arm/mach-s3c64xx/mach-crag6410.c     |  1 -
 arch/arm/mach-s3c64xx/mach-hmt.c          |  1 -
 arch/arm/mach-s3c64xx/mach-smartq.c       |  1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c     |  2 +-
 arch/unicore32/kernel/puv3-nb0916.c       |  1 -
 drivers/video/backlight/corgi_lcd.c       | 68 ++++++++-----------------------
 drivers/video/backlight/pwm_bl.c          | 19 ---------
 include/linux/pwm_backlight.h             |  2 -
 include/linux/spi/corgi_lcd.h             |  3 --
 30 files changed, 65 insertions(+), 112 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
