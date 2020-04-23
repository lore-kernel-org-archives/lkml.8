Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B41BC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FFD20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e12bR+Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgDWQ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729662AbgDWQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:26:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454EAC09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so1511209pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+az60ThGdIE96zHd3j4C+YFzxV2ee2icRXc48MtdSg=;
        b=e12bR+ZpXLVjEEpan9cAEWHV4kDr8Z7MZkqcd7f2suEPYFg8jvkfNyq70AOvFiT7wa
         4R/XyzA6cL0T1vpLIg314Ii0SKalB98Q4CK9r4ofREWXmfxZDtzOTMdjCYn1ytmbKmiX
         ZkpDOzjkjb2l8hrkAs+QCG1FNUaXWUvOjEhEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+az60ThGdIE96zHd3j4C+YFzxV2ee2icRXc48MtdSg=;
        b=K+FVEHl0jIcIdYTrDbfmy1RYv1CmN5tGDskvpndUWo71dPWrO4XzmxEQTICanJ9jud
         FHcE325OFvUZ0ZcvSJi/dCRYKLbrlmQtEax9mZTOjeDTKnvICNmN5Jt6ooXaz+/4a8hV
         pnQFApu8q/IoKv9L+Mz4PK5H3S1gBIqYTeGdM3KEKI7dZnTVNM91nqpdQUj64I+HhUC3
         OY2G2UmiVJ9Qs3xJ3sdjGILpPqWC7kZlKzfUzo0bfPMW5cwBX0GSwoio5PdZyokLgEJk
         vRxBqv6L9KU1W6pb+tCZkgo2TLxzaPl+IVpxC4eBZdLLyF676lxwvofpUOt1TTUZx28X
         d7cg==
X-Gm-Message-State: AGi0PuYoaoFD0wKQFfpXiP+UAYZSCoEGZNpT94mBOpKzgFzse+bEWecz
        2avSkSIyG50F/evRbOujBS28GQ==
X-Google-Smtp-Source: APiQypKjcxU1Aq1NSUI9ytZOpl3JXA96PEo792irFM8Rg9bStYDnDS9zclolWyNi4CYW+A0kSTRQDw==
X-Received: by 2002:aa7:9709:: with SMTP id a9mr4779536pfg.166.1587659173796;
        Thu, 23 Apr 2020 09:26:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm2841927pfq.36.2020.04.23.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:26:13 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] dt-bindings: display: Add hpd-gpios to panel-common bindings
Date:   Thu, 23 Apr 2020 09:25:44 -0700
Message-Id: <20200423092431.v3.2.I1976736b400a3b30e46efa47782248b86b3bc627@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423162548.129661-1-dianders@chromium.org>
References: <20200423162548.129661-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cases where there is no connector in a system there's no great
place to put "hpd-gpios".  As per discussion [1] the best place to put
it is in the panel.  Add this to the device tree bindings.

[1] https://lore.kernel.org/r/20200417180819.GE5861@pendragon.ideasonboard.com

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3: None
Changes in v2:
- ("dt-bindings: display: Add hpd-gpios to panel-common...") new for v2

 .../devicetree/bindings/display/panel/panel-common.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index ed051ba12084..e9a04a3a4f5f 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -96,6 +96,12 @@ properties:
       (hot plug detect) signal, but the signal isn't hooked up so we should
       hardcode the max delay from the panel spec when powering up the panel.
 
+  hpd-gpios:
+    maxItems: 1
+    description:
+      If Hot Plug Detect (HPD) is connected to a GPIO in the system rather
+      than a dedicated HPD pin the pin can be specified here.
+
   # Control I/Os
 
   # Many display panels can be controlled through pins driven by GPIOs. The nature
-- 
2.26.1.301.g55bc3eb7cb9-goog

