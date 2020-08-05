Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6EEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF5C20792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rYobUMFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgHEJyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:54:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54984 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:51:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0759m3pf153911;
        Wed, 5 Aug 2020 09:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=MT1IenkERUHhaKZWvKrpivkl0Eede+Swc2LRUTtH294=;
 b=rYobUMFBIajWJ2Q3kT+ueBPxDbpnt6r65crxNIHkm86jJe8yu4zrlDJaaB6efWydeyYF
 Yc43ZrX01JQADrs7MeUI/vnIA9pERmT5v3K0wsh+EATP7b2qlIWR3JTiGChB4QBBJjQe
 5+MyixKOQvWiHYHmoRkdqViK3OPXQFQun5n8O6InmizgsAMs93/RtWa1pJzRQ+AEUa4b
 L/uSXBlwzevqTm/9Pz48WSxQauRREnP1T0Ds98p4oPTKwDdcXGWiapPPoIGvrrfSwD0o
 DjpR1LQyaAID8c9oYbbAZhp7cv2sOr+NYHOt5cmI3nX+1t6NzYsbnj6KdNJ8GrHKQNCj vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11n92f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 09:51:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0759n4Kb132827;
        Wed, 5 Aug 2020 09:51:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32pdhdxk3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 09:51:17 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0759pD60018117;
        Wed, 5 Aug 2020 09:51:16 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 02:51:12 -0700
Date:   Wed, 5 Aug 2020 12:51:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] habanalabs: Fix a loop in gaudi_extract_ecc_info()
Message-ID: <20200805095105.GA483832@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition was reversed.  It should have been less than instead of
greater than.  The result is that we never enter the loop.

Fixes: fcc6a4e60678 ("habanalabs: Extract ECC information from FW")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 00a0a7238d81..de2f81b80ced 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5215,7 +5215,7 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
 	*memory_wrapper_idx = 0xFF;
 
 	/* Iterate through memory wrappers, a single bit must be set */
-	for (i = 0 ; i > num_mem_regs ; i++) {
+	for (i = 0 ; i < num_mem_regs ; i++) {
 		err_addr += i * 4;
 		err_word = RREG32(err_addr);
 		if (err_word) {
-- 
2.27.0

