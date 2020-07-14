Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A8C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4638721D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753657;
	bh=QuTUpPj32od8xKGnqQ9wp9FMjS5Eo+apjOKbMlh7Uxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WQ6OPZ33UrUHAzh0rkFdcRS+vJpf2I7S8mcWb71lWUiGjAeT2Eta4AUzOlIg0ZNi
	 BEwNFX4NiexaZPV0InHQEKfTRlfR6h4Gad+A2TNIf1FVLlfMq6TAqCe04DASG0mo24
	 q1rIVKT5q0ms3TZLDC8ZCXEU6KhltlhlqDwx7mEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgGNSv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbgGNSvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:51:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1ED22B2B;
        Tue, 14 Jul 2020 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752713;
        bh=QuTUpPj32od8xKGnqQ9wp9FMjS5Eo+apjOKbMlh7Uxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehIiNthK9RfzTIMpxDyWMHdjLlSZ8lGreOKe7rbuk7lsb8k+0hLPdWrSKdd9dLBLN
         NMDRut1Z8V1M4TXwGIKFhtRu78zBNn43CNnKelY3Lc0+2mO3swKK5xHoWno59It7fV
         R+3wA2byJ1z0TdxwauqmqBtSkvBoa3KwRNOR0oKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Edich <andre.edich@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/109] smsc95xx: check return value of smsc95xx_reset
Date:   Tue, 14 Jul 2020 20:43:54 +0200
Message-Id: <20200714184107.964772377@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Edich <andre.edich@microchip.com>

[ Upstream commit 7c8b1e855f94f88a0c569be6309fc8d5c8844cd1 ]

The return value of the function smsc95xx_reset() must be checked
to avoid returning false success from the function smsc95xx_bind().

Fixes: 2f7ca802bdae2 ("net: Add SMSC LAN9500 USB2.0 10/100 ethernet adapter driver")
Signed-off-by: Andre Edich <andre.edich@microchip.com>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 3cf4dc3433f91..eb404bb74e18e 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1287,6 +1287,8 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	/* Init all registers */
 	ret = smsc95xx_reset(dev);
+	if (ret)
+		goto free_pdata;
 
 	/* detect device revision as different features may be available */
 	ret = smsc95xx_read_reg(dev, ID_REV, &val);
@@ -1317,6 +1319,10 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	schedule_delayed_work(&pdata->carrier_check, CARRIER_CHECK_DELAY);
 
 	return 0;
+
+free_pdata:
+	kfree(pdata);
+	return ret;
 }
 
 static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
-- 
2.25.1



