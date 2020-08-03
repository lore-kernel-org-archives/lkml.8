Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85AF2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gLohY7k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgHCOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:36:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:36:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073ERxgj053670;
        Mon, 3 Aug 2020 14:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=w46iEBwp3HuFZAesLfmw1uLgFfsQjo4Ft7S0gSZrADI=;
 b=gLohY7k10p33fYDTZ7EvlRJbAeTxGcdDs/nQEu1M5eIK+j2uYw06H2qJBpvCpvooHDYn
 8sRdEVx5fYqODjiACr3Bh4xeISMpQKfij8SRK+x0X2CdH74A9JNUy7yppxZcFvPSOL3G
 7j+3zdnVFQH0DNjt4xlIwyWiD65Cxbg4WiKWJtoylzpyrYvTQONlHY2B+mD6qDOUX+Qd
 l711KOt/pznWJZ8w+qw5R9msBhyW2onmEL0tu6FIfqW7hBUkJKUeunr68m02xz5BLH6J
 0xzhUfR+Nsc4ebuwIG+FizcpFHGdHnTL31DMYDZRdZPtm3OCbkwdzNEqCkpmC8annEw/ 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11mxr1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 14:36:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073EWtSQ040039;
        Mon, 3 Aug 2020 14:36:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32pdhahkvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 14:36:45 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073Eaiew020885;
        Mon, 3 Aug 2020 14:36:44 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 07:36:43 -0700
Date:   Mon, 3 Aug 2020 17:36:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] habanalabs: Fix memory corruption in debugfs
Message-ID: <20200803143636.GD346925@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has to be a long instead of a u32 because we write a long value.
On 64 bit systems, this will cause memory corruption.

Fixes: c216477363a3 ("habanalabs: add debugfs support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/habanalabs/common/debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 71cfe1b6fafc..ecd37b427480 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -19,7 +19,7 @@
 static struct dentry *hl_debug_root;
 
 static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
-				u8 i2c_reg, u32 *val)
+				u8 i2c_reg, long *val)
 {
 	struct armcp_packet pkt;
 	int rc;
@@ -36,7 +36,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	pkt.i2c_reg = i2c_reg;
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, (long *) val);
+						0, val);
 
 	if (rc)
 		dev_err(hdev->dev, "Failed to read from I2C, error %d\n", rc);
@@ -827,7 +827,7 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	char tmp_buf[32];
-	u32 val;
+	long val;
 	ssize_t rc;
 
 	if (*ppos)
@@ -842,7 +842,7 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
 		return rc;
 	}
 
-	sprintf(tmp_buf, "0x%02x\n", val);
+	sprintf(tmp_buf, "0x%02lx\n", val);
 	rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
 			strlen(tmp_buf));
 
-- 
2.27.0

