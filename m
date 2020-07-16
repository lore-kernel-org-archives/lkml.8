Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6602C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA02207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbSrvjzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgGPOBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGPN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071CC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k6so7201982wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAwxCR3FswqosS52SCWPUccYu39mwWTweivr1S93PDQ=;
        b=WbSrvjzZ+me1f7OJ0qgvWTaTmehnJm51LUwmlCUhKUbF+qlvIe4uGE2/KNcZJqlOMU
         uSIqdcHRC43EfSL5b4dXl6pKp874ICuqayB9J64srbBrfJwvtaZxqRKfAj9d7qxBqecw
         wiARRCC5VitFz7463p6C8ZsZ0lAIZn+Fxeh9/LcDBlMNuE7BWSGzOopUiEQQ9eTAB3R1
         OSdUPfuXprrxgsUFw0giAdc6jEoVZ9kNHpbRjelXdNxQnvuswdbseDlIWzXKlmBn2AOt
         nDRPyfJZ9B1LtPSVozgoje/+YG8yIBAwjX3KADMyfMSv31gUA3TMnue9Jc7CZUrSxJQ5
         27Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAwxCR3FswqosS52SCWPUccYu39mwWTweivr1S93PDQ=;
        b=StMlCmb/VMM/8FZM8BhB98QYGH8odfwr8uLVwHaDLGvEEc5ROzBTM2KLnvQK2PpBfZ
         lgZdBc7bde6rPC5ZvUg/98pnW7atIH6eHBQ+Ee8q+E4fmjrMlMB4/Sd0Lx0I+1AD1wHs
         J6Eo84cXrSZitBfI6Y0ZSm/jKNJuXz3oZD7iUfmKyf/Fb8bVE4CQ2si04nfjJMGzfWsU
         Fo2lPw41CJx1szxFOkVF2YcXU/SvHl9YGoIg5DXdHl94wSxd0MFBU8CFeZ2wFiAYt90F
         iF5uL6EXKjYPo9AuVMT/R2mqN+Aa0nJ0T7lUgymMHhhtRseTT5gKiNSwBRYFNo98B1/y
         m++Q==
X-Gm-Message-State: AOAM533WRx43ghIckpPP4L9prBaIa5ofdkkKzxvYwYvmXY0mXKyxora4
        gisRKr+EJjGtgDKBdi9X4Kso/Q==
X-Google-Smtp-Source: ABdhPJzpkee4iDYRSwY5SxXKdttWlHBS7plXBxXLtYs5VNEVnJJ6o7JJbBDYVzv8HwciPazGJkB60Q==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr5230088wrp.34.1594907971551;
        Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/30] First batch of W=1 fixes for IIO
Date:   Thu, 16 Jul 2020 14:58:58 +0100
Message-Id: <20200716135928.1456727-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (30):
  iio: adc: ad_sigma_delta: Remove unused variable 'ret'
  iio: accel: bma220_spi: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI
  iio: common: ms_sensors: ms_sensors_i2c: Fix misspelling of parameter
    'client'
  iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard
    comment blocks
  iio: chemical: sgp30: Add description for sgp_read_cmd()'s
    'duration_us'
  iio: adc: ad7923: Demote obvious misuse of kerneldoc to standard
    comment blocks
  iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5380: Fix kerneldoc attribute formatting for 'lock'
  iio: dummy: iio_simple_dummy: Demote unworthy kerneldocs and correct
    misspelling
  iio: dummy: iio_simple_dummy: Add newline after function-end
  iio: dac: ad5421: Fix kerneldoc attribute formatting for 'lock'
  iio: gyro: adis16080: Fix formatting issue and compiler attribute
    ordering
  iio: dummy: iio_simple_dummy_events: Demote file header and supply
    descriptions for val2 params
  iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const
    * const'
  iio: dummy: iio_dummy_evgen: Demote file header and supply description
    for 'irq_sim_domain'
  iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
  iio: adc: ad7949: Fix misspelling issue and compiler attribute
    ordering
  iio: dummy: iio_simple_dummy_buffer: Demote file header and correct
    misspelling
  iio: dac: ad5064: Fix a few kerneldoc misdemeanours
  iio: dac: ad5446: Complete 'struct ad5446_state' doc and demote
    unworthy kerneldocs
  iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy
    kerneldoc
  iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5764: Fix misdocumenting and formatting error
  iio: dac: ad5791: Complete 'struct ad5791_chip_info' documentation
  iio: light: cm32181: Fix formatting and docrot issues in
    cm32181_acpi_get_cpm()
  iio: magnetometer: mmc35240: Fix function header formatting
  iio: imu: kmx61: Fix formatting in kerneldoc function headers
  iio: dac: ad7303: Complete 'struct ad7303_state' doc and reorder
    compiler attribute

 drivers/iio/accel/bma220_spi.c                 |  2 ++
 drivers/iio/adc/ad7298.c                       |  8 ++++----
 drivers/iio/adc/ad7887.c                       |  2 +-
 drivers/iio/adc/ad7923.c                       |  8 ++++----
 drivers/iio/adc/ad7949.c                       |  4 ++--
 drivers/iio/adc/ad_sigma_delta.c               |  7 ++-----
 drivers/iio/chemical/sgp30.c                   |  1 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c |  2 +-
 drivers/iio/dac/ad5064.c                       | 10 +++++-----
 drivers/iio/dac/ad5360.c                       |  2 +-
 drivers/iio/dac/ad5380.c                       |  2 +-
 drivers/iio/dac/ad5421.c                       |  2 +-
 drivers/iio/dac/ad5446.c                       | 11 +++++++----
 drivers/iio/dac/ad5449.c                       |  2 +-
 drivers/iio/dac/ad5755.c                       |  2 +-
 drivers/iio/dac/ad5758.c                       | 18 +++++++++---------
 drivers/iio/dac/ad5761.c                       |  2 +-
 drivers/iio/dac/ad5764.c                       |  5 ++---
 drivers/iio/dac/ad5791.c                       | 10 ++++------
 drivers/iio/dac/ad7303.c                       |  5 ++++-
 drivers/iio/dummy/iio_dummy_evgen.c            |  4 +++-
 drivers/iio/dummy/iio_simple_dummy.c           |  7 ++++---
 drivers/iio/dummy/iio_simple_dummy_buffer.c    |  4 ++--
 drivers/iio/dummy/iio_simple_dummy_events.c    |  4 +++-
 drivers/iio/gyro/adis16080.c                   |  4 ++--
 drivers/iio/imu/kmx61.c                        | 14 +++++++-------
 drivers/iio/light/cm32181.c                    |  8 ++++----
 drivers/iio/magnetometer/mmc35240.c            |  4 ++--
 28 files changed, 81 insertions(+), 73 deletions(-)

-- 
2.25.1

