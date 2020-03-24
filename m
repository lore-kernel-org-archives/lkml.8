Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4926C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6FC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QvybQ+1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCXKut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:50:49 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:1433 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCXKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585047049; x=1616583049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OPMX17Omz7JYkY/istcTHVeb5cJ/SKsg2S1n95nmmHo=;
  b=QvybQ+1kChJuca7Bavk7J0qlgq2UqRN05Zt2csTKMAQPydxvbcvPuSaM
   sVrt/xEEmqiBNokmQhar+12UmkrOxAPhLKGvJ0ZgQ3Kz/lWf4b8Uo541D
   q9p5x1IYdD5G0n67b89Q4zbBsundb6MhC+MTDSbsLXK74oQTXtP+eYJG5
   U=;
IronPort-SDR: ma+rg5XVEMHGmlUxlr8tgQYulPnfsvlygMWmbtcKx62xEhagWsn0sETL8/mnMTAzhGt2FpIqIe
 QsaAPFyypWcg==
X-IronPort-AV: E=Sophos;i="5.72,300,1580774400"; 
   d="scan'208";a="22914903"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Mar 2020 10:50:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 7A902A0708;
        Tue, 24 Mar 2020 10:50:34 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 24 Mar 2020 10:50:34 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.241) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Mar 2020 10:50:24 +0000
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
Subject: [PATCH v5 1/6] dt-bindings: arm: amazon: rename al,alpine DT binding to amazon,al
Date:   Tue, 24 Mar 2020 12:49:13 +0200
Message-ID: <20200324104918.29578-2-hhhawa@amazon.com>
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

As preparation to add device tree binding for Amazon's Annapurna Labs
Alpine v3 support. Rename al,alpine DT binding to amazon,al.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/{al,alpine.yaml => amazon,al.yaml}           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/arm/{al,alpine.yaml => amazon,al.yaml} (74%)

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
similarity index 74%
rename from Documentation/devicetree/bindings/arm/al,alpine.yaml
rename to Documentation/devicetree/bindings/arm/amazon,al.yaml
index a70dff277e05..58eb4ad55a76 100644
--- a/Documentation/devicetree/bindings/arm/al,alpine.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
+$id: http://devicetree.org/schemas/arm/amazon,al.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Annapurna Labs Alpine Platform Device Tree Bindings
+title: Amazon's Annapurna Labs Alpine Platform Device Tree Bindings
 
 maintainers:
   - Tsahee Zidenberg <tsahee@annapurnalabs.com>
-- 
2.17.1

