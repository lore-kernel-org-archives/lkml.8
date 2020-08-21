Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099D320724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/hgqOb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHUT4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:56:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3948 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgHUT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:56:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LJWxB5023963;
        Fri, 21 Aug 2020 15:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1PGyV5xOIEUjK9z3Jg4QxXcPpDhZXcE3sZY/Qjg8gwg=;
 b=m/hgqOb6xYkIo2JBgQ4vwLXlYtOPuBTDm8FJSm5gXVV9YWphk4Tn+cBZcQhbwU+kSQYq
 dplXEUnQEnSiZCqEVhbLVXA96AUXd3g//V3V14reif3WsA958GtJPaXKa6VYFx4e2v6K
 hQubKbUzI7Ov5DmYwv2rhwKhc2jk7b1idk7Qj+DX4uIo6kUVPHRiIMr5+2rFdA6+PzIs
 Mv9P3WkjmgPXCQsYHCqzwtO38cBwiyEQCu/KrBrPRPYicvzeDNvp5vf+GlDre3xubmut
 i/iJISzCa0EVrpylb+/2j/fSKquUAQIuH6QlPf1CkcDJ+qsBS4KCE4vXy5cX2g9D7VOR 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332dw6vavh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 15:56:29 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07LJYAfO027332;
        Fri, 21 Aug 2020 15:56:29 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332dw6vava-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 15:56:29 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07LJsM76005387;
        Fri, 21 Aug 2020 19:56:28 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3304ceprww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 19:56:28 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07LJuPFW47841588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 19:56:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C41F778060;
        Fri, 21 Aug 2020 19:56:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 475C27805C;
        Fri, 21 Aug 2020 19:56:24 +0000 (GMT)
Received: from cpe-172-100-175-116.stny.res.rr.com.com (unknown [9.85.191.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 19:56:24 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v10 01/16] s390/vfio-ap: add version vfio_ap module
Date:   Fri, 21 Aug 2020 15:56:01 -0400
Message-Id: <20200821195616.13554-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200821195616.13554-1-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_09:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=3 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's set a version for the vfio_ap module so that automated regression
tests can determine whether dynamic configuration tests can be run or
not.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index be2520cc010b..f4ceb380dd61 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -17,10 +17,12 @@
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
 #define VFIO_AP_DEV_NAME "matrix"
+#define VFIO_AP_MODULE_VERSION "1.2.0"
 
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(VFIO_AP_MODULE_VERSION);
 
 static struct ap_driver vfio_ap_drv;
 
-- 
2.21.1

