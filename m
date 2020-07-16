Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190DE2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlc3vie/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGPR02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:26:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2EC061755;
        Thu, 16 Jul 2020 10:26:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so7450473ejb.2;
        Thu, 16 Jul 2020 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jBcnYwmL1Uye8q3dLd1EweGhjBjTG8xKZRkBHMZLXs=;
        b=qlc3vie/5miu7A1D/2cg5R/CF2VhZqrTYyyudXPm7rSBsJ8k8WnSKy8ARJWsJi+vSx
         b0ISRDOeB7e9TlMZgdPAahqT/iNvYEn9dzWqG/EsAZX2U/1eid9O7Cyt6aIOCbFfGZ1g
         V9llTPForD+KNk3OQn9v7xKfxaU/CiNojP16/A77im+ODSlr6/omAPagl8reaIL51W5F
         pXihrRfkC1OFgDi5EQnH4ITOoUl7waasSIdSfBquU5qnIGjFHcYZB4ofiMg19oIIJFeS
         Oa18FWyb1yn+FC0tx2IwNYR6gyUuI+Z6svt/HiH4sM5BWx3VSv2TROR+lh/p2H4fvjSg
         x5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jBcnYwmL1Uye8q3dLd1EweGhjBjTG8xKZRkBHMZLXs=;
        b=VDwCMRpIcbj4z1ux9l+kLIhsKStRssf8ONiwZjqu2d3ChXsWKiHoT8py/0PhCcAm4o
         W49mUbmBbk8/XfGIhemNSZOyR3NFJJwChb5ZlneI8trgTFx7KVIjKkZqk5GGY0QIocKH
         nHl21OZQiE1EVtlm+9bimNLzVAuU6UOycWSiKbXVwRvXOi1R1+/P2ZsvBJLl3fG1v0Fb
         mQ+ze3S1QvD0I0WW0MSePfc4kOzJ8jYrX6oh6YKBO/Kxgjm3ncEkSyzf+IFoiFNrNDed
         Rt6/QbaW0CD+gQ0RKr2ZQWEzoIVNrhYMdtvN/5gH5g/k6EdkO6Ub0ZaIGWdm0bzPbW06
         RmTQ==
X-Gm-Message-State: AOAM5322Kwy4DK4Okzb3KDxgZhtkdga2b0uJhAOMX8dkuLmRI8KSrZjY
        szmE3oYdgO6MMcdmhw0SCdF21OBrQxj/cQ==
X-Google-Smtp-Source: ABdhPJyB4dHrn2DSaiuvkpJ9MMPnVnAXL7VjTtttIOwO/ZkWzpw+XEApcHhrldZecTqdRTkiCJ+caQ==
X-Received: by 2002:a17:906:5912:: with SMTP id h18mr4969904ejq.259.1594920385875;
        Thu, 16 Jul 2020 10:26:25 -0700 (PDT)
Received: from xps13.lan (3e6b1cc1.rev.stofanet.dk. [62.107.28.193])
        by smtp.googlemail.com with ESMTPSA id bc23sm5800658edb.90.2020.07.16.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 10:26:25 -0700 (PDT)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: fsl: add kamstrup flex concentrator to schema
Date:   Thu, 16 Jul 2020 19:26:10 +0200
Message-Id: <20200716172611.5349-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kamstrup OMNIA Flex Concentrator compatibles to the schema
so we can make use of them for the validation.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since version 1:
- Patch prefix renamed to "dt-bindings: fsl:"
- Added acked-by from Rob Herring.
- Fixed typo in commit message.

 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e291e38..66627b272e40 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -299,6 +299,8 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
+              - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
+              - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit

base-commit: f8456690ba8eb18ea4714e68554e242a04f65cff
-- 
2.26.2

