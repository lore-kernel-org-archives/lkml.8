Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40824206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="koaPYN2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436537AbgFYURQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407101AbgFYURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:17:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEC8C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:17:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so3297630plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfbKgemW+h2MxakeR0KWqGEyeZapu5dTocFIrlzaeTk=;
        b=koaPYN2wBZx0y+NwH0a3Pgb4IbwCzVKE0QofUhT/yNqkp3+2eOH+J3TeQKgs0AJIid
         yhijL7J+yBwsg1advmT17TkrfJsnIbPlHhgkbXgw68uBlowbo+9465HUE7eFCjrYKhDZ
         wqV5Ff+vqqyUJDn+B85ahXC8e2Yxtom8h2Ls0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfbKgemW+h2MxakeR0KWqGEyeZapu5dTocFIrlzaeTk=;
        b=qI0/Itafwo6gKEuTY8AyyUMP2Rp3EKnIJB2eWAUZnEy+bwK0OXidkdCYlxLz95iaJ/
         mLI6LFLWx8DuWNSyTWl+W5ROIDEBNjDxrvSFdKBIxfI7qazx7ZAfBbGoAi6Cd3IMXkwI
         L3z3LrrKFBPJzuKbm5Yaq5tT1XE2PJFiId6KziAb2DTDWubfPgPnslvOJXjGumnGzZz9
         yvEoOGVyOvLLjyugduDkQpgY39i/AKBltYVVV1yIYBHSMeXe9cuUixb0b8+643ouOTOS
         B/8DT45WM7jzyE6JHa85YJQI+8/Of4Bc13RMZ/x2lyPD/9jlBok4b5SyNUf/oLdYV8xu
         ESZQ==
X-Gm-Message-State: AOAM530m8LRnfZGfz1c8QSGuuJk8eianx0VUFTI30ckEzX5Wd+L25SL9
        Axaebkc/93K+r3MBfCbzGEn6Dw==
X-Google-Smtp-Source: ABdhPJwPiKQ2jBtfYOBSS7xaUWBbx2DJaXUSav4Q73TNrW9/BI70Esu/z3iw48+y0xzuhrISTm+Jyg==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr35561059plc.169.1593116234073;
        Thu, 25 Jun 2020 13:17:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id t4sm2067565pjs.39.2020.06.25.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:17:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH] arm64: dts: qcom: Fix WiFi supplies on sc7180-idp
Date:   Thu, 25 Jun 2020 13:17:09 -0700
Message-Id: <20200625131658.REPOST.1.I32960cd32bb84d6db4127c906d7e371fa29caebf@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi supplies that were added recently can't have done anything
useful because they were missing the "-supply" suffix.  Booting
without the "-supply" suffix would give these messages:

ath10k_snoc 18800000.wifi: 18800000.wifi supply vdd-0.8-cx-mx not found, using dummy regulator
ath10k_snoc 18800000.wifi: 18800000.wifi supply vdd-1.8-xo not found, using dummy regulator
ath10k_snoc 18800000.wifi: 18800000.wifi supply vdd-1.3-rfa not found, using dummy regulator
ath10k_snoc 18800000.wifi: 18800000.wifi supply vdd-3.3-ch0 not found, using dummy regulator

Let's add the "-supply" suffix.

Fixes: 1e7594a38f37 ("arm64: dts: qcom: sc7180: Add WCN3990 WLAN module device node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have an IDP setup but I have a similar board.  Testing on IDP
would, of course, be appreciated.

Repost because I screwed up the "after-the-cut" notes on first post.

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 39dbfc89689e..472f7f41cc93 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -391,10 +391,10 @@ video-firmware {
 
 &wifi {
 	status = "okay";
-	vdd-0.8-cx-mx = <&vreg_l9a_0p6>;
-	vdd-1.8-xo = <&vreg_l1c_1p8>;
-	vdd-1.3-rfa = <&vreg_l2c_1p3>;
-	vdd-3.3-ch0 = <&vreg_l10c_3p3>;
+	vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
+	vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l10c_3p3>;
 	wifi-firmware {
 		iommus = <&apps_smmu 0xc2 0x1>;
 	};
-- 
2.27.0.212.ge8ba1cc988-goog

