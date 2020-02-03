Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14327C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12FA21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkgvUjOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBCXX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:23:27 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46293 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgBCXXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:23:25 -0500
Received: by mail-pf1-f201.google.com with SMTP id c185so10283404pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AAnnuPr/HPGLn+hB/1uqyzxSnBEz8gxTGjNzCNKjlS0=;
        b=YkgvUjOhEnSOR192jl1bKhbfajQljLIUBasKGgoyrMqoBix5dJvEkT/w2gCbif5WQg
         AxALwxZVORapq4E2odlv0R7fR5oDwsdOtA4u60L4ddNBtTyyNtEO02kYWzB4r2Sp7dvS
         yNv6hQnHsomyne2JwoZvzi4fAPIq5CJfZ/x6ZOmmbQsm8DUB9YTqi16x2upBDlR9mamg
         HVGabJAx3mW4ia2vc/uNw+qQ6nXSFvrWYIvNMb/ucRE1rZmjK8JozF3Sd+61ODjhFdVq
         Mehl/BIchmECuN2gfIXQtg+NWrrITCnPqrRsQiwIJLD19ZWvKOZjDW0cITiMBcAX89oU
         iAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AAnnuPr/HPGLn+hB/1uqyzxSnBEz8gxTGjNzCNKjlS0=;
        b=OSfEYeFc/Pyv9sv9dJTdcam23EAJl5Nm4/FNezcGZISyzI1llwomQoybjyllhruk8w
         Exf/RGQekL3b3tm5Hbh9TGOX9MMJaJJQqwepLXbsdI+PXMC/dGvN8O4gQJXbviKA69uj
         XZOtRgJWWXIR/E9pnViqUSKbQjt4pXoL11+04DJ+oM3PFmfDKlFIM2od3oaZ4qzo1tb4
         M7SWC0uTrHzkES1Hy9RVXRsCqPq8pMErXIIhtfZgINHuRGV68fe0xxgF+G8Q2/Qasf7z
         IDyqmL57gWslacsQIe1VRv4+fMuPqg56G2X4E87hileQhiKJG55QXmQsZmJgBi4FCX4X
         Zo5Q==
X-Gm-Message-State: APjAAAU3RPlmYij7zl9ABpfY8ilnnpCL+ydN79nGQ9cxxdMD38gWlm3H
        ZL9YUT6y2u8p90yxHqO5zIBPtTLpWqaGN356iQ==
X-Google-Smtp-Source: APXvYqyhLae0QP76xxs/IosBsmNX7AreR4agocuTC7BThUsrEMEoBlcXac4AiXDBVJSoapD/oaFOMzb07uO0AMuHyw==
X-Received: by 2002:a63:4853:: with SMTP id x19mr28162927pgk.385.1580772204625;
 Mon, 03 Feb 2020 15:23:24 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:22:46 -0800
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Message-Id: <20200203232248.104733-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v11 7/9] hugetlb: support file_region coalescing again
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier patch in this series disabled file_region coalescing in order
to hang the hugetlb_cgroup uncharge info on the file_region entries.

This patch re-adds support for coalescing of file_region entries.
Essentially everytime we add an entry, we check to see if the
hugetlb_cgroup uncharge info is the same as any adjacent entries. If it
is, instead of adding an entry we simply extend the appropriate entry.

This is an important performance optimization as private mappings add
their entries page by page, and we could incur big performance costs for
large mappings with lots of file_region entries in their resv_map.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 mm/hugetlb.c | 62 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ec0b55ea1506e..058dd9c8269cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -272,6 +272,22 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 #endif
 }

+static bool has_same_uncharge_info(struct file_region *rg,
+				   struct hugetlb_cgroup *h_cg,
+				   struct hstate *h)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	return rg &&
+	       rg->reservation_counter ==
+		       &h_cg->rsvd_hugepage[hstate_index(h)] &&
+	       rg->pages_per_hpage == pages_per_huge_page(h) &&
+	       rg->css == &h_cg->css;
+
+#else
+	return true;
+#endif
+}
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
  * list. If regions_needed != NULL and count_only == true, then regions_needed
@@ -286,7 +302,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	long add = 0;
 	struct list_head *head = &resv->regions;
 	long last_accounted_offset = f;
-	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
+	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL, *prg = NULL;

 	if (regions_needed)
 		*regions_needed = 0;
@@ -318,16 +334,34 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		if (rg->from > last_accounted_offset) {
 			add += rg->from - last_accounted_offset;
 			if (!count_only) {
-				nrg = get_file_region_entry_from_cache(
-					resv, last_accounted_offset, rg->from);
-				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
-								    h);
-				list_add(&nrg->link, rg->link.prev);
+				/* Check if the last region can be extended. */
+				if (prg && prg->to == last_accounted_offset &&
+				    has_same_uncharge_info(prg, h_cg, h)) {
+					prg->to = rg->from;
+				/* Check if the next region can be extended. */
+				} else if (has_same_uncharge_info(rg, h_cg,
+								  h)) {
+					rg->from = last_accounted_offset;
+				/* If neither of the regions can be extended,
+				 * add a region.
+				 */
+				} else {
+					nrg = get_file_region_entry_from_cache(
+						resv, last_accounted_offset,
+						rg->from);
+					record_hugetlb_cgroup_uncharge_info(
+						h_cg, nrg, h);
+					list_add(&nrg->link, rg->link.prev);
+				}
 			} else if (regions_needed)
 				*regions_needed += 1;
 		}

 		last_accounted_offset = rg->to;
+		/* Record rg as the 'previous file region' incase we need it
+		 * for the next iteration.
+		 */
+		prg = rg;
 	}

 	/* Handle the case where our range extends beyond
@@ -336,10 +370,18 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	if (last_accounted_offset < t) {
 		add += t - last_accounted_offset;
 		if (!count_only) {
-			nrg = get_file_region_entry_from_cache(
-				resv, last_accounted_offset, t);
-			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
-			list_add(&nrg->link, rg->link.prev);
+			/* Check if the last region can be extended. */
+			if (prg && prg->to == last_accounted_offset &&
+			    has_same_uncharge_info(prg, h_cg, h)) {
+				prg->to = last_accounted_offset;
+			} else {
+				/* If not, just create a new region. */
+				nrg = get_file_region_entry_from_cache(
+					resv, last_accounted_offset, t);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+								    h);
+				list_add(&nrg->link, rg->link.prev);
+			}
 		} else if (regions_needed)
 			*regions_needed += 1;
 	}
--
2.25.0.341.g760bfbb309-goog
