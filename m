Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4032BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FB2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQv0mtxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgE2TCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgE2TCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:02:30 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC359C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g9so2528670edr.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyZMdQOMoWlhJA08T+Mo//t1Ng1mjO7MldqgKEnlguk=;
        b=EQv0mtxSYflKj5GjBUxDI93wqLBRAAkseUM8QRLe9c6zgdM4+GkaWZOlKUMCX1F8tM
         qVGrHpiTIOyMi01Kv3+a1R3geTWJlshE+sOAI6nlwzVJ0F66z8Zm8pz9BWVOwJmkOIM1
         xD4GLXeKMTSBpxyeVZG1acwkCOPmPOLcED3hCytxsVRKCaaGlBcKQ6U1LjTL5Gj1UTPX
         8aPh3METAZKZVH0OhRYIRWQZ7eXaf+puzRZFqWThOlHLDWP0MHwrRQi3nZAlhpijskKs
         jObGPTIZgdNC0prVx0vuXWbGw/OS8yESO+d0n5IUxBN4xNcsynk23Bz35Mjob62GuWbX
         Imhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyZMdQOMoWlhJA08T+Mo//t1Ng1mjO7MldqgKEnlguk=;
        b=ly8Fhbrvw1aaXkxrVMBxtBchOUuqZxPfPgu4pDQ+mq9kQnHiF7JaXz1GPKxCJ0vYPN
         xkdWUa2c+EHAVKAuDL+NAH251DW8SaXZ1EmeuNcj8SoG6TCKX+fMFy9AfC/8ejFTzRa0
         yidqZCLoXD42OUVUylIpHGVEWAuAp8zdMyxHJNEkrVCK9URi7xGnkk+q+3KfSfKsxIxK
         AodUWIhaqZA8z7zT+O8H5ncGgHOfrBam56lHool6mt2FtWWP6nXXL0NZXdcLQ0ojL819
         MuOnW6bnsHpDnle6t/2/3Xr6CKCK2Ckri5IBjjg9ZToqD/zi99mPPzREEh9MZaH0pgBL
         ye9Q==
X-Gm-Message-State: AOAM532m3VSZrjsSYkBFaSS+eJgfoonjPrU7JH/NZdFSkltWTYPI4t/E
        /WjLfj5RCs/qa2go+RdZrmI=
X-Google-Smtp-Source: ABdhPJyLOKOerOmjHPSq9DADE5maRLthF6JfjSS8rl3cqsnHlqDv9Q2ED480K9Acqr4Cgb/yLFyRkA==
X-Received: by 2002:a50:ac84:: with SMTP id x4mr10122216edc.124.1590778947609;
        Fri, 29 May 2020 12:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:1951:ff2b:10f0:1763])
        by smtp.gmail.com with ESMTPSA id f4sm8166135ejk.17.2020.05.29.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:02:26 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] m68k,nommu: fix implicit cast from __user in __{get,put}_user_asm()
Date:   Fri, 29 May 2020 21:02:18 +0200
Message-Id: <20200529190218.36560-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
References: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly for __get_user_asm() & __put_user_asm() uses memcpy()
when the size is 8.

However, the pointer is always a __user one while memcpy() expects
a plain one and so this cast creates a lot of warnings when using
Sparse.

So, fix this by adding a cast to 'void __force *' at memcpy()'s
argument.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/m68k/include/asm/uaccess_no.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
index 9651766a62af..9959327e99b0 100644
--- a/arch/m68k/include/asm/uaccess_no.h
+++ b/arch/m68k/include/asm/uaccess_no.h
@@ -42,7 +42,7 @@ static inline int _access_ok(unsigned long addr, unsigned long size)
 	__put_user_asm(__pu_err, __pu_val, ptr, l);	\
 	break;						\
     case 8:						\
-	memcpy(ptr, &__pu_val, sizeof (*(ptr))); \
+	memcpy((void __force *)ptr, &__pu_val, sizeof(*(ptr))); \
 	break;						\
     default:						\
 	__pu_err = __put_user_bad();			\
@@ -85,7 +85,7 @@ extern int __put_user_bad(void);
 	    u64 l;						\
 	    __typeof__(*(ptr)) t;				\
 	} __gu_val;						\
-	memcpy(&__gu_val.l, ptr, sizeof(__gu_val.l));		\
+	memcpy(&__gu_val.l, (const void __force *)ptr, sizeof (__gu_val.l)); \
 	(x) = __gu_val.t;					\
 	break;							\
     }								\
-- 
2.26.2

