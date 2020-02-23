Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDDBC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4082C208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KGfJM2NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBWJgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:36:02 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33764 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582450559; x=1613986559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=a5PZ/C/56H3nwY+rg0jdUjFtaNWinowZnLVddntgaoo=;
  b=KGfJM2NJ1w4yFx3IkhHGmQpkEQB/+1dUS7S1vrZlzBDTcqbKJDT/DnN2
   S5qKj3QVwQXzil3rm8d8pSPQxexnPKNn+lu8Ioc5GqiFG00JkJ9kGzNCV
   pcGUKkl0mPk6rNXB8lV7ZMKTW8bj7h75RY6XqJZUvdQ4TDY14iq4HkMhj
   57TckkjyWOUpt2vv4aSOder74yHcrDkfzX/bMqAUWGAukgxUMcp67BDhQ
   X3Ey1K2doOqdBM9ud86fUlk6ZZuCA/wKifK5NQfQS4/PAsToPIBge858t
   VrcX2ZKzXWFFfNPfp1oD/FUm6TOShVNZb7Y07mxhWbNNHDLEoJbzeizzO
   w==;
IronPort-SDR: tmNM59LVRTqXRSWIPuCv/f19MXdEbX10bg4fvIlqgnheukau3dES9OuHwxf4pws3ebvBfFy3kW
 YcCPqbc6Je7DbOQuyD1HJjazpmeAI8HG4Xb4LEROlR3+RjkwT2zPfeTeK58KBkvL6RzamoHU0k
 ccm/MATASqR2OG5qcM/Bx29RDIKgDmPgY1RjNJQHCneYEBvobR1v707QIKWvjHG4CSw6y1HHSZ
 Lh57u3TL1RsWgYy1VV1wDK0dn5my6qNmoE7Yn4XenW4nJQx60P9MgKIF30O42fUIVQHCh4ObZr
 Wmg=
X-IronPort-AV: E=Sophos;i="5.70,475,1574092800"; 
   d="scan'208";a="131020062"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2020 17:35:50 +0800
IronPort-SDR: PT1BdczDyP7p0FYIcVWFPPjaK67+dEgCuF4y76wIAXlyG8yLgSJAURU45Ukc0bYcEC4+w78vDW
 Vv9joAnDJjJYFFcBCuwynvlrfbx+dH1+u2w3achO2vBZnCmtApXivN/IgN4/BEvLTHr8yCDbVA
 WkUO3Qk2xxFZQlZc6kVySylgwz1nME29wgWpVyJmN8YhRFU3RUzYOcRx6UZYZDUl5ZNzp2b1ye
 1VHmliyMMKKY3k9F0WVikUFI3OTFIeJldr1udp7SQAVBROIbzmhoIVrbXNZAiw3thUK5t+0pzK
 3GKJrRwUBdElxIsetlFT5wg0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 01:28:20 -0800
IronPort-SDR: i0eD1Zm2pdjWfk8o50KTG7V3XFj/oPkk1LxVV2w4a5tk1TobIBtlyqehhYEy3Q+awmJ/Fv8r6L
 pibPB5aJr459l3G0h6YweoCd0P3MFLgmT24c15HFFr+V1WScbYl8VDa7kAWsgLcMICLE1p+osT
 Lqa0CVfmSu0a4fTSOgknMjkiow5h+xG17Pt38vkmi1DA0b36kgzFvy9quQu0m5igPzZmRFiu7E
 5f/sBz7ZEandBdrI0pSR4x/DuftnoxOp7q0tJmrVaA5VU8ymNnVftLf2lqzero65ZRbGD3b4aF
 m7U=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2020 01:35:45 -0800
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
Subject: [RESEND PATCH 5/5] scsi: ufs: temperature atrributes add to ufs_sysfs
Date:   Sun, 23 Feb 2020 11:35:22 +0200
Message-Id: <1582450522-13256-6-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
References: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Shchislowski <avi.shchislowski@sandisk.com>

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
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

