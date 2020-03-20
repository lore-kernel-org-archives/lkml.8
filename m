Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919A8C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680A120739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L4+m/N1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgCTF6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:58:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34453 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgCTF6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:58:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200320055841epoutp0198ecfa65b0b171ddc1a22fa9b8119171~97aF2XeQ_0508505085epoutp01b
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 05:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200320055841epoutp0198ecfa65b0b171ddc1a22fa9b8119171~97aF2XeQ_0508505085epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584683921;
        bh=vah53AmqrEMXcmGdds4iFjJJZRZ1yBycMR96OdrQFss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4+m/N1vLPPC/y3sKbGxeqEMB0d1Q86rQHfsAquA+ZiD8VciwTHiEiv8Jj7upa5fr
         HANwwu1l5eO6wu/U27daB1opvPbOBRNqqdbMpvaM8ioSkpH2xeCLiDsWBQoPcpNNHz
         HFQYRg+mxCWpPwsjJwI7q4AMiksxsze18qhobZis=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200320055841epcas1p1e455875e4fed5952153773fb70cfa5c2~97aFfrhUK3072430724epcas1p1N;
        Fri, 20 Mar 2020 05:58:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48kCkl6kSqzMqYkc; Fri, 20 Mar
        2020 05:58:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.55.04145.F8B547E5; Fri, 20 Mar 2020 14:58:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200320055839epcas1p1a9b626b3afe8c22e36ff198f9eaeab2e~97aDnirGr3070730707epcas1p1L;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200320055839epsmtrp144ccc173c9c0336c189ed392df040879~97aDlv-in2644226442epsmtrp1F;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
X-AuditID: b6c32a35-2a5ff70000001031-64-5e745b8f6b73
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.84.04024.F8B547E5; Fri, 20 Mar 2020 14:58:39 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200320055839epsmtip16e07cca32822231a709d802fc0c31507~97aDaK3rs1022810228epsmtip1P;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org, srostedt@vmware.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3 1/2] mmap: remove inline of vm_unmapped_area
Date:   Fri, 20 Mar 2020 14:58:22 +0900
Message-Id: <20200320055823.27089-2-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200320055823.27089-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2+VskxaHZfliZetAwWbLneb0VN6gC4eykOpPCq6THjbr7NLO
        ZtkFDG2ltbzQvJSRUVGEZUzRMqVYaZF0Q7qa9aOSFDXpalra5jHq3/O83/PwPLzfKxerDmKR
        8hybi3XaGI7AwiRNtzU6XUmGK1P/4kM8VVNfh1FlJRrqSEM1oryf+kVUV0sNRr2pm5BS7aN9
        Emq8fD81NlKDpSjo6yd6ZHSt3003XNTS/s/lMvpe1ZiEPtZ4CdENnXvpL/4oeuj0IJamSOcS
        LCyTzTrVrC3Lnp1jMycS6zaZVpqMcXpSRy6j4gm1jbGyicSq1DTdmhwu2I9Q5zKcOzhKY3ie
        iElKcNrdLlZtsfOuRIJ1ZHMOUu9YwjNW3m0zL8myW5eTev1SY1C5lbNUnXuBOTph99V6jygf
        XQkvRgo54LFwqOucpBiFyVX4NQTDH87LBPIZwfvLZ0UC+Y6guK9X9tfyc/iBVHhoQ1DpPYAE
        8gPB044JaUiF4dHwqbZ8EofjFvCNvsVCWIy7YXDgnjiEZ+LJ0HXnFQphCb4Q7vsuSEJYiSeC
        79fbYLQ8mDYfzkxMyhV4EjxvvY+FsgC/hUFX6Wup0GgVNB+swAQ8E/rvNk41jYS+Eo9MMBQg
        GKxuQAIpRNDj9yJBZQDv0cfiUJoY10B9S4wwXgDXx04hofQMGPp2VCoUUsJhj0qQLILC3m9T
        HebC7/HeKUxDx03f1IbKEIw9rZOVoqgT/xJqEbqEZrMO3mpmedJB/v9nfjR5glrjNXT8YWoA
        4XJETFdWefhMlZTJ5fOsAQRyMRGu1JmDI2U2k7eHddpNTjfH8gFkDK6yTBw5K8sePGiby0Qa
        lxoMBio2Lj7OaCAilL7nXKYKNzMudgfLOljnX59IrojMR6XbK4tM9giD5OvLzJx1bRnmm+ry
        ke4BfF5gWmBF9KOPG1mLqL117YamgsCuWVtGw7ZNq34mHe6p0RYndUekjJsGPaT1cTxXz3n7
        kgvfvdfgBq7DtP7NExvenH/DWNf25eRoqjZ90b7NRdvmLPZWtA3nehakmh+u3vk1TmMauN1J
        SHgLQ2rFTp75A1U37nWYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnG5/dEmcwdpfbBZz1q9hs5jYr2nR
        vXkmo0Xv+1dMFpd3zWGzuLfmP6vF0V8vWSz+Taq1+P1jDpsDp8fOWXfZPRZsKvXYvELLY9On
        SeweJ2b8ZvHo27KK0WPz6WqPz5vkPN7Nf8sWwBnFZZOSmpNZllqkb5fAlTFjyQ22gtMSFRvW
        tzE1MK4T6WLk5JAQMJH4+eEsaxcjF4eQwG5GiTctD1ghEjISb84/Zeli5ACyhSUOHy6GqPnK
        KHH701FGkBo2AW2J9wsmgdWLCORJtGx6CGYzC1RK/Lt9C8wWFrCXuHzkFlg9i4CqxKmpy1lA
        bF4BW4mpf+4zQcyXl1j4nxkkzClgJ3F9zyk2EFsIqGTuxGfMExj5FjAyrGKUTC0ozk3PLTYs
        MMxLLdcrTswtLs1L10vOz93ECA5SLc0djJeXxB9iFOBgVOLhndFWHCfEmlhWXJl7iFGCg1lJ
        hFc3HSjEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDI9tr
        N/st2yRn1L/KONy+MmtLT8/chRIBLo7T3stmG/nEB/8UMxc+dVbZ8wiXVe2h7Fz5zb/j1kR5
        OK2TsdNsrTi54cTaKa+5rr97LvP9xNpbixSkIpW7pLl9X76/E30l33qW5P3TeRv6Nvxtc1kj
        ceSGKWOZhw0Tc9Xt67UrHwp/FztlUqn2U4mlOCPRUIu5qDgRAJfgYv1OAgAA
