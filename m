Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8897CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A5C20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJbmAjGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGCSxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:53:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48215C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 11:53:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so14656940pgg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWJU0FWdTff+uL3kEpD2oqqgtPNKxa9+VLRU7B17FDA=;
        b=YJbmAjGaE5bR6H2KyJDYOzUTqDr92z7lklxVkbgr9r+PiQ/QOqfAoDLQlPIwUCCOxC
         r/g5S7wYKDe7092l1uDIhNGTLJ/PYsmZbTEMAdQxQUZpFHZsGIYrGnih7kzbPoWWLQTL
         VZwTCp5fGSJ7ehB6yWcDMhR2HRt9bApz7e6RKrAuwZyb4oE3o10+9+lQu9o03dKSUx+b
         8GAzg7SydHbzqhVkZq2ONAEftka+6B36D1uwxQywN9B4vPBoaAp+IE8K2ybMa1rjWAHv
         AEqrSdxpVO60NhE/W/jkRRD249JooqdUV49W4QVGawj/Z69xTKF1FVwmHTB7dVQt2ZyB
         mOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWJU0FWdTff+uL3kEpD2oqqgtPNKxa9+VLRU7B17FDA=;
        b=n3ipfdc3WC63DXsBJG9zE3kPVEAPKyZuksMS5uRsoggwF7YRHv9Fp1jUuNBuP3EPd7
         KcCAjQDq3e0yhrL6XBoq3Ls94Ip/KDrTuuyIKzZHos8wKxLlu2izRxbfgMZUz4zmrU50
         LMVEBLAqMEsVnIVA+qHnk9S36V8Dmk2kqM1CdZHXJ+NKQYAztRQB5j6UCdgJTCnLnbQS
         6nRDs6ZLyCd8GMGKes38WqqjfTyqwtVtJ6pQMqTJN1lDYjhQYgJ6d0qoZjeSZB2cRC5R
         dfZDwsdZs16UzZgf29y4wTLoWuMFpgdHx1Rg5cuCHY1qY//GZJTHcNTvSnmtk5hlqZ6x
         2SGQ==
X-Gm-Message-State: AOAM530vUP/yFDgAYtu3YY4/DtRfDMC19V1f8QZtG1En4FcqjTOmr+4z
        ly8G5oRZ+HWIwucBkuzRgQnRWQ==
X-Google-Smtp-Source: ABdhPJw+BSrPKtvkkkrRdaleQ9tyYprdic3o8VZZKjlUZnxXo1whRA6EaefvUsAIwuHWqtOnnDIMjQ==
X-Received: by 2002:a63:3508:: with SMTP id c8mr31142500pga.9.1593802423724;
        Fri, 03 Jul 2020 11:53:43 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a11sm6346638pjw.35.2020.07.03.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:53:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defcondfig: Enable USB ACM and FTDI drivers
Date:   Fri,  3 Jul 2020 11:53:54 -0700
Message-Id: <20200703185354.1814337-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB serial drivers to provide UART access to various development
boards from an ARM64 host.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 883e8bace3ed..103ddad961cd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -687,6 +687,7 @@ CONFIG_USB_OHCI_EXYNOS=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_RENESAS_USBHS_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
+CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SUNXI=y
@@ -696,6 +697,8 @@ CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
-- 
2.26.2

