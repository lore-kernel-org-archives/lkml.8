Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA269C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C28A2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DD6lyqkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGXN23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:28:29 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:43005 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595597308; x=1627133308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SuzXpx5L0/VcCKBcXXekJpBXKEIzagXsxj/sXeTHMTM=;
  b=DD6lyqknu3vFIFOQT++0cWGDeki1AQRolT3XFDrcmnV/STDkWDQS/+QP
   42Tt2Z9LbfLFUlu1ZknKHEDO9AqWtUG7BLqdfpYWyOXxKcE+ONSYFXxfV
   nfmWJ7VR+LCzncihegIlKEX0bAoiIa6SKU2HVOVj1M+s+0wTPqhxf5e1g
   Q=;
IronPort-SDR: WCmSG4hM3zrfvBXciirxMKnP/wlSRXjdk+q4gLtniDOXgH9P1+MKWTsmnSCFUVi+qvFpKI/4j7
 6WUV7wTwd7rg==
X-IronPort-AV: E=Sophos;i="5.75,390,1589241600"; 
   d="scan'208";a="43769474"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 24 Jul 2020 13:28:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 492D9C08B7;
        Fri, 24 Jul 2020 13:28:19 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:28:18 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.160.65) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:28:10 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, <tsahee@annapurnalabs.com>,
        <antoine.tenart@bootlin.com>, <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>
List-Id: <soc.lore.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arm@kernel.org>,
        <soc@kernel.org>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <eitan@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v6 5/6] dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3
Date:   Fri, 24 Jul 2020 16:26:53 +0300
Message-ID: <20200724132654.16549-6-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724132654.16549-1-hhhawa@amazon.com>
References: <20200724132654.16549-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D32UWA004.ant.amazon.com (10.43.160.193) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings info for Amazon Annapurna Labs Alpine V3.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 Documentation/devicetree/bindings/arm/amazon,al.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 7de3a8c6e740..a3a4d710bd02 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -24,4 +24,10 @@ properties:
               - al,alpine-v2-evp
           - const: al,alpine-v2
 
+      - description: Boards with Alpine V3 SoC
+        items:
+          - enum:
+              - amazon,al-alpine-v3-evp
+          - const: amazon,al-alpine-v3
+
 ...
-- 
2.17.1

