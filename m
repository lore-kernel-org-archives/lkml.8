Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98025C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9262074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j85GSKkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgDGM3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:29:48 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26852 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgDGM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586262584; x=1617798584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5tHbCVV6N4tgdVdrHys4d0EWJHVdHgwDEcQ6SvD2Tt4=;
  b=j85GSKkxeNymz9np6/vg8+U62/0FwwLS9X6HgfKPKcnIBuEjGuzvSnpY
   7V8Kllchl33wVFTnWWCQKbgtaw72eSpbZRBI9wkyMKOsHeRiXR3BqtAq/
   37zG3zmAYuzumBI0/xKMU4jKrx/N6h7nMFmAoNBtvG5DOa2YJYMlGt3hQ
   oz/ktb8anDK43CRl0Lw71gyAo2DczWu9GiSoaxKWvRle97KxOJtjEqOpC
   1tyEAUzb1+YKPkvPLJfdz3Vw4/SLEnT3QnYrqQQlXkkTONpRB+8K2neph
   rxVGV87fvh4xq7W7wqbF1Qc02X0yPy6KjtKd/Iy4xYwgteyf6AjCooeRw
   g==;
IronPort-SDR: z9miHr9GYeetv0nHWCnswn2u4RsGiP3ywilfFYrcEYXaX1tMoCeQryyvXZ0k8bwY9K2r+8DFiM
 TSyXFT17VcyX7dXINP5HFYlEwjRXMOhi4AB6D/M1D62cdu2qOfqAAOMSOAv3zEafUmLyJKGy7z
 9clJGI58GHt6V/y31H9Wm/kBl4aGjopsXkK7r1hubsJyGhh/qvNOHkJJKD7fnGSWb6znokbA7J
 pjrKrKo3WKiWwixGCxvISjJPd2WjJvrduapV/lIGpVUERJ9zFe6Byr9nJ+iA86MWFAPk8voRRA
 uN0=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="75013437"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 05:29:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 05:29:56 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 7 Apr 2020 05:29:42 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 5/7] usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
Date:   Tue, 7 Apr 2020 15:28:50 +0300
Message-ID: <20200407122852.19422-6-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407122852.19422-1-cristian.birsan@microchip.com>
References: <20200407122852.19422-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
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
index 7011438f91d6..1e2194fe06cb 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1061,6 +1061,7 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		switch (usb_endpoint_type(desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
+			ep->nr_banks = 1;
 			break;
 
 		case USB_ENDPOINT_XFER_ISOC:
-- 
2.17.1

