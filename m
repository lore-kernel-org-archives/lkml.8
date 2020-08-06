Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A691C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE55206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/AghX40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgHFRv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgHFQcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:32:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C80C002178
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:31:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so39517526wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeSaeFBmaX2UOS8vhf5MdyTixeaMCetcbpgjFTLJmfg=;
        b=c/AghX40N+5md1YLT5QwCUuxicFBpduiPvQLgeJIBCTUe/0RUdBrQNPaaahVmlPoBW
         Eb1LQr9nje/4ow0B21v8Y0G10Ef4553v81DuNXrdFAEGBMyIaXrrkkwqfdFZVovnI5kG
         SOHYw2KE0OCW+OvE6SlVyV5jjdEiUXPiOKB1fCCkuALyca1Urr66LIth/I7g7iwK5Em6
         eQDiyXY+3KIFlzHJp7yvzEj4+93pp+DXGd4i/qhRsjabpNdhkFQhL7k7ior5uQm9sFIe
         iD9uR4m9xNgEtajOZ260W45eOKiBoL/r6VBV7vLdFGc2/TwTrMy5LE+bDoonA0BdUfMf
         /PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeSaeFBmaX2UOS8vhf5MdyTixeaMCetcbpgjFTLJmfg=;
        b=RRUn/cgsVVoXDBpR+AL8ujnAe0eEDfELYS5dMjlyetPYyf22o0hkk3Aqu/KGXEQy4m
         OyLTDuoLwPR6FkPMi5QORHYb2RiIZK982pbhk1bdka7ls7AWr44iry1NUuCmOk8BthRR
         k3QkMmrynGpFLAKfeBnEb74MKLmzvB221QqWcaL1nP+gEjxV38zEB/EYu/TfOm9H/5oU
         oGuUkPR3PU87t/kO2LouCFlTaC3aj4HKI+buqZk4eLyuVL+PAltJMS0rnjtGBjb8aud1
         TtJEl9K8V3riao8jFNWAXNJ4Y01cCovNl+Q9MWUJXHEz+U7hziRtmWnIWRg1XRSt3ZhY
         yAJA==
X-Gm-Message-State: AOAM530gLX/XXn3QRnJClgi6tNzeuR4k64d+n/KN+5jMAuUgNTo5SqVk
        OxeZj0nU3OiRVcSwc0rnICFINA==
X-Google-Smtp-Source: ABdhPJzF+qEtbxy0Prt75MMumjbxAWyjUEH4K5XMd0aIV/cqwRkDKfESNT3Wwyv5UWulYZyvkpM8/Q==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr8016753wrx.310.1596731492173;
        Thu, 06 Aug 2020 09:31:32 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:31 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: interconnect: Document the support of optional path tag
Date:   Thu,  6 Aug 2020 19:31:21 +0300
Message-Id: <20200806163126.22667-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
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
