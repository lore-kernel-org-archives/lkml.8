Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69FDC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA82E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nd1CtBFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgC0CLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:07 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:54388 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgC0CLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:07 -0400
Received: by mail-pj1-f74.google.com with SMTP id p14so6207002pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5IcQYYvEOpf9NGuTwGi2Hn9JVgRq+o118uhRqu7k0m0=;
        b=nd1CtBFcTZEGQcDkT14QoA4Yt3oF33FVgLCEDBR2Q7ayEh/pg5mxeQei8Hq6Qn/fQN
         dnvae75F9n2TtcYdf4RCvvHCcmR8c4+8qU/cTzfGkGlswnCmlgVaWb3zeCV/UmRCOThK
         ffEw6O7z9sjLvRugSKN6fwq2aWH93kF22ftaeZBjBrBN8bVVTSaBSNj6b+EuPcoaS0Bc
         qYL103D7NSB5dr8XVVEIOJzQtuRRSqJSfW0sAIWuExMN26s2VyTogQwN2Ulb+bgyQzUq
         6XW+y6ZMN2ev1vLcSUTw7Q1PT5IbehalfTH0WflgQfqJgCwpW8WXF/OpN84zvj5v+39c
         jqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5IcQYYvEOpf9NGuTwGi2Hn9JVgRq+o118uhRqu7k0m0=;
        b=H6/R/JimwXu/ehbJxQZLZRkE/tPRoclGZM1p+NJnVuyjqVDaBUZxlUfzjuhrvVbW3W
         ELhI+rPQInFR5qHM6Z8JI1Dn8LAvIoeVGWFkeD7tWAzvsqusxa9zNHhaCylnn31lD2jG
         +9jEu7BLYqzb59ltNP04Ogtqlbl4BQfIs6910lfqVw2uUago/vjCmeb41jjYNuMJga+/
         mvELLGaAW2gl5hRrMrSKur3oRkovagYRoIIOet8Q0bLKFqojTGfJZteQmhz9YSrVT1V2
         1pPTpVYm0pXC0ITonPG+cFTM8U9sZa4GMIdQvOoA+UhELfVgHkAJii0C0QSyszT43b5I
         8BIw==
X-Gm-Message-State: ANhLgQ2CNrPr4gpIQWdAUtldJby7wJopPsbVhaJDpoCaIB6wk7SQBeGc
        dGDQ8a4fUhxXJ9G7bkzVeU+M14mt4/I=
X-Google-Smtp-Source: ADFU+vukgJsaKkjiJl9jV3Uag6Yq8m6U/B+bL9fZPSlqRx0VPEEqdKN0rSymuE2xHRSkZ6VEB9E4A/A6zSE=
X-Received: by 2002:a17:90a:264f:: with SMTP id l73mr3221253pje.92.1585275065886;
 Thu, 26 Mar 2020 19:11:05 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:50 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-3-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 02/10] MMU notifier: use the new mmap locking API
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

