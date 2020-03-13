Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A92C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487C6205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KG/wCXkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCMBOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:14:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28516 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgCMBOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:14:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200313011432epoutp0478734c34102c1fc7a7d9da2c2cbb0baf~7uA-62VBE2385723857epoutp04a
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 01:14:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200313011432epoutp0478734c34102c1fc7a7d9da2c2cbb0baf~7uA-62VBE2385723857epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584062072;
        bh=fzFOTyd4Kwji4bmqnDA3HgG3lu01uGhDeF3O7fUMvII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KG/wCXkQKFQQQgL9uh9+l8ZLbd3rS13hX+Savr6cs8CwZAEuAoIzgCHG7RGvJH9f2
         5QYCLnkJnIrw/fPuuUdSqBXP+W4hknpSuvxeBqFV/65XD55ZFvRIWfJrSYmI8evJPU
         tbTjO/s1oyHQwZBfJpJd3bfSVy2tUQ8fIjGx9AEE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200313011432epcas1p44a713e2d3ce7173ff1ec24377f92ecb4~7uA-bAkuu0948609486epcas1p49;
        Fri, 13 Mar 2020 01:14:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48dnm71Sw5zMqYkY; Fri, 13 Mar
        2020 01:14:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.DD.48019.77EDA6E5; Fri, 13 Mar 2020 10:14:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5~7uA94E3mw1118711187epcas1p1x;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200313011430epsmtrp2190fd3594586da0296370e470c8923b2~7uA90rXJk2955029550epsmtrp2j;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-51-5e6ade77f290
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.B5.04215.67EDA6E5; Fri, 13 Mar 2020 10:14:30 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200313011430epsmtip21f1331bfc614ded8461c4a5ba88b3c7c~7uA9uEzuD2267422674epsmtip2M;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2 1/2] mmap: remove inline of vm_unmapped_area
Date:   Fri, 13 Mar 2020 10:14:19 +0900
Message-Id: <20200313011420.15995-2-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200313011420.15995-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Tw7Z0drdpiaLya6DjWYoW7N2SlcRUYd0MKIICNcBz1Mc7d2
        NrMrVla61FKInBgsypSy22ZZlkEGdi/LLn+kXclS0kqzMrttHqP++z3v9zy8D9/3kZh8BI8i
        8ywO3m7hTDQRIjl3VZUQv/7Z2iy19+gEpvZUI8FU7lUxe3xuxJR/6AtiOltqCeZZ42+c+VW1
        hRn9VkvMJ9kLNd1S1uN1sr6GONY7WCVlr1ePStiKpmOI9d3axA55YzLIVaaUXJ7L4e0K3pJt
        zcmzGPV02nJDqkGXrNbEa2Yzs2iFhTPzenphekb8ojyTvxWtKOBMTv8ogxMEOnFuit3qdPCK
        XKvg0NO8Lcdk06htCQJnFpwWY0K21TxHo1bP1Pmda0y5A4c/4zavvHC4+o6kCLknuVAwCVQS
        FDe0SFwohJRT5xG4bnuQKAYRXHY9HxdfEJQcqJD8jTyoaMXEg1YEh0r2jYuvCPoOdhEBF0HN
        gA+eKtyFSDKcWg6v3WNjjHJC//vrWIDDqHlw2v0JD7CEmg7bv1cEBVhG6WHoVa80EAUqFg79
        HrMHU3PB63uDB1YB1URAx5EiQiy0EG6W9Y9zGPRda5KKHAVDA62EGNiBoN/tQ6IoRtDtLUei
        SwvlZR1YYBtGqeBUS6I4ngoXRg8isXQoDAyX4WIhGZTskosWJRT3DOMiR8PPXz3jzMLD0tox
        llOVCO49Uu5DMTX/FngQOoYm8zbBbOQFjS3p/xfzorFvF8ecR5fuprchikT0RJl68tosOc4V
        CBvMbQhIjA6XGWKNWXJZDrdhI2+3GuxOEy+0IZ3/JiuxqIhsq/8TWxwGjW6mVqtlkpJnJeu0
        dKTsZaYqS04ZOQefz/M23v43F0QGRxWh0xfrMvcUrlZNm1L4tPdazfGQV7jnxpndHSu6pw6u
        +5raVZ964rE0fzEjnH1bGZO+VLn/qf6F+8alZl30HdXn1fkf1eEni39sTtvmjH15pT26K7E5
        tD1b1lrfWRe2JmxEueSmMvJyCbWg/3ba/ebqUkfctyeqyNiIZVs73ynu5+18v7KJlgi5nCYO
        swvcHzA13T+MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvG7Zvaw4g88zpS3mrF/DZjGxX9Oi
        e/NMRove96+YLC7vmsNmcW/Nf1aLf5NqLX7/mMPmwOGxc9Zddo8Fm0o9Nq/Q8tj0aRK7x4kZ
        v1k8+rasYvTYfLra4/MmuQCOKC6blNSczLLUIn27BK6Md4u/sBZsEqr4OuMsSwPjTP4uRk4O
        CQETiUt9e5m7GLk4hAR2M0r0zX/ACJGQkXhz/ilLFyMHkC0scfhwMUTNV0aJc0eWMIHUsAlo
        S7xfMIkVpEZEIFxi6vYKkDCzQKXEv9u3WEFsYQF7iQ0zP4LZLAKqEk2/+sBaeQVsJT4/eskO
        MV5eYuF/ZpAwp4CdxKbNT8HKhYBKWj/MYp/AyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFp
        Xrpecn7uJkZwOGpp7WA8cSL+EKMAB6MSD6+BWFacEGtiWXFl7iFGCQ5mJRHeePn0OCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2M9bMnei14pWL48H/B
        DM6muBzPgE/zLh6dnPS1587UiV3MzV+eHdymoHejnOeEztftD/mZo/Jf/034ztz0cMG+hxca
        hHZYLH/dX8zt81lFZsLvfrWif8LXuYsnFV78495oPZ9vlzmP0sdjhyRn+dY25Dd+6POK+3H4
        967j1QXR8g76/xYK2Yu4KbEUZyQaajEXFScCAHxD8/tDAgAA
X-CMS-MailID: 20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5
References: <20200313011420.15995-1-jaewon31.kim@samsung.com>
        <CGME20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepration for next patch remove inline of vm_unmapped_area and move
code to mmap.c. There is no logical change.

Also remove unmapped_area[_topdown] out of mm.h, there is no code
calling to them.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/mm.h | 21 +--------------------
 mm/mmap.c          | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..1cb01f4a83c9 100644
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
index d681a20eb4ea..eeaddb76286c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
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

