Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2711C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4677214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bymF+xNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgA3VNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:13:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37561 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgA3VNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:13:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so2297417pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+d19VC5GqGDrwah0h0bGrXkFmaAY9eB/iS9cICScuo=;
        b=bymF+xNlsIGFO5AVvycBkMmLMDI0N9JxG/Bf9e+DUzdYKaTxQCQn6cCxkA2xlU1MGQ
         jL3Ocqww4UXSqXcwOpEf4YhwjhY9GQoCIffmfnD0X+Hl0RDO8Cd9rWzI/I6lKgK9KgYt
         di04A74nfJkQ3bC6mWJji/hSv5fOrYlVaKmNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+d19VC5GqGDrwah0h0bGrXkFmaAY9eB/iS9cICScuo=;
        b=RpFidMzmTM2pbsGeKI+9rE/VKL4DiElm9berJxIKHGnyYai+/kwUMbGCJZDFs9T8gU
         /H6TsY66E/odav6VzTaSmH9z69mkJG94xXGxkuDnspThQtQxx7ketdtbsZ8YO6IcU/zy
         eQ39Zmgf6EuU2nCUEvAkMu6C4AHcb8cyBCbsyUX6czP3FqXh8B4//d7UCbFOJXqg7Ar8
         W21an9F8vGj6UMdY4IFcb9wy3J+GgjeTOHKEnMbcPVXN2rH75VgQIyotd/bZvbzDZHm3
         srEd0ycLxrOQYA6F+AiQF5wKrgji4dBEv7vbwi7E6FlsPRbGn0HfIy1B0SzRDIet7bnS
         +kqg==
X-Gm-Message-State: APjAAAWLS3wcOejCapEksSAQuSyVDNSPeaCxl6qFpaxMhBv16YHbKDEG
        LTDDK901e7W5nVoRnMDOZjp5hg==
X-Google-Smtp-Source: APXvYqyT/IU+WqiG933tteXMVt0zK6C+GD/fPoh8GuJLGi5bjbnMq8BTFHzIssXi/t0dghRGHOgoYw==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr6664743pga.223.1580418785098;
        Thu, 30 Jan 2020 13:13:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id ci5sm4343871pjb.5.2020.01.30.13.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 13:13:04 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 14/15] arm64: dts: qcom: sdm845: Add the missing clock on the videocc
Date:   Thu, 30 Jan 2020 13:12:30 -0800
Message-Id: <20200130131220.v3.14.Id0599319487f075808baba7cba02c4c3c486dc80@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130211231.224656-1-dianders@chromium.org>
References: <20200130211231.224656-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're transitioning over to requiring the Qualcomm Video Clock
Controller to specify all the input clocks.  Let's add the one input
clock for the videocc for sdm845.

NOTE: Until the Linux driver for sdm845's video is updated, this clock
will not actually be used in Linux.  It will continue to use global
clock names to match things up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Unlike in v2, use internal name instead of purist name.

Changes in v2:
- Patch ("arm64: dts: qcom: sdm845: Add...videocc") new for v2.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 35d7fcbda43c..3ad08d9deb54 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2607,6 +2607,8 @@ video-core1 {
 		videocc: clock-controller@ab00000 {
 			compatible = "qcom,sdm845-videocc";
 			reg = <0 0x0ab00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
-- 
2.25.0.341.g760bfbb309-goog

