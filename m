Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BCFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29CE2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406452AbgFYTQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:16:04 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:46231 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405969AbgFYTQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:16:04 -0400
Received: from localhost.localdomain ([93.22.134.133])
        by mwinf5d42 with ME
        id vXFw2200S2sr5ud03XFxJK; Thu, 25 Jun 2020 21:16:00 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Jun 2020 21:16:00 +0200
X-ME-IP: 93.22.134.133
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     stefanr@s5r6.in-berlin.de, krh@bitplanet.net, hch@infradead.org
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V2] firewire: nosy: Fix the amount of memory deallocated by some 'pci_free_consistent' calls
Date:   Thu, 25 Jun 2020 21:15:54 +0200
Message-Id: <20200625191554.941614-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624192325.940280-1-christophe.jaillet@wanadoo.fr>
References: <20200624192325.940280-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'lynx->pci_device' is allocated with a size of RCV_BUFFER_SIZE. This is to
say (16 * 1024).

Pass the same size when it is freed.

Fixes: 286468210d83 ("firewire: new driver: nosy - IEEE 1394 traffic sniffer")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: move the #define RCV_BUFFER_SIZE at the top of the file so that it is
    defined when used in 'remove_card()'
    Spotted by kernel test robot <lkp@intel.com>
---
 drivers/firewire/nosy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index 5fd6a60b6741..2fe34a2ce7cc 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -36,6 +36,8 @@
 
 static char driver_name[] = KBUILD_MODNAME;
 
+#define RCV_BUFFER_SIZE (16 * 1024)
+
 /* this is the physical layout of a PCL, its size is 128 bytes */
 struct pcl {
 	__le32 next;
@@ -510,7 +512,7 @@ remove_card(struct pci_dev *dev)
 			    lynx->rcv_start_pcl, lynx->rcv_start_pcl_bus);
 	pci_free_consistent(lynx->pci_device, sizeof(struct pcl),
 			    lynx->rcv_pcl, lynx->rcv_pcl_bus);
-	pci_free_consistent(lynx->pci_device, PAGE_SIZE,
+	pci_free_consistent(lynx->pci_device, RCV_BUFFER_SIZE,
 			    lynx->rcv_buffer, lynx->rcv_buffer_bus);
 
 	iounmap(lynx->registers);
@@ -518,8 +520,6 @@ remove_card(struct pci_dev *dev)
 	lynx_put(lynx);
 }
 
-#define RCV_BUFFER_SIZE (16 * 1024)
-
 static int
 add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 {
@@ -668,7 +668,7 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 		pci_free_consistent(lynx->pci_device, sizeof(struct pcl),
 				lynx->rcv_pcl, lynx->rcv_pcl_bus);
 	if (lynx->rcv_buffer)
-		pci_free_consistent(lynx->pci_device, PAGE_SIZE,
+		pci_free_consistent(lynx->pci_device, RCV_BUFFER_SIZE,
 				lynx->rcv_buffer, lynx->rcv_buffer_bus);
 	iounmap(lynx->registers);
 
-- 
2.25.1

