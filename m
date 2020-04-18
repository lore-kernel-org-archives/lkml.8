Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577FC38A2D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41E52223D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDRIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:47:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39014 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgDRIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:47:10 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jPj80-0006op-Bv
        for linux-kernel@vger.kernel.org; Sat, 18 Apr 2020 08:47:08 +0000
Received: by mail-wr1-f69.google.com with SMTP id g7so1490075wrw.18
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vOPg5rr8Ro1A6zb9Lv2UALWQl5DWsT0FSeERgKCUFKE=;
        b=qtyGjSFqvPHL2ubVGZdChnvZRI19jeO8GDlTzWUPwWauYVX+44ShlB94qLrREAFTgN
         H61jGd14vfOMPW93MnukahVUc35uGptbZo+j5Nr+IsRcNhR0voa/CKItA5lcNIhSpsJ1
         raW5712QaEs2IVIY1xw6vFFVsBK4BW/Ff0L2rpgIU6ZmmB4ByhFn5k+k/Su+I9W1cXnv
         MyFjkwzWlYL9dvb5DdiDtCBPcsubKHTvI81qa/AJdq5Ugq+tIwxB0CooWZD/Zd2ghbeV
         /xnFV3ucK87WP5MVl38NEMv4VZVkm4yk4BVrwYgP12KSe0Buv3AsOR4IHteeBhc8cXuL
         Pc4g==
X-Gm-Message-State: AGi0PuYVZXbpi1uuP5IEFCa23SrR7I1Ri2NBKSUPKf8+kzGNWlG+O1AB
        wiISIvrJ/LfaxgjywtHRcxH4j4e4qIuVQ5N5jLYWyf9yXtZwbohnr+nSpvQD6b95evcg4rf9qUo
        kE9Fr/f/HZ33ZxiqcMbn42G66drkk8ETXwwpZ+uaRqg==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr8551993wrm.143.1587199627651;
        Sat, 18 Apr 2020 01:47:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpEFeCVqy5Rt0bsSfSYXTR3NDU+MleLjnhB32QOoJMYn3AU4x9EhhyI0g6wBGva+4iCiJ9UQ==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr8551965wrm.143.1587199627338;
        Sat, 18 Apr 2020 01:47:07 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id k9sm36943698wrd.17.2020.04.18.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:47:06 -0700 (PDT)
Date:   Sat, 18 Apr 2020 10:47:05 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm: swap: properly update readahead statistics in
 unuse_pte_range()
Message-ID: <20200418084705.GA147642@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In unuse_pte_range() we blindly swap-in pages without checking if the
swap entry is already present in the swap cache.

By doing this, the hit/miss ratio used by the swap readahead heuristic
is not properly updated and this leads to non-optimal performance during
swapoff.

Tracing the distribution of the readahead size returned by the swap
readahead heuristic during swapoff shows that a small readahead size is
used most of the time as if we had only misses (this happens both with
cluster and vma readahead), for example:

r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
        COUNT      EVENT
        36948      $retval = 8
        44151      $retval = 4
        49290      $retval = 1
        527771     $retval = 2

Checking if the swap entry is present in the swap cache, instead, allows
to properly update the readahead statistics and the heuristic behaves in
a better way during swapoff, selecting a bigger readahead size:

r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
        COUNT      EVENT
        1618       $retval = 1
        4960       $retval = 2
        41315      $retval = 4
        103521     $retval = 8

In terms of swapoff performance the result is the following:

Testing environment
===================

 - Host:
   CPU: 1.8GHz Intel Core i7-8565U (quad-core, 8MB cache)
   HDD: PC401 NVMe SK hynix 512GB
   MEM: 16GB

 - Guest (kvm):
   8GB of RAM
   virtio block driver
   16GB swap file on ext4 (/swapfile)

Test case
=========
 - allocate 85% of memory
 - `systemctl hibernate` to force all the pages to be swapped-out to the
   swap file
 - resume the system
 - measure the time that swapoff takes to complete:
   # /usr/bin/time swapoff /swapfile

Result (swapoff time)
======
                  5.6 vanilla   5.6 w/ this patch
                  -----------   -----------------
cluster-readahead      22.09s              12.19s
    vma-readahead      18.20s              15.33s

Conclusion
==========

The specific use case this patch is addressing is to improve swapoff
performance in cloud environments when a VM has been hibernated, resumed
and all the memory needs to be forced back to RAM by disabling swap.

This change allows to better exploits the advantages of the readahead
heuristic during swapoff and this improvement allows to to speed up the
resume process of such VMs.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
Changes in v4:
 - added a "conclusion" section in the patch description to better
   explain the importance of this change (no functional changes)

 mm/swapfile.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..f8bf926c9c8f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1937,10 +1937,14 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		pte_unmap(pte);
 		swap_map = &si->swap_map[offset];
-		vmf.vma = vma;
-		vmf.address = addr;
-		vmf.pmd = pmd;
-		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
+		page = lookup_swap_cache(entry, vma, addr);
+		if (!page) {
+			vmf.vma = vma;
+			vmf.address = addr;
+			vmf.pmd = pmd;
+			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+						&vmf);
+		}
 		if (!page) {
 			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
 				goto try_next;
-- 
2.25.1


