Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A2B22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220553;
	bh=wdwwvVSenVt6N8xdd9g8pLjeeMvBztVrT/ceq7bgBaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q378gIdH9AzZRmRlxAwjSqdhak9puUTPtb+G3QfUtLbtMx/BzC3h3DouGR7LWvLLt
	 p5eSmAE1CXENHTrf90CQAuspHRYnaMOvKJ+MMceKBhLAad+xES9yOcxnuGNmuwAaB7
	 DKuYlk4pFc+YB3leIvuoDHFx96s8LSNeOTVwhH3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgA1OJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgA1OI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:08:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D195922522;
        Tue, 28 Jan 2020 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220539;
        bh=wdwwvVSenVt6N8xdd9g8pLjeeMvBztVrT/ceq7bgBaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfwPWkqSQUZoNUq7pB8rbUO1tZ0t8RUjhJCUl6obQJg/ZyjANagdLHNM0aUA8gViI
         na1TIqtt0OMfqKCrmzNTt7mDelWQcf6CWpvf2tI3MsqQzhgu02lWaNWNafppYDr8ZJ
         7eDhYD9GhT4Q9/zTzh7bdNPZ7nkQ+ixQfIgN/0zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 048/183] vfio_pci: Enable memory accesses before calling pci_map_rom
Date:   Tue, 28 Jan 2020 15:04:27 +0100
Message-Id: <20200128135834.766684922@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4b62eb3b59233..7a82735d53087 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -496,6 +496,7 @@ static long vfio_pci_ioctl(void *device_data,
 		{
 			void __iomem *io;
 			size_t size;
+			u16 orig_cmd;
 
 			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
 			info.flags = 0;
@@ -505,15 +506,23 @@ static long vfio_pci_ioctl(void *device_data,
 			if (!info.size)
 				break;
 
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



