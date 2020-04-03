Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBEC2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0AB20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QbzBh9e+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390854AbgDCNf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:35:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40016 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390822AbgDCNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:35:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id z15so1710266qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=fGV3n8t+9BV7JTkRPUzZ2QXHvp25yaVJAKZtXq13X1k=;
        b=QbzBh9e+W+8iOpYg0+rGGGiU6KrpTT42G5riwwro+9vvy+mAOclzJDqQGKBZYWFEVK
         0Y7WR7UKpFVgrB3UlLssjLQQzJS+DC8MZcX0LIiatPACJpJ/IqNvk+3mVyLsad+BkABl
         n4C0d9q5ZWEo6kYiRHX6nLpp3Z0zK5ruBmCa6xPv5CHirh0N7zn4YyotF0XL5gewijuw
         LjM2AbR6gi+RgiCqfmIKvxyZoUGjhmkxg2Lw5UqdtblJJiV4a0gcKOhwdmszBnSgL1sy
         n38Z1/glMlD6Q8ic0OU5MbyRrf5kzkmUZspLb4aGPEEhX/KArbhSuncZKrFdxWMofvj1
         YXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=fGV3n8t+9BV7JTkRPUzZ2QXHvp25yaVJAKZtXq13X1k=;
        b=unfs+Tj8xt3cn4lFTn+9xdiYmWWxoPJ4fiBZcMdaZIyN+Qx5ZFRF2iozpXJLpbEIu4
         a1th2nU7lRcjAC0Yes8d1/9Dm/suYOVlVhP79PJ4mkOS7lidpOl1CFZY+RPc1VJa4uey
         tzbjL2RnQe7kmMmP2Q5kMdDkkW4KD/Pe15wfMyw3hy40grHPZyF7iwOa4uEPPjdvCWl1
         taJnUzRf8/Zohwj/i5xksCTbtx5B3zznVMGsWjQSEvJwx5iRvaZGEkOqoHqk+FiJjViB
         aqXVSlwIbmklZuvh+o5kKDFUJXRvg9iunh/T6PnagDpsEaYesQCqJDGqSMp07oF9V09G
         /d1Q==
X-Gm-Message-State: AGi0Pub8AMki2jPr+bTo7a1X8Etd2Zi1/O0sICAATje9GgbQvuGngsvF
        nqG26aTs0OfB0Aokzr005d36/U7Yywo=
X-Google-Smtp-Source: APiQypJCvkMVix2XYKBYT3Rs1fxbKi+KbxCQXEGCj6HEdOr2BiuHAjnK+DDnF7WjEbM/Sl2K/RLu+Q==
X-Received: by 2002:ae9:dd02:: with SMTP id r2mr8129764qkf.180.1585920953238;
        Fri, 03 Apr 2020 06:35:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 17sm6210799qkm.105.2020.04.03.06.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:35:52 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v3 1/3] mm: call touch_nmi_watchdog() on max order boundaries in deferred init
Date:   Fri,  3 Apr 2020 09:35:47 -0400
Message-Id: <20200403133549.14338-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403133549.14338-1-pasha.tatashin@soleen.com>
References: <20200403133549.14338-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

deferred_init_memmap() disables interrupts the entire time, so it calls
touch_nmi_watchdog() periodically to avoid soft lockup splats.  Soon it
will run with interrupts enabled, at which point cond_resched() should
be used instead.

deferred_grow_zone() makes the same watchdog calls through code shared
with deferred init but will continue to run with interrupts disabled, so
it can't call cond_resched().

Pull the watchdog calls up to these two places to allow the first to be
changed later, independently of the second.  The frequency reduces from
twice per pageblock (init and free) to once per max order block.

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
Cc: stable@vger.kernel.org # 4.17+

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>

---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..e8ff6a176164 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1639,7 +1639,6 @@ static void __init deferred_free_pages(unsigned long pfn,
 		} else if (!(pfn & nr_pgmask)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 1;
-			touch_nmi_watchdog();
 		} else {
 			nr_free++;
 		}
@@ -1669,7 +1668,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 			continue;
 		} else if (!page || !(pfn & nr_pgmask)) {
 			page = pfn_to_page(pfn);
-			touch_nmi_watchdog();
 		} else {
 			page++;
 		}
@@ -1809,8 +1807,10 @@ static int __init deferred_init_memmap(void *data)
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
+	}
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
@@ -1894,6 +1894,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 		first_deferred_pfn = spfn;
 
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
 
 		/* We should only stop along section boundaries */
 		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
-- 
2.17.1

