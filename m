Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7549C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADB02071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pr9E2+c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgC0WvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:14 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48811 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgC0WvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:13 -0400
Received: by mail-pl1-f201.google.com with SMTP id w3so8131280plz.15
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lSXLGIOt8CRablzbfhFF+Q5uTpG35OzukruA70fch2E=;
        b=pr9E2+c94H3cyVpUhv6RL9t5kHwQquMJZk6iN1ny94wPJj0B4pWgILpyBC7hsMbiB3
         F0leBO0n6ZLok2b2apMVgxlGtxUzMlKDjdo9YP04ZeM3huYyUtpl3S/k69p8+mXU/5DU
         xgAxQGPDUu0roolsXlPjQg+fsdBF84v2cH1RY4RR1KugvkjcWiZdP2I6TEiYEelPTJqB
         WIgTil+KOFbvvqg/543RqVqDAAW+1dQo2cyL2eFOHQ/hggAyhFbJaP+hpX/VJ/hLJhhL
         8S0GW8RJt04wKndXyNfoOh2W6RkZ+iACRYxpvS1QMD920yFO91jUXp5wC2kZKhzNJ4uo
         S5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lSXLGIOt8CRablzbfhFF+Q5uTpG35OzukruA70fch2E=;
        b=NONLrXwmKZwAGDiu4z/bciWDi7sfnR2GtwNQEqWz6FFPBJtIG2anSq1qIpwxkT7MgM
         y/zEsBzTzh45XWshqK1QXrQQw0xh2hsfNa9wE7HnXceuZEI4uo8ixUq7kBviGaK0EOJx
         EqqF26kCulCtlOMDexwCiZOs/GucZRWVXUO+DN+vNVe6ciQIRL5EJF+mcxzq+1HknhcN
         Ak92knJn8g6vsu79XFSKydZQ14zFNIaeMjCd1LI9M0WOfaumEsQtW3xoDnQcAcQ7TDEF
         GQYEHMjNiWuSafJg/LcK0o1W4iwA422Icy1SgweXMhwn9e8fmaIw6ZvALiZlXlIVo18j
         fd8w==
X-Gm-Message-State: ANhLgQ17DngTktIxLFVpLsoca1irmNUxg441hCpb+3xAZq8D6GueYUt0
        kpPgW2YuATA/QtNmV0k4Dt+PdEgXuag=
X-Google-Smtp-Source: ADFU+vtDE/LK5H5j6boGSuTVP/f/NQ7fzp4Go6KUomHA2EDSqo6OJIDYUOBj8rfcrmJBNJBWlVLgAyrjWd4=
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr1773277pjy.157.1585349471947;
 Fri, 27 Mar 2020 15:51:11 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:50:55 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-4-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 03/10] DMA  reservations: use the new mmap locking API
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

