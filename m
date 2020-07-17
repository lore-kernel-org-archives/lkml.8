Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC6C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100002074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwxcUmz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGQQKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGQQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:10:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42EC0619D2;
        Fri, 17 Jul 2020 09:10:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so5580702pfn.12;
        Fri, 17 Jul 2020 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THfYUaDXgdHi7xOdNZjiSROuNXEFCr7diXe1yGMo3qI=;
        b=IwxcUmz2XFrQueIBSjOsg08tB1mxglvkCpvRqLsc8zVpTmX0MgSeQLZGVoWCvszY9r
         ghCfOwQ2Tvh17dQsQJNySf4oXjUBNU01piFZmcN+sqmN4Rx0O/UQRxOBE+ToMydaSg8T
         BIIte/MTTsbKtyalTemSj3AHd01h2LhjoGTqkRTa/CgcJ9ng9aDK5KO7Y1IM5G8F7Dzd
         S3zHJ+Z7gu3xAXUdZXvp1Th+8i3Spp+5CpJvjsmh+q9m5lsZo+mLkvyAUPtR2fUF0a4j
         LcK5ltSVRr/RPH1UinriTGZaRnjzT+6tF+qnmitM7ska2z0/EatC975z7nOgdlQ6xRZV
         JE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THfYUaDXgdHi7xOdNZjiSROuNXEFCr7diXe1yGMo3qI=;
        b=C9xdJbF5EPf4sHVqNBfyK+2Br84k6t1bFIWKrCrjiL0JOqqfyc1iJgfxdkQsFb4TiH
         s92xijSwfYNdYKDc0n1qj8lbs57aykuyN/lk5M1WgR/vmyNHDLgbyny32FUlpokKwf5e
         RC1ucsDcqVwEKTgj7f8VsgrrXSkKjIndDgxot7rLbk51tk5DhhC1qnyTrzBQj1x2HUR3
         NcQaMoLuyL226S6YqTmM/D+ybyUHtelXpnXMCv1t6fwEv89uEgtpcpCBMT0xQ5MiWymE
         CbAaiYBKsublfNl9hjMS17Mmo9UBEI0KNDerXVmX583VmfDI7b8vUy+OifXt5fd7rjFF
         5q5A==
X-Gm-Message-State: AOAM532l39tra5DsjKep1ievPORszRMNX31kEJgrW4UJ3nMZ8POEck9a
        pDBdqRoMUypNjAn642+hCt8=
X-Google-Smtp-Source: ABdhPJwgmrLwESJyWit/vqNOwVQ1MgTrBNf+Wutx7ZIg8OVw/fi5c6NXIUy6mDOfrF36KIScWySKLA==
X-Received: by 2002:a62:768d:: with SMTP id r135mr9281279pfc.198.1595002253031;
        Fri, 17 Jul 2020 09:10:53 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id ji2sm3170303pjb.1.2020.07.17.09.10.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 09:10:52 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        f.fainelli@gmail.com, heiko@sntech.de, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v4 0/2] drivers: provide devm_platform_request_irq()
Date:   Sat, 18 Jul 2020 00:10:43 +0800
Message-Id: <20200717161045.11458-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will call devm_request_irq() after platform_get_irq() function
in many drivers, And sometimes, the error handling of these two functions
is incorrect in some drivers. So this function is provided to simplify
the driver.

the first patch will provide devm_platform_request_irq(), and the
second patch will convert to devm_platform_request_irq() in some
dirver of i2c bus.

v3 -> v4:
	- The patch v3 sent on May 27 may be lost somewhere in the
	  world, so resend it.
	- add Michal's Acked-by tag in the second patch. and Thanks
	  for Michal's help.

v2 -> v3:
	- add devm_platform_request_irq() to devres.rst by Grygorii's
	  suggestion.
	- And also Thanks Michal, Wolfram and Linus's review and
	  comments.
v1 -> v2:
	- I give up this series of patches in v1 version. I resend this
	  patches v2 by that discussion:
	  https://patchwork.ozlabs.org/project/linux-i2c/patch/20200520144821.8069-1-zhengdejin5@gmail.com/
	  The patch content has not changed.

Dejin Zheng (2):
  drivers: provide devm_platform_request_irq()
  i2c: busses: convert to devm_platform_request_irq()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/platform.c                       | 33 +++++++++++++++++++
 drivers/i2c/busses/i2c-bcm-kona.c             | 16 ++-------
 drivers/i2c/busses/i2c-cadence.c              | 10 ++----
 drivers/i2c/busses/i2c-digicolor.c            | 10 ++----
 drivers/i2c/busses/i2c-emev2.c                |  5 ++-
 drivers/i2c/busses/i2c-jz4780.c               |  5 ++-
 drivers/i2c/busses/i2c-meson.c                | 13 +++-----
 drivers/i2c/busses/i2c-mxs.c                  |  9 ++---
 drivers/i2c/busses/i2c-pnx.c                  |  9 ++---
 drivers/i2c/busses/i2c-rcar.c                 |  9 ++---
 drivers/i2c/busses/i2c-rk3x.c                 | 14 ++------
 drivers/i2c/busses/i2c-sirf.c                 | 10 ++----
 drivers/i2c/busses/i2c-stu300.c               |  4 +--
 drivers/i2c/busses/i2c-synquacer.c            | 12 ++-----
 include/linux/platform_device.h               |  4 +++
 16 files changed, 73 insertions(+), 91 deletions(-)

-- 
2.25.0

