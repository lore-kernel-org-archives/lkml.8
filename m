Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07CE20738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mREfFYj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgFVOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:30:45 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:9948 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729126AbgFVOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:30:42 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MEP2ZE020796;
        Mon, 22 Jun 2020 10:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=J1g4xvWNe5bq4hXmUovFSL7jOukUWKFlWiaPq0XVZ9E=;
 b=mREfFYj+W41tQX2zFlfP8d3Z7NlfLpFov9C2LF+7hq4IrmfaoIti5ch5vcYIjXHbuSs4
 VEcIBo/h99aEo7EG1rYVzDSI8neUZhgOS59En0B2zJsmxYpHfGkRyF3GtH6zedeopdgS
 571wx1iOTXSfAjIFbJ54p+uKNvD5KOjCRGr5uJdpxWaodc4gp5ffNQ9iblWvxfEx1Rsp
 ChGEzoIB+a7mWNcOO6I4nkIgaagD/yHFB+ChR7LKjKQmw8IMcZzS/AHeoQjETXtyJ6BX
 b1H9G3ReymSicOyFIaMaTlmeTeXYWriIrudkqopIT7HJOvDPl6sBhFl5GC7eMrgmBqRs YA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31sdp8vvsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 10:30:41 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MESgwH074354;
        Mon, 22 Jun 2020 10:30:40 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 31sbqgt7s6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 10:30:40 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="513697118"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 1/2] thunderbolt: Add support for separating the flush to SPI and authenticate
Date:   Mon, 22 Jun 2020 09:30:34 -0500
Message-Id: <20200622143035.25327-2-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622143035.25327-1-mario.limonciello@dell.com>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_08:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220110
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220110
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
 drivers/thunderbolt/switch.c                  | 43 ++++++++++++-------
 drivers/thunderbolt/tb.h                      |  1 +
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 82e80de78dd0..26b15cbc9881 100644
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
+		- Writing "2" will only flush the image to the storage
+		area.
+
 		When read holds status of the last authentication
 		operation if an error occurred during the process. This
 		is directly the status value from the DMA configuration
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index d7d60cd9226f..4c476a58db38 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -27,6 +27,11 @@
 #define NVM_MIN_SIZE		SZ_32K
 #define NVM_MAX_SIZE		SZ_512K
 
+enum nvm_write_ops {
+	WRITE_AND_AUTHENTICATE = 1,
+	WRITE_ONLY = 2,
+};
+
 static DEFINE_IDA(nvm_ida);
 
 struct nvm_auth_status {
@@ -164,8 +169,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
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
@@ -371,6 +380,7 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 		}
 	}
 
+	sw->nvm->flushed = false;
 	sw->nvm->buf_data_size = offset + bytes;
 	memcpy(sw->nvm->buf + offset, val, bytes);
 
@@ -1536,7 +1546,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
-	bool val;
+	int val;
 	int ret;
 
 	pm_runtime_get_sync(&sw->dev);
@@ -1552,25 +1562,28 @@ static ssize_t nvm_authenticate_store(struct device *dev,
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
index 2eb2bcd3cca3..222ec19737fa 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -40,6 +40,7 @@ struct tb_switch_nvm {
 	void *buf;
 	size_t buf_data_size;
 	bool authenticating;
+	bool flushed;
 };
 
 #define TB_SWITCH_KEY_SIZE		32
-- 
2.25.1

