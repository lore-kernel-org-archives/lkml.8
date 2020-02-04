Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55936C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F0720730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nmTN3EPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBDM65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:58:57 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38426 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBDM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:58:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200204125854euoutp02d0f653d63134eff5f933ed7840cd38d5~wNHJGACug2459424594euoutp02t
        for <linux-kernel@vger.kernel.org>; Tue,  4 Feb 2020 12:58:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200204125854euoutp02d0f653d63134eff5f933ed7840cd38d5~wNHJGACug2459424594euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580821134;
        bh=OpcxaeFkkMnFoF4KDR3jWlSTbVAXsa0PzMZkJ48/Klw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nmTN3EPJbeOEiyv73LIhyH7Ssbv9xllRlaDl5KXSJJ8eugDoIf7LruXQuhgHC+I+J
         iQpy5lb0Ya6Kip9ztltpgTDVum05kvtsvfPyhVZxSumC6FYpVuXcPvsHYlIeKF+ahQ
         0QcU8krZTDbiGdn81UKsiMc69NVpC6CfL9PoxvL4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200204125854eucas1p2e5152ed7218c2f4cd6418263e191357f~wNHI1sifg1929819298eucas1p2m;
        Tue,  4 Feb 2020 12:58:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E0.6D.60698.E8A693E5; Tue,  4
        Feb 2020 12:58:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd~wNHIiIUV_2294722947eucas1p1f;
        Tue,  4 Feb 2020 12:58:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200204125854eusmtrp26c0f7ebe3f233d77e4b723f80a75975d~wNHIhiFL30906509065eusmtrp2r;
        Tue,  4 Feb 2020 12:58:54 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-60-5e396a8e5ab9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.C8.08375.D8A693E5; Tue,  4
        Feb 2020 12:58:53 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200204125853eusmtip1a0d64063c1b54e266cf56a375ebb3b8a~wNHIMWkkz0624506245eusmtip1D;
        Tue,  4 Feb 2020 12:58:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree-compiler@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] libfdt: place new nodes & properties after the parent's
 ones
Date:   Tue,  4 Feb 2020 13:58:44 +0100
Message-Id: <20200204125844.19955-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7djPc7p9WZZxBpNfCFpsnLGe1eLDwW1M
        Fpd3zWGzWHvkLrsDi0ffllWMHp83yQUwRXHZpKTmZJalFunbJXBlPGj+xFLwR6Ri5YXjjA2M
        dwW6GDk5JARMJK6s/s7UxcjFISSwglHi5oYnbBDOF0aJ+c+bmSGcz4wSi7bvYodpmfjtNVTL
        ckaJxXs7meFaXn+dwAJSxSZgKNH1tosNxBYRUJd4MO0EWAezQCujxIMrF8ESwgL+EuuWzGIG
        sVkEVCXW7pnICmLzCthKrJw/A2qdvMTqDQfANkgIrGGT2PL+OgtEwkXi8eLfULawxKvjW6Aa
        ZCT+75zPBNHQzCjx8Nxadginh1HictMMRogqa4k7534BncEBdJOmxPpd+hBhR4lD79uZQMIS
        AnwSN94KgoSZgcxJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMELaHxI1Hd8B+FBKIlXj5ZB3r
        BEa5WQi7FjAyrmIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAiM6tP/jn/dwbjvT9IhRgEO
        RiUeXg1Hizgh1sSy4srcQ4wSHMxKIrzn9S3jhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZ
        KySQnliSmp2aWpBaBJNl4uCUamAs/v4iYOL0ziLBBOZv2gwak1Wu/pnYOE3+6p7maA6WFapH
        eG3mvT0Q7+T16Z73t3tVuYVTJmw737pnwkHLRZ/rlH7eN0nQ2vxsgtKGZ47qIlqaj09pdP14
        e6gg9X9PyKLZ9eXfF5q+O/U2Id4xZJnylYcSsf1VPz9X3JrQ8zzVWDH02ZfNqR7lSizFGYmG
        WsxFxYkAXKsmouYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t/xu7q9WZZxBrs+mltsnLGe1eLDwW1M
        Fpd3zWGzWHvkLrsDi0ffllWMHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlPGj+xFLwR6Ri5YXjjA2MdwW6GDk5JARMJCZ+e83UxcjF
        ISSwlFHiTPcxRoiEjMTJaQ2sELawxJ9rXWwQRZ8YJdrOTWICSbAJGEp0vQVJcHKICKhLPJh2
        AmwSs0A7o8TfzjXsIAlhAV+Jxd86wIpYBFQl1u6ZCDaVV8BWYuX8GewQG+QlVm84wDyBkWcB
        I8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwFDaduzn5h2MlzYGH2IU4GBU4uG9YGcRJ8Sa
        WFZcmXuIUYKDWUmE97y+ZZwQb0piZVVqUX58UWlOavEhRlOg5ROZpUST84FhnlcSb2hqaG5h
        aWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbF4ZZ5xScbq6u5eqak3l77adcg5
        a25cMaf9zsgn1+f/jAiOkPKd0LIj8KFys6l7y/vwv0YVW57mpOT+NCg7fuXm396IVW5bb5zm
        5q4o/S/6SFtu6yOD/Q0dURw6Gaf+XDp1acG02b6KSTd/yXh+vXoy0lD49KOd5awvi/maeXVT
        t/TFhL/ZLKDEUpyRaKjFXFScCACua4WpOwIAAA==
