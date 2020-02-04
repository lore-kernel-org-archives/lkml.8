Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621BFC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C8F2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9y3Xj/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBDTmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:42:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBDTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:42:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014Jcni3068450;
        Tue, 4 Feb 2020 19:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=yEuu2rGf2EzMFdKEz2FW/Nbv62TgR5F3I7z7o8+SbDI=;
 b=g9y3Xj/QBfWn5aGbDt9KnscnH+Qg/zPpv2u29tk54o+S75+3imhs5yCfIrc+3iZ7oOF2
 ETWH+aLZf0KU8e+JKuKMIC1fYsG2FV328p3rlpU8wv4ryZvhShtA/iZWIguPxmHxm1g3
 zAWwPQEXOlCsd8PvqL1NrlzG4xigR43wvnGmnZMaGCY3gcLqj2dW4XNe3N26nrIzoUqI
 w+TJ8+OB0d4FUGM//p8Uvwtbb65OGJZmwVzsno7uU/boM3/6M9NIRqpBG6iR9XJRZrva
 lMFtPjKeYBtQjNt2XZOMo7q6u9tnEhQbXMInfmx8rOg4gjbHe21KY72Dr5yPNO4JMct7 BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xw19qh255-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 19:42:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014Jd9ZX045156;
        Tue, 4 Feb 2020 19:42:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xxvusgppk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 19:42:11 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 014Jg9KO017732;
        Tue, 4 Feb 2020 19:42:10 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 11:42:09 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm: always consider THP when adjusting min_free_kbytes
Date:   Tue,  4 Feb 2020 11:41:56 -0800
Message-Id: <20200204194156.61672-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At system initialization time, min_free_kbytes is calculated based
on the amount of memory in the system.  If THP is enabled, then
khugepaged is started and min_free_kbytes may be adjusted in an
attempt to reserve some pageblocks for THP allocations.

When memory is offlined or onlined, min_free_kbytes is recalculated
and adjusted based on the amount of memory.  However, the adjustment
for THP is not considered.  Here is an example from a 2 node system
with 8GB of memory.

 # cat /proc/sys/vm/min_free_kbytes
 90112
 # echo 0 > /sys/devices/system/node/node1/memory56/online
 # cat /proc/sys/vm/min_free_kbytes
 11243
 # echo 1 > /sys/devices/system/node/node1/memory56/online
 # cat /proc/sys/vm/min_free_kbytes
 11412

One would expect that min_free_kbytes would return to it's original
value after the offline/online operations.

Create a simple interface for THP/khugepaged based adjustment and
call this whenever min_free_kbytes is adjusted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/khugepaged.h |  5 +++++
 mm/khugepaged.c            | 35 ++++++++++++++++++++++++++++++-----
 mm/page_alloc.c            |  4 +++-
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index bc45ea1efbf7..8f02d3575829 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,7 @@ extern int __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 				      unsigned long vm_flags);
+extern bool khugepaged_adjust_min_free_kbytes(void);
 #ifdef CONFIG_SHMEM
 extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
 #else
@@ -81,6 +82,10 @@ static inline int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 {
 	return 0;
 }
+static bool khugepaged_adjust_min_free_kbytes(void)
+{
+	return false;
+}
 static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 					   unsigned long addr)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..d8040cf19e98 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2138,7 +2138,7 @@ static int khugepaged(void *none)
 	return 0;
 }
 
-static void set_recommended_min_free_kbytes(void)
+bool __khugepaged_adjust_min_free_kbytes(void)
 {
 	struct zone *zone;
 	int nr_zones = 0;
@@ -2174,17 +2174,26 @@ static void set_recommended_min_free_kbytes(void)
 
 	if (recommended_min > min_free_kbytes) {
 		if (user_min_free_kbytes >= 0)
-			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
+			pr_info_once("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
 				min_free_kbytes, recommended_min);
 
 		min_free_kbytes = recommended_min;
+		return true;
 	}
-	setup_per_zone_wmarks();
+
+	return false;
+}
+
+static void set_recommended_min_free_kbytes(void)
+{
+	if (__khugepaged_adjust_min_free_kbytes())
+		setup_per_zone_wmarks();
 }
 
-int start_stop_khugepaged(void)
+static struct task_struct *khugepaged_thread __read_mostly;
+
+int __ref start_stop_khugepaged(void)
 {
-	static struct task_struct *khugepaged_thread __read_mostly;
 	static DEFINE_MUTEX(khugepaged_mutex);
 	int err = 0;
 
@@ -2207,8 +2216,24 @@ int start_stop_khugepaged(void)
 	} else if (khugepaged_thread) {
 		kthread_stop(khugepaged_thread);
 		khugepaged_thread = NULL;
+		init_per_zone_wmark_min();
 	}
 fail:
 	mutex_unlock(&khugepaged_mutex);
 	return err;
 }
+
+bool khugepaged_adjust_min_free_kbytes(void)
+{
+	bool ret = false;
+
+	/*
+	 * This is a bit racy, and we could miss transitions.  However,
+	 * start/stop code above will make additional adjustments at the
+	 * end of transitions.
+	 */
+	if (khugepaged_enabled() && khugepaged_thread)
+		ret = __khugepaged_adjust_min_free_kbytes();
+
+	return ret;
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..a7b3a6663ba6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -68,6 +68,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/khugepaged.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -7827,9 +7828,10 @@ int __meminit init_per_zone_wmark_min(void)
 		if (min_free_kbytes > 65536)
 			min_free_kbytes = 65536;
 	} else {
-		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
+		pr_warn_once("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
 	}
+	(void)khugepaged_adjust_min_free_kbytes();
 	setup_per_zone_wmarks();
 	refresh_zone_stat_thresholds();
 	setup_per_zone_lowmem_reserve();
-- 
2.24.1

