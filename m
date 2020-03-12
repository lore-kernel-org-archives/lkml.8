Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E7C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11449206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="list6E2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgCLOai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:30:38 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38561 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgCLOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:30:36 -0400
Received: by mail-wr1-f51.google.com with SMTP id x11so2988570wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYlsV+0cFhI9h/pYRfsk3djKR8WhNlc269xMicOU68A=;
        b=list6E2hu0YAwMIDt+JPZR0ang+wqpLJPzY9oxQPcsmVekhQyifaFtxHlTPWjwA9Je
         fjhNeQbCTVPQkAS6awePwy91Dzjp8Gz4D7Xj7xw5GZ2avB2v4YpYKlbxc0d921dZsmWQ
         KSQe6TyLMn1lR3zGBF81mRC/fduAOtqGmSsMtaV+xJRTmEVcxtp6991wYNyNRJmPmYjb
         5hDvWlkLoB/9DxHsJBMarZD3YaAQ0uSQ1Ua68Kd7lrOrwQZT1a1HjAbZGvd+Cb9vvWVU
         hUFmGbP71trSGC3VUuz4zOhsHkUzBi6aCxmGRe+/YXm/jUaCcN0DacHaSOwSMz+kZ/kR
         FanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYlsV+0cFhI9h/pYRfsk3djKR8WhNlc269xMicOU68A=;
        b=oXIQgtg0atV7wFmS2Q7uUS/E9w5NUirYgvngT+6np1TAJoXz+5ZkttnwJDVlYlbkrX
         DjLdgKrZ9c1HW08/hX+7Qr8LhTwOoUaZQ9KfZsyMMJO+sS464Jd2FHK7EuPKM8h3rLjI
         sipzfDgxjddxDA1BEsbgcZJtdXh9l7q4s+xnKj9y9pPhzbcYbVPsTDlsrsRZ6n8rNYcU
         R9m5jyHkpicEVkWY2Bx0xWFxFpyfg8Zrzqi/yxP9NHyePwF8GP6DGQkT1x7w0JBXw5RG
         m8m3O7zofgAmDV24XUPsY/dJigX9y9RGkipb0mZVUlrI3Tb8yfmPCOLdD4pxERGt01C8
         Vumg==
X-Gm-Message-State: ANhLgQ1/9RICgq/AZqK/EEE+PygQ2Y+e1B52gLw8zS6WOD9uvfEQmRrw
        oHWbGjh51J+4BrT39KaqaPJM4g==
X-Google-Smtp-Source: ADFU+vu25VE3Sm06Pe6EURmiIU0APvhxTGY3muWASxJ2HSGF1+cC0Oh6wwWs2ENxev29gzq+PgsqPw==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr3257467wrr.392.1584023434641;
        Thu, 12 Mar 2020 07:30:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v8sm72860454wrw.2.2020.03.12.07.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:30:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] arm64: dts: qcom: sdm845: add audio support
Date:   Thu, 12 Mar 2020 14:30:19 +0000
Message-Id: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds analog audio support for sdm845 based boards.


Changes since v1:
	- various trival cleanups done as suggested by Bjorn
	- added compressed audio dai for db845c

Srinivas Kandagatla (5):
  arm64: dts: qcom: sdm845: add slimbus nodes
  arm64: dts: qcom: sdm845: add apr nodes
  arm64: dts: qcom: c630: Enable audio support
  arm64: dts: qcom: sdm845: add pinctrl nodes for quat i2s
  arm64: dts: qcom: db845c: add analog audio support

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 159 ++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 281 ++++++++++++++++++
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 113 +++++++
 3 files changed, 553 insertions(+)

-- 
2.21.0

