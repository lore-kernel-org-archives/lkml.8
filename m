Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6799F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHfi2r83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFPWyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:54:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:54:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GMl5uh191571;
        Tue, 16 Jun 2020 22:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=Zmvxp6TcklTF5tZHdIjURz6zaQoJfhp55XSlQEQbRBQ=;
 b=XHfi2r836QGJbY2pb+IHV8UwTlHhIeA1V8Dg2/Log+JAp2Ye4WofBcW2KOqkNULm7M3H
 ATpM2OLgDQe5XG6K6HY7ztoLiLvIzHLuOHLH8eVNoTVPhzDyOC1lBzxjDUggJBrCyG07
 G697HRQ2MY85AWBah5rFvQYT9sk/4LmdZnrSRkEcp3liTfFQ7Ooaxr7UaSb3iUQ1LFQ4
 p+Tgv1PfC0OBf7Mh1KsehSwHcMheEfE9EgH5kAqhNLjJX8y/V7MU48fODynBo617Jlnu
 eQBNz+gPfVyWUDSLjtXNTmLG33Uc6qtFHVMerKA6Zifgs0mbRSoMU37Ba1rfiAnGelBW Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31q65jr6ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 22:54:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GMr54r145209;
        Tue, 16 Jun 2020 22:54:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31q66m9sxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 22:54:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05GMsPkl029460;
        Tue, 16 Jun 2020 22:54:26 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 15:54:25 -0700
From:   William Kucharski <william.kucharski@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: ksize() should silently accept a NULL pointer
Date:   Tue, 16 Jun 2020 16:54:09 -0600
Message-Id: <20200616225409.4670-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=884 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 cotscore=-2147483648 suspectscore=0
 bulkscore=0 mlxlogscore=903 mlxscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other mm routines such as kfree() and kzfree() silently do the right
thing if passed a NULL pointer, so ksize() should do the same.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/slab_common.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9e72ba224175..2bff01ad94d8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1660,10 +1660,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 					   gfp_t flags)
 {
 	void *ret;
-	size_t ks = 0;
+	size_t ks;
 
-	if (p)
-		ks = ksize(p);
+	ks = ksize(p);
 
 	if (ks >= new_size) {
 		p = kasan_krealloc((void *)p, new_size, flags);
@@ -1723,10 +1722,9 @@ void kzfree(const void *p)
 	size_t ks;
 	void *mem = (void *)p;
 
-	if (unlikely(ZERO_OR_NULL_PTR(mem)))
-		return;
 	ks = ksize(mem);
-	memset(mem, 0, ks);
+	if (ks)
+		memset(mem, 0, ks);
 	kfree(mem);
 }
 EXPORT_SYMBOL(kzfree);
@@ -1749,8 +1747,6 @@ size_t ksize(const void *objp)
 {
 	size_t size;
 
-	if (WARN_ON_ONCE(!objp))
-		return 0;
 	/*
 	 * We need to check that the pointed to object is valid, and only then
 	 * unpoison the shadow memory below. We use __kasan_check_read(), to
@@ -1764,7 +1760,7 @@ size_t ksize(const void *objp)
 	 * We want to perform the check before __ksize(), to avoid potentially
 	 * crashing in __ksize() due to accessing invalid metadata.
 	 */
-	if (unlikely(objp == ZERO_SIZE_PTR) || !__kasan_check_read(objp, 1))
+	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !__kasan_check_read(objp, 1))
 		return 0;
 
 	size = __ksize(objp);
-- 
2.26.2

