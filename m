Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C7C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EBB207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="CX1ZGntT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIKPjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgIKPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:35:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B6C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:35:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w16so10255415qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UB/8wNdkDm3ezMOvTd3hwGm2T0KYN22DgvIUjk5dmqk=;
        b=CX1ZGntTzJQqhGb8UHMy1gSTz3hgRfnUz91q5ex/Yikuwhx7ogSiGkljifjQ7rciTF
         /y9ZxUah6Bpj3v1rF48I8FPmJw01fNRZoiVw5AQr7GGQ6qQu7G+DorXR5P6mb+Nlji0v
         biYsfJfCucNUKwB/2NRsdGjNWevVFCkujjR9zibSPNvvd9eWEcdxKAVxNf0vU3lAlEZq
         suUpseCa4WtCAIS+x0gpjHxl7PmaASJjfLJ7yb12+1cmFinaqDzDT1PXzzqNkHJy0jTL
         oFZ6RDaODLBBF+oakwbC6Wmfio97RF13uhBeNP41Ft+elXuham5hc7/eX14fkhTxtuVw
         VR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UB/8wNdkDm3ezMOvTd3hwGm2T0KYN22DgvIUjk5dmqk=;
        b=HJ7CdTBtzhZCKlP/4ofLrFrFYS7eAPDAhQOxFBz0XJ4Kx3Yrx/vSt34HHvoMXew6Qy
         JfCCWh2BAS7pp5e836Rq6X79Z3SI31xdDk2bnuOQ8B4u2KkvVhm8HshEQFaVZVGHnYNu
         nIqZ9roZrfhjhdaDEpFVKOIxu54BoMNVUK6ScjEypr/ffdNdc/IQ5fyTrSjfe2YD3TPt
         nAuEawQwNQXjn22TXWhMAr+syKzExtk4Dr8jooqAF2uPLfS7Bucnbkua4LX8ao5wmA0u
         djH/1GrSClFetIJslKONKfLzLmjQEPiv6JtK4d6JFgVNYIQVUWJeQT/ux+5GuV85kCU7
         Txew==
X-Gm-Message-State: AOAM5303AEFdhY69na0obdy3wUkBz1VnkSMSNNI76BI1qDzlQxzX0tbz
        7ltiI/dziubQcPArgl7iuQEWYw==
X-Google-Smtp-Source: ABdhPJxIOGuiAqONyI2gDXdvk31GBfSIxJRtYTLqSi8FdF+FkFeWI7j1Afvd0YeNAoz6A05BlulJow==
X-Received: by 2002:a05:620a:65a:: with SMTP id a26mr1937093qka.424.1599838532062;
        Fri, 11 Sep 2020 08:35:32 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id v16sm3001744qkg.37.2020.09.11.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 08:35:31 -0700 (PDT)
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
Subject: [PATCH v3 0/7] SM8150 and SM8250 dispcc drivers
Date:   Fri, 11 Sep 2020 11:34:00 -0400
Message-Id: <20200911153412.21672-1-jonathan@marek.ca>
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

v3:
 - combined dt-binding: "gcc_disp_gpll0_clk_src" is needed by sc7180 too
 - use the right order in drivers/clk/qcom/Kconfig

Jonathan Marek (7):
  dt-bindings: clock: sdm845-dispcc: same name for dp_phy clocks as
    sc7180
  arm64: dts: qcom: sdm845-dispcc: same name for dp_phy clocks as sc7180
  dt-bindings: clock: combine qcom,sdm845-dispcc and qcom,sc7180-dispcc
  dt-bindings: clock: Introduce QCOM SM8150 display clock bindings
  dt-bindings: clock: Introduce QCOM SM8250 display clock bindings
  clk: qcom: Add display clock controller driver for SM8150
  clk: qcom: Add display clock controller driver for SM8250

 ...om,sdm845-dispcc.yaml => qcom,dispcc.yaml} |   32 +-
 .../bindings/clock/qcom,sc7180-dispcc.yaml    |   86 --
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |    4 +-
 drivers/clk/qcom/Kconfig                      |   18 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/dispcc-sm8150.c              | 1152 +++++++++++++++++
 drivers/clk/qcom/dispcc-sm8250.c              | 1100 ++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm8150.h    |   69 +
 .../dt-bindings/clock/qcom,dispcc-sm8250.h    |   66 +
 9 files changed, 2430 insertions(+), 99 deletions(-)
 rename Documentation/devicetree/bindings/clock/{qcom,sdm845-dispcc.yaml => qcom,dispcc.yaml} (74%)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sm8150.c
 create mode 100644 drivers/clk/qcom/dispcc-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8250.h

-- 
2.26.1

