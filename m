Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B90C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D8221927
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgWD3qhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDTIBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:01:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77714C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:01:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so4554311pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nsx1nAzu/4IjpERoVyY6SnIjrlRZ5fYE1H4hmGJNrOs=;
        b=sgWD3qhhnIaTK/UDtnfaErwDaCv5ytr79OtnA304aSdPTCnortVmqPP2YSZU5//FB8
         9/nhTTku0eJtrjnB9kz+zIvAtfyIU28pS7y+L0SUVDMTbg6XXkncVhIbrshCmyJJOYjw
         DnF3tn0ZMhOzZWC33j+UVYAiHSVeDQXO3lWcVytdYBHh20+6ck+Z18OBncg+jt2bTIl2
         M10CtSeIb03s9mWkFEl+Ghf/84V0pgN28tG2hOo8btKdSie8Pu/ly4xwKK4kIt3GX9uV
         ++KM2XjONM+V/wNabJ3BduyGMUHx48Kc3rM03f42yXolhlI7H+NU1VixQ48m5afnN494
         Lpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nsx1nAzu/4IjpERoVyY6SnIjrlRZ5fYE1H4hmGJNrOs=;
        b=XGSjG+CUteFvFDlCXCD/jvGVx7waI3syEg6Fh41q4X9p/uNl7Sc7ElVEzdcEQTLwcl
         K5t5saSnBbzFMMVOsFzV+9IEfmar/dydoqF8BeeLyCIFC5OPheiF+gxjL62fRUhfiy0D
         mz6spOxjQCFhsIQmT3sN0UNLs1SMZ1/134mHk1wStDxWB58iVg61p/qciOwIw8ZU5A2f
         2Au5gmttI5veDoub+Y0/HzTh1++nPaKL7RlbC7/jQS+U4HQQKHWloHLavFI8TSiJmaPj
         Agm0PzJWauohIz5bxYGVuBPUhDiHcSKIFDzc+tNF2iiFS9EDQ/EYQNGLGpGNfLvB0Wgl
         gwOQ==
X-Gm-Message-State: AGi0PuZYQj21i7imNKC08Ns70XoKTmujPxOAgML0EGhdWgniBVXFzIEe
        bt0reMfGs6KMzxhRzNTO0uw=
X-Google-Smtp-Source: APiQypL3+hsYLGvHCOb6pozOVQI7g5jjGwti43W8THeIPnoYzD+h/KwfZ77nfNt8nDrj54CL2Ln5YQ==
X-Received: by 2002:a62:7b03:: with SMTP id w3mr9258910pfc.313.1587369670013;
        Mon, 20 Apr 2020 01:01:10 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.01.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:01:09 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 10/10] mm/page-flags: change the implementation of the PageHighMem()
Date:   Mon, 20 Apr 2020 16:59:42 +0900
Message-Id: <1587369582-3882-11-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Until now, PageHighMem() is used for two different cases. One is to check
if there is a direct mapping for this page or not. The other is to check
the zone of this page, that is, weather it is the highmem type zone or not.

Previous patches introduce PageHighMemZone() macro and separates both
cases strictly. So, now, PageHighMem() is used just for checking if
there is a direct mapping for this page or not.

In the following patchset, ZONE_MOVABLE which could be considered as
the highmem type zone in some configuration could have both types of
pages, direct mapped pages and unmapped pages. So, current implementation
of PageHighMem() that checks the zone rather than checks the page in order
to check if a direct mapping exists will be invalid. This patch prepares
that case by implementing PageHighMem() with the max_low_pfn.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/page-flags.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fca0cce..7ac5fc8 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -375,6 +375,8 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 
 #ifdef CONFIG_HIGHMEM
+extern unsigned long max_low_pfn;
+
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
  * available at this point.
@@ -383,7 +385,7 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
  * in order to predict previous gfp_flags or to count something for system
  * memory management.
  */
-#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define PageHighMem(__p) (page_to_pfn(__p) >= max_low_pfn)
 #define PageHighMemZone(__p) is_highmem_idx(page_zonenum(__p))
 #else
 PAGEFLAG_FALSE(HighMem)
-- 
2.7.4

