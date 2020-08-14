Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF872078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFvEcPmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHNQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:50:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B20C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:50:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so4835652pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NhtFbl/XT/fNJtXIOkJbd01ZUJG0WSNdtqeIvrQZm5M=;
        b=AFvEcPmCLr6XEpCa6VqWWD3moPXxkQMbV03UY+L7yPI2N6eVEn+FzCWtH53m7X49Oq
         pOQ8wauTltihOwF2MwkFreTJEPK3C/AFjRkAzPv3aPGfxNbnFatjwZBbInhqvZGVOMLe
         m5CHaddGebOKm9LTn99PC4zwVECb7kMrXRnPsEoiQnR7yufZwjjKNidl6aLZfxcm2U5p
         A+sQlpjWlYwSWsBALV7sTrFGt6ukiCQC6770RyXxxhTOt2itVCq4Mbr8Na3cOVqUiCdI
         mYcxw34UmGCLYhI/GZHXUl6JYS44kSNc5/5VDECywSv+SnP5DcT1V1TmjSoYILnWhPKM
         TGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NhtFbl/XT/fNJtXIOkJbd01ZUJG0WSNdtqeIvrQZm5M=;
        b=NlklEl6tR2kXTp84DOUb4QqArskOEg3f/ESzAMOsFvK8tOot8x8ZzHEyzRGgKWXHTC
         dp6pnBKD12T2p/7igeaxrzIahH7i1bsRgyp3vq2YsFzB8/I+BaA8+4U3QhhkhdyuSvsR
         1nz7Rim1PH/BJ0g07Y/tQeLko2ye7Wjco7gTgci2vhlU2PPEilzWKdwD/6lFvkOyWiMd
         nneIq99j36/jVBfOgbylDpAM2q1gzHtkShgUSJJ88DLWt7bEWT3vKTR3zuWujM8JZcjo
         krLhPZI4BirfDDQynCNc2hs6uyYzbV7GKHvRkm0ISCZjNSCDREb39nL1pUJt73IUUSmL
         xj9w==
X-Gm-Message-State: AOAM533ERQBRgQxMtjj5StM8qoRBm0YpLAJLPQ9vMcGJSHOZPRuIfImM
        PPC3ewPPPtbMIKM/+LpqXkM=
X-Google-Smtp-Source: ABdhPJz54ssn56mHayR6quMpHG5wxmawgiA9EHX7ihUxI+z8K87Svdcz2Gq/wnolVhHBau/eI148ow==
X-Received: by 2002:a63:1523:: with SMTP id v35mr2396760pgl.317.1597423811498;
        Fri, 14 Aug 2020 09:50:11 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s125sm9952636pfb.125.2020.08.14.09.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 09:50:10 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2] mm: include CMA pages in lowmem_reserve at boot
Date:   Fri, 14 Aug 2020 09:49:26 -0700
Message-Id: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowmem_reserve arrays provide a means of applying pressure
against allocations from lower zones that were targeted at
higher zones. Its values are a function of the number of pages
managed by higher zones and are assigned by a call to the
setup_per_zone_lowmem_reserve() function.

The function is initially called at boot time by the function
init_per_zone_wmark_min() and may be called later by accesses
of the /proc/sys/vm/lowmem_reserve_ratio sysctl file.

The function init_per_zone_wmark_min() was moved up from a
module_init to a core_initcall to resolve a sequencing issue
with khugepaged. Unfortunately this created a sequencing issue
with CMA page accounting.

The CMA pages are added to the managed page count of a zone
when cma_init_reserved_areas() is called at boot also as a
core_initcall. This makes it uncertain whether the CMA pages
will be added to the managed page counts of their zones before
or after the call to init_per_zone_wmark_min() as it becomes
dependent on link order. With the current link order the pages
are added to the managed count after the lowmem_reserve arrays
are initialized at boot.

This means the lowmem_reserve values at boot may be lower than
the values used later if /proc/sys/vm/lowmem_reserve_ratio is
accessed even if the ratio values are unchanged.

In many cases the difference is not significant, but for example
an ARM platform with 1GB of memory and the following memory layout
[    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]

would result in 0 lowmem_reserve for the DMA zone. This would allow
userspace to deplete the DMA zone easily. Funnily enough
$ cat /proc/sys/vm/lowmem_reserve_ratio
would fix up the situation because it forces
setup_per_zone_lowmem_reserve as a side effect.

This commit breaks the link order dependency by invoking
init_per_zone_wmark_min() as a postcore_initcall so that the
CMA pages have the chance to be properly accounted in their
zone(s) and allowing the lowmem_reserve arrays to receive
consistent values.

Fixes: bc22af74f271 ("mm: update min_free_kbytes from khugepaged after core initialization")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8b7d0ecf30b1..f3e340ec2b6b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7887,7 +7887,7 @@ int __meminit init_per_zone_wmark_min(void)
 
 	return 0;
 }
-core_initcall(init_per_zone_wmark_min)
+postcore_initcall(init_per_zone_wmark_min)
 
 /*
  * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so
-- 
2.7.4

