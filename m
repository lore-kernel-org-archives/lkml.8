Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2619EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC632495C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgEKK1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:27:21 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47408 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgEKK1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:27:20 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id 21C86CD464;
        Mon, 11 May 2020 13:27:18 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: fix over-read of ACPI UID from IVRS table
Date:   Mon, 11 May 2020 10:23:52 +0000
Message-Id: <20200511102352.1831-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/iommu/amd_iommu_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6be3853a5d97..faed3d35017a 100644
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
2.26.2

