Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DAFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC14A207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLcs+9vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404684AbgE1PrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404669AbgE1PrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:47:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBBBC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y18so13687019pfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bzFkEpeMiuczNpVrGeVDfJTOaYxKHg+WzWEH40XhWE=;
        b=HLcs+9vbHgcJOleOjvkmnddOoWOENq1ApNFuKlsvL7Fhqhv+BZzqph1mjN9eSJWnvs
         D9SThGRtoBtovGAknlmhY5N0KECznIyDjSsgIH1TapbLnIs40D69D6HewwtcKGLDcRJc
         E6gj14FTp3OUmF8uVng6h30QlcDJtl6e1+qzUlSLtma1s5D/3Qs/fDfOYvH96k2/kJJy
         5eRkjrMUmRJWuPb7EwTPnrR/tvxjgtNvlir084wxB+aIncgTYgfIeuBT7J94B8ut56JZ
         32PEY6R6IJhjvOe79CHMLjx/B/soPDWjGp5C+xWPmwpU0VncfaIhreWCoipx7QKZQxXF
         u80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bzFkEpeMiuczNpVrGeVDfJTOaYxKHg+WzWEH40XhWE=;
        b=Sihf0cFcwn1eZpbIY4c5bmJEfDlSy/kWsBGrNQ4q/2Y+/9mMuqgOhlXy4+WBHwLuAS
         ZCsrH8QXmnY5JD64u4Jw4FNXwfleB4KyZiW0rdkSPcUBJW+kZ9OqFpQdRpG/qSZOmR8h
         FjXHJmkXiGr0H2026DbIo5purjb+tVvWZ5B3GcMceaqii1jNzoL5jr4lY5EZW45LK36M
         Mt/YWSGxyccUmhkIgEhzNSGE88t+2G1xa+TPQrqEHwq73ruwuSro6xinAROb7wVcT2Hu
         Bu5/Di87sRt2435ReVLCqOL+7pqSwmEln5sBoXC0NY/O4+wCxZV1tMJhJGRm48Tvh2mZ
         7LhA==
X-Gm-Message-State: AOAM533rJ6FXhAytfOU7anuJFrdPnBuLFgwLJofUU7DYw/Z61JXl5urd
        NeaFyaCiV8ONoqlkbYAtUizZ+EC6+wl4jA==
X-Google-Smtp-Source: ABdhPJzqKkm7zM1Q9nJmBlgmD27dvX4y5zG//O+pRAV+bthX0R54UHNlVgcsDY/Rc/HWan7HktwORw==
X-Received: by 2002:a63:c846:: with SMTP id l6mr3474336pgi.197.1590680819568;
        Thu, 28 May 2020 08:46:59 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id y22sm5212551pfc.132.2020.05.28.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:46:58 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v3 0/5] Qualcomm labibb regulator driver
Date:   Thu, 28 May 2020 21:16:20 +0530
Message-Id: <20200528154625.17742-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
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

Nisha Kumari (4):
  dt-bindings: regulator: Add labibb regulator
  arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
  regulator: qcom: Add labibb driver
  regulator: qcom: labibb: Add SC interrupt handling

Sumit Semwal (1):
  regulator: Allow regulators to verify enabled during enable()

 .../regulator/qcom-labibb-regulator.yaml      |  63 ++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  14 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/core.c                      |  28 ++
 drivers/regulator/qcom-labibb-regulator.c     | 316 ++++++++++++++++++
 include/linux/regulator/driver.h              |   5 +
 7 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
 create mode 100644 drivers/regulator/qcom-labibb-regulator.c

-- 
2.26.2

