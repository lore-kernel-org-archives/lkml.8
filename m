Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7DAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84360206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgEHNP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:15:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728237AbgEHNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:15:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048D5ski102786;
        Fri, 8 May 2020 09:15:01 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtw0m299-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:15:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048DCmUw027719;
        Fri, 8 May 2020 13:14:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5wg3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:14:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048DEubk56885402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 13:14:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53D62A4060;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42275A405C;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id D9A18E027F; Fri,  8 May 2020 15:14:55 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
Date:   Fri,  8 May 2020 15:14:55 +0200
Message-Id: <20200508131455.55407-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508131455.55407-1-sth@linux.ibm.com>
References: <20200508131455.55407-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_12:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=875 phishscore=0 suspectscore=1 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call getgeo method directly and obtain pointer to dasd_biodasdinfo
function and use this instead of ioctl.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 block/partitions/ibm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 073faa6a69b8..69c27b8bee97 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -13,10 +13,10 @@
 #include <asm/ebcdic.h>
 #include <linux/uaccess.h>
 #include <asm/vtoc.h>
+#include <linux/kallsyms.h>
 
 #include "check.h"
 
-
 union label_t {
 	struct vtoc_volume_label_cdl vol;
 	struct vtoc_volume_label_ldl lnx;
@@ -288,7 +288,9 @@ static int find_cms1_partitions(struct parsed_partitions *state,
  */
 int ibm_partition(struct parsed_partitions *state)
 {
+	int (*dasd_biodasdinfo)(struct gendisk *, dasd_information2_t *);
 	struct block_device *bdev = state->bdev;
+	struct gendisk *disk = bdev->bd_disk;
 	int blocksize, res;
 	loff_t i_size, offset, size;
 	dasd_information2_t *info;
@@ -297,6 +299,7 @@ int ibm_partition(struct parsed_partitions *state)
 	char name[7] = {0,};
 	sector_t labelsect;
 	union label_t *label;
+	int rc = 0;
 
 	res = 0;
 	blocksize = bdev_logical_block_size(bdev);
@@ -314,9 +317,15 @@ int ibm_partition(struct parsed_partitions *state)
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	geo->start = get_start_sect(bdev);
+	if (!disk->fops->getgeo || disk->fops->getgeo(bdev, geo))
+		goto out_freeall;
+	dasd_biodasdinfo = (void *)kallsyms_lookup_name("dasd_biodasdinfo");
+	if (dasd_biodasdinfo)
+		rc = dasd_biodasdinfo(disk, info);
+	if (rc == -EINVAL)
 		goto out_freeall;
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
+	if (rc) {
 		kfree(info);
 		info = NULL;
 	}
-- 
2.17.1

