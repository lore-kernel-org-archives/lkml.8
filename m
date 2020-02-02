Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C42C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C71E206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RKYSDMBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgBBPrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:47:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580658459; x=1612194459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=J2CwgzRWIYLSpvNnhogUm4kTDIqaX6TbFTnNTEDWAng=;
  b=RKYSDMBLcPfYx5XGVjEFiQHiyvCpOAo2yG2R34BTntEtXxzGVTNl17pl
   mcSea1OUqNjaZsSwHhgc11isYZM458qzL68BXx4PmxKMCxOpC0DASmDtx
   Oc7gdZFjUzcfAfAUA/bv7CYyD2xJ8rBV6kqoVswlDQ+RZF/APx+l5FJuv
   x7uao6LffHKThE0I9vLiX2nHPASp6BkZZMzQz8M2X8FSaGeFKQcCaLY/5
   AGizLaHfUVbmgWBNyBPRDu4DHgLqX2WMr28gC+ZG/LXjHtvh/+devO4kI
   Cys/emmttX0rmQMg2c2tpWsVCcyD8YaJuyaBrWpEXf3v1P04Voj/FAJHG
   Q==;
IronPort-SDR: 6/+Jm3xVaFngCKOByxj/l6EhQaqYgKVT+2/RfVRUDVmwkEb8lCW4338IANIkq3oaN4I6HuF3al
 EFvlAVz01g6Z3o9ZtOk6yYYupLJtHeiQi2R9/7ofj+ZoKiS4RFskCQ8Qe63F2BMDD7LjVGs3Y5
 EW+9No0yOqEHcwXJyswIzIdrBFYC3+tjalVaaBkLWsdd5KaM0GuCi3be3XmFf8RMd4ovoRkpOU
 hpFYJQtf+UykODdhKli62dzKLxCLbMHyJbKhyI2hv/TTw3k3ctjmpV5q2OLf0+U7UWG1IK5g//
 I4A=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; 
   d="scan'208";a="128932821"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 23:47:39 +0800
IronPort-SDR: gTrott4zywmnjA0BXr7B1bYNNfWGhH18n94RCccK6Z5VWeckROi4c6ares4QENyM3WwiYJJiWw
 FkaJraA2ZLBI5wZeSftBw33yZJJdHloUl+uFLspBDoEB+wc4js1e1dbW5f0NTf3eM12XRIriBU
 P8MP09/R+IG6OzAdPIq5rB4sPYQNQT2WV0DZ0kwKmtpNzoyyWfIadPUaWByJFqfGNW/IwMXUdl
 EzuEq6+nj4DtkkMtRU2Z8B6M6c+KT+yoCUL4+RlmoVIbPmhPoBGCwEbtYR6kf02epsqYJVlMvL
 xGrBdQ0817pnrp5Lcr9HfjkU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 07:40:45 -0800
IronPort-SDR: r68cTnAKKRfRHof+sPcX1FclE68KsVqI4uKRWje6u+GmzDVIFgiuy3reo1gVLrtb4Hyw2Imgt/
 nM7pUhaPSR7qURPnbA83F0Ileswdcw5SeHVMcd3IhPyT0gNVHwPcFBikIvc3XtoOh51ldLntvA
 F9T7dI7gSz3UXMhdFLSZs/phkj/4GsV5xJhX5OpSNPdTjs8BwXLklouQFACW3eV/d9kYbrqEGX
 h7jIs+71ZrQ7OCEh7NRCx5Ko5/5qg7M84p9VaYbRQ7hyisJdRJuyui1GS8YdYQ3ysx5eBz32l7
 Z8I=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Feb 2020 07:47:37 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Uri Yanai <uri.yanai@wdc.com>
Subject: [PATCH 2/5] scsi: ufs: export ufshcd_enable_ee
Date:   Sun,  2 Feb 2020 17:47:22 +0200
Message-Id: <1580658445-15232-3-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
References: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

export ufshcd_enable_ee so that other modules can use it. this will
come handy in the next patch where we will need it to enable thermal
support

Signed-off-by: Uri Yanai <uri.yanai@wdc.com>
Signed-off-by: Avi Shchislowski <avi.shchislowski@wdc.com>
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

