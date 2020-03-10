Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A79C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB172467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlNXK9fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgCJNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52984 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgCJNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so1072075wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxchRFsuVj/LyP+NgoEiyC8jFK69DiY6+bUysuIeuzo=;
        b=IlNXK9fb/0uqwuUWA3dfj+xFVda25T63ShcTWej5Hy2NsucsUS1GVuY5dsPSIapt67
         /Xfs4M4pnt4uIaOMW4AJ0GQUOXw+59GBmcVCnjtjRBRy6tiD59KbRU7zx1vwqZFUwwlr
         Q4V9dYX5xL78+TMcccic7HJYxKarfLLSdItrJEjhZI2qKerPDweN6ajwwF7rLu14Aayr
         La4QZ/5SQD78VkSx5mZC1JAWkd+cPuUgAfAlDKs4p5/WCWaLE6FoE6RQpenLkedJ9B8U
         koqo0X9sPHQV9YfQGl/jQFMuNQA1P+FPVpo5DHDM5XSJLGEKSycba3Klh7mF/xh6TiRx
         q18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxchRFsuVj/LyP+NgoEiyC8jFK69DiY6+bUysuIeuzo=;
        b=iCiTuMo0OqXAlifMjBAEGS22K9Svy+StNabkSXUXayJ5I6AGuo63GKgvo3MDvLKv5M
         ZUmyhLQeQqjlLgiwf9JKaCeCDR8BEVxh8ydnYe8QiXCEeplFt9ZFIbiMNZ2169sT6dF4
         w972yBVySzUjZfeh7YsenrLeXe+lUkXr9Kd/zMmn9sj25ffzn0XGVtlNk75c8ZjOgaRM
         BLSkYWORyOSqT8wike3XJW0hvSclxGENBJXPj9s288va3yv0oYB4587LuFSeMTQ0OMo/
         1dsf9oDRDzCHe6JF3WyfX+b5UhTPNTrCWIhPaG0cYr4KCmaUNK/88+HvR+oNcw9YpsSu
         YThA==
X-Gm-Message-State: ANhLgQ02KJeO222I6KlLj5qsPL6zEUsH0nz9wHJ2yFepiIZlPpItHjrq
        sgbUf7JcIQC/vPNbBsV5Za7RJg==
X-Google-Smtp-Source: ADFU+vtA9g46P4iNhjcF+gpC5wEksLVfFdh56RI8v1VEtEOo575ab3wkA+HPF1d07UEXUZECiG56iA==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr2188420wmj.1.1583846624650;
        Tue, 10 Mar 2020 06:23:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/14] Bindings: nvmem: add bindings for JZ4780 efuse
Date:   Tue, 10 Mar 2020 13:22:54 +0000
Message-Id: <20200310132257.23358-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch brings support for the JZ4780 efuse. Currently it only exposes
a read only access to the entire 8K bits efuse memory.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
[converted to yaml]
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
new file mode 100644
index 000000000000..1485d3fbabfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/ingenic,jz4780-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic JZ EFUSE driver bindings
+
+maintainers:
+  - PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - ingenic,jz4780-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    # Handle for the ahb for the efuse.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4780-cgu.h>
+
+    efuse@134100d0 {
+        compatible = "ingenic,jz4780-efuse";
+        reg = <0x134100d0 0x2c>;
+
+        clocks = <&cgu JZ4780_CLK_AHB2>;
+    };
+
+...
-- 
2.21.0

