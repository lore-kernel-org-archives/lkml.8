Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46935C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3FB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581545785;
	bh=nh/fCuQsemp1ev5seT2rEzpA0w2JnCg+BtPxs4P4pjE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZskFyi61mKOR6LU4PqbxC/GMIOO2gyKpBxIZTJ8DxrqJG4ZJlNgVq4MSi8OVOHot9
	 bzngXnK9WU3+VFyl8cdnkiw00dClOnM+9VemLIAFRDzyvKpg1m0Wybq20UWVbnWh8S
	 VO1XLHEHFMRIDr4u/rMrpjwShJFWLc8CAM7lnWxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgBLWQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:16:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:16:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so1944193pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IRbfdGWqcwmnNp2DnvQOXpGpDdlJdzZpC1N7ZpXf7R4=;
        b=m2+iclFGS8CzBhvrLeUiObRXq+BHsUSMMB7Vj20hZbpVGnjh/++VyGUTYt2woRJvbz
         L/tFb9D7IjjcHYxbU1p16n0jDAd49fMG5fydr961+y1BEXCfEkYgb+tn1HlwvBfA7Bk6
         I9/cVK87OWQEVxTu8l4ZyYDMQ3fRJlGRnfAe3+Uf2t0Ncu/tzwbO7i0xk8enb/Cjcv1w
         YZOPvQVFwN9Joc3PLsZNieDH1S0lhbebYGRgZGijwZTApsCTAiSfFZDmWBpfV/IwAcQj
         AFrnPWicOYux0+P25+pC2SJAJIkuHnqMOCaXq8aQ1oa0O+S29vcTAOFJYlxuEeemPoyc
         /RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IRbfdGWqcwmnNp2DnvQOXpGpDdlJdzZpC1N7ZpXf7R4=;
        b=fJpAjIRLRLzjyB5TN3IlKUPaDSKAqDb20rbW1gQnTn6thq7Kb2VkyJpBt7hDKxaREv
         aSRyUzXnhWd6gZh9R+rVmxdrTCLi+lbrCh0C4GZbbxEAb5Xh6ToiZfwlA0X3OYqmUkrO
         DdjgkHUatx1vRszskpJE7amDS4ICzEILvl7DKLlJppuOHu25+bEOo6ka5PNAG3FDKkx4
         vyxmzs+87rteOoo2pBy9OZZFZPOCFmqlR9SkK6/3HX8r7sqDO2Cvz1jqLcMKQt9kfU53
         mvbJuudKEH65bQ7uz3BSjU1ScXtquIIeY5UZThaEs1JPZptzob42HBjexRfT3NDdGDpj
         o1qQ==
X-Gm-Message-State: APjAAAVSS9pbTkLN4wsC/tRcYyLwBbCqo+YVcRzgiIWPMxKHiaVXrbiw
        YMgHXCTavgc/pTPujw2lm+Kn6uxi
X-Google-Smtp-Source: APXvYqzIIedGxf8nZB9JoeCmITqMhnSUr9gnQJ8hlq9gR2gywKw1M3NDG//Z/TKJd6Spy2jGjOp+xw==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr14135402pfl.32.1581545781691;
        Wed, 12 Feb 2020 14:16:21 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o10sm117683pgq.68.2020.02.12.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:16:20 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Robert Stupp <snazy@gmx.de>
Subject: [PATCH 1/3] mm: Don't bother dropping mmap_sem for zero size readahead
Date:   Wed, 12 Feb 2020 14:16:12 -0800
Message-Id: <20200212221614.215302-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

When handling a page fault, we drop mmap_sem to start async readahead so
that we don't block on IO submission with mmap_sem held.  However
there's no point to drop mmap_sem in case readahead is disabled. Handle
that case to avoid pointless dropping of mmap_sem and retrying the
fault. This was actually reported to block mlockall(MCL_CURRENT)
indefinitely.

Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
Reported-by: Minchan Kim <minchan@kernel.org>
Reported-by: Robert Stupp <snazy@gmx.de>
Reviewed-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..5bffaa2176cd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2416,7 +2416,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ)
+	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
-- 
2.25.0.225.g125e21ebc7-goog

