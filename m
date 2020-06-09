Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE823207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehA44KHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFIIBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgFIIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:01:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB2C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 01:01:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so9737778pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18hQIFxxb4fD1C1+i73AnLwiiv5RpwYKr4iaPhsBge0=;
        b=ehA44KHJheJ5tCGuWWRAK7cSE6paLgsnSvCJA9JwTagkNfTSH7xqAZLb6J8SnvxaDO
         xn0OQpXPW2Gx5Ncm5j4EJxYtYgAdF2z1ugqd8nsxNhFcG0sYTB0jfFWsnUw0cNso+DD0
         49+JF/8jBlv/xgfRsmEHl/5Hrd/sgtIzcAThg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18hQIFxxb4fD1C1+i73AnLwiiv5RpwYKr4iaPhsBge0=;
        b=MhyXANNg6BmgBDyg/yfuaylS4K74EhiBolUzh2YVj6VeNtk/IXoGQ69OHJXE0jf8f6
         ZPkCaX4PA+eAROmUq51IKgbvrOY556/DpfmsTgJG10CyYszOI2JTwnHtGIGejuBT9pFm
         CX0zCErRu5s4YuZedvjWPQ6fnlwVWdBr4tCThyDCjS06/p5B/qUZJw+aMWwOLU7uTyIe
         HZCvA+TpDsTdq1bt/ZgzoAW9wyVghSm+lQUlV0NF9Jx32B5rU6z6Vu1jGIfTSRf6vJf0
         LsrMheTKkmoCgciVpY5g8BFkBRyNNn99Pw9pGnYcbPNW6WbUPzEon0H0IRnXJBWqmZkc
         /dcw==
X-Gm-Message-State: AOAM530IIkJNiKqa4jRj3QRk3bLFGI9q4QR9stSMnNYDxvlrLnIRT9Xy
        0h0MuKLkqo53Q6ya9tnk3x8Hpg==
X-Google-Smtp-Source: ABdhPJxYvggs5Ai2s6IKU9Lq52eGFynw+RsXr2Ru3yVwjrm6uwoAQ/9I+vRe7Pgmd87x/QS6OXWdFg==
X-Received: by 2002:a62:1b4b:: with SMTP id b72mr25268707pfb.179.1591689665824;
        Tue, 09 Jun 2020 01:01:05 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id gt22sm2506252pjb.2.2020.06.09.01.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 01:01:05 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 1/2] dt-bindings: regulator: Add DT binding for cros-ec-regulator
Date:   Tue,  9 Jun 2020 15:59:54 +0800
Message-Id: <20200609080001.121499-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200609080001.121499-1-pihsun@chromium.org>
References: <20200609080001.121499-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for cros-ec-regulator, a voltage regulator
controlled by ChromeOS EC.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 .../bindings/regulator/cros-ec-regulator.yaml | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
new file mode 100644
index 000000000000..1b6ba9a6cc91
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/cros-ec-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC controlled voltage regulators
+
+maintainers:
+  - Pi-Hsun Shih <pihsun@chromium.org>
+
+description:
+  Any property defined as part of the core regulator binding, defined in
+  regulator.yaml, can also be used.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: regulator-cros-ec
+
+  google,remote-regulator:
+    description: Identifier for the voltage regulator to ChromeOS EC.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+required:
+  - compatible
+  - google,remote-regulator
+
+examples:
+  - |
+    cros-ec-regulator {
+      compatible = "regulator-cros-ec";
+      regulator-min-microvolt = <1800000>;
+      regulator-max-microvolt = <3300000>;
+      google,remote-regulator = <1>;
+    };
+...
-- 
2.27.0.278.ge193c7cf3a9-goog

