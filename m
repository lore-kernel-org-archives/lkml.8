Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB0C5ACC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C617E20575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtWHzBiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgCKTPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:15:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33469 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbgCKTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so4147231wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kbRrkAeJHyKBfoxhtaOStXipnG/Sgu+7cKCsLovVUec=;
        b=LtWHzBiyI50M/8tTfrptPo7mD56R1D87P168cheHi6NnxFnl1grqBHKpMnUK56FTaP
         c7SnLF5S+Mk14346cBOXCOJIehCTy8HXr7HMSEieTKYxnyvS6d+Q4MPajC18WDTeOUdZ
         knZux5cIa9ubxh6vMW8AsXNBEUvmygdkvpsM78I9HzvCJNZM6yjZd0ukWXDPZM6ckyI5
         8hVAYBd+cZ/TBgk4IsnvHLnt5pKhrOHeKKZYLOTW2853FJbsSyxEebRSD/8U4QnzA0QM
         iJ3g/KOZAzdYMDWh40iMETC8cn9dKXpA33EjWsErNO1jXi2TcsNP4LhdP7dAs5lvTyq3
         PrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kbRrkAeJHyKBfoxhtaOStXipnG/Sgu+7cKCsLovVUec=;
        b=bBZUXRJBwe1jzzTqOcB7QZhyc2UjVOblc6U05QAuHFvH2GNTwnd4f0eisW7He3+gtf
         XDFum9h8Zy9mAvukWDGsW6c9xib6p1D6+An63BOhBUIvtNR/nh7auxi3uy9ChsGEJjUF
         r3NDdLE0ASsdt6I/jpkFgGnlQ2eHvMZf/7kHfJnCpmDI2soOg7Rxzr2xdNsB2FrwwVxC
         xp/EiUZHdDYNTnkkgAER5MBYgdTAIZ+R4hBbtW6iH/axlVPYscqS4T1LY6MsfXOI2sGc
         6N7J4sByz4k49E9utUQfSuwI0LgXWREtZMDRDPg7cgZzOUaDx+Kl4QozgQakiaeU5tXs
         XtZw==
X-Gm-Message-State: ANhLgQ2TV7zxDNDXH0g0V2F52wJ9QF7+5jqO3mouJy1KnmxpdQ8Dd3UA
        gzl8FKaOwB6G6tcx21cavrriBA==
X-Google-Smtp-Source: ADFU+vsD2ZqK4dtZKHh/wIu3OCvgAU1ewymHvX1gnWzG3Cmh50v327zeKOhmUotyxi/hMvs30e/Mzg==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr6293762wrn.29.1583954102179;
        Wed, 11 Mar 2020 12:15:02 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c85sm9687437wmd.48.2020.03.11.12.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:15:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, robh@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/6] Add DT bindings for USB HS/SS in QCS404
Date:   Wed, 11 Mar 2020 19:15:11 +0000
Message-Id: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds DT entries for the Primary and Secondary DWC3 controllers on
QCS404 and the PHYs attached to those controllers.

Additional board-specific bindings are required to make the SoC change
functional on the EVBs as on the EVB a type-c connector interfaces with the
SoC which is responsible to toggle VBUS via a regulator interface directly.

These patches have been through seven review cycles already and have a
number of Review-by and Ack-by. For the pusposes of making it easier to
merge this set focuses on the SoC DT bindings and target board bindings
alone.

The last set for can be found here:
https://lkml.org/lkml/2020/3/3/807

Bjorn Andersson (1):
  arm64: dts: qcom: qcs404: Add USB devices and PHYs

Bryan O'Donoghue (5):
  arm64: dts: qcom: qcs404-evb: Define VBUS pins
  arm64: dts: qcom: qcs404-evb: Define USB ID pin
  arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
  arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
  arm64: dts: qcom: qcs404-evb: Enable USB controllers

 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  90 +++++++++++++++++++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 100 +++++++++++++++++++++++
 2 files changed, 189 insertions(+), 1 deletion(-)

-- 
2.25.1

