Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7B3C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C482176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SFr5FcVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgBYLag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:30:36 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11683 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgBYLae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630234; x=1614166234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SL6BZmD4jmjWbjXl8N+TY5rCn4h74dxErtWXusGgkjc=;
  b=SFr5FcVLuYPvxHR6NGeecLHzqNlU9LjIRSKdsFvGnM0ZFY75/PKs93Hs
   QRdKMqA7qtRayOF7yAF/MQbFCPvqJ/6LlkhdpvQLzfy0/w+B1wKEf2jd1
   56rSPinW1UTJSvu8N+tYyycvoZl4cU7fmbzBhiqq1LAf19ysh8xr5BaYU
   c=;
IronPort-SDR: +uXldnfRzV9/NuIJkbFk3QIO1oCSf1ZHrY5CPSwWnC91IiXmaX9TEPIJFCfkiYD8+4ptqL0k34
 OwsB3hN5Syfw==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="28702654"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 25 Feb 2020 11:30:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id B6C43A29F5;
        Tue, 25 Feb 2020 11:30:30 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:30:30 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 11:30:20 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v4 4/6] dt-bindings: arm: amazon: add missing alpine-v2 DT binding
Date:   Tue, 25 Feb 2020 13:29:24 +0200
Message-ID: <20200225112926.16518-5-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225112926.16518-1-hhhawa@amazon.com>
References: <20200225112926.16518-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amazon Annapurna Labs Alpine family includes: Alpine-v1, Alpine-v2.

This patch adds the missing DT binding of Alpine-v2 in amazon,al.yaml.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amazon,al.yaml        | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 19ee489396f9..7de3a8c6e740 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -13,10 +13,15 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: al,alpine
-  model:
-    items:
-      - const: "Annapurna Labs Alpine Dev Board"
+    oneOf:
+      - description: Boards with Alpine V1 SoC
+        items:
+          - const: al,alpine
+
+      - description: Boards with Alpine V2 SoC
+        items:
+          - enum:
+              - al,alpine-v2-evp
+          - const: al,alpine-v2
 
 ...
-- 
2.17.1

