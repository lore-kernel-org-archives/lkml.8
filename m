Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D0EC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB19214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CVH8yKY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBWJfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:35:37 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58089 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582450537; x=1613986537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=y5/Gl/CvGsuxB0z8BsFf8LWlrYVDHgpEV9U+Dwmox/8=;
  b=CVH8yKY+Ci4AL9r1rifl+H5AdmmchIQQ5S+rwwyWRCIP0ckaU82348U8
   BqIDtpqenvVVhZ+mhjsqvUaO0fVQ0jav2qpyIlVFiTB8e1O71Q9X26EXs
   4pCzSCBLRoFqtEdIn2xe8PVOOSDzVZDDAA7JCHKbQ00BrFMKXNpx0yzZ7
   AET8xDu6Xj1YM57cmNjKIrijExCJNrckYf8vbD3knIBdbEotxPp3151Nt
   Y+48QHj7uqQ4ONcWfGv1Q21Jkh3ckoimTDCqLPlDlixppXUW+DvWv0cRk
   Kisx3gmf5vNIhgBJ0Lb3HtEP3aRiYBx1mrY2CPciozZzrlyprGJeswJtw
   w==;
IronPort-SDR: i/vqQZ2G2BCjaOzuaHYODXTxuTbTzT+LnAQxjnQ5Ln2Z+BTXt4X+FzC0A97dBReGz6R3THrr1z
 ooKUlJtl+YZzNtMaad5olI8Zkyb8HKuSyYLMvCcBATw8JHyeFg8d8+mI+zzmj9qIMOBfmwLaYE
 uD/u5njZRohkHRgfvbEKNcf2gqyTDui2X0LINRe8FE+VdZ8iiDvFiI9ihkJW4cWXB0OxcokXtT
 ZDwRE6RzZ59B5/pHRZiti/IA928uNl8JP9xrS/FjdXlaTOBj14lgWpcuvulJHr549TW6KV8Fdk
 iOE=
X-IronPort-AV: E=Sophos;i="5.70,475,1574092800"; 
   d="scan'208";a="131020046"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2020 17:35:37 +0800
IronPort-SDR: JHZmdSsZO0cfCh0EQ242D2MHNHsD5KhLYbduDeFiXKyM+EUbwZx/9RwThO2SZpnelmXLb0l7Nm
 C/QgaUJ7LO53F41TXGwUA4fiC5lRMTXSYQ/DrYNyJA3cO81I8QRhV4nOEQmOpPfJS7C0yeQm58
 g65Vg9OzTgZYLRiLLcvOIzuUzkFgM5Py7r53VTsDJnbHJACwnx0q1pAEok3gDaAH5H/0mpW7dH
 WDGJu6biAmud+1iWKjY4ubgQ5UVGk+YSVSKB9TsURv/EELOJKEGnxRbWVcIpVw859fzyYpvCUd
 Ejs/EEWcxAx3xuP3w/SZjJIg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 01:28:07 -0800
IronPort-SDR: GQF2k/X53d0COFb+4YBa/IJprvc29QNwEadFYRc6GQAqjAM6ENQbnO2PCsE7/gM/Dz62I2P/tU
 Y5XnERM3XZ4hdXXORUmP8JuoparwL9p9kK1Bz0l/CZteR/P5T2HiROZgJLj6xzi2DsPeM3gKSt
 CPNbcmyVmnvtgyQYjZvLAByGuGXZtIKfHuwUZKjXnPUrpF6Sqph9u1hmIRJ5V1bndKguIiY72C
 FIBZBLe3frAOZOSB82W2rZ7/lgpVDAMUIIjW8sFd5/kkoaUAttGOW2Vts3zJ2qM2rUTu9rAbNt
 QfE=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2020 01:35:32 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, avri.altman@wdc.com,
        avi.shchislowski@wdc.com
Cc:     Avi.shchislowski@wdc.com,
        Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: [RESEND PATCH 2/5] scsi: ufs: export ufshcd_enable_ee
Date:   Sun, 23 Feb 2020 11:35:19 +0200
Message-Id: <1582450522-13256-3-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
References: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Shchislowski <avi.shchislowski@sandisk.com>

export ufshcd_enable_ee so that other modules can use it. this will
come handy in the next patch where we will need it to enable thermal
support

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 drivers/scsi/ufs/ufshcd.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 099d2de..f25b93c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4923,7 +4923,7 @@ static int ufshcd_disable_ee(struct ufs_hba *hba, u16 mask)
  *
  * Returns zero on success, non-zero error value on failure.
  */
-static int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
+int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
 {
 	int err = 0;
 	u32 val;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 28c0063..6d2a5fd 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -960,6 +960,8 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     u8 *desc_buff, int *buff_len,
 			     enum query_opcode desc_op);
 
+int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask);
+
 /* Wrapper functions for safely calling variant operations */
 static inline const char *ufshcd_get_var_name(struct ufs_hba *hba)
 {
-- 
1.9.1

