Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6813C3B187
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA87321734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="W9aXQyY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgBMAsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:48:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgBMAsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:48:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so1752281pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=W9aXQyY//t6eHEP3C8xuynwnJgm3YQCe8jjIZ3jCl0XfEK1dL1LvAILAOPmzj61Wyv
         cLQmZJFRaGPd6uoU68W52/jyWaaFaARR6xS2exIJFuTEJXhxX3hO4kgPoJGtQAIU5pPz
         ZyimzxrCfOURO0SYjraq+Mo0+houUqGxBke04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=dM9rRzrn0PzY2zxCvahl3UTC29J7p7JcTberb79xHonBTFbjOhNI7YPZ6Y3wZ/+1Lf
         tBjkYcJdXIy9jFKab/xeFXNDeLfgHy2tskLRMgm7RKIxGIXcJRNECelmq+M/TQ6ViiDy
         2T33Uz3n/7xeic/TSkawTs0RETCZ7X3UU43xE73ZwAkm26B2caNhKRgQ7aNTP1qpL0tm
         5mtv9b82RUbaV6O22BrCOr/cD9u+LyBkwb/uxvdy8y3FosVg7VlXSpqkV3cUQL4Aar+C
         VxUHiUcHhwHmPHqx9U201rM0dr+EtczO0nxrNnzIkIKCkZAF9g6ZXhMieUtqA/pWo7Yn
         6AiA==
X-Gm-Message-State: APjAAAXICG/9Oq9Ob6kEbBYoSk4r7IBtoimyVO34VsD8R+afmpRQILSC
        cR1JUZYA6CtLFfXgQSAQgHuImL1Gedk=
X-Google-Smtp-Source: APXvYqwyap/Y1z+aWXaQcMFjb/rmFgVx+/DpIXipaiV7eULH7aVUnIjevBdz+ooJFdwM28lcergD5w==
X-Received: by 2002:a62:ee0f:: with SMTP id e15mr10920842pfi.256.1581554891854;
        Wed, 12 Feb 2020 16:48:11 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-f1ea-0ab5-027b-8841.static.ipv6.internode.on.net. [2001:44b8:1113:6700:f1ea:ab5:27b:8841])
        by smtp.gmail.com with ESMTPSA id l21sm311099pgo.33.2020.02.12.16.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 16:48:11 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v7 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Thu, 13 Feb 2020 11:47:51 +1100
Message-Id: <20200213004752.11019-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213004752.11019-1-dja@axtens.net>
References: <20200213004752.11019-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..36a4e1b10b2d 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,4 +2,4 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.20.1

