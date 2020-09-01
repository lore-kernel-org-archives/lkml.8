Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82FBC2BB4D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9681B2100A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Rp5RQjtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgIAACe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAACe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:02:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35DBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:02:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1so11156761ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/WK1I/ZsCqLXTjRuojbNjOezx7X+DvJD8ltypu8xs/g=;
        b=Rp5RQjtHdrOV9oOAdw+rlYP2b8FmTtHIgndUhzBsN6m2ht3rZ2dwnn8NuxI3w4UGT8
         0J1LvrZkq4Lbr+l2dtcWKk+8RLUmXANtSDp10Uj9+GdaIMrkQu8TnpXfaQgWMcg93dej
         MIqACyfGvzUbrr5quNyAz+OwT49UB7EXJMfC91936uBlOeeDzjZkjTxvE7fXXhyhYhcX
         liBOmUqrs7fmCKcXilVo1NsHB6vvjsU2Kuy60NsXLe4saEIomU1vLqMoDK9cdIor/P0M
         iuTlHQW0c8U+yeM0rjV0VZ0otUkH4w/kl/1e/P8iES0nrVbuhU3CW1EEwdMGB2btJGoI
         gSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/WK1I/ZsCqLXTjRuojbNjOezx7X+DvJD8ltypu8xs/g=;
        b=f3+oKEfwoZyKoPMm/CSgVypywVXuYowNgVaGayifsh90u4iq5kJFRO6bSC0t5ts315
         0dUNqch70UlPgUJ40cdykye0abXjFyZwESgPq0qe9CL9ByDPqsyvHZG/BprMF9L9NJze
         hZjgJrrdxep/WwNDAn0dc+lYUmc0EEYu8An2Ctt3BZf1DMYJdiU7JMAL1vxlnMns9G98
         O8l2bzKMxmyMHFJavytsFaImjSbLSVX6Apz/bhjMZQJ2sHc4miuXHbe9ZJvn6yABDvq6
         r73YQNpTohzt+auJ24bs2G5xfHZr6yTcMM61MomB9WlnzIHE9JAXjioAyXHu5aX5i8iy
         IsPA==
X-Gm-Message-State: AOAM533kL1phurHtiuTRIZIbLBqQAXT4EoLZTuKOB4RiQweQ/1qhTxjb
        f+KiDIeJvdB8oSyXMY1dMexa1AgWjQ==
X-Google-Smtp-Source: ABdhPJwa8OHde2lQYnBK4sl7X9zvZNhHYLqhFJDFsng0d53MBPOB6RRRkl9jFfyBnOl/wZCGnBHzMaDZTg==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a25:40cb:: with SMTP id n194mr6162269yba.7.1598918552892;
 Mon, 31 Aug 2020 17:02:32 -0700 (PDT)
Date:   Tue,  1 Sep 2020 02:01:43 +0200
Message-Id: <20200901000143.207585-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH] mm/mmu_notifier: Fix mmget() assert in __mmu_interval_notifier_insert
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment talks about having to hold mmget() (which means mm_users), but
the actual check is on mm_count (which would be mmgrab()).

Given that MMU notifiers are torn down in
mmput() -> __mmput() -> exit_mmap() -> mmu_notifier_release(),
I believe that the comment is correct and the check should be on
mm->mm_users. Fix it up accordingly.

Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
Signed-off-by: Jann Horn <jannh@google.com>
---
Can someone please double-check this? I'm like 90% sure that I fixed
this the right way around, but it'd be good if someone more familiar
with mmu notifiers could confirm.

 mm/mmu_notifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4fc918163dd3..5654dd19addc 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -913,7 +913,7 @@ static int __mmu_interval_notifier_insert(
 		return -EOVERFLOW;
 
 	/* Must call with a mmget() held */
-	if (WARN_ON(atomic_read(&mm->mm_count) <= 0))
+	if (WARN_ON(atomic_read(&mm->mm_users) <= 0))
 		return -EINVAL;
 
 	/* pairs with mmdrop in mmu_interval_notifier_remove() */

base-commit: 15bc20c6af4ceee97a1f90b43c0e386643c071b4
-- 
2.28.0.402.g5ffc5be6b7-goog

