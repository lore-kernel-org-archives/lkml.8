Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A70C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 23:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D575A2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 23:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDM/9zRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgARXI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 18:08:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43851 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgARXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 18:08:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so25992733wre.10;
        Sat, 18 Jan 2020 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tOn8mq9NdKT/KRhPIH0AzeKwIeYeoG77AtMkfuKA4Gk=;
        b=YDM/9zRP0Z0heJRTGk5w0BRB3T3JljkBY+Vn8MM05T5goIwGJ3B7QM77rfOdkLagPT
         3kxmbC4ea6Uq5dNYFl0PjEa9AlqWVN4uPP2bDdahCwocVBLWBErKVzIPiH7aDM2edf88
         IYxRQj274L1siKaNVt9kDkM7KCVTw29mfdNQrSqqczUDeL1/u1pk2nAOd/aaR03iHzv1
         ol7cSFcGmMIRkZ/b7ldOjm2B/I1IX/4baIsH6nufFbEdLDvtw8T+hy7Vw/iyBMtUCFhS
         uEvlq5AWpnrcH6HgUYT7RY0dWkvdjSfUC4gMXEogpkHvHZW/ByqmEKVasBvA9jRJpZtY
         hbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tOn8mq9NdKT/KRhPIH0AzeKwIeYeoG77AtMkfuKA4Gk=;
        b=KJ8ngvEysh2CuJKEHqBtuRUWvrGQPM51yXe46Ptp2CbE515Jb9G8FhoAMO5ynY/x7N
         A+Uy5QbvThJQ8iUHMGCj2olmYmkO4WYw4sImML1Kzj98qr0Nw1pT0iR/9gjVXc4aQhSv
         wcRtG6wWPYLBTKruzq3lIC3w8TmvuTJNDQeI7b0wj0ssvHlTfLl8oT7KYH0LnicbBGxt
         8B+u9Hfb+gWPe7Z2FihktTvgh2UyEsXJE3IF/kuuGsElhmwnjoQJeIl/5/xP1foGg44G
         7y/YWSOFet4I6Z4dUkX0TLQGNXssd8pGg1LW6wLPVZXWtF0r/XQ94IIW7mlbmomt0wKr
         mUDA==
X-Gm-Message-State: APjAAAX7YWWy5bRA5JRfX9fI2utLyTlqNG1rPWYj3CWrNbVQFpnngjjt
        dNPJCem+SBIk1H/VODXwKY8=
X-Google-Smtp-Source: APXvYqz8Jn89LtX623GRYGQbqvDjF4Jme+gXm0owhz3njGWJrRgQY103W3rliYxx+qDV/A1GfvaE/Q==
X-Received: by 2002:adf:a41c:: with SMTP id d28mr10910809wra.410.1579388936444;
        Sat, 18 Jan 2020 15:08:56 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x16sm5746408wmk.35.2020.01.18.15.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jan 2020 15:08:56 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/3] dt-bindings: spi: spi-rockchip: add description for rk3308
Date:   Sun, 19 Jan 2020 00:08:47 +0100
Message-Id: <20200118230848.15326-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200118230848.15326-1-jbx6244@gmail.com>
References: <20200118230848.15326-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3308 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 80c56c583..24d9567a6 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -29,6 +29,7 @@ properties:
             - rockchip,px30-spi    #for px30 SoCs.
             - rockchip,rk3188-spi  #for rk3188 SoCs.
             - rockchip,rk3288-spi  #for rk3288 SoCs.
+            - rockchip,rk3308-spi  #for rk3308 SoCs.
             - rockchip,rk3368-spi  #for rk3368 SoCs.
             - rockchip,rk3399-spi  #for rk3399 SoCs.
           - const: rockchip,rk3066-spi
-- 
2.11.0

