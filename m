Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6940420709
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GxsVYEWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgIGL3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgIGLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:23:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD9C0617BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:10:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so12093940wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaJv1mu5ukB/CIcMyJjiUkroua19/SVkAvuVAHfagew=;
        b=GxsVYEWAqcHsbTP7ldWw3XMCSUXXkLDNAViB7TZMo3ZdMOGcqOqxNnbyfEhbNIoRUM
         46jE43/CA1WYcTx4AqrwiYOz/01itWTgB+EffYBiHX4xig9Tao2uLgSoQlTWbshlEH2j
         0FPQtFZmsYMXrHjWZYDF7JSkI/IY3sQoSn06lAxsA6tikxN+NkDDlOpLMHVtlLgOYAYV
         xgbWw8OmqH0UulxQdF141iVs1KUGrOXXXpCC5sd7enVwNSdfwFHhGpWtBP9A9yn3fHsC
         BfpBBqMkntjTpjaS26AU1P7IzvA6Yq1idSLklbk8e6YWdhVWF0Gjyo9IT4YixZjMlBYI
         jWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaJv1mu5ukB/CIcMyJjiUkroua19/SVkAvuVAHfagew=;
        b=SnV3W9LGIIzVF5J+I1JDr3MP7BGGx38qp5vwI016PC36panL6RHyiEQOTc3Vrc4l8l
         /J69+exbC6u4KvKSOYaxYr0hxlYWwFY73BMUXIbez7eHBngxYm/PY/3+jAruL7BDWuvA
         pxD90E2+D3/4+aPkSyOscrdTWsFn8xRiGzfJsz8eAdGWFK0Fu0rUf+gHbx2INoDRs3kg
         IH6Zr37J/Dwwbhn74rlywHtikMosxrop7hV0qAqXPX1w+99V29MJe0mi29WOiSN1aIEF
         Xg3CCORIunYOBN5GhPTzsMutZI7l5nWGX4mN6dCHNnorEFjXMr94T1c530jQTSuLEAdj
         X3wg==
X-Gm-Message-State: AOAM5309umYKrx1rjFmqev3vFzmKNe6041nbosyt8GOBOTpmXLlO9DAH
        4UvLmYPZ+63kcfG9NYGXmwNOkQ==
X-Google-Smtp-Source: ABdhPJxBVx0IfuJV1VVAaaxBYLauf53V/lzKaqIwtKzsD1pKBa6yHb2u7PSmJhqIF4DQRqGalb1VWA==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr21097200wmj.140.1599477031712;
        Mon, 07 Sep 2020 04:10:31 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id u13sm19922111wrm.77.2020.09.07.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:10:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Shanghai Top Display Optolelectronics vendor prefix
Date:   Mon,  7 Sep 2020 13:10:25 +0200
Message-Id: <20200907111027.21933-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907111027.21933-1-narmstrong@baylibre.com>
References: <20200907111027.21933-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shanghai Top Display Optolelectronics Co., Ltd  is a display manufacturer
from Shanghai.
Web site of the company: http://www.shtdo.com/

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a1e4356cf522..4e9dfb352c68 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1078,6 +1078,8 @@ patternProperties:
     description: TPK U.S.A. LLC
   "^tplink,.*":
     description: TP-LINK Technologies Co., Ltd.
+  "^tdo,.*":
+    description: Shangai Top Display Optoelectronics Co., Ltd
   "^tpo,.*":
     description: TPO
   "^tq,.*":
-- 
2.22.0

