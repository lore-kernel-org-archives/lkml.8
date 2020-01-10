Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F1C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0545C2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MkxgcYU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgAJHho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:37:44 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:47035 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgAJHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:37:43 -0500
Received: by mail-pf1-f182.google.com with SMTP id n9so698351pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPmK1IVjUjoDDdGXICIzNkDG9sEfLCivKbwQNM5Dc3g=;
        b=MkxgcYU+henCA5kN+O1OSgQ8jmPxocJVAdEbEUCpADdqi+QU1aESTk+OSpiZdSVmtN
         BSTNqEljO1iisJAdLb+nt03AMZ7kc9QJc46EksUCwub/MJbfMZ5V3aaF6RVb9oagpULU
         1HA+Njc4sZEWYahfHvl3yrvQKZn75/jxDBmLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPmK1IVjUjoDDdGXICIzNkDG9sEfLCivKbwQNM5Dc3g=;
        b=CieRelmtqOKjlTfZUybuiGrBEoeVj+GS7DFq4AWIO488dxp5/ywhgz6Pfazlv9Zhhz
         4Ao2jVFCboxpn1HcmoCZoxJYKOk0INLXcKIgsoZa/PcHjKqz0p/8JkRGjLiknA/kFNGw
         fnE0PKMVxpK3+ExzMGZjwDzKqJ5dJmWONR3ihizoAB5uanbB3I/R8A8hbHYSvFh6tQAg
         NYLm4H9zHnKfWqDahpDxOaV+syCZrT/q1sCdAJ0D0HwEmPn2VrXtP9r0arkGllvuk931
         9AmfCMcI0SdHBrAH4tpiUXBNcnYZ8pRMJ8RrqG2OVS11jWfokav8VoHtVcyG07UTgttY
         svXw==
X-Gm-Message-State: APjAAAVSKhpD8I6RO+s6h5UuR9XCkv9WvDwdqsmXNl7YYmEJsDyJvDDX
        SYdCwbeksjtu3aY4yC3owHxXcg==
X-Google-Smtp-Source: APXvYqxXyq/aIJxYy6CGQGlrFbVq7DCDQJRkJEBFWREvT9xXXlpwtMYfLPLZqL7CdRPmXfF7Y0olwA==
X-Received: by 2002:a62:7681:: with SMTP id r123mr2477932pfc.169.1578641862585;
        Thu, 09 Jan 2020 23:37:42 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p28sm1373919pgb.93.2020.01.09.23.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 23:37:42 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
Date:   Fri, 10 Jan 2020 15:37:29 +0800
Message-Id: <20200110073730.213789-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200110073730.213789-1-hsinyi@chromium.org>
References: <20200110073730.213789-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173
SoC.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Changes in v2:
- fix dtbs_check errors, use const instead of enum
---
 .../devicetree/bindings/arm/mediatek.yaml     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4043c5046441..5272899b08fa 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -84,6 +84,33 @@ properties:
           - enum:
               - mediatek,mt8135-evbp1
           - const: mediatek,mt8135
+      - description: Google Elm (Acer Chromebook R13)
+        items:
+          - const: google,elm-rev8
+          - const: google,elm-rev7
+          - const: google,elm-rev6
+          - const: google,elm-rev5
+          - const: google,elm-rev4
+          - const: google,elm-rev3
+          - const: google,elm-rev2
+          - const: google,elm-rev1
+          - const: google,elm
+          - const: mediatek,mt8173
+      - description: Google Hana (Lenovo Chromebook and more)
+        items:
+          - const: google,hana-rev6
+          - const: google,hana-rev5
+          - const: google,hana-rev4
+          - const: google,hana-rev3
+          - const: google,hana-rev2
+          - const: google,hana-rev1
+          - const: google,hana-rev0
+          - const: google,hana
+          - const: mediatek,mt8173
+      - description: Google Hana rev7 (Poin2 Chromebook 11C)
+        items:
+          - const: google,hana-rev7
+          - const: mediatek,mt8173
       - items:
           - enum:
               - mediatek,mt8173-evb
-- 
2.25.0.rc1.283.g88dfdc4193-goog

