Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28053C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8972073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Y5zCrsiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgBLFro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:47:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgBLFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so654658pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 21:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=Y5zCrsiJGwwkqvTmrIJW1tBz/wqOw4mjVFElWat4dzzdZ6Tw66aYt5a07SvkTy/Lck
         rXUewXSEE2EBaczbtBWm7T8x41V/SlEQ+pnZvX/FCrOzxcP0YgR+CQQR/Ia/Xv4N7GAe
         6g6jWirRVTMbP5ERKo2gAd3GMioB6TzWqCNiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=IgTmgyFH5IZgNlZlEbFbcPMXxyUI4LM+QI0ZfcEWSih4ZVMkao4lG4zJ84B7u703XE
         g2MiBBvfJ8caxc4KIR2wDoIBsKlGv2n35SfRnGVuau61y65nODJNaEJ70/zbpAEZUn1q
         tJhQWMrBTm5/TtF3Y8t1Rxe1KgWWAlZADjTEUhqSdLK3w+sj1iEEgtibRuU2yiwRVcKV
         4lYDqTkEW51Lpw2gLuUGROSH5t7zWlg6y2DLvCl8mgGGj2FnxtcdNGR8gsrweM4RNKzZ
         ZCzJ9B8jzQnBxgIhMYbtvM13/h/SKWdi8xtxKjsbhja9DQJSr+lmk84hE3lO2JE7r8TD
         Le+A==
X-Gm-Message-State: APjAAAVFFesydHDNMXpiQySpAmN5QrgN56zR9zX+o/c9gI7rM5HKKSjw
        2NxJSKvq9+1kJEuHGVIhYmW065csyW4=
X-Google-Smtp-Source: APXvYqzKp61yzT24DArB0Z77F3iwms69CI28EmKMr/1q10yZcKMwchYaLBInd+f3G6rmK2f3pR244A==
X-Received: by 2002:aa7:8605:: with SMTP id p5mr6770773pfn.87.1581486463072;
        Tue, 11 Feb 2020 21:47:43 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-65dc-9b98-63a7-c7a4.static.ipv6.internode.on.net. [2001:44b8:1113:6700:65dc:9b98:63a7:c7a4])
        by smtp.gmail.com with ESMTPSA id q12sm6250115pfh.158.2020.02.11.21.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 21:47:42 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Wed, 12 Feb 2020 16:47:23 +1100
Message-Id: <20200212054724.7708-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212054724.7708-1-dja@axtens.net>
References: <20200212054724.7708-1-dja@axtens.net>
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

