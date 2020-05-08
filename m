Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418ECC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8552496E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgEHNPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:15:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgEHNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:15:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048D4aG1084653;
        Fri, 8 May 2020 09:15:01 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsr45tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:15:01 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048DCknK013771;
        Fri, 8 May 2020 13:14:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 30s0g5dgt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:14:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048DEuZX55967844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 13:14:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 549EFA4062;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41DA1A405B;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id D70C1E027E; Fri,  8 May 2020 15:14:55 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: [PATCH v3 2/3] block: add a s390-only biodasdinfo method
Date:   Fri,  8 May 2020 15:14:54 +0200
Message-Id: <20200508131455.55407-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508131455.55407-1-sth@linux.ibm.com>
References: <20200508131455.55407-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_12:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The IBM partition parser needs to query the DASD driver for details that
are very s390 specific.  Instead of using ioctl_by_bdev with a fake user
space pointer just add a s390-specific method to get the information
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[sth@linux.ibm.com: remove fop, add gendisk check, export funcion]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_int.h   |  1 +
 drivers/s390/block/dasd_ioctl.c | 21 +++++++++++++++++++++
 include/linux/blkdev.h          |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa552f9f1666..6eac7b11c75b 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -845,6 +845,7 @@ void dasd_destroy_partitions(struct dasd_block *);
 
 /* externals in dasd_ioctl.c */
 int  dasd_ioctl(struct block_device *, fmode_t, unsigned int, unsigned long);
+int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info);
 
 /* externals in dasd_proc.c */
 int dasd_proc_init(void);
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index dabcb4ce92da..d29045a37b92 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -666,3 +666,24 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 	dasd_put_device(base);
 	return rc;
 }
+
+int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
+{
+	struct dasd_device *base;
+	int error;
+
+	/*
+	 * we might get called externaly, so check if the gendisk belongs
+	 * to a DASD by checking the fops pointer
+	 */
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
+EXPORT_SYMBOL(dasd_biodasdinfo);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..915465aa8e43 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct dasd_information2_t;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
-- 
2.17.1

