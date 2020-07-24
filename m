Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBEC433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1883A206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G3ZqKwBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGXN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:28:10 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34205 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXN2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595597286; x=1627133286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EXi3tTBHf8P3xAGZvqsO/kEW9lXFWZ2Yowzh8A1KNTI=;
  b=G3ZqKwBd8rgnt1nwnFnGAm5OnY97lGlhVi4Jv0wXUgD+bmVfIohEx3EC
   O9tTFgiWYuD9DpWuVXTEDJXbSjCX4599o5lqTYg+oAhMqyYK3BSOhaFLe
   J69B8ZoijNk3mnhpnuPJYVINe2d7QKYW4l5HIpS7G76UAySebaObX821j
   U=;
IronPort-SDR: 7jFFeONIrrdpxNdbouE0R7Yx2R0SSXt8hUfWbDs20BY7fyU180bbE/HsH3DqDzJ/j/WSzmn18b
 hi9Whw/bkgJQ==
X-IronPort-AV: E=Sophos;i="5.75,390,1589241600"; 
   d="scan'208";a="43878160"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 24 Jul 2020 13:28:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id B9B1BA2248;
        Fri, 24 Jul 2020 13:28:03 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:28:03 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.160.65) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:27:55 +0000
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
Subject: [PATCH v6 3/6] dt-bindings: arm: amazon: update maintainers of amazon,al DT bindings
Date:   Fri, 24 Jul 2020 16:26:51 +0300
Message-ID: <20200724132654.16549-4-hhhawa@amazon.com>
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

Update maintainers of amazon,al DT bindings.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>
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

