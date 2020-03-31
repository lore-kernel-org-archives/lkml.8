Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4867220757
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uKErOqy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgCaDOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:14:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCaDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:14:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02V3Ah2E121256;
        Tue, 31 Mar 2020 03:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=nA6fsaHl2te6SiHnjKdg8oaZ7QhXep57UK2rK4KkRQ8=;
 b=uKErOqy8SI95tt7fMTNB8SQI0WrFh9IcxqPHZAyLWqIZMRaLTdB91e/erWYP3SXgMq0k
 zgpOcodJYX3TvTsoJf/5Fx82Y6AO5jpC57srjcPL5guiToLD/BK1Uxw9Q4NFTVP4NfKL
 OTAxJZntoB3Zu9lg8swvjXGIxjwE/UxfIa1nA4SVT84K5ZnHEKB+RJaWT4Yn8zkaOiV+
 SvA9YxUBhSIZG2URphRQwkDfzcMhUq1x87L/fV7Uyt4iHDMBygVywmDGk6f3Pfns97c9
 qPwbWKOYMGQOyMvuDES0II/dig8EncGTROwQEDIU9ONztA7QOcajGrdGvPJ9Kc/4Cg70 BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhdj9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 03:14:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02V3DNlg123784;
        Tue, 31 Mar 2020 03:14:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 302gcb7k6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 03:14:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02V3EOWG029127;
        Tue, 31 Mar 2020 03:14:25 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Mar 2020 20:14:24 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        dongli.zhang@oracle.com
Subject: [PATCH 1/1] mm: slub: fix corrupted freechain in deactivate_slab()
Date:   Mon, 30 Mar 2020 20:14:50 -0700
Message-Id: <20200331031450.12182-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slub_debug is able to fix the corrupted slab freelist/page. However,
alloc_debug_processing() only checks the validity of current and next
freepointer during allocation path. As a result, once some objects have
their freepointers corrupted, deactivate_slab() may lead to page fault.

Below is from a test kernel module when
'slub_debug=PUF,kmalloc-128 slub_nomerge'. The test kernel corrupts the
freepointer of one free object on purpose. Unfortunately, deactivate_slab()
does not detect it when iterating the freechain.

[ 92.665260] BUG: unable to handle page fault for address: 00000000123456f8
[ 92.671597] #PF: supervisor read access in kernel mode
[ 92.676159] #PF: error_code(0x0000) - not-present page
[ 92.681666] PGD 0 P4D 0
[ 92.684923] Oops: 0000 [#1] SMP PTI
... ...
[ 92.706684] RIP: 0010:deactivate_slab.isra.92+0xed/0x490
... ...
[ 92.819781] Call Trace:
[ 92.823129]  ? ext4_htree_store_dirent+0x30/0xf0
[ 92.829488]  ? ext4_htree_store_dirent+0x30/0xf0
[ 92.834852]  ? stack_trace_save+0x46/0x70
[ 92.839342]  ? init_object+0x66/0x80
[ 92.843729]  ? ___slab_alloc+0x536/0x570
[ 92.847664]  ___slab_alloc+0x536/0x570
[ 92.851696]  ? __find_get_block+0x23d/0x2c0
[ 92.856763]  ? ext4_htree_store_dirent+0x30/0xf0
[ 92.862258]  ? _cond_resched+0x10/0x40
[ 92.866925]  ? __getblk_gfp+0x27/0x2a0
[ 92.872136]  ? ext4_htree_store_dirent+0x30/0xf0
[ 92.878394]  ? __slab_alloc+0x17/0x30
[ 92.883222]  __slab_alloc+0x17/0x30
[ 92.887210]  __kmalloc+0x1d9/0x200
[ 92.891448]  ext4_htree_store_dirent+0x30/0xf0
[ 92.896748]  htree_dirblock_to_tree+0xcb/0x1c0
[ 92.902398]  ext4_htree_fill_tree+0x1bc/0x2d0
[ 92.907749]  ext4_readdir+0x54f/0x920
[ 92.912725]  iterate_dir+0x88/0x190
[ 92.917072]  __x64_sys_getdents+0xa6/0x140
[ 92.922760]  ? fillonedir+0xb0/0xb0
[ 92.927020]  ? do_syscall_64+0x49/0x170
[ 92.931603]  ? __ia32_sys_getdents+0x130/0x130
[ 92.937012]  do_syscall_64+0x49/0x170
[ 92.940754]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Therefore, this patch adds extra consistency check in deactivate_slab().
Once an object's freepointer is corrupted, all following objects starting
at this object are isolated.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 mm/slub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 6589b41d5a60..c27e2d993535 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2082,6 +2082,20 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		void *prior;
 		unsigned long counters;
 
+		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
+		    !check_valid_pointer(s, page, nextfree)) {
+			/*
+			 * If 'nextfree' is invalid, it is possible that
+			 * the object at 'freelist' is already corrupted.
+			 * Therefore, all objects starting at 'freelist'
+			 * are isolated.
+			 */
+			object_err(s, page, freelist, "Freechain corrupt");
+			freelist = NULL;
+			slab_fix(s, "Isolate corrupted freechain");
+			break;
+		}
+
 		do {
 			prior = page->freelist;
 			counters = page->counters;
-- 
2.17.1

