Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AD220814
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591860998;
	bh=Wu4ja646t8kMQ7GZ1MbMhDOvKUJn6HqxUuYVQtcb1Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsK73epA6QFcgCgoQNVSVGpk5VbhGdJfMwPEG8ZAVpNVQGVirUdMF005rSElS6mEJ
	 7150lURWSFYMVMzHWlom53QqCrqmM5TyfMDB2yAVRDP8mwNtHyj3kGVs2mWGJiFnL/
	 RO7Y/u+np3QdS5ma2Lq4K1ZwFT2Wm8znz0SLmtx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFKHgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:36:35 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC9720814;
        Thu, 11 Jun 2020 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591860995;
        bh=Wu4ja646t8kMQ7GZ1MbMhDOvKUJn6HqxUuYVQtcb1Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eV7zznIQZ9mBpzvcdl8yksaSpyY2EYKgJPD7oP1KuwonW9aknHGm4/PivtSGAsh4X
         kNLYQmPiJ7Af75xhIhfTHlRtIo9axvOw3x+exeNnngaxtEXCa3RAznunNRPA416T0h
         yfq0HAStiYzFWP3nuSV2azK9LIPelD0zf1poA0uM=
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Lontium vendor prefix
Date:   Thu, 11 Jun 2020 13:06:09 +0530
Message-Id: <20200611073611.1446562-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611073611.1446562-1-vkoul@kernel.org>
References: <20200611073611.1446562-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Lontium Semiconductor Corporation

Acked-by: Rob Herring <robh@kernel.org>
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
2.26.2

