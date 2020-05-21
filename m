Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9749C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E07A20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lbJnvqkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgEUVVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:21:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:30188 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590096097; x=1621632097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdAMOjHLIL52IjrktH/4zpMrbAD/w3CJWe4Kq01sDTk=;
  b=lbJnvqknMKmtu/4sH7/8zDBHnjUS2UpKqmLScL6oofU4KlO2OGkGCFph
   IFzghoQ1qsyUrhXOR6zEY6btO4eDEHkxWCb0Bi3lEDeA7xUINj+G54/By
   2QHmJO8/OL153a5jhOWDbo3BMqb+9/2Kz3IB1UXyRX3CBjcxiNGuarHjI
   0pyGKnS0sh+6PAh05Cmsn9MGGYbXxIE9oxtWwXXzTkg1VNwI7GnrRU8T2
   AIiaOQv2otRVmF8OJJj7BwqR4URy2sb1pPdhI+QYRU5XU2lT0Yz+fbWUf
   FknHgYYKjkONh8nXVj0cPDL1xYeOpgM3lpwGVi1+ka19oPhlNPMKeI7h+
   Q==;
IronPort-SDR: T2/9xtOWlSU1VFyDJ2IQtqBie1D9DIIUdZzI0FxBCtoy6qRTmvU2nl05H1SF8gbdR71dU4GHpC
 j13NxQTGYEXA6+k4kH5iUQjTypG8iqUaPP8EPFfcfdbkHw7BATYIeMLlGZzaFukJaepsUAhfP1
 jiFU6rU2HH/Gkb3H70cBOH0+WxLiE+CYr+ir6VqE69iB8KDTQOslkGyBSTycujLalk7Szm1RHS
 9zF0manjinLlWaMBtSEgTY79oPQ2863AcR4rEA+VWHUQB+5LY5n6Sqb4+sV+gvYHh/HpHkRwz/
 LKg=
X-IronPort-AV: E=Sophos;i="5.73,419,1583218800"; 
   d="scan'208";a="74176781"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 May 2020 14:21:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 May 2020 14:21:35 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 21 May 2020 14:21:33 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <jiri@resnulli.us>, <ivecera@redhat.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <roopa@cumulusnetworks.com>,
        <nikolay@cumulusnetworks.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/3] switchdev: mrp: Remove the variable mrp_ring_state
Date:   Thu, 21 May 2020 23:19:06 +0000
Message-ID: <20200521231907.3564679-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
References: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the variable mrp_ring_state from switchdev_attr because is not
used anywhere.
The ring state is set using SWITCHDEV_OBJ_ID_RING_STATE_MRP.

Fixes: c284b5459008 ("switchdev: mrp: Extend switchdev API to offload MRP")
Acked-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ae7aeb0d1f9ca..db519957e134b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -62,7 +62,6 @@ struct switchdev_attr {
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 		u8 mrp_port_state;			/* MRP_PORT_STATE */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
-		u8 mrp_ring_state;			/* MRP_RING_STATE */
 #endif
 	} u;
 };
-- 
2.26.2

