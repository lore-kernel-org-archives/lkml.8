Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C381FC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D6A20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SfhM9LjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGJXDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgGJXCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:02:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE2C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:02:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so3233517pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kf4bs78mZD6VPb7hGbMzwU1SDkoaJXih+VvUUu+oT8M=;
        b=SfhM9LjMFbCFHtzRBA4SYqf4zywNRWj3h+ZgZB00uTROQfzpfdrl4ryysqaf4tBwmn
         FN5/X0Iaz/Jv0JelCgSiqQCksM1Mtpd61VVkSa5kJaEzio+e8kAzYsbBZWtOdJnGC0IZ
         LJKsybrd4RMtUZ3XEr2Cn+AYmRcozOtq4sOtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kf4bs78mZD6VPb7hGbMzwU1SDkoaJXih+VvUUu+oT8M=;
        b=ilP8MLZG8YidHmyNofd2hQFjHZTTrH72jo9XyKLHn3JJMUliEo4t1NdZTHMUepNrZV
         aUUOZaFXXn7qmMDY/H7OOCzXcEWXED2T4WJT9KRtk7UCyL2XTE4Cum8j4R5N1S1ytaiX
         mvxxInhGtYUm9cgACuWanDgUQYgFfKtcU98grlWdRKWvH6AY5wKv42VrJKIG3s+toU11
         U6p2t4srnLpYaSmUAPV/aHWHp2OPPD40NOvdGvz9D60RsXDoKYbp6ikHNrFnOB+CSRB6
         q/dthk0Kbfqa5S9WVoZpInrWUvwuDSQuL25SKBd8qgpFPx2CJGQRFAVKaDLcda7srKj6
         dLDA==
X-Gm-Message-State: AOAM530RObcmDunn0U9heOE+EG4i15b/f2pvaZp639vd1Voh+i5DeP8+
        DG+q/tUqpVKcg4PwIWpGagpprg==
X-Google-Smtp-Source: ABdhPJzXgkBIOOjHFIe0B/r5cwGP2/G1OFIlhiURScaD7ul10GXJnds6PU6GdJAicb/gntGJ5m6eTA==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr7950555pjb.138.1594422168452;
        Fri, 10 Jul 2020 16:02:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id my9sm7266836pjb.44.2020.07.10.16.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:02:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] dt-bindings: msm/mdp5: Add simple-bus to dpu bindings
Date:   Fri, 10 Jul 2020 16:02:18 -0700
Message-Id: <20200710160131.3.I823f3420d7c25300a58819ff03560ca4d41e53f6@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200710230224.2265647-1-dianders@chromium.org>
References: <20200710230224.2265647-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just like the patch ("dt-bindings: msm/disp: Add simple-bus to
dpu bindings") but for the mdp5 bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/display/msm/mdp5.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdp5.txt b/Documentation/devicetree/bindings/display/msm/mdp5.txt
index 43d11279c925..bb57b07b7546 100644
--- a/Documentation/devicetree/bindings/display/msm/mdp5.txt
+++ b/Documentation/devicetree/bindings/display/msm/mdp5.txt
@@ -9,7 +9,7 @@ controller found in SoCs like MSM8974, APQ8084, MSM8916, MSM8994 and MSM8996.
 MDSS:
 Required properties:
 - compatible:
-  * "qcom,mdss" - MDSS
+  * "qcom,mdss", "simple-bus" - MDSS
 - reg: Physical base address and length of the controller's registers.
 - reg-names: The names of register regions. The following regions are required:
   * "mdss_phys"
-- 
2.27.0.383.g050319c2ae-goog

