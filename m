Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556EAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275CA20885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446659;
	bh=ovU23r/Etbj70jTV5pACK96PBP4+CkrG2+2V3Ar5ZZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pB2kTO2GhSNn5IDybTGQvJlVfv+/cSmnS05cTxFHQ4mpVKUV3r2FiM/A8HQcJaAVX
	 w4ZfeuCn0/GPp3Lf8IS/nS0UPJxhUB8aDBGy9goN68pbxX/cBX1nFTOM+2E6AuyapC
	 g97L6385H5+Qdm0PlW5bQ+a5lxBM2yuvXsWq8PA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgFRCRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbgFRBTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D1221D90;
        Thu, 18 Jun 2020 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443193;
        bh=ovU23r/Etbj70jTV5pACK96PBP4+CkrG2+2V3Ar5ZZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2uhbmvWyUEqBGQOfhuDOJiO5DLzDBCCWwlmwKQGOfpnCQE0kzBd2SMknNyrxyUBs
         X3ekBRGGCRn/XhN6G31aGK1yGz4RVWouYLhBxu7GY77bBfwJlTiARkKtGASg7F4eu2
         1/q/JplJfz1TyzIEH9oSgnnvKVhI3f1bJajBhrkg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 154/266] vfio-pci: Mask cap zero
Date:   Wed, 17 Jun 2020 21:14:39 -0400
Message-Id: <20200618011631.604574-154-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit bc138db1b96264b9c1779cf18d5a3b186aa90066 ]

The PCI Code and ID Assignment Specification changed capability ID 0
from reserved to a NULL capability in the v1.1 revision.  The NULL
capability is defined to include only the 16-bit capability header,
ie. only the ID and next pointer.  Unfortunately vfio-pci creates a
map of config space, where ID 0 is used to reserve the standard type
0 header.  Finding an actual capability with this ID therefore results
in a bogus range marked in that map and conflicts with subsequent
capabilities.  As this seems to be a dummy capability anyway and we
already support dropping capabilities, let's hide this one rather than
delving into the potentially subtle dependencies within our map.

Seen on an NVIDIA Tesla T4.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index c4d0cf9a1ab9..d6359c37c9e5 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1460,7 +1460,12 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
 		if (ret)
 			return ret;
 
-		if (cap <= PCI_CAP_ID_MAX) {
+		/*
+		 * ID 0 is a NULL capability, conflicting with our fake
+		 * PCI_CAP_ID_BASIC.  As it has no content, consider it
+		 * hidden for now.
+		 */
+		if (cap && cap <= PCI_CAP_ID_MAX) {
 			len = pci_cap_length[cap];
 			if (len == 0xFF) { /* Variable length */
 				len = vfio_cap_len(vdev, cap, pos);
-- 
2.25.1