X-CMS-MailID: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While applying dt-overlays using libfdt code, the order of the applied
properties and sub-nodes is reversed. This should not be a problem in
ideal world (mainline), but this matters for some vendor specific/custom
dtb files. This can be easily fixed by the little change to libfdt code:
any new properties and sub-nodes should be added after the parent's node
properties and subnodes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 libfdt/fdt_rw.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/libfdt/fdt_rw.c b/libfdt/fdt_rw.c
index 8795947..88c5930 100644
--- a/libfdt/fdt_rw.c
+++ b/libfdt/fdt_rw.c
@@ -189,19 +189,27 @@ static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
 			     int len, struct fdt_property **prop)
 {
 	int proplen;
-	int nextoffset;
+	int offset, nextoffset;
 	int namestroff;
 	int err;
 	int allocated;
+	uint32_t tag;
 
 	if ((nextoffset = fdt_check_node_offset_(fdt, nodeoffset)) < 0)
 		return nextoffset;
 
+	/* Try to place the new property after the parent's properties */
+	fdt_next_tag(fdt, nodeoffset, &nextoffset); /* skip the BEGIN_NODE */
+	do {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
+
 	namestroff = fdt_find_add_string_(fdt, name, &allocated);
 	if (namestroff < 0)
 		return namestroff;
 
-	*prop = fdt_offset_ptr_w_(fdt, nextoffset);
+	*prop = fdt_offset_ptr_w_(fdt, offset);
 	proplen = sizeof(**prop) + FDT_TAGALIGN(len);
 
 	err = fdt_splice_struct_(fdt, *prop, 0, proplen);
@@ -321,6 +329,7 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 	struct fdt_node_header *nh;
 	int offset, nextoffset;
 	int nodelen;
+	int depth = 0;
 	int err;
 	uint32_t tag;
 	fdt32_t *endtag;
@@ -333,12 +342,21 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 	else if (offset != -FDT_ERR_NOTFOUND)
 		return offset;
 
-	/* Try to place the new node after the parent's properties */
+	/* Try to place the new node after the parent's subnodes */
 	fdt_next_tag(fdt, parentoffset, &nextoffset); /* skip the BEGIN_NODE */
 	do {
+again:
 		offset = nextoffset;
 		tag = fdt_next_tag(fdt, offset, &nextoffset);
-	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
+		if (depth && tag == FDT_END_NODE) {
+			depth--;
+			goto again;
+		}
+		if (tag == FDT_BEGIN_NODE) {
+			depth++;
+			goto again;
+		}
+	} while (depth || (tag == FDT_PROP) || (tag == FDT_NOP));
 
 	nh = fdt_offset_ptr_w_(fdt, offset);
 	nodelen = sizeof(*nh) + FDT_TAGALIGN(namelen+1) + FDT_TAGSIZE;
-- 
2.17.1

