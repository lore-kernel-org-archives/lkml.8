Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B0FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5472072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AW8zZuny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFKIZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFKIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:25:51 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F30C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:25:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so2234784pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcdvgMi0Xcc7Ab0dGvWFdpG5J1Q/LouhVGvMRTvGq+M=;
        b=AW8zZunyFOy7ogqrnyoJDLBKiXbpoHHaT2rDKSXg5N31yrBfMQpcm+3pIV0C0rdNRT
         YVCKQWdblJ7ElB+Dd91WiDFq5ctI7j7em6PDJMrgAUqQP11okcZU++NIjP5yQnJgA6GE
         i+9kaThIdvstFQW/MjpfOeXnVTIIOTYX5+DFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcdvgMi0Xcc7Ab0dGvWFdpG5J1Q/LouhVGvMRTvGq+M=;
        b=fuSTblzWxHUshp7w5y6OS0TUmRQTfTHax6mqv3rWoKlWjt9gCECwOso+UskHiBXVFb
         QnPPGOPREC5cMNOgfrE/0ShSdceuV/aDSy/UJ5qawbm3PQPTXKKEhLAUv6mss0o+0Lj8
         Wcov1RbN1ogP955L8hhCv7I6bDAeg522W40H6qqGEv3PzZ4QQ99RMhwyKFdfisM+mBJV
         wE47HmjlbsyIG5vDPTWLho4jI13dENiz+Qtp5ON3wLXzO8gsN/nHkRZkKBCkzOyIyuMq
         cdRMEe+9rB3Vajx2KV2TQ2a6kMtvY45yMLFAtkl7NNlMs+jgv/esdMRgtJbKnqr2wjzz
         LDtA==
X-Gm-Message-State: AOAM533G0MCvAJpCKolv8rhwcwKIynFsDPxu+OSTWOjx4W772bi7hFB+
        7HHnUKm8dCWc4xk2vj/18cyOzg==
X-Google-Smtp-Source: ABdhPJxeNdE/130ZUtUH02C1mLN7r4Pn/HDKQPxhyIXBP0M6zU4tXTo5WF9QcK3lWZyKY5tzKNFYZw==
X-Received: by 2002:a62:1d89:: with SMTP id d131mr6179776pfd.294.1591863950760;
        Thu, 11 Jun 2020 01:25:50 -0700 (PDT)
Received: from pihsun-glaptop.roam.corp.google.com (2001-b400-e256-fea4-a6c2-ff17-248d-0f67.emome-ip6.hinet.net. [2001:b400:e256:fea4:a6c2:ff17:248d:f67])
        by smtp.googlemail.com with ESMTPSA id m5sm1994749pga.3.2020.06.11.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:25:50 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: [PATCH v5 0/2] Add support for voltage regulator on ChromeOS EC.
Date:   Thu, 11 Jun 2020 16:25:35 +0800
Message-Id: <20200611082542.219516-1-pihsun@chromium.org>
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

Changes from v4:
* Change compatible name from regulator-cros-ec to cros-ec-regulator.

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

