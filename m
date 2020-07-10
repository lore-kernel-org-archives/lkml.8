Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1892077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSC+TB0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGJF3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJF3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:29:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D70C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 22:29:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so1776473plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fq5dVVlXW8qg+ASmc5eHI9qkJpaHLFgd8jV55IoO3ds=;
        b=fSC+TB0W8aTyto0vDTACgNdE+o/xQvY0+T6xDsLXb8pdgoa95Mj8zMAZqwwL++d39S
         lVWyFoGN+3odNlUh7r3IiowLswEqO1iqmK6kt8zqBamwRNYtPpZ+UVrltGKfoObVSGmg
         ZqomVJgpYVNQRFbedwWIKVU9uAaDp4HIr85uzOiHAFqOnH/Dok9dMvN2ypcfzVQazEi1
         6/j6vK8cL9oDX4dC3WH0/3HyKaCTdGzPloRaPMqz6jgIYXipYxr3fPheAh6eI4Bh675I
         BmDbCj5qK6MMy5KwF4l4Ptu1RycxCp1Bhd//HyFQBPuRkRSYjoP7hy0GzNZIL1kG5kHH
         llxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fq5dVVlXW8qg+ASmc5eHI9qkJpaHLFgd8jV55IoO3ds=;
        b=hkz9wGluQE32gM/eNbiGYtE5f5b1wcXBL8VPB75uoGTxsB4b3wpMyX6bu5braXWmum
         gd2G9VogEure0ba4hNitgMeKevOtCp4LxrKEOgmxI3CTfQruzGz2RNS3sHFZ05H4UnFC
         eMflNfF1AIeSS/05hLWUj3Ho3GRuZZrIu8CmMJ2/ag9iQvjTgoJRzqLXpsIASYcghyuM
         2CoaqrBfRCJTideEkLxuwqv2C8zmStT40DnrOnOFaCXpJpAupN2b/FhGVKKZm+2wVj2h
         SBhnjP8cSuD4Iqzs3I7t5Vpd3uOTKyqh9S8Ad8zL7Xh1U5Fi6ALbHjFlBYxROWIkZe6n
         sFxA==
X-Gm-Message-State: AOAM533zHQLfgs4q/mjS7EMOE+PylJz9lN0isCfwkLVVSwEZNpLvUYse
        bOQL3qjTYqwZIN8omlCqHqqiRw==
X-Google-Smtp-Source: ABdhPJyGZ0UdSuIDAqgj791fJ6nEZkauC+BEQanM5UDNKEQvIpcTaJkj0dDI4tcfvYGmn77x60c0Sw==
X-Received: by 2002:a17:902:a3c7:: with SMTP id q7mr23353866plb.20.1594358970129;
        Thu, 09 Jul 2020 22:29:30 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id j17sm4168320pgn.87.2020.07.09.22.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 22:29:29 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [RESEND: PATCH v5 0/4] Qualcomm labibb regulator driver
Date:   Fri, 10 Jul 2020 10:59:15 +0530
Message-Id: <20200710052919.2611-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver for LAB/IBB regulators found on some Qualcomm SoCs.
These regulators provide positive and/or negative boost power supplies
for LCD/LED display panels connected to the SoC.

This series adds the support for pmi8998 PMIC found in SDM845 family of SoCs.

Changes from v4:
- v4 Review comments incorporated
  - simplified the driver: removed of_get_child_by_name(); use ENABLE_CTL
    register and switch over to use the regulator_*_regmap helpers
  - improved kerneldoc
  - From the dt-bindings, removed interrupt-names, changed to dual license,
    added unevaluatedProperties: false, removed interrupt-names, since there
    is only one interrupt per node
  - Since the Short Circuit handling needs more details from QC engineers,
    drop the SC handling patch from this series, to submit it later

Changes from v3:
- Handled review comments from v3
- In core, swapped the meaning of enable_time and poll_enabled_time; so we
   wait for total enable_time delay, and poll in-between at poll_enabled_time
   interval now.
- fixed dt_bindings_check issues in dt-bindings patch.
- Cleanup of register_labibb_regulator(), and adapted to updated meaning of
   poll_enabled_time.

Changes from v2:
- Review comments from v2
- Moved the poll-to-check-enabled functionality to regulator core.
- Used more core features to simplify enable/disable functions.
- Moved the devicetree binding to yaml.
- Updated interrupt-names and simplified handling.

Changes from v1:
- Incorporated review comments from v1
- Changed from virtual-regulator based handling to individual regulator based
  handling.
- Reworked the core to merge most of enable/disable functions, combine the
  regulator_ops into one and allow for future variations.
- is_enabled() is now _really_ is_enabled()
- Simplified the SC interrupt handling - use regmap_read_poll_timeout,
  REGULATOR_EVENT_OVER_CURRENT handling and notification to clients.

Nisha Kumari (3):
  dt-bindings: regulator: Add labibb regulator
  arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
  regulator: qcom: Add labibb driver

Sumit Semwal (1):
  regulator: Allow regulators to verify enabled during enable()

 .../regulator/qcom-labibb-regulator.yaml      |  70 +++++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  12 ++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/core.c                      |  63 ++++++-
 drivers/regulator/qcom-labibb-regulator.c     | 175 ++++++++++++++++++
 include/linux/regulator/driver.h              |   5 +
 7 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
 create mode 100644 drivers/regulator/qcom-labibb-regulator.c

-- 
2.27.0

