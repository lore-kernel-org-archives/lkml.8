Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52888C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2811120870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOyfmgSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbgCDSmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:42:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36313 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:42:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id g83so2958890wme.1;
        Wed, 04 Mar 2020 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Taz9B582B17QJFHq4vnyy3ks6+/Yxqr+YFZUhRft8sQ=;
        b=JOyfmgSGO+maesgkLYYDa0CJeG7EdGd6AzUXmExJB2vvYlruA9zcJHaLaBClmeMSEs
         q1SjIwXR4xJfZLtV5cXNlVWfBv1EWzNZj7Rnh5EnLDHTGsYSlDX8njy2SoiOjEX0qoJs
         fQeoeP1NW8tmls0GKQkkLWdpUU4NADd7UwAuXobByJrORXReSn6EuqRrBC9wZ4dmUnVf
         mgHxVCrA0eSDGpUREUE7knc8U4GsHJsZmuypfQKeij2bPTwllOH0Zcvs1fC3PbH3oF1J
         R24Umg04leHsDw7iUWZm7DPtnqwGavl/ldcx8UG21M2VWrkZQ/qpApMVzzu0jscUjmLs
         kmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Taz9B582B17QJFHq4vnyy3ks6+/Yxqr+YFZUhRft8sQ=;
        b=i+aYYx9IBeTgh0aVW1acoWb19RRUIrxWpWdkv44qZbPLF+zWTuR/mFT0SPyjTvzVMz
         DSZ8dwd1igNItoUhpYq/dOSYrC6eCZiPRxY6KUWUWXigkMX5FRebuzflZdtGAXEtvorL
         FDxWHqhCoJVC8FXbL+r2wv5ITpz4vEU63GmXtoG25RIaGsetfUShqfH9oOGGzA5Bbw1e
         hG19hYukrKzF27fTzJj2HADs/Kk91budlMKX+BHk2hYWfzlcmwA9x6mM8cC2jFB8eQWj
         39LK6mydff4EXlckNruEIYZLsgR7a3kr6Zws8SFOpNvDvymoVwk51H+Ir/r316XdC+Ab
         mwnQ==
X-Gm-Message-State: ANhLgQ2CKsVQ9Dcx5RQsquI7A8RYG8Gox/IRLnF4j2+EMQJ6dyAx/kdi
        NnCQrHupH25wNTa1zDkb5ZI=
X-Google-Smtp-Source: ADFU+vu89SUtNLXOa0wDBls7mVKttadFUyRVC8wIrTXOR1+RiC1XClyH+9OgoeF0Ll5q4Sa3ayoZlw==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr3634960wmk.121.1583347332383;
        Wed, 04 Mar 2020 10:42:12 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v11sm28175848wrs.54.2020.03.04.10.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:42:11 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: spi: spi-rockchip: add description for rk3328
Date:   Wed,  4 Mar 2020 19:42:03 +0100
Message-Id: <20200304184203.9548-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200304184203.9548-1-jbx6244@gmail.com>
References: <20200304184203.9548-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description below is already in use for rk3328.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3328-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3328 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes v3:
  remove some comments

Changes v2:
  add acked by
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 456896e2d..81ad4b761 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
             - rockchip,rk3188-spi
             - rockchip,rk3288-spi
             - rockchip,rk3308-spi
+            - rockchip,rk3328-spi
             - rockchip,rk3368-spi
             - rockchip,rk3399-spi
           - const: rockchip,rk3066-spi
-- 
2.11.0

