Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D0C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89F7206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jkd8MtvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBRJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:38:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBRJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:38:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so2030260wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/6gF09OIYAAYDcV57fzVa8XqTwVQognyAPormZwLXA=;
        b=jkd8MtvSOtVnYifARU89XpBkdqANfqh7MXovx1YKhWkbdiEFirQ4AY8HjQbEX3y7YY
         GEJQ74pSQ0kmhgrj9hbZE0itGIgDUzjxwNZRV3UCA59KkI+T0411iaFtluDGem8FiiIH
         9qXvRlcoYKcpbAw72aInzprRqjTMUWKxQV4g0G1Nn4+MESXG5TwbvBgiy8qeoA3Jxmlv
         h5eImD3MuUy80shHsELOc/zQfVAw9ygS6cdKVQnkoroYvhqKb0YhEAHOZ0jya+22S694
         UZ+Jt5MisOcCZzCV9c2EiRYevgupCLgh3S3uFeBP0JwCsCTZpuJys1el1ucWIU3n9Klm
         Q1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/6gF09OIYAAYDcV57fzVa8XqTwVQognyAPormZwLXA=;
        b=QARzVdOHsO6wGvLxls+w4dtHBJX9mm2DdpMz7MOgEgJzPF4+noPw1JKMKSBIDunAuE
         bqkBSB6bc6r6plls9Itc6yJ5RVExez1u9ID/A4a7sD2X59GVIP0F6OU5yYjP1D0XUyi2
         U922h/UBpzG29W3qVE5awLHo/kpGgv/nWOLqeweHwPeOc8nlX2hQKcy2I9QDc3BQlp6h
         yohBrQjUbhWJ8dKR/Gfwwp9/SgoZYhNEHrNXjsRY1h8zBMMhNqGsMaUil3hnz0j7ohi5
         65m+zt0g9YLJXDCdwGWsgNOwIxBJdoORwzHkFP2CJg5g5TTmAHntLwd/7F8y0d7IiG7Z
         wy3w==
X-Gm-Message-State: APjAAAVtrtVdhiGDmSEzT1HZ+Pa234UPV6V9tU/z4I7/iwldtlsoLs5v
        Z6lA4JRUNLVvemdV4+CWnfk9dTv+x44=
X-Google-Smtp-Source: APXvYqwssAl9cUC7VpPEbfIcYkeAkuUcIj4vu9Jjx1nRTtW9CHByLiZvJnz4DBWx2fM22AzNQnISNw==
X-Received: by 2002:a05:600c:d6:: with SMTP id u22mr2102284wmm.77.1582018691466;
        Tue, 18 Feb 2020 01:38:11 -0800 (PST)
Received: from nbelin-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f127sm2740626wma.4.2020.02.18.01.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 01:38:10 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com
Cc:     Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: Document shiji vendor-prefix
Date:   Tue, 18 Feb 2020 10:37:35 +0100
Message-Id: <1582018657-5720-2-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582018657-5720-1-git-send-email-nbelin@baylibre.com>
References: <1582018657-5720-1-git-send-email-nbelin@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Shiji Lighting Co.,Ltd is a LED manufacturer.

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..a463286c3960 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -863,6 +863,8 @@ patternProperties:
     description: SGX Sensortech
   "^sharp,.*":
     description: Sharp Corporation
+  "^shiji,.*":
+    description: Shenzhen Shiji Lighting Co.,Ltd
   "^shimafuji,.*":
     description: Shimafuji Electric, Inc.
   "^si-en,.*":
-- 
2.7.4

