Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C946C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AC02076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Pnc6feGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgFWQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:14:59 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:22296 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732253AbgFWQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:14:53 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NG6nTH022425;
        Tue, 23 Jun 2020 12:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=DTH18SvzrNB7/O2vrWKYQk5zb280Mwh2uYpgNkdhqB8=;
 b=Pnc6feGOtNI6AlG6x3Jb9kx7Loj7UiyWE9JNwMCOf/aGJtr9yPfAnJsXR0Edi9IImCZ0
 gYN0ZJReYtm9tfVRlVEGbcR5MGRW/cMOCgYvCHQ2H1An5cIP4bUcPxOpRTy6rtXRFFyD
 mXgN90dKgIQNLFbcvCWBHA+IDpEatcWT6nkvwATSCEfCp52amn3BR6fNlU8/0jhNSgli
 UgJlNfT0l1CmGsCUIdnhKPBfm752TBRi36Cldn0Mxnoqi3/KRFNBePK3z5BFgzGZtJSb
 sDs9comflAb9AFdJ2vRuBxqYRh+dDaguZXfuCvF8T0IxxAD8Gx7OxMUhGd+ameZpRwYw Bg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31uk320kdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 12:14:52 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NG5V5E109532;
        Tue, 23 Jun 2020 12:14:51 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 31uk2ejqd2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 12:14:51 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1568825313"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.yuan@dell.com, Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 1/2] thunderbolt: Add support for separating the flush to SPI and authenticate
Date:   Tue, 23 Jun 2020 11:14:28 -0500
Message-Id: <20200623161429.24214-2-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623161429.24214-1-mario.limonciello@dell.com>
References: <20200623161429.24214-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230120
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows userspace to have a shorter period of time that the device
is unusable and to call it at a more convenient time.

For example flushing the image may happen while the user is using the
machine and authenticating/rebooting may happen while logging out.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         | 11 ++++-
 drivers/thunderbolt/nvm.c                     |  1 +
 drivers/thunderbolt/switch.c                  | 42 ++++++++++++-------
 drivers/thunderbolt/tb.h                      |  2 +
 4 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index bd504ed323e8..7d0500b4d58a 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -178,11 +178,18 @@ KernelVersion:	4.13
 Contact:	thunderbolt-software@lists.01.org
 Description:	When new NVM image is written to the non-active NVM
 		area (through non_activeX NVMem device), the
-		authentication procedure is started by writing 1 to
-		this file. If everything goes well, the device is
+		authentication procedure is started by writing to
+		this file.
+		If everything goes well, the device is
 		restarted with the new NVM firmware. If the image
 		verification fails an error code is returned instead.
 
+		This file will accept writing values "1" or "2"
+		- Writing "1" will flush the image to the storage
+		area and authenticate the image in one action.
+		- Writing "2" will run some basic validation on the image
+		and flush it to the storage area.
+
 		When read holds status of the last authentication
 		operation if an error occurred during the process. This
 		is directly the status value from the DMA configuration
diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 4c6aa06ab3d5..29de6d95c6e7 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -100,6 +100,7 @@ int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
 			return -ENOMEM;
 	}
 
+	nvm->flushed = false;
 	nvm->buf_data_size = offset + bytes;
 	memcpy(nvm->buf + offset, val, bytes);
 	return 0;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 817c66c7adcf..bbfbfebeee7f 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -26,6 +26,11 @@ struct nvm_auth_status {
 	u32 status;
 };
 
+enum nvm_write_ops {
+	WRITE_AND_AUTHENTICATE = 1,
+	WRITE_ONLY = 2,
+};
+
 /*
  * Hold NVM authentication failure status per switch This information
  * needs to stay around even when the switch gets power cycled so we
@@ -155,8 +160,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
 	}
 
 	if (tb_switch_is_usb4(sw))
-		return usb4_switch_nvm_write(sw, 0, buf, image_size);
-	return dma_port_flash_write(sw->dma_port, 0, buf, image_size);
+		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
+	else
+		ret = dma_port_flash_write(sw->dma_port, 0, buf, image_size);
+	if (!ret)
+		sw->nvm->flushed = true;
+	return ret;
 }
 
 static int nvm_authenticate_host_dma_port(struct tb_switch *sw)
@@ -1488,7 +1497,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
-	bool val;
+	int val;
 	int ret;
 
 	pm_runtime_get_sync(&sw->dev);
@@ -1504,25 +1513,28 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 		goto exit_unlock;
 	}
 
-	ret = kstrtobool(buf, &val);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		goto exit_unlock;
 
 	/* Always clear the authentication status */
 	nvm_clear_auth_status(sw);
 
-	if (val) {
-		if (!sw->nvm->buf) {
-			ret = -EINVAL;
-			goto exit_unlock;
-		}
-
-		ret = nvm_validate_and_write(sw);
-		if (ret)
-			goto exit_unlock;
+	if (val > 0) {
+		if (!sw->nvm->flushed) {
+			if (!sw->nvm->buf) {
+				ret = -EINVAL;
+				goto exit_unlock;
+			}
 
-		sw->nvm->authenticating = true;
-		ret = nvm_authenticate(sw);
+			ret = nvm_validate_and_write(sw);
+			if (ret || val == WRITE_ONLY)
+				goto exit_unlock;
+		}
+		if (val == WRITE_AND_AUTHENTICATE) {
+			sw->nvm->authenticating = true;
+			ret = nvm_authenticate(sw);
+		}
 	}
 
 exit_unlock:
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 736d1589c31e..b04a2da9128b 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -39,6 +39,7 @@
  * @buf_data_size: Number of bytes actually consumed by the new NVM
  *		   image
  * @authenticating: The device is authenticating the new NVM
+ * @flushed: The image has been flushed to the storage area
  *
  * The user of this structure needs to handle serialization of possible
  * concurrent access.
@@ -53,6 +54,7 @@ struct tb_nvm {
 	void *buf;
 	size_t buf_data_size;
 	bool authenticating;
+	bool flushed;
 };
 
 #define TB_SWITCH_KEY_SIZE		32
-- 
2.25.1

