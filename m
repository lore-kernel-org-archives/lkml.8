Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C579C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB4321D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IY7dG2oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgAQWLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:11:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgAQWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:11:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so12559176pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=I07pR0oCHYZ+OosxxFEWPv5kDJlwMJ/Csumm0eUVygc=;
        b=IY7dG2oFgZVtqoBqrQQrRCWrDUSV1LC/NSDgr//4rHlhS6Vp+V2u9iTNfTll0hhDN0
         DdXnXLiBhzLElgcNysVIBSjuv1OZHnhvzacjA3ME7q7snNAM7nhpF2/eLxykhfZW9nxZ
         p9bT7Qf/wSA3MOfjBFHK00dxMdnX6IDsCoC1fY5U2jLU64alEpoY1r9mUrfYgG3Utqsq
         xDxk6JCxmxEFka1Jf6072QxB24IglEagJ24t0HdToxnLnNCEuF6zAoMUQaNJvfDrgwaf
         5AjBAIM9OAWoOBELnt7qJa4Hs15KW19nZkxmsmx4U3bj7f18zSMFOyPOyJctM0TiPkZs
         pkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=I07pR0oCHYZ+OosxxFEWPv5kDJlwMJ/Csumm0eUVygc=;
        b=CJAfkgeCAeQMsCz4f5dvE6ilVa4LSLRng5W1jahkMDiXSAeGgXpT3lkiITJZF1kifT
         03jzP8mt5POxoi7j6uwxXfKIRz4HpKIuO1KzBqnfpI9jSdeaLqzbJkg2Dnepii8548CF
         xCN0oUtrUBdkz4L5dMRn5G9bu7EjnHrksPyWEs3PnXq9pvlbQj5S7o42uT+gO1G9bLqm
         h046dWbesVfZH2bOdE0llJQrem1wyTjHlBQtbqwOmkl+YTS2bLIf6kxlmlr/aPcq9lOv
         wrpLA3dkGrZuPJc2NfBZUXspu1gxQDoFuPSmfe8FR34F0vJfhkvwODQYGpRmT3cv5NSv
         zxqg==
X-Gm-Message-State: APjAAAVjmhQdijiSBcBEJU/QeDB/A0K8daE8C13AGzFplbbxIB9tVbU+
        RiESXHIywo5o9EeX3h6MU7OhKkCkDto=
X-Google-Smtp-Source: APXvYqzl5ui39E2Jhw94MkIfpeo/6fENDkaM2NcZLxDoCcu8TbV6QLo/CC4vzcYcHtJWW6l4jIGhIA==
X-Received: by 2002:a63:d62:: with SMTP id 34mr49600714pgn.268.1579299109485;
        Fri, 17 Jan 2020 14:11:49 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a195sm30899088pfa.120.2020.01.17.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:11:48 -0800 (PST)
Date:   Fri, 17 Jan 2020 14:11:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch v2] mm, thp: fix defrag setting if newline is not used
In-Reply-To: <a3c269a7-ff41-ee7c-9041-ee06e50c5a10@suse.cz>
Message-ID: <alpine.DEB.2.21.2001171411020.56385@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com> <20200116191609.3972fd5301cf364a27381923@linux-foundation.org> <025511aa-4721-2edb-d658-78d6368a9101@suse.cz> <alpine.DEB.2.21.2001170136280.20618@chino.kir.corp.google.com>
 <a3c269a7-ff41-ee7c-9041-ee06e50c5a10@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If thp defrag setting "defer" is used and a newline is *not* used when
writing to the sysfs file, this is interpreted as the "defer+madvise"
option.

This is because we do prefix matching and if five characters are written
without a newline, the current code ends up comparing to the first five
bytes of the "defer+madvise" option and using that instead.

Use the more appropriate sysfs_streq() that handles the trailing newline
for us.  Since this doubles as a nice cleanup, do it in enabled_store()
as well.

Fixes: 21440d7eb904 ("mm, thp: add new defer+madvise defrag option")
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 Latest 5.5-rc6 doesn't boot for me, something to be debugged separately,
 so this was tested on 5.4.  No changes in this area, however, between
 the two kernels.

 mm/huge_memory.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 13cc93785006..1c61dea937bc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -177,16 +177,13 @@ static ssize_t enabled_store(struct kobject *kobj,
 {
 	ssize_t ret = count;
 
-	if (!memcmp("always", buf,
-		    min(sizeof("always")-1, count))) {
+	if (sysfs_streq(buf, "always")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("madvise", buf,
-			   min(sizeof("madvise")-1, count))) {
+	} else if (sysfs_streq(buf, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("never", buf,
-			   min(sizeof("never")-1, count))) {
+	} else if (sysfs_streq(buf, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
 	} else
@@ -250,32 +247,27 @@ static ssize_t defrag_store(struct kobject *kobj,
 			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
-	if (!memcmp("always", buf,
-		    min(sizeof("always")-1, count))) {
+	if (sysfs_streq(buf, "always")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("defer+madvise", buf,
-		    min(sizeof("defer+madvise")-1, count))) {
+	} else if (sysfs_streq(buf, "defer+madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("defer", buf,
-		    min(sizeof("defer")-1, count))) {
+	} else if (sysfs_streq(buf, "defer")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("madvise", buf,
-			   min(sizeof("madvise")-1, count))) {
+	} else if (sysfs_streq(buf, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("never", buf,
-			   min(sizeof("never")-1, count))) {
+	} else if (sysfs_streq(buf, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
