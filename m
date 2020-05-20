Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E91D207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Asq3Jfgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgETF3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETF3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:16 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8546DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v17so2488719qtp.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I4IWEay9tfHjto1pM06hhncLdwAsyJxZN27E9Fb+y+8=;
        b=Asq3JfggVRMqoaOmL40MRkmLe0/nLLbg70x2Kka2C1NuXL5dvuCykX4OYhqeegVUJ2
         JkeXYyCexXXZNA7sjBbtiPv/8CCl9XjyGT4TRYqU7kXMPYttQf1d0mLj9QWhqUz6Zcaj
         TSsrLjiXZg3J/t5tibIyHByvjx8wKhN3t1sWpcAn+Qbv7JIRScWf/XUzD07W4Wkh3Efp
         1TIi8BTOE7Jph3X3QF3hfZd9Y7luzc+/hCTtFnURLMIgMUccnsZ6LJyr5HBpKka2YBaD
         JuzeYKQ8vaxb9lKiXZGWCs/rTZnURcIrUHDEvFobUHYy315TKD8HQnC6eMsCYsiGL2wd
         lICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I4IWEay9tfHjto1pM06hhncLdwAsyJxZN27E9Fb+y+8=;
        b=atcTsma3uaq+FpPaCVel8gMZdex3rEdI20N+3ygyiGyogMZiP9aRYikxOE1HaBtPUP
         hruDUFVE66hK3XNqTLtK577E53gsYpKf/xNLxiR3flqqR4PDO9cuZ2edg6iaKTtnj7JW
         ZFOeZOb1usQuqI+x2aP16vJgp9rY5QOsHrqtl62SJjW8Xs6Q2z2IyXAMWQ2UU0jIdToi
         Z5RH9EYCedgXPjZTDJgHqcYLfYwmn/8+xZtEGgYIBcZRAA/5q1gP9Rli7t+T8GmWIkyw
         hnVQSdA2bT1o6KofBCCPmDck1wpnfAUlhmzangrekx1LX8EA2t/aHPUeq62oDxInUMi/
         /59w==
X-Gm-Message-State: AOAM530K7vgbZCjcyqHYTqXf4B4IvrK7F42uwoAhP/Rnc1FrvIZa5wmc
        DV5hysR+sEdnWMWOQAFN8W0vWLL0Mso=
X-Google-Smtp-Source: ABdhPJw1uSV6k7KGE+Q7byXYZkrzaGAIh0cuhgPJDP6RExBnWIRyMbR9hIGxMXhW3mxaltFYcHeXWjA+CV0=
X-Received: by 2002:ad4:588b:: with SMTP id dz11mr3121275qvb.226.1589952555723;
 Tue, 19 May 2020 22:29:15 -0700 (PDT)
Date:   Tue, 19 May 2020 22:28:58 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-3-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 02/12] MMU notifier: use the new mmap locking API
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
        John Hubbard <jhubbard@nvidia.com>,
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
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
2.26.2.761.g0e0b3e54be-goog

