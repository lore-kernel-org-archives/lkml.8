Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606CFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427E920B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403909;
	bh=o8sRhaHgWPSPd3P6mFJsQFZFuiL8sjkixOve0V/XQ7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODUjTnyJa8XmQpIwSYS5bMdgsioWrdTWy+2pdninWbZrOBYI6euVOj0iAGxiueBoi
	 4iYFhFhkDzP32MNarvryHQmuUMrGC0w1JPpH0ul3nBedjx7H8kTcRLbGBYKwMMmT8r
	 fFgQl3qE0Z8mePjxBbcAmcFEqRsW3+m3XIDgfEWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgDTRbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDTRbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:31:47 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B97320BED;
        Mon, 20 Apr 2020 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403907;
        bh=o8sRhaHgWPSPd3P6mFJsQFZFuiL8sjkixOve0V/XQ7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtlQWmLCCHlxV10fw2X3UlMZR/dxpYzcukn/JQovRX+FQ5X8Cc46TODobeFV+/zTS
         4seRAb3dUVzznuNvLO82W1yVm4D3rIJs9sY/1v1Nf0pRWkgSXZC6c53F1utkEqMX+N
         KdW7kR9A+8OzCaXGeEjs/GoiMIYkeSXPy1HhvpGs=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 1/6] dt-bindings: Add vendor prefix for Shiratech Solutions
Date:   Mon, 20 Apr 2020 23:01:19 +0530
Message-Id: <20200420173124.27416-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

This commit adds devicetree vendor prefix for Shiratech solutions,
a SOM/embedded board manufacturing company.

https://www.shiratech-solutions.com/

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e3f1b06d12ae..48ad8f954f33 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -902,6 +902,8 @@ patternProperties:
     description: Sharp Corporation
   "^shimafuji,.*":
     description: Shimafuji Electric, Inc.
+  "^shiratech,.*":
+    description: Shiratech Solutions
   "^si-en,.*":
     description: Si-En Technology Ltd.
   "^si-linux,.*":
-- 
2.17.1

