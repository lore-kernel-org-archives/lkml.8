Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD122C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94B52073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="KeFi1ABs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgGBKa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgGBKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:30:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9379FC08C5E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:30:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so5268523wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LlGrsZv5MDXCoixnPWrg/mlv9SQt5SL1loevVSN/VHc=;
        b=KeFi1ABsxr3fl8GMR0/3qDI8qj0sYAqgYksocmCHaogDsB9OQ3G5HpO6Y6CBVUElHV
         PvUS3X88SRGYnJImNTB84cxpPTk7lVw9xAogix8X8LJRF8vymzAo+R4PdDRQcyUspUfH
         WAbhIsS2RcJmQxrnlTbxPcuf1DH88gm3VBZfM6Alq0BSEDO4ZF5QbQxI2d7YOu1iw/lb
         4tP4BwAHtDWiQfZU/4tcUT3UbOJ1AuWEsYRORfi0MWP79GUWDvgiBrFx7Qfy0Nt1puyb
         pNV/n9QLoVLRnSFw4AKwnxG+ByqeBDny3S/7QB8o7vPb2VI1az0o+DFpaD1vabdZV6uE
         20Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlGrsZv5MDXCoixnPWrg/mlv9SQt5SL1loevVSN/VHc=;
        b=bxyFegg0FIQL+3KCaqLeSiH4gmxx7xjWzIP0v8Z+wgK9oatbLoaGIOIOW2C3pAejVy
         xL/J9zp8nf54NMuXUK1kakr61E58E4V7j31g7yHZBgb84LYOBiWsfZw55xCtU96EhKh9
         7JMXCFCYHYe8OxvDB49eGlmhHpHChtd3iyP301NO/t/eWY1Mby5P+6OO5VIiPjL+RMNM
         Xm0DwFH/hzA9pk5lpFW0quFG3AptMXahS1LokH7Hc7HJxzwgoogP3yq52h0SShAA5vNR
         iqvLw+0f1KJZNfzPuuqzs4rdn/Et6hVNy4EG+EtfTrbzffjZ1xeONmHM1atrj6TTYeUh
         vexw==
X-Gm-Message-State: AOAM531EH4esVx7kyJDqIgYimbEBbZwtoxi57MDuSPYI5SZYFtLFVjtZ
        nksTNg7k1Xe7KvV8NOhoVNpTM48cLRI=
X-Google-Smtp-Source: ABdhPJzrKkA5IL6AI6zOIP68F3NzFvD0431eMMCeA/kAyZb4PVbZ8/a84PbeXlReLLXV8E4fU5mjaQ==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr28770641wrt.138.1593685817345;
        Thu, 02 Jul 2020 03:30:17 -0700 (PDT)
Received: from localhost.localdomain (dh207-99-59.xnet.hr. [88.207.99.59])
        by smtp.googlemail.com with ESMTPSA id 68sm10406912wmz.40.2020.07.02.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:30:16 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [net-next,PATCH 4/4] dt-bindings: mdio-ipq4019: add clock support
Date:   Thu,  2 Jul 2020 12:30:01 +0200
Message-Id: <20200702103001.233961-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702103001.233961-1-robert.marko@sartura.hr>
References: <20200702103001.233961-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary bindings for SoC-s that have a separate MDIO clock.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/net/qcom,ipq4019-mdio.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 13555a89975f..06b4eedb4370 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -25,6 +25,17 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mdio_ahb
+    maxItems: 1
+
+  clock-frequency:
+    default: 100000000
+
 required:
   - compatible
   - reg
-- 
2.26.2

