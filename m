Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B35C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6DE24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rp40sf94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAOB6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:58:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35951 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgAOB6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:58:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so6100021plm.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=fj5c4UIrwrHuebCnymMMYIFQTDYFE/X+bvsiYmpq1Rk=;
        b=rp40sf94iCEseNvhH50Jdc6oYJ86AKGlN+xQYpJeK1VMwb6JRd2kU1FwlPEuRsWOgG
         hsQkXNJ3e/tUuqqEQY/m+jjKwKoHayO6J5kXj4zv6kLZRc+B/ofINmXQrFJWsLj/5Pi6
         f3xl6aoH8pYHbyNccC+LvUJ1AiiZZBdHE9gLsj/7QZpxPQFxC7W3ZkkWC5HZotUMisMj
         9elVQEz5uMUgUGHnu0/Ps13cnWB3cermPzMjh/u+As8TMPfB27Q6z4QZNMyUXuQgd0yI
         yGMzs5dVse9AYzVxXI5BDhihKFC3UoDSubrflA3nuOGDl2Q6pq7qwbDXfJaOGtEO886X
         fuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=fj5c4UIrwrHuebCnymMMYIFQTDYFE/X+bvsiYmpq1Rk=;
        b=lMOwT1Kk6b7blSqHEzltwOhXMlEzYDmsI27G21stMzC3zTzvvx0bTnCjoniiBgjeps
         uOSozTGIxto7ezM123dz3+TR6oOKGpZ64IzM1QPOgui8ypF5DOQPzkbib5sufaXPO4bo
         UYmEf31EmUN2Y+PY1rqUfOu2rZ2la38JcWg72bmiQWF2L7W5dpuwv891cYrms7gg+QzE
         nskfNTSdA8RxRVVHw7RF566BAIX7b8rJsCFn3tE5rx1EAbkAKp1tDSCVDtLpGarVIbm4
         a/CS6LuqNE/PUVccu1nNhhn+7zV0ahLHBusBwS9yvQs1fhIYGS4Sj8kSwxVzD8BJPoy3
         sAmQ==
X-Gm-Message-State: APjAAAXtyIAie8pXY2zl3iwcc+kxWDdNk+UGDAv4rhsjqkK6baoJ1Psh
        sbTgSwoat0Bt9SXa902HyEWvpQ==
X-Google-Smtp-Source: APXvYqyPSthc9ZtJ5YzXVGQgIPCZZDAyRXEc85YTMs1GQxMFcjiC8jCWCdzTe75XV+KW4Mf/Rfm1LA==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr33633296pjv.15.1579053517840;
        Tue, 14 Jan 2020 17:58:37 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g9sm19978122pfm.150.2020.01.14.17.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:58:37 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:58:36 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch] mm, thp: fix defrag setting if newline is not used
Message-ID: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com>
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

Find the length of what the user is writing and use that to guide our
decision on which string comparison to do.

Fixes: 21440d7eb904 ("mm, thp: add new defer+madvise defrag option")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 This can be done in *many* different ways including extracting logic to
 a helper function.  If someone would like this to be implemented
 differently, please suggest it.

 mm/huge_memory.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -250,32 +250,33 @@ static ssize_t defrag_store(struct kobject *kobj,
 			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
-	if (!memcmp("always", buf,
-		    min(sizeof("always")-1, count))) {
+	size_t len = count;
+
+	/* For prefix matching, find the length of interest */
+	if (buf[len-1] == '\n')
+		len--;
+
+	if (len == sizeof("always")-1 && !memcmp("always", buf, len)) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("defer+madvise", buf,
-		    min(sizeof("defer+madvise")-1, count))) {
+	} else if (len == sizeof("defer+madvise")-1 && !memcmp("defer+madvise", buf, len)) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("defer", buf,
-		    min(sizeof("defer")-1, count))) {
+	} else if (len == sizeof("defer")-1 && !memcmp("defer", buf, len)) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("madvise", buf,
-			   min(sizeof("madvise")-1, count))) {
+	} else if (len == sizeof("madvise")-1 && !memcmp("madvise", buf, len)) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (!memcmp("never", buf,
-			   min(sizeof("never")-1, count))) {
+	} else if (len == sizeof("never")-1 && !memcmp("never", buf, len)) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
