Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D2C3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C4D2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B8LQ0Ab8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBBPrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:47:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580658469; x=1612194469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L4nAHFKokWMKbsmdb2ayPfvOB5mMFhDgRN9aEfo+7Pk=;
  b=B8LQ0Ab8juFgT6O0o1eiSBsibVHOSCCE9lD92k/QpRQ113sij3m9Wxqo
   E2D0FXIk7SBBK7TQW3yPztd4/+EFltfJeFW9iHRpfwNZSNfYEzKjJwpbv
   7CQr3wTRR8odDkrixXqWR1b8uh94zCKIoU4j2vqsg5ykOQ4a81YB/ZnUR
   1dxm4xMFXwQqMz6lnUF+WIXJdSbGF8GwwE3CyH0feKyJuass3pECBcFuw
   rIPLOmFfcDkSdBBEIW+wy/fhfLaWw5TxFiS0VDheDN+xR1CTDqLVHZlFe
   pD3tqr8OkRjfj7stoTAjNQAA58JmJVE4XVh1b8fTh1gkXOxrp0BGcPe7A
   w==;
IronPort-SDR: vNC5X6Fb38EIFUvcooGcESefuoTsuEs9aoUqvF5/4e6fneZKZNtKCyRsvoi12QB9zAtyZrJKJ7
 wXRLGArNBZhLR/z1xTrL5B0kKaEqjL03BIs1VmuubpfndL3QD57ExrUJ7EW+XNTRt1RVhDsHp9
 CUqodYu5SyiqoODKZ6Dp9foQUaFNNSjNPkeEv2IKJgkLV/2rZhNGkNJjrwHVzzul/lzvqif4iX
 hqNPHWh8g6IcGQRPzk+A2RFoeuzvXjIdcbBb3bkB8aTz6bwjUeMXTC4k1OeRrgZ/eNTby1U/j+
 29w=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; 
   d="scan'208";a="128932829"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 23:47:49 +0800
IronPort-SDR: bnnmQnV+pzldgFGq94O11ekWuPWQV4Kmtm14iZaHSGbepA9ekMmQxjEbGX9VDBXSgrs3/wmEOm
 frDgUw+Hiu3rcYFsXDhC9CiHQCN2x8oR9YYSB2HIPQVLRpIu7ZoeC3UE26wUsKyteHnuoDR9zr
 y8LsM+IMGE4FV0Xe7elaqEkmonmS0LaVb0QEEqpSSnACjshiKyzD1GZw99Qa4GcU2YQMjSxPT3
 fq6cAMMV1grkfez6h8RVv+0OVAIgyVhWoCpevXnO4otDK2Ryjf2EK1m2oXyg4ZKHf4hF8qj4bJ
 LwoGTkcCwt0dxl79+uEElFEB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 07:40:56 -0800
IronPort-SDR: B/r68EzglUPwQie2uuavU0xLfRZSP17qXm4qK2q3ppnX+zvaMBeE+Fc8reU7gPvMBfnkad2JwM
 xJWe6FHyxNPxDwY6Us00hzU+XCv/TYytmYmUu69+mt8fN+azunSPqanWnXeaEZaLoHpNXMkHX1
 7UbmdRuVuGTnfEwbccXfoeqCA0vNl2l0Jvewx1qExj4iskpxWGdSyjYk1bbNqURHvLizmwYEH/
 vIq5hqVxwp8lBHP+xM7OfKWz/W+MgYt3GRUroAfKLFDkyWuWhbRchoiX9+198O1BA5U4sZaKw0
 GqA=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Feb 2020 07:47:47 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@swdc.com>,
        Uri Yanai <uri.yanai@wdc.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>
Subject: [PATCH 5/5] scsi: ufs: temperature atrributes add to ufs_sysfs
Date:   Sun,  2 Feb 2020 17:47:25 +0200
Message-Id: <1580658445-15232-6-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
References: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Shchislowski <avi.shchislowski@swdc.com>

Signed-off-by: Uri Yanai <uri.yanai@wdc.com>
Signed-off-by: Avi Shchislowski <avi.shchislowski@wdc.com>
---
 drivers/scsi/ufs/ufs-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index dbdf8b0..180f4db 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -667,6 +667,9 @@ static DEVICE_ATTR_RO(_name)
 UFS_ATTRIBUTE(ffu_status, _FFU_STATUS);
 UFS_ATTRIBUTE(psa_state, _PSA_STATE);
 UFS_ATTRIBUTE(psa_data_size, _PSA_DATA_SIZE);
+UFS_ATTRIBUTE(rough_temp, _ROUGH_TEMP);
+UFS_ATTRIBUTE(too_high_temp, _TOO_HIGH_TEMP);
+UFS_ATTRIBUTE(too_low_temp, _TOO_LOW_TEMP);
 
 static struct attribute *ufs_sysfs_attributes[] = {
 	&dev_attr_boot_lun_enabled.attr,
@@ -685,6 +688,9 @@ static DEVICE_ATTR_RO(_name)
 	&dev_attr_ffu_status.attr,
 	&dev_attr_psa_state.attr,
 	&dev_attr_psa_data_size.attr,
+	&dev_attr_rough_temp.attr,
+	&dev_attr_too_high_temp.attr,
+	&dev_attr_too_low_temp.attr,
 	NULL,
 };
 
-- 
1.9.1

