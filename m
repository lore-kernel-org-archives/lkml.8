Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713ADC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1612074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JBY9RsGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFKIFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgFKIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:05:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F5BC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:05:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so1938888pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yMmmZsMipTgwttKpw11WoJuRVGJqcbJJeQ1lnyJW94=;
        b=JBY9RsGtqzjVq+35NqUJtuzjd6CEmam1JB/V1SkHdJ73Wht+IZmDHLwB/N2f1FzM//
         7eWrCmln0gp9GPX2UvZuax0T6fdM2nqkcLhrfTpvYe4ka0plEcDkjiXszn5CXro2UNez
         huURZFOZl98oVofrv/uEg31TdLxqykMftUpWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yMmmZsMipTgwttKpw11WoJuRVGJqcbJJeQ1lnyJW94=;
        b=NowiXL5ghTharpLKGMqnisheFJI/4nugrJnDz1GMLmGk89upH7rg4FRaN9HU4gPWQl
         RLi4m0ewrGHocjQgz5Xl48lTy7FqxBGgs9yALAk1TkrfDoNrW4kz6SEkBWihb7rzHoTD
         a2Xfwnodxjg/mYJjNvgMI2KQ47Rfq3l/zFg2MMuXtsPi6pbz2QHbdgor7v++wHma/drt
         M11ykLB/Q6BJ1sZ5Pu2hbl7mExSVHV4eD1c11QSMyC2D/J5hUExGPgMkJ5QTMbqCIyW5
         rbnR7vpJvnSlk7R0eBXxh0sNh1wTuhPciyfaz7El3j2wiHSeA5lroEGutTb1cNo+LSMj
         icMQ==
X-Gm-Message-State: AOAM532sjskQY7nCaBaA8qOyTESUNUHyG8Rz2M4DOkRqXbyJ+MgFKcBW
        xWrJBS4p0jRG98kExV1wCStisQ==
X-Google-Smtp-Source: ABdhPJyPL7Lzl1TIQjHgG84HQRm9jz5/dLsVzlFTklKgr4oQ1oFEU9a2+AZ5sPuzg/PyFP8QVoQWdQ==
X-Received: by 2002:a17:90b:fc8:: with SMTP id gd8mr6909918pjb.142.1591862727754;
        Thu, 11 Jun 2020 01:05:27 -0700 (PDT)
Received: from pihsun-glaptop.roam.corp.google.com (2001-b400-e256-fea4-a6c2-ff17-248d-0f67.emome-ip6.hinet.net. [2001:b400:e256:fea4:a6c2:ff17:248d:f67])
        by smtp.googlemail.com with ESMTPSA id n69sm2155509pjc.25.2020.06.11.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:05:26 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: [PATCH v4 0/2] Add support for voltage regulator on ChromeOS EC.
Date:   Thu, 11 Jun 2020 16:04:57 +0800
Message-Id: <20200611080505.140731-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controlling voltage regulator that is connected and
controlled by ChromeOS EC. Kernel controls these regulators through
newly added EC host commands.

Changes from v3:
* Fix dt bindings file name.
* Remove check around CONFIG_OF in driver.
* Add new host commands to cros_ec_trace.
* Address review comments.

Changes from v2:
* Add 'depends on OF' to Kconfig.
* Add Kconfig description about compiling as module.

Changes from v1:
* Change compatible string to google,regulator-cros-ec.
* Use reg property in device tree.
* Change license for dt binding according to checkpatch.pl.
* Address comments on code styles.

Pi-Hsun Shih (2):
  dt-bindings: regulator: Add DT binding for cros-ec-regulator
  regulator: Add driver for cros-ec-regulator

 .../regulator/google,cros-ec-regulator.yaml   |  51 ++++
 drivers/platform/chrome/cros_ec_trace.c       |   5 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/cros-ec-regulator.c         | 256 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  82 ++++++
 6 files changed, 405 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
 create mode 100644 drivers/regulator/cros-ec-regulator.c


base-commit: b29482fde649c72441d5478a4ea2c52c56d97a5e
-- 
2.27.0.278.ge193c7cf3a9-goog

