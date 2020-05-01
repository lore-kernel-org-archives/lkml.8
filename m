Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AAFC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39472073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxdaX6Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgEAAt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:49:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgEAAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:49:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0410nMRJ030314;
        Fri, 1 May 2020 00:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=7kqQDAeQl0l0aYzQ7rQfhAPkIJYa5BicloGh5FRHiGU=;
 b=BxdaX6Bchfr+lWkpaYeHMXzelXRozRs9ExpYJAWpqJC4MgBjM/XlteJ8p65v2J65f9Uz
 p+X8mTBltQNx87IwIO+iUucdJOInyIlxIJePP4Cbvia/wlZM9ZftbG06u4VfSoEOZbwU
 wOCyh7JbIA3e6pshngCuQOyLw1X9xSwqCzibgo6mmHRAA9DKeE301rTZGUeKFuLnRzSP
 MiD/8k64LTI2+v1tlISZWx1/v3vNe92sZvHes0fYeu83qbQRgfpaJhJakMrY5dfI9QdL
 mDUjBRmeDSZdcBITD1Us30xvBTm5gmthFenzPAyT5kr9W7ClsLyeGX/zzDdJTdYg2eAO 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30r7f5rb4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 00:49:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0410mGOL115929;
        Fri, 1 May 2020 00:49:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30qtg29hbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 00:49:18 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0410nH6I014270;
        Fri, 1 May 2020 00:49:17 GMT
Received: from ca-dev-arm29.us.oracle.com (/10.129.136.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Apr 2020 17:49:17 -0700
From:   Henry Willard <henry.willard@oracle.com>
To:     <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Limit boost_watermark on small zones.
Date:   Thu, 30 Apr 2020 17:49:08 -0700
Message-Id: <1588294148-6586-1-git-send-email-henry.willard@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=3 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
fragmentation event occurs") adds a boost_watermark() function which
increases the min watermark in a zone by at least pageblock_nr_pages or
the number of pages in a page block. On Arm64, with 64K pages and 512M
huge pages, this is 8192 pages or 512M. It does this regardless of the
number of managed pages managed in the zone or the likelihood of success.
This can put the zone immediately under water in terms of allocating pages
from the zone, and can cause a small machine to fail immediately due to
OoM. Unlike set_recommended_min_free_kbytes(), which substantially
increases min_free_kbytes and is tied to THP, boost_watermark() can be
called even if THP is not active. The problem is most likely to appear
on architectures such as Arm64 where pageblock_nr_pages is very large.

It is desirable to run the kdump capture kernel in as small a space as
possible to avoid wasting memory. In some architectures, such as Arm64,
there are restrictions on where the capture kernel can run, and therefore,
the space available. A capture kernel running in 768M can fail due to OoM
immediately after boost_watermark() sets the min in zone DMA32, where
most of the memory is, to 512M. It fails even though there is over 500M of
free memory. With boost_watermark() suppressed, the capture kernel can run
successfully in 448M.

This patch limits boost_watermark() to boosting a zone's min watermark only
when there are enough pages that the boost will produce positive results.
In this case that is estimated to be four times as many pages as
pageblock_nr_pages.

Signed-off-by: Henry Willard <henry.willard@oracle.com>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..67805e794660 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2400,6 +2400,14 @@ static inline void boost_watermark(struct zone *zone)
 
 	if (!watermark_boost_factor)
 		return;
+	/*
+	 * Don't bother in zones that are unlikely to produce results.
+	 * On small machines, including kdump capture kernels running
+	 * in a small area, boosting the watermark can cause an out of
+	 * memory situation immediately.
+	 */
+	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
+		return;
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);
-- 
1.8.3.1

