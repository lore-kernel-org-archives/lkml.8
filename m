Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C42206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHZGyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:54:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbgHZGyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:54:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A604E763DA31AF03A3C;
        Wed, 26 Aug 2020 14:54:02 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 14:53:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <masahiroy@kernel.org>,
        <bjorn@mork.no>, <miguel@det.uvigo.gal>
CC:     <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] net: cdc_ncm: Fix build error
Date:   Wed, 26 Aug 2020 14:52:31 +0800
Message-ID: <20200826065231.14344-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If USB_NET_CDC_NCM is y and USB_NET_CDCETHER is m, build fails:

drivers/net/usb/cdc_ncm.o:(.rodata+0x1d8): undefined reference to `usbnet_cdc_update_filter'

Select USB_NET_CDCETHER for USB_NET_CDC_NCM to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e10dcb1b6ba7 ("net: cdc_ncm: hook into set_rx_mode to admit multicast traffic")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index a7fbc3ccd29e..c7bcfca7d70b 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -252,6 +252,7 @@ config USB_NET_CDC_EEM
 config USB_NET_CDC_NCM
 	tristate "CDC NCM support"
 	depends on USB_USBNET
+	select USB_NET_CDCETHER
 	default y
 	help
 	  This driver provides support for CDC NCM (Network Control Model
-- 
2.17.1


