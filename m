Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049D5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B0420734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZr9rCwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgFBKJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgFBKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:09:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A2C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 03:09:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so1157524plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EWmfZNZs76IOluosDfmNrcdSeX3EmBQEAHMvHcf/Vk=;
        b=uZr9rCwig9hq4NeVRTrP9yee3JCzQwSVErzm2dL4W5KxPlvfZGS28uIBMB94tfdytB
         iTxIl0AMvr1+HntgrZ8WRFYeGX/i+01pdp6HXa+m3FBywDvc2vX1kT+uTtJQSje+9m2P
         ca6mm3GoCXIzlz7Gpn7lnZxAhXqrtIUXwcBOcOao8HpciVMj4Z3JGw97UC9JRyMv+WUd
         cLGFmxaYUhZvOjDx3mnBkn5HFiBvzlrAiHDq+EUoG5Mvr/r94wpggUe/7fl10rlnF0Vf
         tXIOLk5Jex9citYAJ3yOVmG+KAWmBAbOkdKiAT3HpLlIo8gH4/kThrcvZMPAwOrQK/X8
         4s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EWmfZNZs76IOluosDfmNrcdSeX3EmBQEAHMvHcf/Vk=;
        b=lwGr9d+yjc1DLXfcu6xz45gVOm3VdWhHHhaDqqcZl2D4SK3Uu7KjaAINoCvsy8iCJa
         b++SXIfpVUBSqjnraM1PnWtehkRkzHOWnrI8QkiLj85poehqJJMiq8/7U0PnSu6tWM/d
         ZRcvUUX8j+B7RTsX6kvF8hPVyzn7F9tfbS/oPOyo7kdWejIH5/r+4ouRaAFG7AaGJShv
         zbjpW7Gol9cMImXGpBQ0xaoAE1Qi6iI/TFA55ZxXAUHUxCi5KPcx7QnumVF51WIDp0xO
         AFP4sLthCLd2iXtBbx+M6tXcEglnL99yRKDnDCle37UXmXFQVbV7vxHtU16RSp6n2KdP
         DFug==
X-Gm-Message-State: AOAM533HzOFSxBexRd6ydRXC8T9rZSmUj/KaxOCYZm0Ey5+oy3zmOZdG
        cPHaPrE9AViH2DpHTPyzly5v9g==
X-Google-Smtp-Source: ABdhPJwcz+UPRaGJjz1YGfQ6cG165j/BIiASbSQ2PPFQQAhFhCjtu6LEh3fyjK4bz6/m/UhhPBboDQ==
X-Received: by 2002:a17:90a:3d49:: with SMTP id o9mr4352805pjf.26.1591092577852;
        Tue, 02 Jun 2020 03:09:37 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id d8sm1931276pgb.42.2020.06.02.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 03:09:37 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v4 0/5] Qualcomm labibb regulator driver
Date:   Tue,  2 Jun 2020 15:39:19 +0530
Message-Id: <20200602100924.26256-1-sumit.semwal@linaro.org>
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

Nisha Kumari (4):
  dt-bindings: regulator: Add labibb regulator
  arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
  regulator: qcom: Add labibb driver
  regulator: qcom: labibb: Add SC interrupt handling

Sumit Semwal (1):
  regulator: Allow regulators to verify enabled during enable()

 .../regulator/qcom-labibb-regulator.yaml      |  79 +++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  14 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/core.c                      |  58 +++-
 drivers/regulator/qcom-labibb-regulator.c     | 289 ++++++++++++++++++
 include/linux/regulator/driver.h              |   5 +
 7 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
 create mode 100644 drivers/regulator/qcom-labibb-regulator.c

-- 
2.26.2

