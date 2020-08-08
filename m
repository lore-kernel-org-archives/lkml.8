Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCEBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9C9206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PE0cKnHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgHHMus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgHHMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:50:31 -0400
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C9C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 05:50:29 -0700 (PDT)
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by forward.mxwww.masterlogin.de (Postfix) with ESMTPS id A7D9596281;
        Sat,  8 Aug 2020 12:50:19 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id 725683FEAF;
        Sat,  8 Aug 2020 12:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1596891019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wj2UayRDflcnw5kUmZA37cOx3/QYiW/w9iZEs90Vdzw=;
        b=PE0cKnHyhUjOHIKjyvMjunDc16plM449cKob0oqnP5TFPVjNbqPmHxAN3F+kLXiGV8uZnf
        W0I5cMu7yoZkdufBKMuprfRu+s89EWgUenGcDqVljGo5+oPZqFrEm5w8MK/LP9dvZRk44S
        RoLgsP5qDSGitsksqA0Nl9vipEs29/M=
Received: from localhost.localdomain (fttx-pool-217.61.152.39.bambit.de [217.61.152.39])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id D25358018E;
        Sat,  8 Aug 2020 12:50:18 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci-mtk: Fix typo
Date:   Sat,  8 Aug 2020 14:49:06 +0200
Message-Id: <20200808124906.89976-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

fix this small typo u3_ports_disabed => u3_ports_disabled

Fixes: 55ba6e9e25a6 (usb: xhci-mtk: support option to disable usb3 ports)
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/usb/host/xhci-mtk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 4311d4c9b68d..8f321f39ab96 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -77,7 +77,7 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 {
 	struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
 	u32 value, check_val;
-	int u3_ports_disabed = 0;
+	int u3_ports_disabled = 0;
 	int ret;
 	int i;
 
@@ -92,7 +92,7 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 	/* power on and enable u3 ports except skipped ones */
 	for (i = 0; i < mtk->num_u3_ports; i++) {
 		if ((0x1 << i) & mtk->u3p_dis_msk) {
-			u3_ports_disabed++;
+			u3_ports_disabled++;
 			continue;
 		}
 
@@ -117,7 +117,7 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 	check_val = STS1_SYSPLL_STABLE | STS1_REF_RST |
 			STS1_SYS125_RST | STS1_XHCI_RST;
 
-	if (mtk->num_u3_ports > u3_ports_disabed)
+	if (mtk->num_u3_ports > u3_ports_disabled)
 		check_val |= STS1_U3_MAC_RST;
 
 	ret = readl_poll_timeout(&ippc->ip_pw_sts1, value,
-- 
2.25.1

