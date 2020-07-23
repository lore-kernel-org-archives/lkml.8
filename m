Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E6C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E772080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGWXPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:15:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34609 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgGWXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:15:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id x69so7118152qkb.1;
        Thu, 23 Jul 2020 16:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0p3sWjwoIaPmRFGxZVHxaWE9xgeZNDe6TS9EQLQfiVk=;
        b=hyfop1Nq9qhUbrhitGMJeKfJ4dnuX6dBM0QHrhxtqwouEXoJ8XGHmRXPqnH3pxm/iA
         YFwn18x4+4PMufCb/nL0AKfXLXZ6EHTtCKgp5MFksUzQJ5GKkWhO7KT+pKm7yHb1w26o
         grcj/5/z036BrPhd11/s9myEhgCkwFD84PezAuU/qUc2+2+pSvgLoKpnlC1JxZj8zk42
         p6C60NeMkfon+DpHwXS1+mbFi9zw4JznzV9CqSWq935ycKb/++4Kh1NDq684w+moWppV
         RNY1HzE0NnS1p+ZbKKKtS14Rkkm3mL9tOebRaYf0CQPhte/GmG/ferKFYDCDI3+qVRr6
         Q8Eg==
X-Gm-Message-State: AOAM530HxjcDTJmDW35KSr3LBQwg5nIrIqZkgTTwGkXJp4SlfZfLwN1z
        4a46tepfi56Y6cTn8I98q8A=
X-Google-Smtp-Source: ABdhPJxRhrWyFuZm76eJyagUPBPagdoNvBL7r+lFd2f/JrZVqYCD5XYr6+Kk+vyZcZTbD12AbwR/Ug==
X-Received: by 2002:a37:4d90:: with SMTP id a138mr7128415qkb.363.1595546148576;
        Thu, 23 Jul 2020 16:15:48 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u58sm4196610qth.77.2020.07.23.16.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:15:48 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sh/mm: Drop unused MAX_PHYSADDR_BITS
Date:   Thu, 23 Jul 2020 19:15:43 -0400
Message-Id: <20200723231544.17274-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro is not used anywhere, so remove the definition.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/sh/include/asm/sparsemem.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/sparsemem.h b/arch/sh/include/asm/sparsemem.h
index 4eb899751e45..084706bb8cca 100644
--- a/arch/sh/include/asm/sparsemem.h
+++ b/arch/sh/include/asm/sparsemem.h
@@ -5,11 +5,9 @@
 #ifdef __KERNEL__
 /*
  * SECTION_SIZE_BITS		2^N: how big each section will be
- * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
- * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ * MAX_PHYSMEM_BITS		2^N: how much physical address space we have
  */
 #define SECTION_SIZE_BITS	26
-#define MAX_PHYSADDR_BITS	32
 #define MAX_PHYSMEM_BITS	32
 
 #endif
-- 
2.26.2

