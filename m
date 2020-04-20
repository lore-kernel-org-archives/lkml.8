Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426A4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD0E20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgDTU1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:27:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726766AbgDTU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:26:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KK3TZe074910;
        Mon, 20 Apr 2020 16:26:19 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gcs3mgum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 16:26:19 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03KKPiJe013625;
        Mon, 20 Apr 2020 20:26:19 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 30fs66gh6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 20:26:19 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KKQI9040108318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 20:26:18 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284BCAE05C;
        Mon, 20 Apr 2020 20:26:18 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 328A8AE05F;
        Mon, 20 Apr 2020 20:26:17 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.56.120])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 20:26:17 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v10 4/7] soc: aspeed: xdma: Add reset ioctl
Date:   Mon, 20 Apr 2020 15:26:08 -0500
Message-Id: <20200420202611.17776-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200420202611.17776-1-eajames@linux.ibm.com>
References: <20200420202611.17776-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_07:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of the XDMA engine need a way to reset it if something goes wrong.
Problems on the host side, or user error, such as incorrect host
address, may result in the DMA operation never completing and no way to
determine what went wrong. Therefore, add an ioctl to reset the engine
so that users can recover in this situation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/soc/aspeed/aspeed-xdma.c | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index adfb9e13c8b9..64e1c70e046d 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -648,6 +648,37 @@ static __poll_t aspeed_xdma_poll(struct file *file,
 	return mask;
 }
 
+static long aspeed_xdma_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long param)
+{
+	unsigned long flags;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	switch (cmd) {
+	case ASPEED_XDMA_IOCTL_RESET:
+		spin_lock_irqsave(&ctx->engine_lock, flags);
+		if (ctx->in_reset) {
+			spin_unlock_irqrestore(&ctx->engine_lock, flags);
+			return 0;
+		}
+
+		ctx->in_reset = true;
+		spin_unlock_irqrestore(&ctx->engine_lock, flags);
+
+		if (READ_ONCE(ctx->current_client))
+			dev_warn(ctx->dev,
+				 "User reset with transfer in progress.\n");
+
+		aspeed_xdma_reset(ctx);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
 {
 	int rc;
@@ -742,6 +773,7 @@ static const struct file_operations aspeed_xdma_fops = {
 	.owner			= THIS_MODULE,
 	.write			= aspeed_xdma_write,
 	.poll			= aspeed_xdma_poll,
+	.unlocked_ioctl		= aspeed_xdma_ioctl,
 	.mmap			= aspeed_xdma_mmap,
 	.open			= aspeed_xdma_open,
 	.release		= aspeed_xdma_release,
diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
index 2efaa6067c39..3a3646fd1e9e 100644
--- a/include/uapi/linux/aspeed-xdma.h
+++ b/include/uapi/linux/aspeed-xdma.h
@@ -4,8 +4,12 @@
 #ifndef _UAPI_LINUX_ASPEED_XDMA_H_
 #define _UAPI_LINUX_ASPEED_XDMA_H_
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
+#define __ASPEED_XDMA_IOCTL_MAGIC	0xb7
+#define ASPEED_XDMA_IOCTL_RESET		_IO(__ASPEED_XDMA_IOCTL_MAGIC, 0)
+
 /*
  * aspeed_xdma_direction
  *
-- 
2.24.0

