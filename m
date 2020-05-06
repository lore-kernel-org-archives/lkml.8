Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF72207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jJj8oVcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEFXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgEFXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:03:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65105C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 16:03:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so1263611plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmaPtEHyPvGoB0RVI/vcu9s3SLlgGAwwRY3BU1xGh4w=;
        b=jJj8oVccZvz0VnXx/RxslRSl6lS7KnhNSbt4svw5Um1pu8LUgfMmb9WcLEL1iqiPLK
         G+4wMfzeASCOFSnrKIGoRn/y6nbJIYl1NV6RfpsHJnnxes8xXH6iXuSrmE3Njx5tX213
         T2IC0Deegw5PZ+VMuBtGBSRU6fSXOqAAwinVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmaPtEHyPvGoB0RVI/vcu9s3SLlgGAwwRY3BU1xGh4w=;
        b=sTfFtvGGJOM+SbHYuko+SYsZ7Je7+y+DSW8gKZkvi+Td9vt7nWXjpopNHgWfZ6YHAg
         HEN6BdFTLmDqMcDvM3esmEv438+ccSsxNoeGRS++cMkLPxy6ez4VF/TOt5u74qtcS2k1
         sDoO/QuKlEtelD5u64A2amyAqIn22Yq2C5ysHsRrkWLACLRthOFD6Nknuq2Sp9tmLeu0
         2UcZb5fQEV6v5jwJHb3V0CTPOpgF9lHwS8080zifN9+C5EK4XszsBMeBpBm+k9PJ+CSg
         KytxhuS5Jb7MKseDiXHwZsuDWeaCz9iBD+Pf6Z29ZUAwwBT3fm4s/FjL9lVPoNY8NhOh
         mvlA==
X-Gm-Message-State: AGi0PuZQhlQ41xeC33Wur+LIAqNxP3kqbIRWHErZ5sukVsCvHdRbWu1q
        Np+znHsG35CLbDYHf1aCKwrYxQ==
X-Google-Smtp-Source: APiQypKUO7bfvDMai2oDuvIVuwr3nwkhaoD7oZ559rsBY2hRfYMuzzVDjlXNMNfwdicLgaOeZJ2Bjg==
X-Received: by 2002:a17:902:c3d3:: with SMTP id j19mr10226448plj.340.1588806212706;
        Wed, 06 May 2020 16:03:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id 189sm2887851pfd.55.2020.05.06.16.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 16:03:31 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/3] iio: cros_ec: Add support for RGB light sensor
Date:   Wed,  6 May 2020 16:03:21 -0700
Message-Id: <20200506230324.139241-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
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

Gwendal Grignou (3):
  iio: Add in_illumincance vectors in different color spaces
  iio: cros_ec: Allow enabling/disabling calibration mode
  iio: cros_ec_light: Add support for RGB sensor

 Documentation/ABI/testing/sysfs-bus-iio       |  27 +
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
 drivers/iio/light/cros_ec_light_prox.c        | 469 +++++++++++++++---
 drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 -
 .../linux/platform_data/cros_ec_commands.h    |  14 +-
 6 files changed, 441 insertions(+), 76 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

