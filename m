Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB1C54E8A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126B920A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsEDGiwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEGVfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgEGVff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:35:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8431C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:35:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so3231824pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v4vnXxurYJQOROnZvnzfPloWHp2bwE01an31yUPp4o=;
        b=jsEDGiwhIeWeIH5fsxZpLrFy4wAWrwHVPQ0Th5YaMdW+DiPGF2V2BrQMyLzoKF17KF
         qOZcFB9rQwZ1ibCZZ7iw4wbdZFNITQzkcLMUR6z/TFf0zAHfWY2lf/cGJq0O1FOcsMFr
         KWwrbKtdHEusvC97ESZz7VfnP6l0eiZX9wXIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v4vnXxurYJQOROnZvnzfPloWHp2bwE01an31yUPp4o=;
        b=SaOKXff433i488bZwXk6G72geQXXTAlL4Va2tKSq0bUjbcmm7aJ1JYpapDIh0S6W0G
         0fwyYYq2CT6qUCZYXW8d2UFIMSvtaHP7GsRFzk2t6VsvRZb3pQmMwU6fJPKjyAwkRHMB
         AwybCG3wISxj9s5FrFVQz2BlfTdhaONeqqxfVOP0lJ7fNFOSLV90vuNwRU9xsWK+MwvW
         9negGMsDPT2ujz2oNwepBxo4y/7DgKympLXazfjSiJb9lVjKOy4JkBaTG8zGeNBkXkUb
         r75DGO5q5SUEH9wbVmMBpXgAXrFxAJ67iEOKY1KSm1rSKK1pjmYRukEZ1MVPa7tLTitm
         hufA==
X-Gm-Message-State: AGi0PuZGx8I6d9rygX4XKbPqgNFLznXFzA0hUYVgEO7iEGAWOiHNftFa
        21dRNQnd+RnITNLJlkfZv3q5y+SJGdihmA==
X-Google-Smtp-Source: APiQypJrX9Sds2V0tZ/XbcQs1N2tNz4bQqjgUQgoczdv15D6aqrUlNeX63mmz/+P2v3/w/VqhJ8N3w==
X-Received: by 2002:a17:902:9f90:: with SMTP id g16mr15528385plq.215.1588887335252;
        Thu, 07 May 2020 14:35:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i10sm5884860pfa.166.2020.05.07.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:35:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     jonas@kwiboo.se, jeffrey.l.hugo@gmail.com,
        linux-gpio@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza
Date:   Thu,  7 May 2020 14:35:00 -0700
Message-Id: <20200507143354.v5.6.I89df9b6094549b8149aa8b8347f7401c678055b0@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507213500.241695-1-dianders@chromium.org>
References: <20200507213500.241695-1-dianders@chromium.org>
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

Changes in v5: None
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
2.26.2.645.ge9eca65c58-goog

