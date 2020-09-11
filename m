Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40833C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E063621D79
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TA36mDE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgIKLie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:38:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgIKLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:36:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BBYxpe013596;
        Fri, 11 Sep 2020 11:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2gHYQ5Uu4tR0zOg2iVBicKGodqK+c3+W+TJFJxyYkmc=;
 b=TA36mDE5AHAkP4wkzpqVhpG/SgfaqGB/o4z0cD2XOIvCm3934KCw0uYCjFsBMRDpEix4
 /vMkBF9C7w0KCPHPgY3nh9Ad1WdA7HrJcgxMHMtd52TAAivHWAJwimN63R6lRrYNjzBd
 2Tpt4TooMcOoLm1Amx/etTJ+CtarCv7U7V2umcMKA3Bb98tV9h5n0i/pu2fe4hXQh3MV
 SMk40vz9YRGKKOEy16erAdn99cLGAkwj7/pNgnwql5Q3m1SU4btiJIvbrjerqZHD/kK3
 i/GIQv0VEPFyHi1wuW6xwQcXgF7CBazVPHTZhjw2qPEobLIUHmq5OPAedC9iPsiI3K7f Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mmdnv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 11:35:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BBVCuP091987;
        Fri, 11 Sep 2020 11:33:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmkcppbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 11:33:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08BBXWQJ013050;
        Fri, 11 Sep 2020 11:33:32 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 04:33:32 -0700
Date:   Fri, 11 Sep 2020 14:33:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Ben Dooks <ben@fluff.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Sanders <vince@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: sm501: Fix leaks in probe()
Message-ID: <20200911113326.GB367487@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should clean up if sm501_init_dev() fails.

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mfd/sm501.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index ccd62b963952..6d2f4a0a901d 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1415,8 +1415,14 @@ static int sm501_plat_probe(struct platform_device *dev)
 		goto err_claim;
 	}
 
-	return sm501_init_dev(sm);
+	ret = sm501_init_dev(sm);
+	if (ret)
+		goto err_unmap;
+
+	return 0;
 
+ err_unmap:
+	iounmap(sm->regs);
  err_claim:
 	release_mem_region(sm->io_res->start, 0x100);
  err_res:
-- 
2.28.0

