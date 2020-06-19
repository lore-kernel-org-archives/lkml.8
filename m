Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A456DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EA02193E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578965;
	bh=XWha5jXmnuxZxzTaqc8WB8sPmWy5ZZSU3aqYtCVwTZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kWJSPzFTrJGwUP46ohmc0/2QfWRyCJk5epjm325A40MdkYF35PuLPV5JnnPLrZ4vE
	 vAYkUfM84iZ+E7c9obXYf81zYqAOe2cf6lBksWDV2Rouy1I0W5uxmVfXVUzTuIkDzu
	 MyW1z73bX7suHB9T0j9cV8BQiXlS0Ikvs70fPY0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbgFSPCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390773AbgFSPCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:02:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0036206DB;
        Fri, 19 Jun 2020 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578923;
        bh=XWha5jXmnuxZxzTaqc8WB8sPmWy5ZZSU3aqYtCVwTZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azR8cR83HJHEXWRTyzM9xiFGJbVE5QeYHUtLOMmOxXj7w1jxw/9zz7lIjEd119cye
         8qqbsj2qWaQ3KRzArU/HaSISVTjOpfO8LTlakBSR8NPo4/JOLRJlr6GpMQl3ZMo3Wr
         wwN2XyBUXgTqxa4zqW13FCeHKOIXOzGudT9sV1MY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 208/267] PCI: add USR vendor id and use it in r8169 and w6692 driver
Date:   Fri, 19 Jun 2020 16:33:13 +0200
Message-Id: <20200619141658.711479858@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 9206eb0bc5679d06d2f54b9db86fe2b9a55e07e4 ]

The PCI vendor id of U.S. Robotics isn't defined in pci_ids.h so far,
only ISDN driver w6692 has a private definition. Move the definition
to pci_ids.h and use it in the r8169 driver too.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/mISDN/w6692.c  | 3 ---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 include/linux/pci_ids.h              | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index 5acf6ab67cd3..6f60aced11c5 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -52,10 +52,7 @@ static const struct w6692map  w6692_map[] =
 	{W6692_USR, "USR W6692"}
 };
 
-#ifndef PCI_VENDOR_ID_USR
-#define PCI_VENDOR_ID_USR	0x16ec
 #define PCI_DEVICE_ID_USR_6692	0x3409
-#endif
 
 struct w6692_ch {
 	struct bchannel		bch;
diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 807ef43a3cda..6df404e3dd27 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -229,7 +229,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4300), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4302), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AT,		0xc107), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(0x16ec,			0x0116), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_USR,		0x0116), 0, 0, RTL_CFG_0 },
 	{ PCI_VENDOR_ID_LINKSYS,		0x1032,
 		PCI_ANY_ID, 0x0024, 0, 0, RTL_CFG_0 },
 	{ 0x0001,				0x8168,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 81c7af243a31..2792bca03088 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2362,6 +2362,8 @@
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
 
+#define PCI_VENDOR_ID_USR		0x16ec
+
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
 
-- 
2.25.1



