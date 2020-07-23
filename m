Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B7DC433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0588720737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YhcoKZnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGWSt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:28 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57925 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgGWStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530165; x=1627066165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MnRMwgeR1VP4Ff/VfkHXb0v/p9CjQoRUD0iRNqINwto=;
  b=YhcoKZnx/5LUFpqFoWpbhM9gdNYpTb1yzKzxGOs/vczzirIzWcYOHSWR
   kR3847jVgcEf+9sc/KFEzjxL2gcjc0DZuZLA6QRQPUtPq0u51FZEbk9BB
   tTkKZT0cu9Q5a4v/zNKDdqhbDnLoGd1eQqyfjzWRcdWosbFUhlw77Rvqm
   Nya2kpJRmfIEXmuczFk9nXP2HGJVoAFLiIW/rmxnsSwkeyKEFgv5GFxWB
   zv3uSQgUC2BUdwTcAg5uJka9rgSUqevii6uDJ3GqiR9KdzIUIclvmerp+
   t/FQjYLdvA5lUDEKdaLQqqFFST1fBL0omdq2rqP8/WPAUYGKdv2KcqK84
   g==;
IronPort-SDR: FHDKERzMy/NtMaEsyYOzB8X7FTf07smKJe9p31CtIMtWE3yULkLer6qhpO/N9on6vsdVT+NEII
 FAv+LGITudw6oTM7Lj7oWX0CALiv9JDBMvUKibOqXzIw8LodE/B44QYQaDGJylXi1ZYI6C6nXf
 YXIey+X2qeC9GnQoNudrhTRrLZ3gFXply83Cf2Yz/iS/slpQujv9H9q3/sPFYjZy/9vtCjAr3F
 Bfr7rFxx9ZS1m0x1UAvVTdPKTl5i8Z//UTW5Qc5NRGsCVhLAW5fPn8N3ordja2bwV3YwjYgYub
 A7A=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="85153693"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:48:45 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:41 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v4 4/6] usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
Date:   Thu, 23 Jul 2020 21:49:00 +0300
Message-ID: <20200723184902.416705-5-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723184902.416705-1-cristian.birsan@microchip.com>
References: <20200723184902.416705-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Use 1 bank endpoints for control transfers

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 10fa72ec8b79..59b200e32784 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1056,6 +1056,7 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		switch (usb_endpoint_type(desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
+			ep->nr_banks = 1;
 			break;
 
 		case USB_ENDPOINT_XFER_ISOC:
-- 
2.25.1

