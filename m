Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86919C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F31A20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MdUcR4l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBJTBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:01:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58102 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgBJTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:01:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AJ13Tg050555;
        Mon, 10 Feb 2020 19:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=fiMfJC756ecS7GfUy9yJCMgFOo0FmNrlR+6WgzE8ObY=;
 b=MdUcR4l+ktzS1OITIaCIj2h1+3ij1vYn3EvXnVT8mmze5zXX1pJbLG2xaMs7cVWjvJsK
 lnYo2srpCmGhci8f4WNvb8C5qKExOoppTkTR8+P7ncYdp0oqMqGbCpMPTI/OKn/JzLd8
 dntdWo6Co9PZioDHchz/NA4DEHLtBT1ukMq8Lb0+3jFB6XmPhWb8zmv97zReqVtlwcUV
 odYjTe2labPqDB+yAa23CKRNXRLs00iMhfzWD3a+FsW6YPZdKmCVEFN+V6O+Kl4BW9FO
 XmgB+WsLABZyrPKVdmeM9X3d8vmRq7x2PX+bHxMQoTiWRRqRjRRLQfL5wDYBB68b2/KH +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y2p3s6g4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 19:01:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AIw5OL026585;
        Mon, 10 Feb 2020 19:01:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y26htg8g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 19:01:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01AJ1PF6022074;
        Mon, 10 Feb 2020 19:01:25 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 11:01:25 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2] mm: Don't overwrite user min_free_kbytes, consider THP when adjusting
Date:   Mon, 10 Feb 2020 11:01:21 -0800
Message-Id: <20200210190121.10670-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=2 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of min_free_kbytes is calculated in two routines:
1) init_per_zone_wmark_min based on available memory
2) set_recommended_min_free_kbytes may reserve extra space for
   THP allocations

In both of these routines, a user defined min_free_kbytes value will
be overwritten if the value calculated in the code is larger. No message
is logged if the user value is overwritten.

Change code to never overwrite user defined value.  However, do log a
message (once per value) showing the value calculated in code.

At system initialization time, both init_per_zone_wmark_min and
set_recommended_min_free_kbytes are called to set the initial value
for min_free_kbytes.  When memory is offlined or onlined, min_free_kbytes
is recalculated and adjusted based on the amount of memory.  However,
the adjustment for THP is not considered.  Here is an example from a 2
node system with 8GB of memory.

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
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
---
v2 - Don't ever overwrite user defined value.  Always log message if we
     calculate a value different than user value.  As in existing code,
     do not attempt to validate user defined values.

 include/linux/khugepaged.h |  5 ++++
 mm/internal.h              |  2 ++
 mm/khugepaged.c            | 56 ++++++++++++++++++++++++++++++++------
 mm/page_alloc.c            | 35 ++++++++++++++++--------
 4 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index bc45ea1efbf7..faa92923dbe5 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,7 @@ extern int __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 				      unsigned long vm_flags);
+extern int khugepaged_adjust_min_free_kbytes(int mfk_value);
 #ifdef CONFIG_SHMEM
 extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
 #else
@@ -81,6 +82,10 @@ static inline int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 {
 	return 0;
 }
+static inline int khugepaged_adjust_min_free_kbytes(int mfk_value)
+{
+	return 0;
+}
 static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 					   unsigned long addr)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..57bbc157124e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -164,6 +164,8 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
+#define UNSET_USER_MFK_VALUE -1
+extern int calc_min_free_kbytes;
 
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..6af72cb7e337 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2138,8 +2138,9 @@ static int khugepaged(void *none)
 	return 0;
 }
 
-static void set_recommended_min_free_kbytes(void)
+int __khugepaged_adjust_min_free_kbytes(int mfk_value)
 {
+	int ret = 0;
 	struct zone *zone;
 	int nr_zones = 0;
 	unsigned long recommended_min;
@@ -2172,19 +2173,40 @@ static void set_recommended_min_free_kbytes(void)
 			      (unsigned long) nr_free_buffer_pages() / 20);
 	recommended_min <<= (PAGE_SHIFT-10);
 
