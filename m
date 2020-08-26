Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31732C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B66F2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SO5iEERq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgHZLib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:38:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgHZLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:34:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBU3OI079427;
        Wed, 26 Aug 2020 11:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=4d0UEY0MXbhyacpjI1yRuNRF+3MeSwYn+K5Lelz7zok=;
 b=SO5iEERq4BF1tLDEDNrPv4XwotVauqLillq4/v5Mc/+xjDq0Qy1jaGClXXyjs3l40zOc
 gw/Tqyw1+jv+wZxtVypp51J9RU7r6eUKu1I+yXE+K5b1oK7n1FQlvcW6mkK/dC7kFY32
 VLzwdWxDUHN6PC3ZP0i9ep87Et8R0II5dq8DQRSAGgpd/sVZj61jhrP0UN1fJBxj7dLO
 P0X8DDJmqa6tt25759bT2RQuvJphDCgXjcXhHMhl8/5OALJXVRq39UMNpGp5FeBwr/N3
 qGyu3eumDuRE/+u/f3QCsE6L6ceAbCPnHc0MNl00Xil9/8GwfJSwahcPsuLqmzYECf1m wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 333dbrytst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 11:33:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBUE92001015;
        Wed, 26 Aug 2020 11:33:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 333rua2a2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:33:38 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QBXbQi012927;
        Wed, 26 Aug 2020 11:33:37 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 04:33:36 -0700
Date:   Wed, 26 Aug 2020 14:33:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dma-pool: Fix an uninitialized variable bug in
 atomic_pool_expand()
Message-ID: <20200826113330.GD393664@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "page" pointer can be used with out being initialized.

Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same memory zone")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 06582b488e31..1281c0f0442b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -84,7 +84,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 	int ret = -ENOMEM;
 
-- 
2.28.0

