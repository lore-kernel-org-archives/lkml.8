Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45334C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBBF206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WOSuVKIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgDUOmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:42:49 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:61583 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgDUOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587480165; x=1619016165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xoMFGgH5DELLbtoeobiA873J6IsfnJEOZCpVd+LRec0=;
  b=WOSuVKIV33vm/UttnJYZpB0KT/O5/Nhh4PMn4h7TkqyVOL1QqRnUFuHd
   V9FJJSX2nA08Oj9WfVwHa05gAcpPCc5tJ6OHvcKf8wD1IVkfIWrZ5QQ5T
   TtYvSNXNHCTt8dUPpV6OCOaT0gHppdU/Fa6fvY5L/TBnwMqPpum0QwR3y
   odf9+KkDufliAg1amOJmu0SyNGbQKbDLPENDrwAZsKRxbnpcCD8jBaB9r
   VGH6mLbmXG5P05kyNhuAvQHS46Qo76iY4yVMkFzCgPhnPAr3CSAMgqbhd
   Xh9l7QBMRbczXX2t8n7dPy3tGK9Q4yKSUQbgWEt8CfzsdwCWY9aOHtYld
   w==;
IronPort-SDR: i4+4A8EGK6183R9m4abc5K3SWHnsHWvDvXQs4vG/ARhOAJ5fkoR+rjaL3bgd0CmjrldolEe29U
 KG1iKFqPaaoiYG1+J/+VwJchVHJ1hCnaDcSSN+5oqrVlp5JDpk/tDvpbqxNlXdsH7J9ULqeXaK
 YJI42JLmyCBVXBdoYtPBFA6SxZrZgxvZ9A4kUdKI3idhab4vCK1nDSHDSIXWcVoM1csINSqLSd
 6BksY9cPVBljeA8xM5UXJZ9cm22dwcbH5VlD+bVC4ZQg/liVlxJDTfFbYip9yzxfbWKqGwJsFy
 zZc=
X-IronPort-AV: E=Sophos;i="5.72,410,1580799600"; 
   d="scan'208";a="72862605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2020 07:42:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Apr 2020 07:42:44 -0700
Received: from soft-dev3.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 21 Apr 2020 07:42:42 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <davem@davemloft.net>,
        <jiri@resnulli.us>, <ivecera@redhat.com>, <kuba@kernel.org>,
        <roopa@cumulusnetworks.com>, <olteanv@gmail.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 02/11] bridge: mrp: Update Kconfig
Date:   Tue, 21 Apr 2020 16:37:43 +0200
Message-ID: <20200421143752.2248-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421143752.2248-1-horatiu.vultur@microchip.com>
References: <20200421143752.2248-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the option BRIDGE_MRP to allow to build in or not MRP support.
The default value is N.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index e4fb050e2078..51a6414145d2 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
 	  Say N to exclude this support and reduce the binary size.
 
 	  If unsure, say Y.
+
+config BRIDGE_MRP
+	bool "MRP protocol"
+	depends on BRIDGE
+	default n
+	help
+	  If you say Y here, then the Ethernet bridge will be able to run MRP
+	  protocol to detect loops
+
+	  Say N to exclude this support and reduce the binary size.
+
+	  If unsure, say N.
-- 
2.17.1

