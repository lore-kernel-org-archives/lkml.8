Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8508C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE26020786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ui/LImuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCXKvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:51:25 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:17250 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgCXKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585047085; x=1616583085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=e2Xw+4d8lNIhM4PNtaJCZ2fQOhyOuwNnLnlDeaT6Q5E=;
  b=Ui/LImuq+cb+NH3CmOWDlXQ1cWcIjpQymRQEObimiILQ2prgfXyOjTjC
   GUu+E4SzpugzfKN+2EXFII9Hm3+bs+NW2iIg7goiPGPoko4TKuisB01Ns
   bRkvAIkFYz+YIUk+tFIX8CUbXelX4sji9Qmq0KPTSbEzomzcdiRO5ekJY
   c=;
IronPort-SDR: n6aS153fkeGgz3H9JQz2TLLuG4OLqtZeFtyS66xqGShJP7Yspprr86J7TKKdEiiVErftHKYg17
 QbJ7ZC24nL5Q==
X-IronPort-AV: E=Sophos;i="5.72,300,1580774400"; 
   d="scan'208";a="22486804"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 24 Mar 2020 10:51:11 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id EDAC6A17E9;
        Tue, 24 Mar 2020 10:51:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 24 Mar 2020 10:51:09 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.241) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Mar 2020 10:51:00 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>
Subject: [PATCH v5 5/6] dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3
Date:   Tue, 24 Mar 2020 12:49:17 +0200
Message-ID: <20200324104918.29578-6-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324104918.29578-1-hhhawa@amazon.com>
References: <20200324104918.29578-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.241]
X-ClientProxiedBy: EX13D36UWA001.ant.amazon.com (10.43.160.71) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings info for Amazon Annapurna Labs Alpine V3.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

