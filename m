Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08877C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28EB2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp+VcqVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHBMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHBMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 08:12:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC94C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 05:12:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so7034766pgf.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x34jeaJ2aLXW5rG4/FZaBIjGpZc92ILS+pWh9qzk3Ig=;
        b=qp+VcqVtXKLpiNMLiY8/vydsthwpH5CT92OLtBT7xID6pyRT1oW2n++LsgFCYdedyw
         /MKMt6ZNtype4VTHsgbrsGM72Ena2GSgLrRViSgK5S/9dw3Q1ZxTVrxNHb+AWtBh3IYZ
         ni63MLWxT9tSNTC+tUm3pRA42QZ/SB7J52ApJm2wKBZ1Qd0ZwVZBNBFEAzIYX/KeIDkj
         rIseqh5sYp7zoTQTgXvDbVXJKG7eCUr6Ct+8psx0YKFF1vs6WObjvlmNIeL0HyM4dyB5
         GCJHyY9Gpcitif0/Uf9mvYnI5J++KubOYSV0nHa4AKaZg6PXHCKf0S9Jh3TAEtOpdSui
         yCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x34jeaJ2aLXW5rG4/FZaBIjGpZc92ILS+pWh9qzk3Ig=;
        b=hmJ02A837yyt7VYIVQy4XDSmaq+LVFDqESp5Wm8q1E4uk+avW8WJz6p7dH9iK0yunZ
         NttcUVCZv7oRdNrw6ixvzEt6MQGpVstFGM3PorO0pP2XoWUbuXGlSAIOGVkXJZRJQsEA
         Mnsg4Oo7Eoz7Eqocr+o6aMSiR1sX927ClSDG8CGfCtBwR7u9Odcnzr+RD93xVYpodEo5
         x94hjfKAxOOj4h8mcAH+9Lc3QFUHOnY8kyR+nr80T5ZNHKfNws+uaYmsG5CilO7wjSYW
         24DBn8PqS28QSiyZCBqRejsjUP/Y5/HxaUXu3pMdblMtYAyLgnrd1m2Esz+lj/2G5WCB
         YgnA==
X-Gm-Message-State: AOAM533XQFPeU2/O3gEABjnfB4vBDXDkfXEh8BAzGB2gRcVKsqPFPHcs
        KBCCaQTFbV0n3JTqoB/2SdJ/ydp5dmA=
X-Google-Smtp-Source: ABdhPJzwhH1e5INK6avMw2XKxQKU3dLOB215znWg7fkoLJy4Cob2ryS0BWJPlSZPY81u7vFndW8A4A==
X-Received: by 2002:a63:5a20:: with SMTP id o32mr11074404pgb.15.1596370368663;
        Sun, 02 Aug 2020 05:12:48 -0700 (PDT)
Received: from localhost.localdomain ([110.34.72.105])
        by smtp.googlemail.com with ESMTPSA id my16sm15649496pjb.43.2020.08.02.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 05:12:47 -0700 (PDT)
From:   mcsmonk <mcsmonk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sunghyun Jin <mcsmonk@gmail.com>
Subject: [PATCH] mm/percpu.c: Modify size of populated bitmap of chunk for memory allocation
Date:   Sun,  2 Aug 2020 21:12:43 +0900
Message-Id: <20200802121243.15148-1-mcsmonk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <dennis@kernel.org; tj@kernel.org; cl@linux.com; akpm@linux-foundation.org>
References: <dennis@kernel.org; tj@kernel.org; cl@linux.com; akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunghyun Jin <mcsmonk@gmail.com>

Variable populated, which is a member of struct pcpu_chunk, is used as a
unit of size of unsigned long in below code:
```
1142         /* manage populated page bitmap */
1143         chunk->immutable = true;
1144         bitmap_fill(chunk->populated, chunk->nr_pages);
```

```
230 static inline void bitmap_fill(unsigned long *dst, unsigned int
nbits)
231 {
232         unsigned int len = BITS_TO_LONGS(nbits)
                               * sizeof(unsigned long);
233         memset(dst, 0xff, len);
234 }
```

However, size of populated is miscounted. So, I fix this minor
part.

Signed-off-by: Sunghyun Jin <mcsmonk@gmail.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 696367b18222..d83e0032cb20 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1300,7 +1300,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 
 	/* allocate chunk */
 	alloc_size = sizeof(struct pcpu_chunk) +
-		BITS_TO_LONGS(region_size >> PAGE_SHIFT);
+		BITS_TO_LONGS(region_size >> PAGE_SHIFT) * sizeof(unsigned long);
 	chunk = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
 	if (!chunk)
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
-- 
2.17.1

