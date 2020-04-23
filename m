Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D834C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CA020787
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jlf8Pn1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDWACf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDWACe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:02:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4EC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o185so1953215pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PitJZLSh8FX/H+hNsELa/boJvIBRP85pYm/veh8bMug=;
        b=Jlf8Pn1X7oG+tjm11lLjt/iVrUiz/YSvXh9WXKKkBZVleXsWU1xqHhzjY8mNsFDrEM
         a4NqwZvTew7aXbMa5RUkr9rLY+OhXYHiqjOYpOpplPsn1LMZJfTCD3rs56Yy0jguZjF4
         G2mBReItWnaYCZHKunleEE7Shb3YHyR2/Q6fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PitJZLSh8FX/H+hNsELa/boJvIBRP85pYm/veh8bMug=;
        b=alVuDac920OYVP82MSG9NaoRjsg9IVlgaVdG6F2KnvkSWsxRMkMoSiWwXQ4UZhc16S
         XwjSiYM+O1Gt1moIH4SSMINzhFnL6T/iOIFcYaBTEabkA008DakI5+RmFEyFKRNPnT12
         /WgCpjmlCObSH78gg77olQF0Xm6ofrkYAy49euARQf/mhzfBth82yJIjgAWziGcJxLdF
         CB6nV4xDDBaK89yY4oraatz1Z3y9pPar+B1CvhxGexUWuXRkb4bbI12JiKu/kckUPYZh
         4D0QO6NCnXv/2oQCSdDqLg43hpskVfAoEz3si2DsTyQLWbUmwoBeP2RCMkGcuv7oovSG
         0h2A==
X-Gm-Message-State: AGi0PuZn275j5+wV5juInYswfhQXuIwNeyDdzT3gIvE/GQxq5RdkBDB/
        wE5ddHzXWXxGOWTuPHySI0WsAw==
X-Google-Smtp-Source: APiQypL2YbCjuii692n7GM9WnGt6oTqOQcuBhUzTEba3QCu5V18FkquL+nWFNRRUwucWYPWMVmCl+w==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr1063589pfl.290.1587600154067;
        Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id d74sm656351pfd.70.2020.04.22.17.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:02:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] iio: cros_ec: Add support for RGB light sensor
Date:   Wed, 22 Apr 2020 17:02:28 -0700
Message-Id: <20200423000230.82750-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for color light sensor presented by the Chromebook Embedded
Controller (EC).
Instead of just presenting lux measurement (clear channel), a color light
sensor is able to report color temperature measurement.

The EC, using factory settings, can transform the raw measurement into
the CIE 1931 XYZ color space (XYZ) and take adavantage of color sensor
autocalibration to provide the most accurate measurements.

Gwendal Grignou (2):
  iio: cros_ec: Allow enabling/disabling calibration mode
  iio: cros_ec_light: Add support for RGB sensor

 .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
 drivers/iio/light/cros_ec_light_prox.c        | 470 +++++++++++++++---
 drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 -
 .../linux/platform_data/cros_ec_commands.h    |  14 +-
 5 files changed, 415 insertions(+), 76 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

