Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C473C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD29C20722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxSMag+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgICPKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgICN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:57:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2A7C0619E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 06:31:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so3240347wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v7riCkWqOW12WqwNbdYgi3MhtDbA8fxMcLkKxaVn1Q=;
        b=FxSMag+QeOzVZzZ+W/d4wUZ228qXnTc22tAxz97IrORD8jZ1HYcP+sq2f2Lx6LfZL3
         hCQmI3l6sISeNn78F6Z3VYf7cXFECd9N8RKUZSKARukgkj2KPTDjIQ10GSUQZ2e4kU1i
         5lq3epDjkN01sN0gOs9C3LbtQ6sDJ/49NDuxEpQXTerjREMHIdAX7obuKgHhjQb7KXWQ
         Z2+WlBaT30YpbYgKs+NkWSUG4DKGwNe0EF60dRWyW7HFlwDhxELhqAmCvLa6/kBrW/87
         TrIVqzw/5wBYmDyhC465Zn9R9K5WBAHLQZxAy/QZRgflKb/yJcaMeT2obJzIRa5fJ54F
         x3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v7riCkWqOW12WqwNbdYgi3MhtDbA8fxMcLkKxaVn1Q=;
        b=J/80YWjYARKyIKgKy/ppAHxjBMIBRZNMCDlCVd1BeZvAkAPPg9/eT//ftJl1c3xaw3
         N720Slf3WzAfrqpVYfWSXJHAmL5x2NOwUuNDRE2KQOSgnUiuO3ia38JsV49afijNPsU0
         bbgG34tSlx8M6K25fIev6r8wNk5qMqQR/5iJCZLY6Ju1Oq/DqbsQhyIQgTbiISzzA8Tu
         dEZUhPl1c/HibqLzpeG/WojJwRkhOgPBSGNqcqYpMXdshD2ML2gVxapt+OF8zDNT56Z6
         rPN/5S7u64C/K3xI9CNczS2o4sNNo93VUaf9CqTsai+PAhveIupu2ghprIGaU3Hk+94c
         JVew==
X-Gm-Message-State: AOAM532wor5MKrf6OVipME6TJCK90r/Va90EpgakENwzWcpCaFDu1yw0
        r0RpJuUmPnIkZqLiixbSuur8Og==
X-Google-Smtp-Source: ABdhPJy2mm+MBBMVkV5XJikd7HS9L+iWlSQLCxuxQL9VOQRGQ/LByHjHzHNmXzyk4i662snmvdW6GA==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr2485171wrt.211.1599139899481;
        Thu, 03 Sep 2020 06:31:39 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:38 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] dt-bindings: interconnect: Document the support of optional path tag
Date:   Thu,  3 Sep 2020 16:31:29 +0300
Message-Id: <20200903133134.17201-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's document that we now support specifying path tag information in the
arg cells of the 'interconnects' DT property. This information would be
populated when the xlate_extended() callback is used.

Specifying the tag in DT will allow the interconnect framework to do the
aggregation based on the tag automatically. The users can still use the
icc_set_tag() API if/when needed.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6f5d23a605b7..138c544c8c8c 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -19,7 +19,8 @@ directly.
 Required properties:
 - compatible : contains the interconnect provider compatible string
 - #interconnect-cells : number of cells in a interconnect specifier needed to
-			encode the interconnect node id
+			encode the interconnect node id and optionally add a
+			path tag
 
 Example:
 
@@ -44,6 +45,10 @@ components it has to interact with.
 Required properties:
 interconnects : Pairs of phandles and interconnect provider specifier to denote
 	        the edge source and destination ports of the interconnect path.
+		An optional path tag value could specified as additional argument
+		to both endpoints and in such cases, this information will be passed
+		to the interconnect framework to do aggregation based on the attached
+		tag.
 
 Optional properties:
 interconnect-names : List of interconnect path name strings sorted in the same
@@ -62,3 +67,20 @@ Example:
 		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
 		interconnect-names = "sdhc-mem";
 	};
+
+Example with path tags:
+
+	gnoc: interconnect@17900000 {
+		...
+		interconnect-cells = <2>;
+	};
+
+	mnoc: interconnect@1380000 {
+		...
+		interconnect-cells = <2>;
+	};
+
+	cpu@0 {
+		...
+		interconnects = <&gnoc MASTER_APPSS_PROC 3 &mnoc SLAVE_EBI1 3>;
+	}