-	if (recommended_min > min_free_kbytes) {
-		if (user_min_free_kbytes >= 0)
-			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
-				min_free_kbytes, recommended_min);
+	if (recommended_min > mfk_value)
+		ret = (int)recommended_min - mfk_value;
+
+	return ret;
+}
 
-		min_free_kbytes = recommended_min;
+static void set_recommended_min_free_kbytes(void)
+{
+	int av = __khugepaged_adjust_min_free_kbytes(min_free_kbytes);
+
+	if (av) {
+		if (user_min_free_kbytes != UNSET_USER_MFK_VALUE) {
+			/* Do not change user defined value. */
+			if ((min_free_kbytes + av) != calc_min_free_kbytes) {
+				/*
+				 * Save calculated value so we only print
+				 * warning once per value.
+				 */
+				calc_min_free_kbytes = min_free_kbytes + av;
+				pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
+					calc_min_free_kbytes,
+					user_min_free_kbytes);
+			}
+		} else {
+			min_free_kbytes += av;
+			setup_per_zone_wmarks();
+		}
 	}
-	setup_per_zone_wmarks();
 }
 
-int start_stop_khugepaged(void)
+static struct task_struct *khugepaged_thread __read_mostly;
+
+int __ref start_stop_khugepaged(void)
 {
-	static struct task_struct *khugepaged_thread __read_mostly;
 	static DEFINE_MUTEX(khugepaged_mutex);
 	int err = 0;
 
@@ -2207,8 +2229,24 @@ int start_stop_khugepaged(void)
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
+int khugepaged_adjust_min_free_kbytes(int mfk_value)
+{
+	int ret = 0;
+
+	/*
+	 * This is a bit racy, and we could miss transitions.  However,
+	 * start/stop code above will make additional adjustments at the
+	 * end of transitions.
+	 */
+	if (khugepaged_enabled() && khugepaged_thread)
+		ret = __khugepaged_adjust_min_free_kbytes(mfk_value);
+
+	return ret;
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..73162a5bf296 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -68,6 +68,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/khugepaged.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -314,7 +315,8 @@ compound_page_dtor * const compound_page_dtors[] = {
 };
 
 int min_free_kbytes = 1024;
-int user_min_free_kbytes = -1;
+int user_min_free_kbytes = UNSET_USER_MFK_VALUE;
+int calc_min_free_kbytes = -1;
 #ifdef CONFIG_DISCONTIGMEM
 /*
  * DiscontigMem defines memory ranges as separate pg_data_t even if the ranges
@@ -7819,17 +7821,28 @@ int __meminit init_per_zone_wmark_min(void)
 
 	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
 	new_min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
-
-	if (new_min_free_kbytes > user_min_free_kbytes) {
-		min_free_kbytes = new_min_free_kbytes;
-		if (min_free_kbytes < 128)
-			min_free_kbytes = 128;
-		if (min_free_kbytes > 65536)
-			min_free_kbytes = 65536;
-	} else {
-		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
+	if (new_min_free_kbytes < 128)
+		new_min_free_kbytes = 128;
+	if (new_min_free_kbytes > 65536)
+		new_min_free_kbytes = 65536;
+	new_min_free_kbytes +=
+		khugepaged_adjust_min_free_kbytes(new_min_free_kbytes);
+
+	if (user_min_free_kbytes != UNSET_USER_MFK_VALUE) {
+		/* Do not change user defined value. */
+		if (new_min_free_kbytes != calc_min_free_kbytes) {
+			/*
+			 * Save calculated value so we only print warning
+			 * once per value.
+			 */
+			calc_min_free_kbytes = new_min_free_kbytes;
+			pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
+		}
+		goto out;
 	}
+
+	min_free_kbytes = new_min_free_kbytes;
 	setup_per_zone_wmarks();
 	refresh_zone_stat_thresholds();
 	setup_per_zone_lowmem_reserve();
@@ -7838,7 +7851,7 @@ int __meminit init_per_zone_wmark_min(void)
 	setup_min_unmapped_ratio();
 	setup_min_slab_ratio();
 #endif
-
+out:
 	return 0;
 }
 core_initcall(init_per_zone_wmark_min)
-- 
2.24.1

