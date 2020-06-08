Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F78F2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nDeDRBRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgFHQ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:29:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgFHQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:29:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058G8Un1065789;
        Mon, 8 Jun 2020 16:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=1CnvvLK92zk5dgs6SDTf+XweULl4QvBCd3wi5q7qwqM=;
 b=nDeDRBRhGxh3J664cgi4uJyQ9w0Cmxlk+OQ3A3IXAu4tSZwEOa0GaCM4ofLqRmahqdS6
 jnu8kB9Y9MIqoWhPlDZn7cHTzOfn6I2+Vk8nxjbc9FP5TT1InlApOIFPo6Z8LoJSEJdz
 Kc9X+290HvY/e7yc3zwF88Zgt+IuPcHBXky0zpjjg7PKrrHRdVUAfxz4mvhINMK3xjXS
 Asy7xLB1YKo+bI7G/UZanTaogXJCAx6WOgU91Gmw6iJMDHfSavB4k/gCeNtIdL80dHFJ
 6MJ9FM34QAwWLcdSEIaU9xj7+p2/P/tW3SbUp5YVL4Ek7aN+Q5mbl3CgFXxk4pCC0rMW VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31g2jqyu6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 16:29:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058GE5mb178581;
        Mon, 8 Jun 2020 16:29:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31gmqmetya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:29:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 058GT0YB011186;
        Mon, 8 Jun 2020 16:29:00 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 09:28:59 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com
Subject: [PATCH 2/2] nvme-pci: remove empty line following nvme_should_reset()
Date:   Mon,  8 Jun 2020 09:20:02 -0700
Message-Id: <20200608162002.17017-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608162002.17017-1-dongli.zhang@oracle.com>
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup by removing the empty line.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d690d5593a80..4471e9910906 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1153,7 +1153,6 @@ static void abort_endio(struct request *req, blk_status_t error)
 
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 {
-
 	/* If true, indicates loss of adapter communication, possibly by a
 	 * NVMe Subsystem reset.
 	 */
-- 
2.17.1

