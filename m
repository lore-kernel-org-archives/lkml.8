Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C146C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A12920786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594204581;
	bh=j4EX+FYYMmUL3lz0Sf39rotA7d7j4vro6NAbsWtYLko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xz/jQBTdIWURHJWK0x5GVsyAZPfUe9MBjJHq1xY2sp4ceBhhBFm7ZoPHzQndLp+io
	 LhG//AmXgt1XwUWXQWgkPKnawbBecEnjWLqJGHr+f7Hrfh6WGsSOxIx2dlDeU0ezZ3
	 XWPOl2r9lyaUcoj4jCN8Uxvgx67awYPN4q1uD8aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGHKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgGHKgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:36:19 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B1820772;
        Wed,  8 Jul 2020 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594204579;
        bh=j4EX+FYYMmUL3lz0Sf39rotA7d7j4vro6NAbsWtYLko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV2Sus3+GfHAz3YX6mDetTIQ59c65IsSFM0x/7I4TnxHuz6Coc4eTY9+3jBGWUUhJ
         9Rc7QmzEdpkgQEcawXOih+5hnCt384un3DGMZ9MoQaJp/V91NJkgTRN3hKU08Fozs3
         oijZ90OGG28jfD7DdMtNP7sG72hxFKbwrCFYYmE4=
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: vendor-prefixes: Add Lontium vendor prefix
Date:   Wed,  8 Jul 2020 16:05:56 +0530
Message-Id: <20200708103559.132300-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708103559.132300-1-vkoul@kernel.org>
References: <20200708103559.132300-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Lontium Semiconductor Corporation

Acked-by: Rob Herring <robh@kernel.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..31cdb21a3d22 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -595,6 +595,8 @@ patternProperties:
     description: Logic Technologies Limited
   "^longcheer,.*":
     description: Longcheer Technology (Shanghai) Co., Ltd.
+  "^lontium,.*":
+    description: Lontium Semiconductor Corporation
   "^loongson,.*":
     description: Loongson Technology Corporation Limited
   "^lsi,.*":
-- 
2.26.2

