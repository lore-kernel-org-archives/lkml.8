Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C5C4725B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D566120836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeP8tZra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD3Tqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD3Tqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:46:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B6FC09B043
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:46:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so384446pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNXt2FmO52CndewwhPBTf6I3mlSfjDZ6zV6z3LcD0VE=;
        b=EeP8tZraylGTLmSTJH6KQFW78ibPGi/n6VR3j90ey0lht5hgmByF7Ag8EXQRMbYY57
         IlG5tDXde2JUI0MV5tWKn0bOMGytiYol6M1pGGnhyrNAPTxlRKSNOdzzdJxAJ4f2sMAH
         03lRzJvQy2wVsDVtMwt8z0cb7Mlulvu7VFMf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNXt2FmO52CndewwhPBTf6I3mlSfjDZ6zV6z3LcD0VE=;
        b=pq3gHlkZRC1T5sdscDvpLFhJWMzjTy3qV05fbrnuerFmrrGVyu47D/MnuR1w3fNvZB
         Co0AOMmqkXSFmN4d5Oi//PAI5/c3hU6MJ2dGvvB46XxDjQr/bDHoMx4HaaZzZT4emL5h
         HkQyv2rxk/XrIxNzcMWwUCoYO7bnTKcICsLJuEs9RYu+w8eBln4WqupE/Ni11BzFHGhx
         4BxF8hKX1pu+ynBdyQmTj7Kv1FdJwhTouUuQPMpalhot1g2iPCvgm4naiUnxNSSztLHb
         DlSFp8Z4fW9lw/j0xKA9FMdxqFSjowckitGV8hbjxanwBzxoiOIsKDwU5Xz0oeJaGqKP
         aBLQ==
X-Gm-Message-State: AGi0Pua1GCukRYfMrvjoqWbUJlSCIdO52VhsLaHO3OzBKaGtOl+WTKRw
        TIadEf+1ggEMg17NmraSGZ9dRg==
X-Google-Smtp-Source: APiQypJ5w6J53xRub/aTQzetgTJoWBXw5Zybbw7vRWEji/fczl1ZvQQJUx093mXZMrARd9s0cFlHQQ==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr506112pgd.277.1588275994930;
        Thu, 30 Apr 2020 12:46:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u3sm495993pfb.105.2020.04.30.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:46:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     linux-gpio@vger.kernel.org, jonas@kwiboo.se,
        robdclark@chromium.org, bjorn.andersson@linaro.org,
        jeffrey.l.hugo@gmail.com, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza
Date:   Thu, 30 Apr 2020 12:46:17 -0700
Message-Id: <20200430124442.v4.6.I89df9b6094549b8149aa8b8347f7401c678055b0@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200430194617.197510-1-dianders@chromium.org>
References: <20200430194617.197510-1-dianders@chromium.org>
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

Changes in v4: None
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
2.26.2.526.g744177e7f7-goog

