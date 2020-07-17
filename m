Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A251207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0wYVFni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGQNy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE61C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so11183169wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZfMUaA17R3icGqKhk35Xjzi+ajkOiQtF78NjxJlh+I=;
        b=t0wYVFni3sQJhsteO0i7CsJzNHAU3gm1n7rUGL+qpWUY0zG24jq6mHGpCRztRtUnwf
         IOYjz3GZfJtUIbcOJRAuKfwBpzFLJax83ltNTsLH9l3xREzmZgApSTfqhCn2FwFw16B/
         BTKKJjo4LmfEa2aMP8au9ZoYNGN0u0qvyX4GRpJjQTaZ3G4fPh8Gs0mtNsjZBmG4cfkt
         bntEjAaUGTb4QxIYeSdeXK4hSaily2WQ8SzEI1dLeee07rWeLCgM/AfajXQFM9kztgao
         onKzun9gCP2HjWLxnRrX1L4F8cxFHTRi6fLr7mhJpi7EeL6wCz2tF8Xlyq6EgLdFVHEp
         ZxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZfMUaA17R3icGqKhk35Xjzi+ajkOiQtF78NjxJlh+I=;
        b=jZzwoZHgfRNLRXBmcLRI8LGnsN+0sADXy1xmYzqrZiWy8xquXZGF934e3+0NL/1Vld
         isg6DHGXnA3U42mNbC0RXG1Sct2pTE5vZKrgKEcOWeJaPMJ11OUFW1qAshxe0NpA1ny8
         7FfIbLmNWYNbXCwfL8BMVWFugmNV5favcX5Y8yZ9H7co8GnNSCm5i9RQBmQQk1fxGgYm
         ye675n6OzjFfymDsA7au01E7JHInKuu+6elDmnmh5YjmDLgFEsEmRFrvSVkQIaKbMNyG
         Rk3ithUcR6y1jIorthAa4cSl0jCk9K/Cc4p00xkKvxnfjJOplRMIWvBGJBPW9UPjUhlh
         eC8w==
X-Gm-Message-State: AOAM530966eIgFEX7MHwrsreDAdbmKzBc+zVimZC+gn3GOHQmGRpX3oc
        o/FHwEeVQkPLUXdgifz+g32SdA==
X-Google-Smtp-Source: ABdhPJxg8iuLuT9JBHIPwafmAtJ1s/7zlCngVDEQH1UApsQdxbmvzfQ6mI4P0ZzZNDSocgJDY6MAsA==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr10451087wru.344.1594994067074;
        Fri, 17 Jul 2020 06:54:27 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/14] Rid W=1 warnings in SPI
Date:   Fri, 17 Jul 2020 14:54:10 +0100
Message-Id: <20200717135424.2442271-1-lee.jones@linaro.org>
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

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/spi.

Hurrah!

Changelog:

v2
 - Add *-bys
 - Remove instead of use OF table

Lee Jones (14):
  spi: spi-loopback-test: Fix formatting issues in function header
    blocks
  spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard
    comment blocks
  spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
  spi: spi-ep93xx: Fix API slippage
  spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct
    meson_spifc'
  spi: spi-meson-spicc: Remove set but never used variable 'data' from
    meson_spicc_reset_fifo()
  spi: spi-s3c64xx: Add missing entries for structs
    's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
  spi: spi-pl022: Provide missing struct attribute/function param docs
  spi: spi-zynq-qspi: Add description for 2 missing
    attributes/parameters
  spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
  spi: spi-topcliff-pch: Add missing descriptions to 'struct
    pch_spi_data'
  spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
  spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI
  spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI

 drivers/spi/spi-amd.c           |  2 ++
 drivers/spi/spi-at91-usart.c    |  7 -------
 drivers/spi/spi-bitbang.c       |  6 +++---
 drivers/spi/spi-davinci.c       |  7 ++++---
 drivers/spi/spi-ep93xx.c        |  2 +-
 drivers/spi/spi-loopback-test.c | 16 ++++++++--------
 drivers/spi/spi-meson-spicc.c   |  4 +---
 drivers/spi/spi-meson-spifc.c   |  2 +-
 drivers/spi/spi-pl022.c         | 12 +++++++++---
 drivers/spi/spi-pxa2xx.c        |  2 ++
 drivers/spi/spi-s3c64xx.c       |  9 ++++++++-
 drivers/spi/spi-topcliff-pch.c  |  8 ++++++--
 drivers/spi/spi-zynq-qspi.c     |  3 ++-
 drivers/spi/spi-zynqmp-gqspi.c  |  6 +++---
 14 files changed, 50 insertions(+), 36 deletions(-)

-- 
2.25.1

