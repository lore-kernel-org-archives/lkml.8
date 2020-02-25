Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D4AC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3EC24653
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q5lSKIAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgBYLa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:30:28 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:13218 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgBYLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630228; x=1614166228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DEssGXIsB7EUj0Tn+8tY3DwWsX+hFqfa/2RyzoqrTJU=;
  b=Q5lSKIADhoi6jdAnv+7iLkblcmPB3VhbuADK4tRMX95/0VBkaqcPvRbY
   uAsVHLqjvLFbWuMhWhuThffEM9HB1GOz5i0JJ6Ibum+U7xH70EutZCeZi
   IgAQeaiC67NBGYnF5CiSHS73nmybAmDgWgxOiRbvCUGjoUOYs14TO9BqD
   E=;
IronPort-SDR: H87tfKLKVcUdzGYb6olGgN9Q9zUSdD8MsX8+eHav8SUd3VDNsW4gAiwi/1v/PU8WC6dy/zqpMX
 RKZXd1uFqizQ==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18946426"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 25 Feb 2020 11:30:27 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id E2889C1290;
        Tue, 25 Feb 2020 11:30:22 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:30:22 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 11:30:11 +0000
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
Subject: [PATCH v4 3/6] dt-bindings: arm: amazon: update maintainers of amazon,al DT bindings
Date:   Tue, 25 Feb 2020 13:29:23 +0200
Message-ID: <20200225112926.16518-4-hhhawa@amazon.com>
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

Update maintainers of amazon,al DT bindings.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amazon,al.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 58eb4ad55a76..19ee489396f9 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -7,8 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Amazon's Annapurna Labs Alpine Platform Device Tree Bindings
 
 maintainers:
-  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
-  - Antoine Tenart <antoine.tenart@bootlin.com>
+  - Hanna Hawa <hhhawa@amazon.com>
+  - Talel Shenhar <talel@amazon.com>, <talelshenhar@gmail.com>
+  - Ronen Krupnik <ronenk@amazon.com>
 
 properties:
   compatible:
-- 
2.17.1

