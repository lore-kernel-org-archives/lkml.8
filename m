Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA739206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEHNPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:15:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729472AbgEHNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:15:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048D2Cf0054830;
        Fri, 8 May 2020 09:15:02 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsemfwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:15:01 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048DCiEL026883;
        Fri, 8 May 2020 13:14:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 30s0g5nepn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:14:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048DEuxp63504766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 13:14:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 540AA52054;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 40A915204E;
        Fri,  8 May 2020 13:14:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id D473EE0271; Fri,  8 May 2020 15:14:55 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: [PATCH v3 1/3] dasd: refactor dasd_ioctl_information
Date:   Fri,  8 May 2020 15:14:53 +0200
Message-Id: <20200508131455.55407-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508131455.55407-1-sth@linux.ibm.com>
References: <20200508131455.55407-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_12:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=718 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Prepare for in-kernel callers of this functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 38 +++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9a5f3add325f..dabcb4ce92da 100644
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
@@ -473,10 +472,6 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	if (!base->discipline || !base->discipline->fill_info)
 		return -EINVAL;
 
-	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
-	if (dasd_info == NULL)
-		return -ENOMEM;
-
 	rc = base->discipline->fill_info(base, dasd_info);
 	if (rc) {
 		kfree(dasd_info);
@@ -520,15 +515,24 @@ static int dasd_ioctl_information(struct dasd_block *block,
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
+	int error = 0;
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
@@ -622,10 +626,12 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
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

