Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8050CC55198
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F68F20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DpLPKwlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgDWQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729615AbgDWQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:26:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260EC09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so2718653pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fs+VyUYiQhHLqjr9qU6M46uht+we4DMR37Sq8mHOUJg=;
        b=DpLPKwlMZsLZnxIioolM8ptTrEbItSx7IHdh1uPs+5fsxWGMGiV+5LduIaSEo0UdUH
         lfewHcUPuCS2CaHrmBVsSnkGCWg/Y04/Hd85eHRDtEqVH1g+b5xaPV0zWfvc0d0aJOmW
         t+u2CkySUhgOQJfywp7JUZRfHAv1W7wSiwO2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fs+VyUYiQhHLqjr9qU6M46uht+we4DMR37Sq8mHOUJg=;
        b=JitS8xpcWfRxlpYAcd8yICorTbfHgQHk5RXDzWVYV1DC+lmVw92IijK/++NAIuTmCU
         ETWJF6oc+6d4Gs5HQ3aK0/xxYwGz9FOZhgQO4MsRCTS22AyPfsIAQug8M/IgDWWrBk/e
         lAiL7NrkLFzpwyHZKvpB6aPy5UnQyOhTJKEDg97PFiV0ipaMAX0JcO9qMNxrHkdC5ngq
         /dBg/PBinoUSzP5+8/eEkQJKWdpnzHf38LEFJ6hPghIcT5BLblZKQ2QGffn63N96trzT
         x4KwBMAtiJVqwck21Xz/U31nrOpIQF84Nm+jxokWLhJmEDNwUqqW5TZen2YWEMR1bPoT
         UsqQ==
X-Gm-Message-State: AGi0Pubb8Uegk7851veud40ydRGkpPbNHXgs6KOk+BxVnjPDGgbUwM3O
        OfwcwWprLc7K1lqsvDkBk1ALMA==
X-Google-Smtp-Source: APiQypKJjjilIFJnRl4OpyzS4YRq70Qi1utK3lHOL5ENRwaojLCeKCJCNTxUDY7zc6N7YPo9khOOyw==
X-Received: by 2002:a17:90a:f68d:: with SMTP id cl13mr1559548pjb.107.1587659179681;
        Thu, 23 Apr 2020 09:26:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm2841927pfq.36.2020.04.23.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:26:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@chromium.org, jernej.skrabec@siol.net, jonas@kwiboo.se,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza
Date:   Thu, 23 Apr 2020 09:25:48 -0700
Message-Id: <20200423092431.v3.6.I89df9b6094549b8149aa8b8347f7401c678055b0@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423162548.129661-1-dianders@chromium.org>
References: <20200423162548.129661-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have the HPD line hooked up to the bridge chip.  Add it as
suggested in the patch ("dt-bindings: drm/bridge: ti-sn65dsi86:
Document no-hpd").

NOTE: this patch isn't expected to have any effect but just keeps us
cleaner for the future.  Currently the driver in Linux just assumes
that nobody has HPD hooked up.  This change allows us to later
implement HPD support in the driver without messing up sdm845-cheza.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3: None
Changes in v2:
- ("arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza") new for v2.

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 9070be43a309..5938f8b2aa2f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -548,6 +548,8 @@ sn65dsi86_bridge: bridge@2d {
 		clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 		clock-names = "refclk";
 
+		no-hpd;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.26.1.301.g55bc3eb7cb9-goog

