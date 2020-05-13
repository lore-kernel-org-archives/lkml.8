Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410AAC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBDA206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364366;
	bh=f4a7jQYUGO+gefhtNwOgyxXu8SfY9ICLOZ0ZEWYfr1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gt0nZfKKM/lwjOimJTZxixK8S56ZT4Ju1hzRCEa80/x8gqXUJ6LV1jqS4y45VdfAv
	 l3183Z3hZKC79ew4vy+DyzJyNPD4vyLtQx6OreN29ZK3ZF+DwjMSh8JAHBj6o5/8P5
	 xufGvq+qQcQ4ZLkrLTt56zqGKPvnaehzhUa9Tmfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbgEMKGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387444AbgEMKGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:06:04 -0400
Received: from localhost.localdomain (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E968C206B8;
        Wed, 13 May 2020 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364364;
        bh=f4a7jQYUGO+gefhtNwOgyxXu8SfY9ICLOZ0ZEWYfr1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3R1wJ7GK/L3htlT9FId9pUaXL7vqHSMvbj3xYa212Rc5lvpxqzSEgX0J8tzVX+qx
         y3EWZyr1iH3CcHGPbPlTOKIgxuJ+JhA1K7KHcw0H9ef7m0tDY8/PxA3eXnB00VkFla
         iF5y4dxlR7eumQ9SUZhvVnGbXx9b99GSPwmhWw74=
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Lontium vendor prefix
Date:   Wed, 13 May 2020 15:35:31 +0530
Message-Id: <20200513100533.42996-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200513100533.42996-1-vkoul@kernel.org>
References: <20200513100533.42996-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Lontium Semiconductor Corporation

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..7294852bc47b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -579,6 +579,8 @@ patternProperties:
     description: Logic Technologies Limited
   "^longcheer,.*":
     description: Longcheer Technology (Shanghai) Co., Ltd.
+  "^lontium,.*":
+    description: Lontium Semiconductor Corporation
   "^loongson,.*":
     description: Loongson Technology Corporation Limited
   "^lsi,.*":
-- 
2.25.4

