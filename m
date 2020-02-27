Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC6C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6620B246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="KOXKcMJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgB0VTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:19:14 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37121 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbgB0VTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:19:13 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so327958pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=7Z8bz7OXFaCWXmhJZYpG2XBXfx6lWjIKQKOr0ZHUqeg=;
        b=KOXKcMJypmZQxCEqEbm3eWRS2qkjdOFko2gxA0a/C0HYIjhfuK9EKjM5tRB0B9GaMd
         ygOeHGghp/WmF8DJAL7hSIZk504YEJcK2JHbJvsttLoy6wdQ6hqg5mkc+eoFjfI+4Fsw
         bsALbRMQE60i3+5JqXC4e4YZugTkxp2XKWMUcBDAela+4Yz1Q2XlyoUlCKU3iPwaTHf0
         9xhrkZsPGn1C7GgpjcWhjRH7bfGlvMnDoes1217ZOdGtL6SYaho1x4oS5eBHrAoDiOyV
         7bmFVsqfaYbSIMIWFfU1wbAubX/qJuXqpUlcCbMKEfe59RlQUH/pVo42XIa2iVyTNrzz
         VUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=7Z8bz7OXFaCWXmhJZYpG2XBXfx6lWjIKQKOr0ZHUqeg=;
        b=aMZDhf1xl+XrFrXAV/vgnF4CpaXGnACEAasCa52R5mfRaTShHbDKrPtvHO9TmlyHFf
         Gz0a9Q8AcfzSJd9yZupQ3k60tw0xNVAc+EODgOGg/glcX4rm51EtAuomtI/YS8CjMO7u
         mQX2sIT+T5gQSNHFrN5nIUdmOMRvrtVyoFLHcvCztqYHkoq0D8rt7b9ViQrCBUmGmimA
         Qu/VW2jHf7hu5w0x016jHm0CWRcBzqGX0AUabi/30zfBBJD2O3jb1hbDuU9Qr0LhvRqo
         2E+UzOdWaRmg3jMRAIDYbS+PqxReUFs15cOCfbgdmA3M5WrPmy3vwd/1CbSiCdkE8Yci
         H/CQ==
X-Gm-Message-State: APjAAAXoVvoX0aa0XOz7vgGsVI6yuRGdXcq4er7HhTTpKK7J2N66gPG8
        i5G92aduIYq7B90SWCyrNfTZW7LzTRA=
X-Google-Smtp-Source: APXvYqzBYfqefBB/2ti0ZyOB0TcFd5pO+B9vbamS9yR2vt1motxQbKl4F76Cojfr37rIsyQM4g1i/A==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr740692plj.112.1582838351818;
        Thu, 27 Feb 2020 13:19:11 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id a18sm8514670pfl.138.2020.02.27.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:19:11 -0800 (PST)
Subject: [PATCH] mm: Elide a warning when casting void* -> enum
Date:   Thu, 27 Feb 2020 13:17:41 -0800
Message-Id: <20200227211741.83165-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akpm@linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I recently build the RISC-V port with LLVM trunk, which has introduced a
new warning when casting from a pointer to an enum of a smaller size.
This patch simply casts to a long in the middle to stop the warning.
I'd be surprised this is the only one in the kernel, but it's the only
one I saw.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..b15e9edde2ac 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1376,7 +1376,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	struct page *subpage;
 	bool ret = true;
 	struct mmu_notifier_range range;
-	enum ttu_flags flags = (enum ttu_flags)arg;
+	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
-- 
2.25.1.481.gfbce0eb801-goog

