Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B846C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE90E2492E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HIKlwMtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbgELWYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731964AbgELWYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540BC061A0C;
        Tue, 12 May 2020 15:24:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so4103993wrt.5;
        Tue, 12 May 2020 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufv+Yo50eSZKu4boEwkvocCNnIFHsje2YroMYtajJH0=;
        b=HIKlwMtA2ZXj4Bw/fXw9cmHIq35HG2LYf36aRSckF4AFVu6yuExCsx1HyPmjWzlmYh
         YZP6N58n5xqlC/lbm3HfW9ppFcfqKSGxMc3dysjaNocvfjotgyki4hWmXbmpGi+p+r82
         E3KQ+sj/Z1XWglnoZBYiSPgPixcQpS8aKMFGaSfc/eiUX0Ys/+3EjuZULd5uL0SOuW5R
         o1ecJM+RzdcmJ3no+r36gn5sbDBl0cTiBNiRgyh/7Th/4utgC06Fg+JCQi624PzLUlYP
         w7bV6xdFqf4Zu0NSuSG7cmHoZthK4bfmx0/jClZTjtmC3lvQRJ9ycs0df1pSk+chTrfM
         WZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufv+Yo50eSZKu4boEwkvocCNnIFHsje2YroMYtajJH0=;
        b=d+Uz4XlYJO05bxahI0U9KyJSdI9HWdp8YHxxCkYaNhEfz86Pn4ZGHkEtMF349Qwiva
         NgiWCNk5xPV6VwyuBm015oj6zM9qRJr+KMOOvTRsKOYnHZJ7rLUno5VbibugIMUlX3sR
         OpBs+AJrGSYyNktZyPhBQXCu+uikA+xgOwE/QkbT3X8gcyxrlz6XG5igHZMyBVYAejmU
         Yji1kVO43quhwa0nmjJuM6DOsAP4WIuteDm21ZWNLaCg3aHhuhb4jypQbJk2YHHTzkKO
         l7rhYp+MOtbxDG5Ff5M842Z8JcydGVkOrJGXeMhLkGeWlt5z6eJI+5HuWEe7eHGaYmXu
         CbsQ==
X-Gm-Message-State: AGi0Puban5V+3vAmSHI0kF/BuSiYwBdqP3XO6TWJ8p4f3+73UD+cVwVs
        2XRLNqZx8cG8QjpTqtwHuxI=
X-Google-Smtp-Source: APiQypI/WPHQ9nOXga6YuAxFxLZkPX/a2ZTfXeF7vKrdEToeLtObnlL2uIU+z/eGV+rnN652uHm2Kg==
X-Received: by 2002:adf:9447:: with SMTP id 65mr27471285wrq.331.1589322275978;
        Tue, 12 May 2020 15:24:35 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/6] dt-bindings: phy: meson8b-usb2: Add compatible string for Meson8m2
Date:   Wed, 13 May 2020 00:24:20 +0200
Message-Id: <20200512222424.549351-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2 PHY on Meson8m2 is identical to the one on Meson8b but
different to the one on Meson8. The only known difference is that Meson8
does not set the ACA_ENABLE bit while Meson8b and Meson8m2 do.
Add an explicit compatible string for Meson8m2 so those differences can
be taken care of.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
index 0bd4ce39525a..03c4809dbe8d 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - amlogic,meson8-usb2-phy
               - amlogic,meson8b-usb2-phy
+              - amlogic,meson8m2-usb2-phy
           - const: amlogic,meson-mx-usb2-phy
       - const: amlogic,meson-gxbb-usb2-phy
 
-- 
2.26.2

