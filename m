Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693EDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C25204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457510;
	bh=hWzuh5MEsC2Obx12cfyar50VxkgrpxaqoloOCSelQv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MhV6Nv8IPFKDdi/dSYjhO+Dwo4szGPNjt/UHEdEyDGz/C25LjIH+L6wdU/Y7zY5xh
	 JX8ASrOuDuF+KW3tLeb0d9jbVi2T+bn4DGpigXyOoepUX9V99/S+yKcAexBDq98/Qp
	 9xpTFwICsHTEi5Rpk/+7nyh01QdEuec2UBYeCIho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHCMZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgHCMY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:24:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D919207BB;
        Mon,  3 Aug 2020 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457496;
        bh=hWzuh5MEsC2Obx12cfyar50VxkgrpxaqoloOCSelQv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2YqbrXHIiDwnpWBhZKtGmSveeljgOejfO0bsN3TA5YEicYqxqjxZCpzS6KgAT+uX/
         OARGem3yL2hZPumELLt4zfJck0xL70pfMisTkg1TAAn/cQjLb5lApllc0exh4KvKOZ
         A5AM88zhAHQBbKrb4rx+XGjRKYro56kpS4F0MKoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 062/120] net: lan78xx: add missing endpoint sanity check
Date:   Mon,  3 Aug 2020 14:18:40 +0200
Message-Id: <20200803121905.821812290@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8d8e95fd6d69d774013f51e5f2ee10c6e6d1fc14 ]

Add the missing endpoint sanity check to prevent a NULL-pointer
dereference should a malicious device lack the expected endpoints.

Note that the driver has a broken endpoint-lookup helper,
lan78xx_get_endpoints(), which can end up accepting interfaces in an
altsetting without endpoints as long as *some* altsetting has a bulk-in
and a bulk-out endpoint.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: Woojung.Huh@microchip.com <Woojung.Huh@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index eccbf4cd71496..d7162690e3f3d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3759,6 +3759,11 @@ static int lan78xx_probe(struct usb_interface *intf,
 	netdev->max_mtu = MAX_SINGLE_PACKET_SIZE;
 	netif_set_gso_max_size(netdev, MAX_SINGLE_PACKET_SIZE - MAX_HEADER);
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 3) {
+		ret = -ENODEV;
+		goto out3;
+	}
+
 	dev->ep_blkin = (intf->cur_altsetting)->endpoint + 0;
 	dev->ep_blkout = (intf->cur_altsetting)->endpoint + 1;
 	dev->ep_intr = (intf->cur_altsetting)->endpoint + 2;
-- 
2.25.1



