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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57814C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C5621D82
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdQHIPT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDTIAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61924C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so4665700pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G/wuob1wBc0uGcbRuTvY4jgnkdXzxj6DiOgk3GS0MzM=;
        b=fdQHIPT1rwwJ5DrceIYUArOc+74FSdCBMoF3QA857fnNN34SFou0axcbsXC9m03XQZ
         abwjovn06OxQYSSaihJZ9uzsaE/67YhzBjC5Y0yb2/1A2OCvg1TF+SoKsBhI2RXMncY7
         +Mu7WwHTJ2PY+fOSirsrjxy+7CT1mqUDbYqMdH4hD7MJWhMeV8Ym2VJzSVS9CdobOCgC
         9I54GhNU2nlmnJLLexdsUQbQQutshuT1qdCzvaPdB5BtITXq/2ehr/ruTcM5e26MQqdx
         5fl+1qLJ3qhKoWffSDiBC65fWi1jw0Ti/flwzqjabQlHMnTqLifX1lOJivGQk0q1raqT
         qoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G/wuob1wBc0uGcbRuTvY4jgnkdXzxj6DiOgk3GS0MzM=;
        b=SW/p7ZGEjRBTM2qn+BXsISG/ntZX2dywTOIbB9Fwb6uLbHlAUdMcbz0E/a+1KCF41l
         nEamzfg5IEqWzqD/9q24HPmIqQAMgrdogw7oj5XFtAq9ZAWa7ckb7zulp3a3jGM7cAOW
         fGiO5t+OX+4YorSQHZoF4kdHxeeyNpWtEFrrx3leytfPYux7XlaLhGCPCdOC1FIPn/oP
         q97maQoUswyiqFNZfmm6GU1InjK/YN9Bl8T+juARJbRTDI4aPeSCV83OoBHM03cKlNLN
         tVgTxwwbk1mzH0ClZbYDfTCNzFVuTVt8tqOuKr2bJyh8ZoCp5HaaXVyvAhmvt1I7CP65
         5RrQ==
X-Gm-Message-State: AGi0PuYxBm9W0MPULa05FADlHx+gCBZtJJSAkbqM7R+uB5DyyyDaiff4
        sb5WgfcMxkuBprWo45gF8FY=
X-Google-Smtp-Source: APiQypL2ITbegcNjaGG8rgkKtk56hMOUjxCaEefh+DxxiWwKZ06Ga0Tj4IvO9iBqVVTIypqxVp6/8w==
X-Received: by 2002:a63:7c1:: with SMTP id 184mr14869032pgh.77.1587369652882;
        Mon, 20 Apr 2020 01:00:52 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:52 -0700 (PDT)
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
Subject: [PATCH 06/10] mm/gup: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:38 +0900
Message-Id: <1587369582-3882-7-git-send-email-iamjoonsoo.kim@lge.com>
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

Now, we have separate functions, PageHighMem() and PageHighMemZone() for
each cases. Use appropriate one.

Note that there are some rules to determine the proper macro.

1. If PageHighMem() is called for checking if the direct mapping exists
or not, use PageHighMem().
2. If PageHighMem() is used to predict the previous gfp_flags for
this page, use PageHighMemZone(). The zone of the page is related to
the gfp_flags.
3. If purpose of calling PageHighMem() is to count highmem page and
to interact with the system by using this count, use PageHighMemZone().
This counter is usually used to calculate the available memory for an
kernel allocation and pages on the highmem zone cannot be available
for an kernel allocation.
4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
is just copy of the previous PageHighMem() implementation and won't
be changed.

I apply the rule #2 for this patch.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 43b0d83..5199de0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1603,7 +1603,7 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	 */
 	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
 
-	if (PageHighMem(page))
+	if (PageHighMemZone(page))
 		gfp_mask |= __GFP_HIGHMEM;
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.7.4

