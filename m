Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E04C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A7E206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptusWilB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDEKtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33866 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDEKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id c195so5626680wme.1;
        Sun, 05 Apr 2020 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlVxpMo3N8K7wg75iggPuxNbQ7akl7aPxo796TvewWU=;
        b=ptusWilBR0UMywqaFMTzUaLupeLJwjXw4MZ/RAe4QkPfPnyGKOUW5OVQ2EDb+LPiUa
         xtcCrPUAChJe2Q20e28jKt3qMRGfEjPniioDDt3ThduS5EmZ0rZrFLK0KtFQoJxCVwmF
         /qzwkKpKUwg9XuUi5HwJ3+EVEugPXK+F8HFZAVfIITBY/+gHf3ayMK3m6zkQTiwFbyfr
         PU+SYre5EFhvIjh8w3gJwhoHGCGn+5DznxVXfTyMM8DZ9mh9cqLTlC5kws8ZqWKpXBoU
         ZWQ288Ji2RvH30uJmywF+c/FEJSZtPz9guLSQY7ikKVC0iPMihparMUFQQSXgO3Yslzg
         9Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlVxpMo3N8K7wg75iggPuxNbQ7akl7aPxo796TvewWU=;
        b=SmIhFibB4xG8LHUpvHTI/b4F+60etk2sqplkjRo/Y7ZkiEOGORfJwdYyrEaFn8h2a5
         ymKRbnRcvqPqvOupbPRqrC2BD3LfkKWJ2EY3qNVt9Moqzq1xnB6n9ETLiHkiMEiMtE7s
         LgSrR+IHfQcontqS4hwbzbAv3Msy3VjfJVtrYGpFCh9Zrt2Isa2iP2ohrBN7chEs8+HZ
         26FGvH3+UNA3zfF8DyKlCu1mwnk/plVpyEtGwIN+ykOHyC2SiiyDdmIMikV7E9rBaR14
         kKSCEghWyJLwOqc8+sG/Sp/v7GZFbqZvzZs8+1CQ7XfhFhfCvXza1ga7JjVajc8xzgcW
         BRBA==
X-Gm-Message-State: AGi0PuZEOlvhIlS/VkrDSLZXLF0zlXvn39vsMWKU5WRCshGbu5VwKedX
        3YSrImExmFgtNl412oWssDg=
X-Google-Smtp-Source: APiQypKOcJ97wwE4UtOnmuAVjQvnUJ4R+GsdW7s2pCGH0nZt+rhOuVsOiqSQ/cf8nJqCNs12RNJa8A==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr17307450wmf.88.1586083759594;
        Sun, 05 Apr 2020 03:49:19 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 3/7] arm64: dts: allwinner: h6: set thermal polling time
Date:   Sun,  5 Apr 2020 12:49:09 +0200
Message-Id: <20200405104913.22806-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reasonable thermal polling time for Allwinner H6.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d4d3963705f5..c3e4f09f60ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -905,8 +905,8 @@
 
 	thermal-zones {
 		cpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
 			thermal-sensors = <&ths 0>;
 
 			trips {
@@ -935,8 +935,8 @@
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
 			thermal-sensors = <&ths 1>;
 		};
 	};
-- 
2.20.1

