Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D90C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83207207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgESOXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:23:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgESOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:23:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JE3TIX037638;
        Tue, 19 May 2020 10:23:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cqn7v1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 10:23:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JE6Rsl003061;
        Tue, 19 May 2020 14:23:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehhsf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 14:23:02 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JEN0Jf63242648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 14:23:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 399EA4C046;
        Tue, 19 May 2020 14:23:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 228AF4C059;
        Tue, 19 May 2020 14:23:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 May 2020 14:23:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id C72C6E027E; Tue, 19 May 2020 16:22:59 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
Date:   Tue, 19 May 2020 16:22:59 +0200
Message-Id: <20200519142259.102279-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519142259.102279-1-sth@linux.ibm.com>
References: <20200519142259.102279-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_04:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=917 malwarescore=0
 suspectscore=1 lowpriorityscore=0 clxscore=1015 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005190126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM partition parser requires device type specific information only
available to the DASD driver to correctly register partitions. The
current approach of using ioctl_by_bdev with a fake user space pointer
is discouraged.

Fix this by replacing IOCTL calls with direct in-kernel function calls.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 MAINTAINERS                     |  1 +
 block/partitions/ibm.c          | 24 +++++++++++++++++------
 drivers/s390/block/dasd_ioctl.c | 34 +++++++++++++++++++++++++++++++++
 include/linux/dasd_mod.h        |  9 +++++++++
 4 files changed, 62 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/dasd_mod.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1608ef8ce8d3..37f700187d74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14625,6 +14625,7 @@ S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	block/partitions/ibm.c
 F:	drivers/s390/block/dasd*
+F:	include/linux/dasd_mod.h
 
 S390 IOMMU (PCI)
 M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 073faa6a69b8..d6e18df9c53c 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -13,10 +13,11 @@
 #include <asm/ebcdic.h>
 #include <linux/uaccess.h>
 #include <asm/vtoc.h>
+#include <linux/module.h>
+#include <linux/dasd_mod.h>
 
 #include "check.h"
 
-
 union label_t {
 	struct vtoc_volume_label_cdl vol;
 	struct vtoc_volume_label_ldl lnx;
@@ -288,7 +289,9 @@ static int find_cms1_partitions(struct parsed_partitions *state,
  */
 int ibm_partition(struct parsed_partitions *state)
 {
+	int (*fn)(struct gendisk *disk, dasd_information2_t *info);
 	struct block_device *bdev = state->bdev;
+	struct gendisk *disk = bdev->bd_disk;
 	int blocksize, res;
 	loff_t i_size, offset, size;
 	dasd_information2_t *info;
@@ -299,24 +302,31 @@ int ibm_partition(struct parsed_partitions *state)
 	union label_t *label;
 
 	res = 0;
+	if (!disk->fops->getgeo)
+		goto out_exit;
+	fn = symbol_get(dasd_biodasdinfo);
+	if (!fn)
+		goto out_exit;
 	blocksize = bdev_logical_block_size(bdev);
 	if (blocksize <= 0)
-		goto out_exit;
+		goto out_symbol;
 	i_size = i_size_read(bdev->bd_inode);
 	if (i_size == 0)
-		goto out_exit;
+		goto out_symbol;
 	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
 	if (info == NULL)
-		goto out_exit;
+		goto out_symbol;
 	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
 	if (geo == NULL)
 		goto out_nogeo;
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	/* set start if not filled by getgeo function e.g. virtblk */
+	geo->start = get_start_sect(bdev);
+	if (disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
+	if (fn(disk, info)) {
 		kfree(info);
 		info = NULL;
 	}
@@ -359,6 +369,8 @@ int ibm_partition(struct parsed_partitions *state)
 	kfree(geo);
 out_nogeo:
 	kfree(info);
+out_symbol:
+	symbol_put(dasd_biodasdinfo);
 out_exit:
 	return res;
 }
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9b7782395c37..777734d1b4e5 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -22,6 +22,7 @@
 #include <asm/schid.h>
 #include <asm/cmb.h>
 #include <linux/uaccess.h>
+#include <linux/dasd_mod.h>
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd_ioctl:"
@@ -664,3 +665,36 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 	dasd_put_device(base);
 	return rc;
 }
+
+
+/**
+ * dasd_biodasdinfo() - fill out the dasd information structure
+ * @disk [in]: pointer to gendisk structure that references a DASD
+ * @info [out]: pointer to the dasd_information2_t structure
+ *
+ * Provide access to DASD specific information.
+ * The gendisk structure is checked if it belongs to the DASD driver by
+ * comparing the gendisk->fops pointer.
+ * If it does not belong to the DASD driver -EINVAL is returned.
+ * Otherwise the provided dasd_information2_t structure is filled out.
+ *
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ */
+int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
+{
+	struct dasd_device *base;
+	int error;
+
+	if (disk->fops != &dasd_device_operations)
+		return -EINVAL;
+
+	base = dasd_device_from_gendisk(disk);
+	if (!base)
+		return -ENODEV;
+	error = __dasd_ioctl_information(base->block, info);
+	dasd_put_device(base);
+	return error;
+}
+/* export that symbol_get in partition detection is possible */
+EXPORT_SYMBOL_GPL(dasd_biodasdinfo);
diff --git a/include/linux/dasd_mod.h b/include/linux/dasd_mod.h
new file mode 100644
index 000000000000..d39abad2ff6e
--- /dev/null
+++ b/include/linux/dasd_mod.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef DASD_MOD_H
+#define DASD_MOD_H
+
+#include <asm/dasd.h>
+
+extern int dasd_biodasdinfo(struct gendisk *disk, dasd_information2_t *info);
+
+#endif
-- 
2.17.1

