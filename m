Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D71320716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="PqLGbKMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgICW1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgICW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:27:14 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0106C061251
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:27:13 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p65so3260809qtd.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9SpSwMIgy/0uDv9Hc0PvSjCztNMgh+f4IT2tkCaQkW4=;
        b=PqLGbKMp2gjiffHSrlocu7l+Z3ajwgMd1X3CxsA+yNf4pwuW1nDh2A5P+x5XtNvX1h
         goUHuIX34yVxPumhBEKDfmhGjy0yCNAqzPU3XzE8c25pUQZE5R3WWiYaTzaE8MayTTwN
         d+bw8tnnyR7Gu/EeVMxOJW0QzuHADNhxpJuynXH9pod1M04KRFjIgXdO+L6app7bNmPF
         oQNDI9cQQwz1Xa1kxrpNhmoTnt7kDoavfajq6JcBKsCUx+XOVrmi0gY1PyVd2+gNVtDO
         IkaY/TD90aNvonnCrlZIeyI4+su8YfM8rG8CWTeF5lgVbdb+hJJlNmvIFmiJQh844a1G
         EPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9SpSwMIgy/0uDv9Hc0PvSjCztNMgh+f4IT2tkCaQkW4=;
        b=m4FzngIHatAg0IkAlhaYiolSUrJ0f4xsvK84bgBsoAk1bmHIXgGYxKdOMqxShgLcoG
         eetFyNppV89IKEPkwpfP2+JZm0cf9iXcdYNDCVrEfuqlILDP9dYFkT9V7qsftSskxgmA
         aoRp4FuPkjzJFsiUtdC4u/dZXzyxskx9+CkhQGvVHk/Avkk/URIeqn/Ff2kbSMIEDr7X
         op7riYLSOLPVbnoaengfWCj0PCcaL5oud+Nf9Caw4fFq7c/XVJdkdmxOnstdcRjTrn53
         +8OYCggadyo6CPStmkO5runfUhcJ21+MFKsA1B5w18rPoyK0Q2gAdUDZetSLHVgIs6iB
         IBiQ==
X-Gm-Message-State: AOAM530Aqp5DcxlfICZgFoamswSDL3NzgOgxLkVnmwIoICWE1aFW+QPS
        +PX2AVgviTGTJeOLPZezOnHMZA==
X-Google-Smtp-Source: ABdhPJyX2L6/vlPMY77nburHLozkIx336EIl0ufaIwZ6yu03grC4E5axYN4yguWf2gLAO+aUHM6K/g==
X-Received: by 2002:ac8:b46:: with SMTP id m6mr5741737qti.72.1599172031736;
        Thu, 03 Sep 2020 15:27:11 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y30sm3217157qth.7.2020.09.03.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:27:11 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/7] SM8150 and SM8250 dispcc drivers
Date:   Thu,  3 Sep 2020 18:26:08 -0400
Message-Id: <20200903222620.27448-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add display clock drivers required to get DSI and DP displays working on
SM8150 and SM8250 SoCs.

Derived from downstream drivers. Notable changes compared to downstream:
 - EDP clks removed (nothing uses these even in downstream it seems)
 - freq_tbl values for dp_link clk is in Hz and not kHz

v2:
 - updated dts example to reflect the change (first patch)
 - updated config_ctl_hi1_val in sm8250 dispcc to latest downstream

Jonathan Marek (7):
  dt-bindings: clock: sdm845-dispcc: same name for dp_phy clocks as
    sc7180
  arm64: dts: qcom: sdm845-dispcc: same name for dp_phy clocks as sc7180
  dt-bindings: clock: combine qcom,sdm845-dispcc and qcom,sc7180-dispcc
  dt-bindings: clock: Introduce QCOM SM8150 display clock bindings
  dt-bindings: clock: Introduce QCOM SM8250 display clock bindings
  clk: qcom: Add display clock controller driver for SM8150
  clk: qcom: Add display clock controller driver for SM8250

 ...om,sdm845-dispcc.yaml => qcom,dispcc.yaml} |   30 +-
 .../bindings/clock/qcom,sc7180-dispcc.yaml    |   86 --
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |    4 +-
 drivers/clk/qcom/Kconfig                      |   18 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/dispcc-sm8150.c              | 1152 +++++++++++++++++
 drivers/clk/qcom/dispcc-sm8250.c              | 1100 ++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm8150.h    |   69 +
 .../dt-bindings/clock/qcom,dispcc-sm8250.h    |   66 +
 9 files changed, 2428 insertions(+), 99 deletions(-)
 rename Documentation/devicetree/bindings/clock/{qcom,sdm845-dispcc.yaml => qcom,dispcc.yaml} (75%)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sm8150.c
 create mode 100644 drivers/clk/qcom/dispcc-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8250.h

-- 
2.26.1

