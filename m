Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66654C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447FF216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEuI4RV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgEAUsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:48:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7BFC061A0C;
        Fri,  1 May 2020 13:48:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so2626212wrt.0;
        Fri, 01 May 2020 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfGOLfXaLulVw5WVuYJtit1hU0mFqdh6Ro95VIBdKw0=;
        b=bEuI4RV8Xn99q3VEtbMvLgV+yoUkaQi8FdtjmYYvgirP8J77thzXg/rItG4SaSEP+Y
         SPoULqwYp3st7sNCJ3iyN9iuy5jhLkHYxWAgrr18Wn1hrOOQZxtCKcWTOi4Vchr/PMG/
         mxBSkiki4bSDpchrdkJgu3WMF3NKvIJq84HFSs86mwtrD/Vr7O2ZTX3glbtDDI/0by6S
         +R3YrO5fagE3Q/8JsSx3NIni0tfeRzb9YKZ60G20EctIjUUUrWizaRsf88zhNMB4Q9Ox
         lwnZbhkbzsjXmtlEM1VWA9DhGhyMtmXHXeutU2Xk5NCckjqA4tPgg37QyNDRWEla5OtK
         rKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfGOLfXaLulVw5WVuYJtit1hU0mFqdh6Ro95VIBdKw0=;
        b=Q8omNuDglz9uqwDqiepLG9LKPgSlcCYLauec779T0RtlUMzXoaBOCg/s9XLCcXAHpn
         G0N+zaSbzVBs4T28zQQ9amjXOGnQhxhfse2GK7ol/IDtmVE8NDm9Z6+S4cnH28JIA2QS
         +RAejlDgunLKcZoSRst584qs+gGJMqElQliRmgL1G6Teuv/+TcQbFtX0jbmo3yd3ZOfV
         Wfb98CJH2AGTbj3CdnGrg6lIbJ2ZMARt/825LV2phjbC3OAxz4/+Pwv/oyQs0i0vKA/1
         Vbku0p61LzkSZCeyjthNNWFoGfbCTrP4R/7HT+pBhBkqJidbo8BI/3pA48NF5eXiGz8R
         CatA==
X-Gm-Message-State: AGi0PubJvlNyaQe8ai6EK7dGfVh3KRdbqoWEmkPkCeOxRghzA2oDyq2m
        4dMqR1Z4wTJf+kPIlLlyS7ZPXHtDCm3hFA==
X-Google-Smtp-Source: APiQypKe5x7InGxR58MMHp7xlHWWep8tKBWq1/0SVqVCutd9ZGsDvmietKRkily1TWE3N6OusrXeEQ==
X-Received: by 2002:adf:9793:: with SMTP id s19mr5470974wrb.147.1588366126534;
        Fri, 01 May 2020 13:48:46 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id w12sm5938623wrk.56.2020.05.01.13.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:48:46 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: display: Document TM5P5 NT35596 panel compatible
Date:   Fri,  1 May 2020 22:48:23 +0200
Message-Id: <20200501204825.146424-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501204825.146424-1-konradybcio@gmail.com>
References: <20200501204825.146424-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../devicetree/bindings/display/panel/tm5p5,nt35596.txt    | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt

diff --git a/Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt b/Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
new file mode 100644
index 0000000000000..6be56983482bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
@@ -0,0 +1,7 @@
+TM5P5 NT35596 5.5" 1080×1920 LCD Panel
+
+Required properties:
+  - compatible: "tm5p5,nt35596"
+  - reset-gpios: GPIO spec for reset pin
+  - vdd-supply: VDD regulator
+  - vddio-supply: VDDIO regulator
-- 
2.26.1

