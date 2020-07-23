Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7262071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgGWXPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:15:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45566 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:15:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id u64so7060630qka.12;
        Thu, 23 Jul 2020 16:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8IZbd4Fczf92kh5M3HwuHrI1z58wZWyf5U7NUnPhRY=;
        b=Q6DX6i2YSUNMEGGIhtAtrqF92uvtKHoxgWAkl6ije5OFCXrE0jN/n20676DhpQxGny
         c0Piq0YVe6w+fv18O1qdcauv8JoqwRsXMrVFE8D9E+WDecxSTWteF9RBF4mjknPKY2Cq
         CTMfn0gITMZU/E/ueL44Cg/QTB8ZNhJ28BAo71HpwlVJS6Ohf/DiJ6/B+WFZ1nYKSLAs
         2D6UUyRIxEKHLKmTUGYy98SOa3CzS+62UOHneVDI5vklrzVFVLXdEhi+GkKhmtjy4itQ
         mjqtAsOjfP5dEYugvzxDRt9VgPfLNFPYGjbx3FmgC6Q5MvC7+TtQZz+J9tkLr3W5quoN
         C5QQ==
X-Gm-Message-State: AOAM532MeK/F4a4W7/VSYJPRq0SbIt7LK1AZTv5Qm1S4wvwwnj14VFls
        BJSc8Lh8qai/XzY1BIsBFes=
X-Google-Smtp-Source: ABdhPJwvgEjMKThPAs1a84yJgSsd+Py7vrCBvLV00/GpEFdmmEqp1wOoieVANE+LZeo7pqmMyDOwhQ==
X-Received: by 2002:a37:7dc3:: with SMTP id y186mr6797518qkc.160.1595546147786;
        Thu, 23 Jul 2020 16:15:47 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u58sm4196610qth.77.2020.07.23.16.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:15:47 -0700 (PDT)
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
Subject: [PATCH 1/3] x86/mm: Drop unused MAX_PHYSADDR_BITS
Date:   Thu, 23 Jul 2020 19:15:42 -0400
Message-Id: <20200723231544.17274-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro is not used anywhere, and has an incorrect value (going by the
comment) on x86_64 since commit
  c898faf91b3e ("x86: 46 bit physical address support on 64 bits")

To avoid confusion, just remove the definition.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/sparsemem.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 199218719a86..6bfc878f6771 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -10,24 +10,20 @@
  *    field of the struct page
  *
  * SECTION_SIZE_BITS		2^n: size of each section
- * MAX_PHYSADDR_BITS		2^n: max size of physical address space
- * MAX_PHYSMEM_BITS		2^n: how much memory we can have in that space
+ * MAX_PHYSMEM_BITS		2^n: max size of physical address space
  *
  */
 
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_X86_PAE
 #  define SECTION_SIZE_BITS	29
-#  define MAX_PHYSADDR_BITS	36
 #  define MAX_PHYSMEM_BITS	36
 # else
 #  define SECTION_SIZE_BITS	26
-#  define MAX_PHYSADDR_BITS	32
 #  define MAX_PHYSMEM_BITS	32
 # endif
 #else /* CONFIG_X86_32 */
 # define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
-# define MAX_PHYSADDR_BITS	(pgtable_l5_enabled() ? 52 : 44)
 # define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
 #endif
 
-- 
2.26.2

