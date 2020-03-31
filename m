Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E22DC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24979208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646360;
	bh=RJWgcURUs3Z19QWXn0t+F1nFSi/KIiKBPPZsaqrFPzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fl32agnDpEo4FjMWS8dvypfYTfckzGOPm2kUjKheY7pKJGxTA/K+t7Iq/ruDbKe7/
	 J7eJ0IadNacJ4tF0HxGrZUV3xInmTOYui7/DtyLWfoMpjUqCtbwIia8CA7BDCLkn0G
	 rfMvLudmIXdyi8UrfmkiSgwkoJt8a4Yos/Q7SmLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbgCaJTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732201AbgCaJTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:19:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3751520787;
        Tue, 31 Mar 2020 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646350;
        bh=RJWgcURUs3Z19QWXn0t+F1nFSi/KIiKBPPZsaqrFPzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIxXFSBIDH3xvoKnwyza9GWpxi66+2UzXFFSHf2HnTCOwlj2uHjhWQcpXm4I9D7Jm
         YjgLsJHunpOPOV2zcZIBCFeXa/rVQi4XJyXlOtLQhOQ28PF7Cxrwkfy45uJ9Quqf+B
         jETdA1gBKdd56p2Obk4uThu+dPCcdxE2eK1ceFoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 149/155] ahci: Add Intel Comet Lake H RAID PCI ID
Date:   Tue, 31 Mar 2020 10:59:49 +0200
Message-Id: <20200331085434.816225586@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 32d2545462c6cede998267b86e57cda5d1dc2225 upstream.

Add the PCI ID to the driver list to support this new device.

Cc: stable@vger.kernel.org
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -393,6 +393,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
+	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */


