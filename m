Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BA0206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ9PHLG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHMDwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHMDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:52:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A662C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 20:52:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so2042097pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VA5B9P3jl9Rwei4btklJKhUkayY4KVxIbC/8uysb2Ms=;
        b=FJ9PHLG0g7f2Maa7cEQaeUtA3Ylx3IdGyk8cYMtQQU+98QK+IT2QqARjp/wBJnclBX
         gh6+YGAnyaAijFJi1Sa+mALef97sfGBdvrTpPoi1Tx8/fcwx3zDq290YDgbx0QCLIx+Y
         jGF0U0KLIzHVkBlpJBAd/BG1JF/1W6VfIMxDDa/lbXLKGWIH0+1lHKtpPgOmlAS68sBZ
         qLoNgZSoLqdoYUfoKHkCGuNi1zx52XhloQWeVTec1kqBA+ao3SrUx63zekVagojb1lj2
         Sy6ZYa/hOxGI0tm69Rqv5U/hZFdlQdoZYBCPKmJbHw1blMl9WYcv72/dlef9I24UTDcK
         tf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VA5B9P3jl9Rwei4btklJKhUkayY4KVxIbC/8uysb2Ms=;
        b=Fb/yyaQgYnxTTy8uI3A9XhFDlHPikdTV521MUTJRyiwdGoo8jazU3WTAZHgXHjNKXm
         6TjbceBCl2hEAg9VeoJGC47NJ/rjkejrFi+CUKjFtOLgFwmxCLoQFj8rxUNQMvMXi04u
         E05qTJKvlCORWb4ixetwS8VXEypq0hZl5pxHrh606dqoUqPS4DdtybvcjSdeHPNOx7Xy
         jgCTIP+VWJstY4N/7KTMMjM4Qu+1wOHT0xvaiC/BJ0qYmgKXDkBgwQy3V+3WPJhvr/Rm
         s5G+BjQlqS4s3ba+AmF6+3zFrGaVvxlkQd+LjfGPcsWwpq5iwuphYkmgA6E5Cxbg+aqB
         Tqsg==
X-Gm-Message-State: AOAM532jefl4DWGgVStk2d8KiqCG6uDLf4/OkzwrgKvBmf7BsBd/f8m0
        Vks3Mfbrzn6XbwbHVJ+pxHQT4NGG/OU=
X-Google-Smtp-Source: ABdhPJyyBYECo8VpyG+iLLqstmWjZwM/PavaoCFYPLSee0oyVvu3TxY0sHJDPEst5m3pobV1uZahJQ==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr2239283plq.135.1597290722526;
        Wed, 12 Aug 2020 20:52:02 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e7sm3630443pgn.64.2020.08.12.20.51.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 20:52:01 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH] mm: include CMA pages in lowmem_reserve at boot
Date:   Wed, 12 Aug 2020 20:51:38 -0700
Message-Id: <1597290698-24266-1-git-send-email-opendmb@gmail.com>
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

In many cases the difference is not significant, but in others
it may have an affect.

This commit breaks the link order dependency by invoking
init_per_zone_wmark_min() as a postcore_initcall so that the
CMA pages have the chance to be properly accounted in their
zone(s) and allowing the lowmem_reserve arrays to receive
consistent values.

Fixes: bc22af74f271 ("mm: update min_free_kbytes from khugepaged after core initialization")
Signed-off-by: Doug Berger <opendmb@gmail.com>
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