X-CMS-MailID: 20200320055839epcas1p1a9b626b3afe8c22e36ff198f9eaeab2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200320055839epcas1p1a9b626b3afe8c22e36ff198f9eaeab2e
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
        <CGME20200320055839epcas1p1a9b626b3afe8c22e36ff198f9eaeab2e@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepration for next patch remove inline of vm_unmapped_area and move
code to mmap.c. There is no logical change.

Also remove unmapped_area[_topdown] out of mm.h, there is no code
calling to them.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
v3: add static keyword
v2: remove inline and move code to mmap.c
---
 include/linux/mm.h | 21 +--------------------
 mm/mmap.c          | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..f4263993d053 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2364,26 +2364,7 @@ struct vm_unmapped_area_info {
 	unsigned long align_offset;
 };
 
-extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
-extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
-
-/*
- * Search for an unmapped address range.
- *
- * We are looking for a range that:
- * - does not intersect with any VMA;
- * - is contained within the [low_limit, high_limit) interval;
- * - is at least the desired size.
- * - satisfies (begin_addr & align_mask) == (align_offset & align_mask)
- */
-static inline unsigned long
-vm_unmapped_area(struct vm_unmapped_area_info *info)
-{
-	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
-		return unmapped_area_topdown(info);
-	else
-		return unmapped_area(info);
-}
+extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 
 /* truncate.c */
 extern void truncate_inode_pages(struct address_space *, loff_t);
diff --git a/mm/mmap.c b/mm/mmap.c
index d681a20eb4ea..ba990c20ecc2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1848,7 +1848,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
-unsigned long unmapped_area(struct vm_unmapped_area_info *info)
+static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
 	/*
 	 * We implement the search by looking for an rbtree node that
@@ -1951,7 +1951,7 @@ unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	return gap_start;
 }
 
-unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
+static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -2050,6 +2050,22 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	return gap_end;
 }
 
+/*
+ * Search for an unmapped address range.
+ *
+ * We are looking for a range that:
+ * - does not intersect with any VMA;
+ * - is contained within the [low_limit, high_limit) interval;
+ * - is at least the desired size.
+ * - satisfies (begin_addr & align_mask) == (align_offset & align_mask)
+ */
+unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
+{
+	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
+		return unmapped_area_topdown(info);
+	else
+		return unmapped_area(info);
+}
 
 #ifndef arch_get_mmap_end
 #define arch_get_mmap_end(addr)	(TASK_SIZE)
-- 
2.13.7

