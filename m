Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD8C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AED20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkJyZtiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgC0CLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:11 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38813 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgC0CLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:11 -0400
Received: by mail-pf1-f202.google.com with SMTP id f14so7052008pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lSXLGIOt8CRablzbfhFF+Q5uTpG35OzukruA70fch2E=;
        b=jkJyZtiTrah0k12mJlrKqb7rSd5WlOpLupMyryDRi33YSxPy+21eUQex0fK+X6UB+0
         zT9vjBnp+JwXEhFJRtxY2RsQTudvG97D1Lhp3WSb6TWLEk4+0gziK988qhQUXl4RUfnA
         JJC0smgj5BCrsqaMZZx/nrKasdKT8AJ3vDRG51QIjnQs+dXXdQb8IFLBNIluFonhWM24
         lBGwXY+6lOwUxGW551lnx+9w9Xh6gM3qrAD4/jWe5h3HN25ESGEJDg9fXRfMZFw8Ciia
         h4zvE9h5T43BpT3s4TZGvD3/NrHuQjjWBNEmx/PkneV8d+2w+CXEFk7tKbW2PI/RYW6J
         uOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lSXLGIOt8CRablzbfhFF+Q5uTpG35OzukruA70fch2E=;
        b=cTxWDOa1W71BgV1QV7TLzGuqTYdPvhE123/DOujtTdBCA1oSj1KsifMeIPSeO3fg0y
         qcLPLxCF6d7tNekuIn2DVrm5Esk74oDrMrBgtcLLgB00kEEPs+XdjERNUHDMvuDRJFHg
         WsVA10+so15QVyQpfz0P1DXP9/9zg1XHcKn1pzq+o+nVtHW5E4RYu1EC2KTtjUn9uSeP
         hCbPaRlNa/8KwB0AiupvLPeMC8/EHlLhPfAXYLr6cVE7uJ4ySmlaexqPIulik2CYgqjU
         kwpNuN/6ZQL/MJnURk+hZ2rLeqWEtX49wtgtSZk7tJNtUANz8xwuOtH9NDZyEIzEu1ci
         6log==
X-Gm-Message-State: ANhLgQ311MkQE94qbr2Ljlk5RPiAR1xx0IE2VNxyL1HnAHJbt/XW1XqE
        n2FrxA7deCawgEnDBayh69mFO/jls3M=
X-Google-Smtp-Source: ADFU+vvRRsE1kbtwpKYeV5gGrgzJavkeIriSS9e6ve7iTLNvp2pxYAdq+JZbiyapnuNAIMUA+wO7dwV9jjg=
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr3322521pju.4.1585275068691;
 Thu, 26 Mar 2020 19:11:08 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:51 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-4-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 03/10] DMA  reservations: use the new mmap locking API
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
 drivers/dma-buf/dma-resv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 4264e64788c4..b45f8514dc82 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -34,6 +34,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/export.h>
+#include <linux/mm.h>
 #include <linux/sched/mm.h>
 
 /**
@@ -109,7 +110,7 @@ static int __init dma_resv_lockdep(void)
 
 	dma_resv_init(&obj);
 
-	down_read(&mm->mmap_sem);
+	mmap_read_lock(mm);
 	ww_acquire_init(&ctx, &reservation_ww_class);
 	ret = dma_resv_lock(&obj, &ctx);
 	if (ret == -EDEADLK)
@@ -118,7 +119,7 @@ static int __init dma_resv_lockdep(void)
 	fs_reclaim_release(GFP_KERNEL);
 	ww_mutex_unlock(&obj.lock);
 	ww_acquire_fini(&ctx);
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	
 	mmput(mm);
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

