Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C98C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF304206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mf1E8Le+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgFJH5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgFJH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:57:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A95C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:57:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b201so772779pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYzOpPCvvtp+Q0cQ7wQGP7OOdUT4aisr6GdQG5QCZCE=;
        b=Mf1E8Le+FQipLj4aEDkLrichXdckHasZQ7i4HDCCj+n0x4SfotnnopYGPc2h8YTl22
         ajvb5jnvcHzHHbPTwD9l9gc9XR5eEEdIYntXdtARy95VDgJCXWSbriqYxw29U53CkPJs
         WIqnWZ3mADoz8CzEitAR0EmmXl1bXy6cwS7y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYzOpPCvvtp+Q0cQ7wQGP7OOdUT4aisr6GdQG5QCZCE=;
        b=dJeCQUo0xYaPBtZ5/dF2EE69dBUMaO4CqrSLL03pSCSfbf+dJ0GFTFXuqn7NZZF69X
         8fPFfQE2v4m4tyifeaJJwec0CkoYZyhI5t7gpYBcYDqD1k1UksR2eXRLOh/6YMNBzabQ
         ajo0IZOBHu6Hyur79JafSzjsSGnsYY1WF52PI64MR9WfUhEp8/wMf8lTKHOBQmCFO5Jv
         2ONYbzx9BrKJadxHWvGLwOmnGE/qvkW847uJhyAQWaJnPxmGu06aVuFCnCiNmW98eQy0
         EidwOz6ChAgBuejeH0jZcn8BPEpwIL1r0xUI4hmFlHiSEFN4DM9AlBe6vok3rJV2cIxz
         CFYw==
X-Gm-Message-State: AOAM531BiwiMI+qPoubZEJ5YIP7M2x9LYY6At5O8d7UXrM1gLP/fexmy
        Cs4g3vjl7IRnQGU8Xrioa4JQig==
X-Google-Smtp-Source: ABdhPJzovtzuhxEIBGTjpE25exaThmE10VZFXUK/WiQuYPPuCRMrxUqSUmeIuD0lSSk1uLDvw+qfSw==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr1569880pgs.91.1591775821812;
        Wed, 10 Jun 2020 00:57:01 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id y26sm12035850pff.26.2020.06.10.00.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:57:01 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH v2 0/2] Add support for voltage regulator on ChromeOS EC.
Date:   Wed, 10 Jun 2020 15:56:42 +0800
Message-Id: <20200610075649.209852-1-pihsun@chromium.org>
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

Changes from v1:
* Change compatible string to google,regulator-cros-ec.
* Use reg property in device tree.
* Change license for dt binding according to checkpatch.pl.
* Address comments on code styles.

Pi-Hsun Shih (2):
  dt-bindings: regulator: Add DT binding for cros-ec-regulator
  regulator: Add driver for cros-ec-regulator

 .../bindings/regulator/cros-ec-regulator.yaml |  43 +++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/cros-ec-regulator.c         | 262 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  82 ++++++
 5 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
 create mode 100644 drivers/regulator/cros-ec-regulator.c


base-commit: 5b14671be58d0084e7e2d1cc9c2c36a94467f6e0
-- 
2.27.0.278.ge193c7cf3a9-goog

