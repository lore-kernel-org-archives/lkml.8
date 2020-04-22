Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A98C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E0B20575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOCgPjpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDVAOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDVAOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:30 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31395C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:30 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l9so152082pjq.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/xPYX04nKsJiukhQBuhEJ9u68izHM8ZA0ttUVx7HKYQ=;
        b=fOCgPjpjPqfxN/zvti9Uz9F22MJpVgNh2v3q4OjtyOZDSp4ZHvIbKO+bJyTLsueskU
         6Rmqq5V27Lx/yqlIkm6H0R1h1NmhLkwtJUghxHRvkrj+vQGMskDR6WrzkQnOIXkHFWsk
         rxQwkUz6OXvo4ppJrc6ESa+nQR/cEGDvw5IrPT2xJBM3FI8Y+MItUjG92F9hCpPofyCl
         IC3wFW0btBDWYfDD+Ispzve/ACmrzfDLNkrHePsFoESSKCrhRNinJTHcFUihIjzGWSMV
         cMgo5U5WpTSaRtbOJLR3n/ArQ7X6KVyC+Hf3Cv56RiiU92ieeplRQ0m8kGxOrywVuFrD
         +dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/xPYX04nKsJiukhQBuhEJ9u68izHM8ZA0ttUVx7HKYQ=;
        b=r1x2+xdEHSDr7IxCVIlewxrV7s34l7U3iM80qTL66Qvs0WkKj80XOLe+k2jvdsbV4p
         GNPbM08lVG4SZ843x4aiBjMTQ1DNS8LqLx0Dw4oFYUib8kpTj6QjASUvxRLaOpD+1o/v
         U5zvWmEOUR2pJ5XIA+T6UhpU/6cfAw08zu+/g4sJt7yfzqvNgf1+NDAlclIvhZYMAd5W
         RBgiQqWrMu6nCJSQ6QO3eHUBCI9KkyCvgAUcsN1Go6kFQ2W0eFDhJc8BuQswt7rsf/mx
         +jCFuqxdWWY3J2E9+2kGrPf/sI63PMYYQzhS5JxZLKdsBHq7VRt+qLUrqtxRI7lAYDp/
         X6EA==
X-Gm-Message-State: AGi0PuYZVLeDUWbBc16gAe8D+XrzVW+K6Lx0c2TceBWeR+Y8ZWB6jrIg
        LzJ/ZMosJ/EtMASQz85vwwl8LLQsZgg=
X-Google-Smtp-Source: APiQypKUjV/xhe4MdNGIXvANHcuoYitjt1clgRyFFabzndb7K24umh2BGOmFP/jqzPtEDLeknFN7MffKs9s=
X-Received: by 2002:a17:90a:d808:: with SMTP id a8mr8408471pjv.6.1587514469596;
 Tue, 21 Apr 2020 17:14:29 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:14 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-3-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 02/10] MMU notifier: use the new mmap locking API
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use is converted manually ahead of the next patch in the series,
as it requires including a new header which the automated conversion
would miss.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/mmu_notifier.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335e..2f462710a1a4 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
 
@@ -277,9 +278,9 @@ mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
 {
 	struct mmu_notifier *ret;
 
-	down_write(&mm->mmap_sem);
+	mmap_write_lock(mm);
 	ret = mmu_notifier_get_locked(ops, mm);
-	up_write(&mm->mmap_sem);
+	mmap_write_unlock(mm);
 	return ret;
 }
 void mmu_notifier_put(struct mmu_notifier *subscription);
-- 
2.26.1.301.g55bc3eb7cb9-goog

