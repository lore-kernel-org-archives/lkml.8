Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74514C352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAA320644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwDIRG+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404801AbgDNDdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404787AbgDNDdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:33:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD2C0A3BDC;
        Mon, 13 Apr 2020 20:33:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so4719553pjb.4;
        Mon, 13 Apr 2020 20:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yq44qY1NsSkf+l5SZ0WYBQFjUQwT8TcW89f6+pzAZf0=;
        b=kwDIRG+vmkVlvGrG1CoLDm24up96GCmQRj4ZFfkQaH2q+aDsglgI49KYLTDtm85vEO
         Pe4tpGT/iWhgc4ZT/4Ndr5v/uqvcM3+F0R63SWHYxumDHWcWDsv/RNo3IxMpqJ4r98zK
         kYlFkYmZ//Fk2akid77aryGmbBKlOonkGJFdL2b7oPPTkzu1BzJXpf/kcGWQqjNUW5fH
         GaACGkjcqqVIDiJIZFUUoqkYD4q0TG2dPq5e8rn7FPqPu29F2FQcRcmlHzDbzMH0P9Yd
         m4RfFEWkoYglWjpqGFhBrdeaLMoT33SSkFmMHap1tFZwOISDW2x2TLl1UmrZA/bNqeWu
         qSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yq44qY1NsSkf+l5SZ0WYBQFjUQwT8TcW89f6+pzAZf0=;
        b=tlq02a1UHDsdtSPEnrxkzLEhsspRWwge2cGct/gyxJodBOXwNqizBeyDw9KbaCUVzx
         frgTFMRLt1LuoL5LeQl8s7kbatp7LBvHDy818U8+CESuV7s24AQ1ctwtWgOtriBGBcPy
         UDq7kZYnRf9OC3gmBXELahqvMcaN1E2xz0yX3cr/LxGdlSv+++2ti/yFQzqZD4AR2hUO
         41nveKNPTAlUFWHerzN08elBoBehO46nDGcgzPZcXSvJ8EDztqtLJ43SQquIcdmNn4/J
         pWo+KKYrnMdi8ayWiTqrRio43PLKwiov9iETskXqv2TQIbgNY7JNhXgp1MPItNtQ6Bzn
         pP5g==
X-Gm-Message-State: AGi0Pub4fpQe3rhpdrkAfrew0P3pTN8WDqKRLlr9S3L+DwH/MqBxr4mu
        VwXHffVUyYUm2UWHgahZDFc=
X-Google-Smtp-Source: APiQypLT8IBv2sVuESWM1xz1uKyLRVuCRs6A7sU13393F0Zqevl4IhDYTISaV/yg8T2/4QqCWjv83g==
X-Received: by 2002:a17:90a:3287:: with SMTP id l7mr1059512pjb.126.1586835221520;
        Mon, 13 Apr 2020 20:33:41 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 140sm5612440pge.49.2020.04.13.20.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:33:40 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 2/4] dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
Date:   Tue, 14 Apr 2020 11:33:23 +0800
Message-Id: <20200414033325.26536-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414033325.26536-1-zhang.lyra@gmail.com>
References: <20200414033325.26536-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
index bb3a78d8105e..87e8349a539a 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -28,6 +28,7 @@ properties:
       - sprd,sc9863a-rpll
       - sprd,sc9863a-dpll
       - sprd,sc9863a-mm-gate
+      - sprd,sc9863a-mm-clk
       - sprd,sc9863a-apapb-gate
 
   clocks:
-- 
2.20.1

