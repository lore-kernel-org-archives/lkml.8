Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02916C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D23207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgESOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:23:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728847AbgESOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:23:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JE2PCQ189091;
        Tue, 19 May 2020 10:23:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312agdre9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 10:23:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JE6Vjs003068;
        Tue, 19 May 2020 14:23:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehhsf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 14:23:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JEN0M666191704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 14:23:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39465AE053;
        Tue, 19 May 2020 14:23:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2743FAE051;
        Tue, 19 May 2020 14:23:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 May 2020 14:23:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id C4668E0145; Tue, 19 May 2020 16:22:59 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: [PATCH v4 1/2] dasd: refactor dasd_ioctl_information
Date:   Tue, 19 May 2020 16:22:58 +0200
Message-Id: <20200519142259.102279-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519142259.102279-1-sth@linux.ibm.com>
References: <20200519142259.102279-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_04:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=817 clxscore=1015 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=1 cotscore=-2147483648
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Prepare for in-kernel callers of this functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[sth@de.ibm.com: remove leftover kfree]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 42 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9a5f3add325f..9b7782395c37 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -457,10 +457,9 @@ static int dasd_ioctl_read_profile(struct dasd_block *block, void __user *argp)
 /*
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
-static int dasd_ioctl_information(struct dasd_block *block,
-				  unsigned int cmd, void __user *argp)
+static int __dasd_ioctl_information(struct dasd_block *block,
+		struct dasd_information2_t *dasd_info)
 {
-	struct dasd_information2_t *dasd_info;
 	struct subchannel_id sch_id;
 	struct ccw_dev_id dev_id;
 	struct dasd_device *base;
@@ -473,15 +472,9 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	if (!base->discipline || !base->discipline->fill_info)
 		return -EINVAL;
 
-	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
-	if (dasd_info == NULL)
-		return -ENOMEM;
-
 	rc = base->discipline->fill_info(base, dasd_info);
-	if (rc) {
-		kfree(dasd_info);
+	if (rc)
 		return rc;
-	}
 
 	cdev = base->cdev;
 	ccw_device_get_id(cdev, &dev_id);
@@ -520,15 +513,24 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
 	spin_unlock_irqrestore(&block->queue_lock, flags);
+	return 0;
+}
 
-	rc = 0;
-	if (copy_to_user(argp, dasd_info,
-			 ((cmd == (unsigned int) BIODASDINFO2) ?
-			  sizeof(struct dasd_information2_t) :
-			  sizeof(struct dasd_information_t))))
-		rc = -EFAULT;
+static int dasd_ioctl_information(struct dasd_block *block, void __user *argp,
+		size_t copy_size)
+{
+	struct dasd_information2_t *dasd_info;
+	int error;
+
+	dasd_info = kzalloc(sizeof(*dasd_info), GFP_KERNEL);
+	if (!dasd_info)
+		return -ENOMEM;
+
+	error = __dasd_ioctl_information(block, dasd_info);
+	if (!error && copy_to_user(argp, dasd_info, copy_size))
+		error = -EFAULT;
 	kfree(dasd_info);
-	return rc;
+	return error;
 }
 
 /*
@@ -622,10 +624,12 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 		rc = dasd_ioctl_check_format(bdev, argp);
 		break;
 	case BIODASDINFO:
-		rc = dasd_ioctl_information(block, cmd, argp);
+		rc = dasd_ioctl_information(block, argp,
+				sizeof(struct dasd_information_t));
 		break;
 	case BIODASDINFO2:
-		rc = dasd_ioctl_information(block, cmd, argp);
+		rc = dasd_ioctl_information(block, argp,
+				sizeof(struct dasd_information2_t));
 		break;
 	case BIODASDPRRD:
 		rc = dasd_ioctl_read_profile(block, argp);
-- 
2.17.1

