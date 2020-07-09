Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE01C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471252078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGITSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgGITSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:18:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069J2LKL062957;
        Thu, 9 Jul 2020 15:17:58 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325kh4ce7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 15:17:58 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069JAsxh012219;
        Thu, 9 Jul 2020 19:17:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 325k28akx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 19:17:57 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069JHumG16253368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 19:17:56 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 219696E050;
        Thu,  9 Jul 2020 19:17:56 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1EEC6E052;
        Thu,  9 Jul 2020 19:17:55 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.54.227])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 19:17:55 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au
Subject: [PATCH] fsi: aspeed: Enable 23-bit addressing
Date:   Thu,  9 Jul 2020 14:17:43 -0500
Message-Id: <20200709191743.11224-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_09:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=994
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 spamscore=0 suspectscore=1 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to access more than the second hub link, 23-bit addressing is
required. The core provides the highest two bits of address as the slave
ID to the master.

OpenBMC-Staging-Count: 1
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-aspeed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f49742b310c2..b49dccf14315 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -241,9 +241,10 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 	struct fsi_master_aspeed *aspeed = to_fsi_master_aspeed(master);
 	int ret;
 
-	if (id != 0)
+	if (id > 0x3)
 		return -EINVAL;
 
+	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
 	switch (size) {
@@ -273,9 +274,10 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 	struct fsi_master_aspeed *aspeed = to_fsi_master_aspeed(master);
 	int ret;
 
-	if (id != 0)
+	if (id > 0x3)
 		return -EINVAL;
 
+	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
 	switch (size) {
-- 
2.24.0

