Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35861207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4xOshzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHUPfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgHUPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:35:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF58CC061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:35:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so1021844plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlcOztWWQPRGdO3GJ4i5K8dX5Ri0O0Yjm2p6XeAjX5c=;
        b=K4xOshzvJr7aCXXwH4DAQRpEXUsdEQHd4W+925408O95RPmPvEx9o1Qfb37SCB1Gho
         oJJeNwvIk992gMb+wjm4aBzLv0AwDdFpQqg6Sx9dh4vQgCXUjAupJMC3PN+v7fFX+V4c
         9ww3RJgSeDEiwb0n5vIcXlfAHk3l6xWnlYojk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlcOztWWQPRGdO3GJ4i5K8dX5Ri0O0Yjm2p6XeAjX5c=;
        b=UhlOr2KH7sJeqTwdwS/E75/FCCqpIYRq2btfcmWmxYLb1/A8toEl5arfVCDVTUL09p
         WHNFlLu1Q2ox1RInK0ST9TDcMMWlc17lFcloRqq/hTMp6MycX6JZx0GLFatBv17C2KOm
         ZHZ7aBkHUmzO3cBTQ/zta2PvZkOT3gDrdbQSdBgEhJJ77zg1av9R4cSQTE2abQJaRECd
         +uzrPQ0NsZiLZsOLVgaSp4h34qP/aM3lgsWzMRlkZ3Pro+NTNPjjpE/swOB+5NpTM1gg
         bb2VNxep3VgzSEdtFJkJfP9ZfOy7b6u17YFELtv6r4xtGf8bT+kKGeQoeQNxF87WNS+2
         AC0w==
X-Gm-Message-State: AOAM531GZRHv2vrHx+cpd4Uarrt+wvWMSn3Ddx559CEG9XPSA6zFTxX+
        7Zj319Bvdi/qo7jser8PwiMCbQ==
X-Google-Smtp-Source: ABdhPJwZXxjhNDGxHTeRfEsG36o7sm8xNgtpV6HgMuiEo8kAPWL1TyuKck2o9/PPo4gkANxrXbSxMQ==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr2784374pjb.188.1598024135637;
        Fri, 21 Aug 2020 08:35:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id u8sm2200720pjy.35.2020.08.21.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:35:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Add KD116N21-30NV-A010 compatible
Date:   Fri, 21 Aug 2020 08:35:14 -0700
Message-Id: <20200821083454.1.I61e6248813d797c9eeebfbb7019c713aa71c4419@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KD116N21-30NV-A010 is a pretty standard eDP panel.  Add it to the
list of compatible strings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 47247ace86ac..f2204f17a9dc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -161,6 +161,8 @@ properties:
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
+        # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
+      - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
       - koe,tx14d24vm1bpa
         # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel
-- 
2.28.0.297.g1956fa8f8d-goog

