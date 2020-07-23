Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DCC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5657B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgGWR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:29:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56394 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgGWR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:29:38 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jyf1z-0001YW-VR; Thu, 23 Jul 2020 17:29:20 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        kyounghwan sohn <kyounghwan.sohn@sk.com>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] nvme/pci: Prevent SK hynix PC400 from using Write Zeroes command
Date:   Fri, 24 Jul 2020 01:29:10 +0800
Message-Id: <20200723172910.28350-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723155731.22313-1-kai.heng.feng@canonical.com>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
command"), SK hynix PC400 becomes very slow with the following error
message:
[  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]

SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
of a range, so the NLB passed isn't a valid value to the firmware.

According to SK hynix there are three commands are affected:
- Write Zeroes
- Compare
- Write Uncorrectable

Right now only Write Zeroes is implemented, so disable it completely on
SK hynix PC400.

BugLink: https://bugs.launchpad.net/bugs/1872383
Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
- Simply disable Write Zeroes command.

v2:
- SK hynix found the root cause so change the approach accordingly.
- lspci is wrong, the device is PC400 instead of SC300.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..25a187e43dbe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3122,6 +3122,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
-- 
2.17.1

