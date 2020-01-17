Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852A1C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE792082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cpiQVRq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgAQVV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:21:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60004 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:21:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00HLLJdd024057;
        Fri, 17 Jan 2020 15:21:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579296079;
        bh=ONsoTuB/2GclkLHgPRMr5rwXOyh+oEbisNCdNrkRWLU=;
        h=From:To:CC:Subject:Date;
        b=cpiQVRq1H+H+a6PYDafbcatf8gVlql4n/JDC/XV/AlYNLC4VixVvFowJ6vpH18Q98
         i4g9vHK7OZUVzt4m55EH6+wqJSPh4HWqAjK+PKLHDfIqDFyC8QzxobBLMqnoXi2ZSs
         sMq+pyJycY1z6q0+5EyrLXhRVCrvxevRn0HRHuyk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00HLLJ0d077243;
        Fri, 17 Jan 2020 15:21:19 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Jan 2020 15:21:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Jan 2020 15:21:19 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00HLLGoI093192;
        Fri, 17 Jan 2020 15:21:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Hongbo Yao <yaohongbo@huawei.com>
Subject: [PATCH] phy: ti: j721e-wiz: Fix build error without CONFIG_OF_ADDRESS
Date:   Sat, 18 Jan 2020 02:53:10 +0530
Message-ID: <20200117212310.2864-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongbo Yao <yaohongbo@huawei.com>

If CONFIG_OF_ADDRESS is not set and COMPILE_TEST=y, the following
error is seen while building phy-j721e-wiz.c

drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
phy-j721e-wiz.c:(.text+0x1a): undefined reference to
`of_platform_device_destroy'

Fix the config dependency for PHY_J721E_WIZ here.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 3a1d3887c99c..6dbe9d0b9ff3 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -36,6 +36,7 @@ config PHY_AM654_SERDES
 config PHY_J721E_WIZ
 	tristate "TI J721E WIZ (SERDES Wrapper) support"
 	depends on OF && ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM && OF_ADDRESS
 	depends on COMMON_CLK
 	select GENERIC_PHY
 	select MULTIPLEXER
-- 
2.17.1

