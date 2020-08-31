Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E4C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C2E2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J9HawXox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHaIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgHaI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:29:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD42C06123A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so2593118pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAU4sCBRiofk2aw8WsyY+3Dm8mUaxukahoabY1FXUkU=;
        b=J9HawXoxxn9OCxKX8bsB9crige77QAv8k+mM8WLEGaeMs4XYL/bHjHKOolmdD6hAQC
         61v3MOs/a+QWmV1ZtYyqq7q+g9pTYtQSRPeMuECiZI2PNSeMipmVW0BggF52XQlEiEGN
         4QFYenzLf0Hv3EYLQpBSepeyK95yJFk8Lr2CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAU4sCBRiofk2aw8WsyY+3Dm8mUaxukahoabY1FXUkU=;
        b=BWVkJyx+c2eNHN6HX4vtUq/CVCoKKth+fnOohyoufFyf/jIdSgGxJABmNZUQDZMVi0
         GUCNifuqv+KoYDMx9R+Xicm+EMyIH08f7XGeRaqKtkaE5z+Yb6u1C6sHa/I9L/jWfIOQ
         mbbgCM8EPz05xD4x8rcJQ8+I96Pko9u6LivKl2j7F1531OnwSwDtdnUV1C9X1H+k94SZ
         8WFf05jj/fJayVZ5zo7CxHQ5zdLMlbUoCMrceiV09jB7mX8uQnmC0C5sEv+rO7IodORf
         l+drMthf+YJ3RCjgx3RaCHWJpkagHpfS1wbBoG64hwFrJwDDgy0UivyjJlvMtNeEx2NG
         uHQg==
X-Gm-Message-State: AOAM530eOMEZtC4pRm9221UXi/388hpXJng6KpFNaD8n27lUhwDZclqI
        ZZ7BoVrwEmqgkKMD3IHWRlmz1w==
X-Google-Smtp-Source: ABdhPJxcdDfE9FJkL63RLb+7aDS4OWHIoeiEl8ktA/Ng44mcZ2xq2v4/qJUxtePGOavfbfhYY1ETzg==
X-Received: by 2002:a17:90a:f187:: with SMTP id bv7mr348529pjb.63.1598862589733;
        Mon, 31 Aug 2020 01:29:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d50:45fe:aaf3:66ee])
        by smtp.gmail.com with ESMTPSA id b5sm6411335pgi.83.2020.08.31.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 01:29:49 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
Date:   Mon, 31 Aug 2020 13:59:15 +0530
Message-Id: <20200831082917.17117-6-jagan@amarulasolutions.com>
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

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

PX30.Core needs to mount on top of this Carrier board for creating
complete PX30.Core C.TOUCH 2.0 board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- new patch

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index bda0f2781890..3aecb1241492 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -70,6 +70,12 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: Engicam PX30.Core C.TOUCH 2.0
+        items:
+          - const: engicam,px30-core-ctouch2
+          - const: engicam,px30-px30-core
+          - const: rockchip,px30
+
       - description: Engicam PX30.Core EDIMM2.2 Starter Kit
         items:
           - const: engicam,px30-core-edimm2.2
-- 
2.25.1

