Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C4FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7DA20899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQRFBHaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGCPyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:54:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbgGCPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593791643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4qID0ZJaeTJxhzFANYqylxfwR8yL+lxsbh+RcCg6IxA=;
        b=NQRFBHaRA68IsYYD8pL0IuXS0DJj8YbqBlJAZvtevyBUnCYrUuCCEZ2jHC2HStLmZIiFAz
        5FKEWdFdcVEiue4maqsn552km6YXBx74FnIIPYpW0eqxrWnz9T7zSm99GWkvfKuenEMQBn
        yRhSe3Tt1hyUaT/AXRirPuWrn1ezMew=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-rvJCKjdLNMmBaB3kUdm81Q-1; Fri, 03 Jul 2020 11:54:00 -0400
X-MC-Unique: rvJCKjdLNMmBaB3kUdm81Q-1
Received: by mail-qk1-f197.google.com with SMTP id i3so15685462qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4qID0ZJaeTJxhzFANYqylxfwR8yL+lxsbh+RcCg6IxA=;
        b=pwR8ItrTJEpZNM9KnU37oZ8DLYedifgd1en7IRviX9N4tMiYe2xefOwghRmli9cF7d
         jio4nqH33wB3hrB07bL8zz02vA7IC8EJZ6p4wBsB4kNNlzpZVVLd5YCeh7q43pGuo/U0
         L+4LMJjupbmMiMSQS9m08izPSo7VLGLlAyLeVxw41fKPjk88ZTmNsZCIlCsWnlYeb3sB
         gU0tfOL3JJmbbjKRvjDtGDU1umvK9FkwFwyTdPiI7ylMlmmK+i/mdesmG2E80ggm4t93
         ms9Xm9ez6FcEoD53eo4nKRXATQJYdogcVMcCIoftEhBQ9iMVgGMQroX8VNmCK5pH0zjh
         JZqA==
X-Gm-Message-State: AOAM533mGxkyzLLzVYz9YuvJYs5llysgAz8SzFq6cJv/AcMWn3CSNt7g
        yQMJR3+ugU8pKvAN/nNEKbFYtK26pU8E4e/kniiGETczYuQSEvQt1VAmkLLnfBvH9jKrBehgFTT
        X0gJ1MIGTSLaHbyjUy5Th+5Z7
X-Received: by 2002:a37:a8c7:: with SMTP id r190mr33031728qke.156.1593791639758;
        Fri, 03 Jul 2020 08:53:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmqMKz6gFD5FSIJ931PXe575jCMsLI6vSuRwnTbWTzh9iHJVIjOidlyvioj0mAqjG9kDRNpw==
X-Received: by 2002:a37:a8c7:: with SMTP id r190mr33031721qke.156.1593791639569;
        Fri, 03 Jul 2020 08:53:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s8sm11553622qtc.17.2020.07.03.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:53:58 -0700 (PDT)
From:   trix@redhat.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] mm: initialize return of vm_insert_pages
Date:   Fri,  3 Jul 2020 08:53:54 -0700
Message-Id: <20200703155354.29132-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports a garbage return

In file included from mm/memory.c:84:
mm/memory.c:1612:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return err;
        ^~~~~~~~~~

The setting of err depends on a loop executing.
So initialize err.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v1 change err intializer to -EINVAL

 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 17a3df0f3994..76a00f414777 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1601,7 +1601,7 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	return insert_pages(vma, addr, pages, num, vma->vm_page_prot);
 #else
 	unsigned long idx = 0, pgcount = *num;
-	int err;
+	int err = -EINVAL;
 
 	for (; idx < pgcount; ++idx) {
 		err = vm_insert_page(vma, addr + (PAGE_SIZE * idx), pages[idx]);
-- 
2.18.1

