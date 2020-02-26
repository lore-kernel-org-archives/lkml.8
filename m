Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA3C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7187524683
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hegrlG36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBZOdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:33:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35882 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBZOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:33:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3367345wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/6gF09OIYAAYDcV57fzVa8XqTwVQognyAPormZwLXA=;
        b=hegrlG36+pNJ7eQm7ecF25m/6jmdt9xJtyaZkyKYXTTcIhQSHUrlFOGC7QM1ZkSs1f
         z8Cii0H2nyG4YFC3gRgyZqEe2HVDgPGAMFF8Oi0EKGpftdOEUEHVDSusQ1+Mx4/446C1
         mQ0rmvHluc25ztTOpLq60P35Fc/x7qwrIxndv01K9RtTNXPG2vhs8y90wuanfqXD2BkE
         fiDkHDNcWL2e7tHjtHwPqJaSfCIBOB5Ep+IcSpKSngLEO8P66LZOkF04iJq2Q7vPKClx
         /mIzKnEUHgviGqFsQYG6Imig61ZMZ8fejNc3vleGlSvmQUwt+gqVDwG0LoxZykRNAY0Q
         Oo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/6gF09OIYAAYDcV57fzVa8XqTwVQognyAPormZwLXA=;
        b=oYjiX72hpuPidN3fb5VKSYLzMQmsUn38omgsSNtwSdWGJiE/E2GGS/x1qSb5ixI8pB
         mqFinLs9gkV36OswyMWLaSyT9LLNuPEqy4dzvSLcvR4OBYvxXBlEytTMoCJVsOthFZ5D
         DK+yyq87O9AACSIeQy0Ty1IQ747p5Vq2pNHuXWMx/DA6mmGyG7JOHQhWgrsn8cE8at6h
         spXOONUlgFDFe1tRv/FOQ+ur8zsAx2bp/5y8Z/unlqoRpzzw6lID39SlLFK6K8SgT01g
         y6+PpYh0o2wFu6sGtKm+L7klxNGB9+Kv0BY6w58m9Rq3jSf+uNC6QRkrfSKLq7lX5aWe
         k1GQ==
X-Gm-Message-State: APjAAAX5mqXFqZCSMi7q43RqaUMi2tQMmXcMTTjPFfnVrspyQnHy5DfP
        2OyJOgsMkOw4dFSYwSPZ+rY4WCp4dEM=
X-Google-Smtp-Source: APXvYqwBKYor34z0MGWsBLW+ZiaHQNfsqktLq4aiSFvylON7V2FQMsPdkd+ygzITY5yRXB619OYQwQ==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr6015351wmk.160.1582727615570;
        Wed, 26 Feb 2020 06:33:35 -0800 (PST)
Received: from nbelin-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10sm3204198wml.18.2020.02.26.06.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 06:33:35 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io, Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH RFC v2 1/3] dt-bindings: Document shiji vendor-prefix
Date:   Wed, 26 Feb 2020 15:33:10 +0100
Message-Id: <1582727592-4510-2-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
References: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
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

