Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ABEC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F12467C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194091;
	bh=Ax2ffis9kznwGy7kUOrBcp+PGfdjZDSEq2lQ9R9XU+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jU+gauJ7F1fY0tFzBhVp+XAlj7RoQ4Tzn+PrHgNbzik86oLYkbgZHSjKYnhXGfw2D
	 Y01W/B3to2WOKYnDEuf/evR3Omy7FLgyFHMUhP7kEDlUfiK21NjaBNg+5gTvy7gSsr
	 jJ87Urn74E8avnuqZwCS07/Dtzkkx31Ilir2mqrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAPRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbgAPRBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2881E2464B;
        Thu, 16 Jan 2020 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194084;
        bh=Ax2ffis9kznwGy7kUOrBcp+PGfdjZDSEq2lQ9R9XU+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7IoOYfGweEINme15bYodpm3de8r4Us2ScfK6Op5BO/0uPdcD33tvjLx9PqFVXYct
         rr3td3PhP8EY7aRUMkxY8XVccZmEAXMsn5jd4gH5nK2MNY+AjWQvJ5RLqIht3bppAQ
         Evratd6lc/hqvQCKTQFg55YceygLb1OPGOmEqrzk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 189/671] vfio_pci: Enable memory accesses before calling pci_map_rom
Date:   Thu, 16 Jan 2020 11:51:38 -0500
Message-Id: <20200116165940.10720-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Auger <eric.auger@redhat.com>

[ Upstream commit 0cfd027be1d6def4a462cdc180c055143af24069 ]

pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
In case the Memory Space accesses were disabled, readw() is likely
to trigger a synchronous external abort on some platforms.

In case memory accesses were disabled, re-enable them before the
call and disable them back again just after.

Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0a6eb53e79fb..66783a37f450 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -696,6 +696,7 @@ static long vfio_pci_ioctl(void *device_data,
 		{
 			void __iomem *io;
 			size_t size;
+			u16 orig_cmd;
 
 			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
 			info.flags = 0;
@@ -711,15 +712,23 @@ static long vfio_pci_ioctl(void *device_data,
 					break;
 			}
 
-			/* Is it really there? */
+			/*
+			 * Is it really there?  Enable memory decode for
+			 * implicit access in pci_map_rom().
+			 */
+			pci_read_config_word(pdev, PCI_COMMAND, &orig_cmd);
+			pci_write_config_word(pdev, PCI_COMMAND,
+					      orig_cmd | PCI_COMMAND_MEMORY);
+
 			io = pci_map_rom(pdev, &size);
-			if (!io || !size) {
+			if (io) {
+				info.flags = VFIO_REGION_INFO_FLAG_READ;
+				pci_unmap_rom(pdev, io);
+			} else {
 				info.size = 0;
-				break;
 			}
-			pci_unmap_rom(pdev, io);
 
-			info.flags = VFIO_REGION_INFO_FLAG_READ;
+			pci_write_config_word(pdev, PCI_COMMAND, orig_cmd);
 			break;
 		}
 		case VFIO_PCI_VGA_REGION_INDEX:
-- 
2.20.1

