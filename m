Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A265C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD842071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5nTqhe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgC0WvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:12 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34715 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgC0WvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:10 -0400
Received: by mail-pg1-f202.google.com with SMTP id 12so9174927pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5IcQYYvEOpf9NGuTwGi2Hn9JVgRq+o118uhRqu7k0m0=;
        b=Q5nTqhe2TmpNAXjMuOUuB4Uul1PuM7N7gC6cL9oRJ6XqGknHjld8NWpjf4F59g4Er/
         7mMqrs8zROG/p95wQKtU11+uzVY27oL2jnpMHh6mpphP9xnFkPuEHuAxVPQtBCiVic6y
         cQwcwa325EqPKIoGD9UCO3TZnLsZm5sERmIxO7X+9AMWtV1pF34RXf5MyfL5xqacsJMp
         erbLQ/k75XQ2entldGrbsueScJ8z9lpB+QVHlBLFMTdwCZ7LGxxtw0gnKdKGdyFvtXLr
         D8JyQrRxkqlgFgMOO472aeSXIywM3Ufj4bWQWvjZe0ikQbdz3DMf7M5BXGRl/mXsb5dF
         cLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5IcQYYvEOpf9NGuTwGi2Hn9JVgRq+o118uhRqu7k0m0=;
        b=PCy7FARKa7do3fleCu9wi+ee4d9M5LKHsmsRJDcD7cBx4wH8190lMc1nyYmG74w85q
         ALSfk5nsQ87+Us0RrzkYnVy0r+6PiQFPojXW9ClF8dt2FU1hy5GWEWtSxtSr/8t8s3CK
         8DlCD2IPmHGNpEZOzHjv08WHtHPZ9XoJgh354A8Ad9JvPAuSS7/l8/CK3zsytkc5c+K0
         0jMi20HFOrPtLdkDO4SuaVSQt7deg5uoJ1cLEZIjglUTcDjDjGFn+VJfJQzYMrKq5Dyu
         XPCDGQXm8QLaA0u/4nHzxLjubalWOOnpfhGAgBKANP0ibj/cICQ+OLVn89v/qre70uKt
         oTwQ==
X-Gm-Message-State: ANhLgQ0lVtKTpkUsp6FIDHN04UT9XULBpbqJUFOqRFghJG7F4oO3UyJ+
        KDspecBusFe7Jl0PVVklKOQdeA8/0Lc=
X-Google-Smtp-Source: ADFU+vtREf0tww1xCyT2LRp9quZ7Qor6eEYHrIW70F5yQHQo8UKHF5iRTEUKyjo9NbytqdyMC06oXER1wBc=
X-Received: by 2002:a63:a361:: with SMTP id v33mr1590659pgn.324.1585349469261;
 Fri, 27 Mar 2020 15:51:09 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:50:54 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-3-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 02/10] MMU notifier: use the new mmap locking API
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
        Markus Elfring <Markus.Elfring@web.de>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use is converted manually ahead of the next patch in the series,
as it requires including a new header which the automated conversion
would miss.

Signed-off-by: Michel Lespinasse <walken@google.com>
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
2.26.0.rc2.310.g2932bb562d-goog

