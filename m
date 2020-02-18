Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF2C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65112173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgBRWRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:17:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38242 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBRWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:17:24 -0500
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j4BBC-0008R0-Dj
        for linux-kernel@vger.kernel.org; Tue, 18 Feb 2020 22:17:22 +0000
Received: by mail-qv1-f70.google.com with SMTP id g15so13333388qvk.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePSzxjRqtz2vpkYpI6b9sCEQoHO2KCvSWV7iBfKgM9M=;
        b=bSMZ10SmUFAXrXS7MsdftkqU/7Cyk6rfadTZt4jiOJULRilrAPpT8oyBcpqrlskyAR
         vHGT07bPm/+5D+IAMuFDMO+zlrbRY0P5F1i/lHyPLQ0M+y7kEmr06d7fZps79BtnzQ0N
         3l5g+9crA5gZeaJnmEjDOTD0NojYd7qlMOeNiXgCO3MOeSal65u9HTG0X9uIGHX/WAid
         I1dg4/aSyVihLVAZlLDxn4VkoXR+u29G61lnpcSzgvlOiUFRGo0clrR4KAIp1wOpFsSs
         si/Mey0I9F/VC38Ua1DLH7e2MXVTjTpjudHQHg0SrxWLpV/JTJw5urhhI9Y0MMuCCkiQ
         95FQ==
X-Gm-Message-State: APjAAAV3+Va66g4L4toRBbymfYP+QiQHdoE2EZkzlNa2zhBZuQWluIOP
        iwL0dSvQc+bL/Upe+IP/Ad7CflN9a12a+IMaAiMVLOeb4E9iQ0skfy3n7c76SJJbW/DRJdF0zAc
        BxiRcs7+6thrOiSlnh2lMWsEIqKiAaFsfUIqB5qoFiA==
X-Received: by 2002:a37:7a06:: with SMTP id v6mr21410913qkc.378.1582064241207;
        Tue, 18 Feb 2020 14:17:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+liMLysEyoFnIHvLaJknNLKj4RrPLdl1EOo4buQMOqwMnaMHjyc1bR+LTw+8iQ1LqG6L+5A==
X-Received: by 2002:a37:7a06:: with SMTP id v6mr21410895qkc.378.1582064240957;
        Tue, 18 Feb 2020 14:17:20 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:1c35:828a:99a9:563b])
        by smtp.gmail.com with ESMTPSA id e130sm8172qkb.72.2020.02.18.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:17:20 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/page-writeback.c: write_cache_pages(): deduplicate identical checks
Date:   Tue, 18 Feb 2020 19:17:16 -0300
Message-Id: <20200218221716.1648-1-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There used to be a 'retry' label in between the two (identical) checks
when first introduced in commit f446daaea9d4 ("mm: implement writeback
livelock avoidance using page tagging"), and later modified/updated in
commit 6e6938b6d313 ("writeback: introduce .tagged_writepages for the
WB_SYNC_NONE sync stage").

The label has been removed in commit 64081362e8ff ("mm/page-writeback.c:
fix range_cyclic writeback vs writepages deadlock"), and the (identical)
checks are now present / performed immediately one after another.

So, remove/deduplicate the latter check, moving tag_pages_for_writeback()
into the former check before the 'tag' variable assignment, so it's clear
that it's not used in this (similarly-named) function call but only later
in pagevec_lookup_range_tag().

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---

 v2: add the missing braces to the conditional statement
     with more than a single statement.. doh; and to the
     else branch (w/a single statement, per coding style.)

 mm/page-writeback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2caf780a42e7..ab5a3cee8ad3 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2182,12 +2182,12 @@ int write_cache_pages(struct address_space *mapping,
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			range_whole = 1;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
+		tag_pages_for_writeback(mapping, index, end);
 		tag = PAGECACHE_TAG_TOWRITE;
-	else
+	} else {
 		tag = PAGECACHE_TAG_DIRTY;
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, index, end);
+	}
 	done_index = index;
 	while (!done && (index <= end)) {
 		int i;
-- 
2.20.1

