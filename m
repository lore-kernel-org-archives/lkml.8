Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A082084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE1B5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:57:46 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:9113 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbgE1B5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:57:43 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 May 2020 18:54:49 -0700
Received: from ubuntu.eng.vmware.com (unknown [10.20.113.240])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 7190E402C2;
        Wed, 27 May 2020 18:54:52 -0700 (PDT)
From:   Ronak Doshi <doshir@vmware.com>
To:     <netdev@vger.kernel.org>
CC:     Ronak Doshi <doshir@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 4/4] vmxnet3: update to version 4
Date:   Wed, 27 May 2020 18:54:26 -0700
Message-ID: <20200528015426.8285-5-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200528015426.8285-1-doshir@vmware.com>
References: <20200528015426.8285-1-doshir@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: doshir@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all vmxnet3 version 4 changes incorporated in the vmxnet3 driver,
the driver can configure emulation to run at vmxnet3 version 4, provided
the emulation advertises support for version 4.

Signed-off-by: Ronak Doshi <doshir@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 7 ++++++-
 drivers/net/vmxnet3/vmxnet3_int.h | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 8930717bdcf1..58ac63783b28 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3492,7 +3492,12 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 		goto err_alloc_pci;
 
 	ver = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_VRRS);
-	if (ver & (1 << VMXNET3_REV_3)) {
+	if (ver & (1 << VMXNET3_REV_4)) {
+		VMXNET3_WRITE_BAR1_REG(adapter,
+				       VMXNET3_REG_VRRS,
+				       1 << VMXNET3_REV_4);
+		adapter->version = VMXNET3_REV_4 + 1;
+	} else if (ver & (1 << VMXNET3_REV_3)) {
 		VMXNET3_WRITE_BAR1_REG(adapter,
 				       VMXNET3_REG_VRRS,
 				       1 << VMXNET3_REV_3);
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 86db809c7592..5d2b062215a2 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,12 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.17.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.5.0.0-k"
 
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01041100
+#define VMXNET3_DRIVER_VERSION_NUM      0x01050000
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.11.0

