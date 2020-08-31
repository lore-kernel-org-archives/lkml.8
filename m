Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB355C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C935020767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GUHaAwd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgHaI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgHaI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:29:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF64CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so2760939pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbXuvXbOyNsrkch0SC6guvyYDJEednZEC4rbU/OSYZE=;
        b=GUHaAwd/OVq+Nq6zo3XRQW5MC7/o7yldoxDX5WzYxROH5nYz/yPBbVfJfKrPS2Z66B
         SaOuGyr1b3zqm//7K+7iZiKcaD0+OE7W/r54u8pmBcckpLX3vK0p0V/mjCZEpSedCWnB
         rh8ppbxSpzUB9eLR0rTw2eSGetJBCapNgEklo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbXuvXbOyNsrkch0SC6guvyYDJEednZEC4rbU/OSYZE=;
        b=sfIr2F+WqMPDffQs+OAo/aoOZEwi85BDcanEdH0h5CiUeCfhQ/9ZpSLVW+o6RHLmPR
         dhMn8zXSTZsmzjpmBK6l+luequOo/ZUPRcHgn2SOmhQYWkM2wD+WyqPU76ya30UGHHM5
         AOPxkdMQyR4yEV3A5VH0pJP4jQRb2Fxdr4yfHqvIzoGNGZtGl9JCgu7aYahbM65ilsH4
         1NquTbG4pQ8PH48s1DGsRP7a5go3y2yiYVYXoLgOCniJzq1BytUWC2YDuVdXY8sBvSAd
         UeVbC0SMJeUawvkdc6PaLLWpPVJ3h1tvFGGcwiMKP8bweCDB3tyAXtbMpvSUqGBnCYS6
         onww==
X-Gm-Message-State: AOAM530lOHd4v96wmMM+nadB4zBl0+gHdZ6JkNXJC9x8oOKf9Bbu/PIC
        HgabjSknHoq8tkBg09JSMjHHEw==
X-Google-Smtp-Source: ABdhPJyJXaeoxtiNl66ML5eCK52+c/iNYMUnqKMB0TmVaIsjhr6uuZSp1si7bK8QzlRt0Anh0eLRlA==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr281191plo.101.1598862574362;
        Mon, 31 Aug 2020 01:29:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d50:45fe:aaf3:66ee])
        by smtp.gmail.com with ESMTPSA id b5sm6411335pgi.83.2020.08.31.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 01:29:33 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Mon, 31 Aug 2020 13:59:11 +0530
Message-Id: <20200831082917.17117-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831082917.17117-1-jagan@amarulasolutions.com>
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board from Engicam.

PX30.Core needs to mount on top of this Evaluation board for
creating complete PX30.Core EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- none
Changes for v2:
- collect Rob A-b

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7025d00c06cc..bda0f2781890 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -70,6 +70,12 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: Engicam PX30.Core EDIMM2.2 Starter Kit
+        items:
+          - const: engicam,px30-core-edimm2.2
+          - const: engicam,px30-px30-core
+          - const: rockchip,px30
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:
-- 
2.25.1

