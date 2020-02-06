Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA2AC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3220658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YaxQ6HuR";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMpzJ9mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBFBhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:37:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58942 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:37:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0161Y5Uf097267;
        Thu, 6 Feb 2020 01:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=twYfghBpOBqf+RXEmTMePU6bb1CDfjerNkz8DFiywos=;
 b=YaxQ6HuRQcrCc1s3UUSgfaUrDaQfPGMNUU3qw4Jb1U5ntirO/RT+eC6Ge9bZzRVfElUB
 Czg9DE6U6kqVMSivPnjGj1jMD10XBMypUJB5cEVIZKgBw0AnhqNydGrWNye0NupKH99o
 eJtjpwGX01U4wVxkHjFkOL4xOqiskJQl7pggid2ffhF8m/I62EvKqfUH935Nvcx9K4hR
 Mvar8XQ2HMhIKOQJQWn0kBYWx75voP53fj2j5jNEquD2I0geY6ZQ6IOr0FbePzr02vU0
 fxFPXun36gaaFxUqwx2RUCVGg/XQrlAjX4JvdkPvMzuk1tVB+ua/Ako81K2ec95pyRFj Ag== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=twYfghBpOBqf+RXEmTMePU6bb1CDfjerNkz8DFiywos=;
 b=FMpzJ9mQ1J0CnNY3djs6dT6q6B+PNqHkqxj20q2C/OmyY1WTtQmOH1MSKZSlcl3p/dSR
 emLuPuWKhU/ixHfUSrbKBbOANuMEwCUJ14CN6Upz9baH3oHuoyi3z461c6uIeEj2Dduj
 wXQIShgcnpBA0z1zw92NQW/L7URFdwbXrYl296Q7CgcmYenkw4WCli/DkjgVUVXSsvJi
 +0f+wgZtU5u9ntvcBtNAG3hjzO7vWlrCPG9UnQW2IOutaMMjXiS8VVquLVysEIgdxeyO
 dqdNWmqsSjwxIsCar+h3l4kf6RSiJ25Dns/gksGBlmOHCT7t1PtDoQGzpvIQ3niNisKN TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbp6rge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 01:36:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0161YNGo105530;
        Thu, 6 Feb 2020 01:36:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xykc9w6r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 01:36:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0161akvN005290;
        Thu, 6 Feb 2020 01:36:46 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 17:36:46 -0800
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
 <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
 <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
 <20200204215319.GO8731@bombadil.infradead.org>
 <b6979214-3f0e-6c12-ed63-681b40c6e16c@oracle.com>
Message-ID: <2ba63021-d05c-a648-f280-6c751e01adf6@oracle.com>
Date:   Wed, 5 Feb 2020 17:36:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b6979214-3f0e-6c12-ed63-681b40c6e16c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 4:33 PM, Mike Kravetz wrote:
> Today, we never overwrite a user defined value that is larger than
> that calculated by the code.  However, we will owerwrite a user defined
> value if the code calculates a larger value.

If we overwrite a user defined value, we do not inform the user.

> I'm starting to think the best option is to NEVER overwrite a user defined
> value.

Below is an updated patch which never overwrites a user defined value.
We would only potentially overwrite a user value on a memory offline/online
or khugepaged start/stop operation.  Since no validation of user defined
values is performed, it seems the desired behavior is to never overwrite them?  

If user has specified a value and we calculate a value, a message containing
both values is logged.

I am not aware of anyone complaining about current behavior.  While working
a customer issue and playing with min_free_kbytes, I noticed the behavior
and thought it does not do what one would expect.

From: Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2] mm: Don't overwrite user min_free_kbytes, consider THP
 when adjusting

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
---
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


