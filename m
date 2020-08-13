Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F94C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E163207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHMPTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:19:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHMPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:19:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id k8so5397500wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWVYbnLUoQh2/bQ8PJoxS/2ocrG/gYbDVzBuksdzAMQ=;
        b=fwKa9tq/kj43Esimh7kXdizIyHU8WFQoxI5LEVmwhsM8T+okPPcxDoBUWDFd8PnkKE
         lrLi6bhISXpzEKhTHOZjGRywZqwBQHyP7pWmw4Ys5EST/0/lcp7n2XuVZ4JGO3WubagH
         VRQ5UbylkLGDUAJRllUPkXxoyGLKnCw9/jTip1H7GHLt+xh6j/Up+xKzTOU+fq4s3AkH
         QlTTjO0+aL0tb8sfDVzwW4tg4+FE02vWEGXxvL9LjLsdafnyohy93PsxQT7uvmbqYBkG
         yZ/n9BCrWcUpcgnLOkdGjhi+vykx+iwdhYIi7ZXTJGXp6P6DGy1azdeW4YzQq9aoXlLY
         VnLw==
X-Gm-Message-State: AOAM531QMYOLSZ1R0qKO4VeaFq2mtqYLBdBLxnRxS9vNNS0TkKyLRsNH
        wKCFz/Kt50Sqthuf8JJ8aE4=
X-Google-Smtp-Source: ABdhPJwKxFGbrbkYgxZpXwjaDbyI5I0M4/6XBG+VYoGVV0KtiAQ9ydy+etzJBWJI2Bu24vC6GiUcYw==
X-Received: by 2002:a1c:de88:: with SMTP id v130mr4675656wmg.98.1597331986347;
        Thu, 13 Aug 2020 08:19:46 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id d23sm10394044wmd.27.2020.08.13.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:19:45 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Cc:     notify@kernel.org
Subject: [PATCH RFC 2/2] lkdtm: Add heap spraying test
Date:   Thu, 13 Aug 2020 18:19:22 +0300
Message-Id: <20200813151922.1093791-3-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813151922.1093791-1-alex.popov@linux.com>
References: <20200813151922.1093791-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple test for CONFIG_SLAB_QUARANTINE.

It performs heap spraying that aims to reallocate the recently freed heap
object. This technique is used for exploiting use-after-free
vulnerabilities in the kernel code.

This test shows that CONFIG_SLAB_QUARANTINE breaks heap spraying
exploitation technique.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/heap.c  | 40 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index a5e344df9166..78b7669c35eb 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -126,6 +126,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(SLAB_FREE_DOUBLE),
 	CRASHTYPE(SLAB_FREE_CROSS),
 	CRASHTYPE(SLAB_FREE_PAGE),
+	CRASHTYPE(HEAP_SPRAY),
 	CRASHTYPE(SOFTLOCKUP),
 	CRASHTYPE(HARDLOCKUP),
 	CRASHTYPE(SPINLOCKUP),
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 1323bc16f113..a72a241e314a 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -205,6 +205,46 @@ static void ctor_a(void *region)
 static void ctor_b(void *region)
 { }
 
+#define HEAP_SPRAY_SIZE 128
+
+void lkdtm_HEAP_SPRAY(void)
+{
+	int *addr;
+	int *spray_addrs[HEAP_SPRAY_SIZE] = { 0 };
+	unsigned long i = 0;
+
+	addr = kmem_cache_alloc(a_cache, GFP_KERNEL);
+	if (!addr) {
+		pr_info("Unable to allocate memory in lkdtm-heap-a cache\n");
+		return;
+	}
+
+	*addr = 0x31337;
+	kmem_cache_free(a_cache, addr);
+
+	pr_info("Performing heap spraying...\n");
+	for (i = 0; i < HEAP_SPRAY_SIZE; i++) {
+		spray_addrs[i] = kmem_cache_alloc(a_cache, GFP_KERNEL);
+		*spray_addrs[i] = 0x31337;
+		pr_info("attempt %lu: spray alloc addr %p vs freed addr %p\n",
+						i, spray_addrs[i], addr);
+		if (spray_addrs[i] == addr) {
+			pr_info("freed addr is reallocated!\n");
+			break;
+		}
+	}
+
+	if (i < HEAP_SPRAY_SIZE)
+		pr_info("FAIL! Heap spraying succeed :(\n");
+	else
+		pr_info("OK! Heap spraying hasn't succeed :)\n");
+
+	for (i = 0; i < HEAP_SPRAY_SIZE; i++) {
+		if (spray_addrs[i])
+			kmem_cache_free(a_cache, spray_addrs[i]);
+	}
+}
+
 void __init lkdtm_heap_init(void)
 {
 	double_free_cache = kmem_cache_create("lkdtm-heap-double_free",
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 8878538b2c13..dfafb4ae6f3a 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -45,6 +45,7 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
 void lkdtm_SLAB_FREE_DOUBLE(void);
 void lkdtm_SLAB_FREE_CROSS(void);
 void lkdtm_SLAB_FREE_PAGE(void);
+void lkdtm_HEAP_SPRAY(void);
 
 /* lkdtm_perms.c */
 void __init lkdtm_perms_init(void);
-- 
2.26.2

