Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D693C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF84206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kblYlArl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgA2WpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:45:08 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51470 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:45:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so439462pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7HPpDZbGMNMzei0pX9Wie2HkG11xn2NGkIboTXv1pMs=;
        b=kblYlArlD43JKi7Kimzz20yWN3J+YPLvrEcVUiS7bMzqY+m8gGEByLZ7fuO5ed0IGC
         Y7bdpVuk3TQpws2xKmX059iHQfHrB98W9WnET9byqBobID6rPWsuWyhSesGRvvZsiH9A
         +79v6YqQKBDsVviXA4z9+drqVcHSDe0hWSwyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7HPpDZbGMNMzei0pX9Wie2HkG11xn2NGkIboTXv1pMs=;
        b=M4qnWcKbQ17xFdf5I+Aq+oIu7YsIl9RxOf5RXv8zKnafamr5w5yUZla1W6gO5xsFnB
         rTkVCdmQ4cVSaCgtxpHmD0BatilyWS1nNdhAKcaf79AJecr7Kukm4JFjjDcJBIQsMoDI
         N/pld1ssdL3j4/W8gCSWll0TSSCxZbBY76C3HaHdclKC9v5QQ3hwtNxr9HrS3O6Gntfh
         BBcIOO2MaA1IIoKr35mmmYm98QVuKnl64LSI9FzqpKVcm4/DP9k9LBAp7CMNqwdSadCF
         43SctuRVG+0HkQhn/VdcIMdDp/Pzhnj3RpT/ABWLJ2lJ7dLqC2aGSdW5kW5bwyY3IpTo
         9Y0Q==
X-Gm-Message-State: APjAAAU3L5xwDYTtTQyUXgXwmFnZz710Ora42PJPQlHbzGX5HzCypxQa
        esq6ll0Tya71iHhWiWUXfePSvg==
X-Google-Smtp-Source: APXvYqweoX7bxY7A38/leYVBpMJSkaUgDlxuLg+gHSPQE9xAoBSFQInKPU+dD4vOdFLBmy8Ha6bjVw==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr2186440pjn.61.1580337907570;
        Wed, 29 Jan 2020 14:45:07 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g9sm3870602pfm.150.2020.01.29.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:45:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: sc7180: Add the sleep_clk to gcc-sc7180 node
Date:   Wed, 29 Jan 2020 14:44:42 -0800
Message-Id: <20200129144432.1.Ie36f0532f67b0221c1e48e7cf6863a2738716a54@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings say that we're supposed to have this in the node.  Who am
I to argue with the bindings?

Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for SC7180 soc")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 8011c5fe2a31..4b621277744b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -310,8 +310,9 @@ gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sc7180";
 			reg = <0 0x00100000 0 0x1f0000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK_A>;
-			clock-names = "bi_tcxo", "bi_tcxo_ao";
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>;
+			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.25.0.341.g760bfbb309-goog

