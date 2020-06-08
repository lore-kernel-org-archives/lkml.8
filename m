Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FF5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B02207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663002;
	bh=ECHHm1tjjPiVV5BIUfnlAx1LvvWnDMygf0UXIqwcJhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v3prDSQE+VTaEi6BflPv4czxq85Rk57gWHbcAYBiUD7Y4cwebkNmiMcC1Oa16IFmc
	 Z6YPGpb4mIY3JwOHjlQmgGPMYtDUfVNa6yawvlUWnc3T628HIVkanQmXK6EJJG0bhz
	 Vq8JWAarqpiDWdeoGl98a7v7YhA9/IZljNM+rk1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbgFIAgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgFHXOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7027621534;
        Mon,  8 Jun 2020 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658044;
        bh=ECHHm1tjjPiVV5BIUfnlAx1LvvWnDMygf0UXIqwcJhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxiJfB+aOzmDkY22060RMIx+9bC5XSiqscH6AYhC8gbIWVsetw0Rao8qv1pXQKxW3
         DmF6rzk+ov0KbIZUfvDgOEk/nG4/UwrozNxdo2wx0JIjrnAz6igRvhQ52UILenXsZb
         Ue7ywNp4OtFqiIut8Lfi6Ut8KFiTUfSHv+3TfHs0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 093/606] iommu/amd: Fix over-read of ACPI UID from IVRS table
Date:   Mon,  8 Jun 2020 19:03:38 -0400
Message-Id: <20200608231211.3363633-93-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Monakov <amonakov@ispras.ru>

[ Upstream commit e461b8c991b9202b007ea2059d953e264240b0c9 ]

IVRS parsing code always tries to read 255 bytes from memory when
retrieving ACPI device path, and makes an assumption that firmware
provides a zero-terminated string. Both of those are bugs: the entry
is likely to be shorter than 255 bytes, and zero-termination is not
guaranteed.

With Acer SF314-42 firmware these issues manifest visibly in dmesg:

AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0\xf0\xa5, rdevid:160
AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1\xf0\xa5, rdevid:160
AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2\xf0\xa5, rdevid:160
AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3>\x83e\x8d\x9a\xd1...

The first three lines show how the code over-reads adjacent table
entries into the UID, and in the last line it even reads garbage data
beyond the end of the IVRS table itself.

Since each entry has the length of the UID (uidl member of ivhd_entry
struct), use that for memcpy, and manually add a zero terminator.

Avoid zero-filling hid and uid arrays up front, and instead ensure
the uid array is always zero-terminated. No change needed for the hid
array, as it was already properly zero-terminated.

Fixes: 2a0cb4e2d423c ("iommu/amd: Add new map for storing IVHD dev entry type HID")

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Link: https://lore.kernel.org/r/20200511102352.1831-1-amonakov@ispras.ru
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 2b9a67ecc6ac..5b81fd16f5fa 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1329,8 +1329,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		}
 		case IVHD_DEV_ACPI_HID: {
 			u16 devid;
-			u8 hid[ACPIHID_HID_LEN] = {0};
-			u8 uid[ACPIHID_UID_LEN] = {0};
+			u8 hid[ACPIHID_HID_LEN];
+			u8 uid[ACPIHID_UID_LEN];
 			int ret;
 
 			if (h->type != 0x40) {
@@ -1347,6 +1347,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
+			uid[0] = '\0';
 			switch (e->uidf) {
 			case UID_NOT_PRESENT:
 
@@ -1361,8 +1362,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			case UID_IS_CHARACTER:
 
-				memcpy(uid, (u8 *)(&e->uid), ACPIHID_UID_LEN - 1);
-				uid[ACPIHID_UID_LEN - 1] = '\0';
+				memcpy(uid, &e->uid, e->uidl);
+				uid[e->uidl] = '\0';
 
 				break;
 			default:
-- 
2.25.1

