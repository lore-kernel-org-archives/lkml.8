Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B340C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCE024672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgB2XLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:11:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39265 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:11:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id e16so6680077qkl.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 15:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5ZPrIWUcFdZz+VY7vEnX2GwkgxMVshMmglqEI63Hd0=;
        b=OfEhwIp2aEf74LXz0/vdWIhFbllJJsJX+MqH8i7jEkHx7XNH5G16bvty+PoCLOq2l/
         nAla9HuLJbgYSupCz/O4nekjpJkITWzeOAeIe9pSUZBR6lRRF2iXSw5+RcxxkCTrSxqT
         o8AfjVTq9AoaPI1IJ5/0uGVj/cCGCZhATxCr3jSQ7SqPsffYiPziHCtEhD96d4gmh+Jl
         Qq29jArCX01E7wJJYE442Lz51z0yKe7ZjHjCjxpd8LrsMhFWvbsbsYxeVrneLV1Fey0M
         C4qg8B5Z2B8U2Mc3f5gOyj8oaF6ssFlMsfOinrLauUzY7aJcLNbb9MVy5P4c1fsqgnFE
         T0xg==
X-Gm-Message-State: APjAAAUcJlgJPMlHTsZkBtjBTJgvlWWYm3Ya0Aou6ZIT9UOFX33CbDAT
        InUMdtcuBy8DppzmogEaQBY=
X-Google-Smtp-Source: APXvYqzJ+SJfesoEXBu07OvOjzBqsP/jFC5ZXJWFZcSGrzC5jVvdiMCeSRFshxY0nR3wLP/Z04f2Wg==
X-Received: by 2002:a05:620a:146c:: with SMTP id j12mr10863660qkl.373.1583017881241;
        Sat, 29 Feb 2020 15:11:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z6sm7588644qto.86.2020.02.29.15.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 15:11:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Cc:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/init: Stop printing pgt_buf addresses
Date:   Sat, 29 Feb 2020 18:11:20 -0500
Message-Id: <20200229231120.1147527-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This currently leaks kernel physical addresses into userspace.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e7bb483557c9..dc4711f09cdc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -121,8 +121,6 @@ __ref void *alloc_low_pages(unsigned int num)
 	} else {
 		pfn = pgt_buf_end;
 		pgt_buf_end += num;
-		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
-			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
 	}
 
 	for (i = 0; i < num; i++) {
-- 
2.24.1

