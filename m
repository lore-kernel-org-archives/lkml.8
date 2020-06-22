Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82767C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9102083B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQvwT91a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFVTb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFVTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:31:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA080C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so8869538pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bd9f3BBqo3zGwwTfmvjboaNS4RxuJ7DCwqiU44HfZsQ=;
        b=jQvwT91aNdu6DbbTFmcHtowv1QDuWeDxsDk/RqKsPvwbGbHTpYzrDrmmY/0dq+aBJQ
         jlwYwDhLmthT175NDbEj6C17KQJgc9BEyT+EwcD3Md/NbUgFJ+PR+YCJt9RkY1QSZdRZ
         QY9d67wu3uA3m5bOy/gHJd8An71KIaVS3oaeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bd9f3BBqo3zGwwTfmvjboaNS4RxuJ7DCwqiU44HfZsQ=;
        b=l0swADG7S3Set0ahPh1rbZLBh95Wg3v7ZmFlPOjp9qeghEmveCINGYXeDs8GwWWZl/
         0MX0fB1htW07UeQ4VaQm4N20mxoa83gA2zfO6SCmRTWA+GNNeewyvg8DMAkct839QIaD
         etJhUgWdwvh82sjOykwvzu+91+GSBe2EmsViPeteYvCOlHC8BP8w88ARyraC6lctVRUH
         dF5GalQS5asKEwd2+aJtNfXuOGVhpq6IP9CPg8lRwfCpOXuoQvxJAY4cspYGG+VvNRP5
         31pMYetieEQcouoUfWjO/VI6F6jIxb3PCqUf3B7BILyuVhblfluEH2ZkpOZ4/YkKgr6K
         MvqQ==
X-Gm-Message-State: AOAM532CyzIvGyXIVmkvudaBvaIgJvphzIyrHSTkwxQ05sQivQnEGYTS
        iZu0r/+RLXPQosV3qfGqCkVMtmAXjYg=
X-Google-Smtp-Source: ABdhPJy/XsCwbSTQ8GDNdy6eIPIN39i7/vLM9SHQLKSs+iIR061Tg/mVW3fZLxYeE/B4wCdXiH9v5A==
X-Received: by 2002:a62:1d0b:: with SMTP id d11mr15185345pfd.1.1592854312494;
        Mon, 22 Jun 2020 12:31:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm14064284pfn.177.2020.06.22.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:31:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] init_on_alloc: Unpessimize default-on builds
Date:   Mon, 22 Jun 2020 12:31:43 -0700
Message-Id: <20200622193146.2985288-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622193146.2985288-1-keescook@chromium.org>
References: <20200622193146.2985288-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and
...ON_FREE...) did not change the assembly ordering of the static branch
tests. Use the new jump_label macro to check CONFIG settings to default
to the "expected" state, unpessimizes the resulting assembly code.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e6824fd4458..0a05b20870c2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2892,7 +2892,8 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc) &&
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc) &&
 	    !page_poisoning_enabled())
 		return true;
 	return flags & __GFP_ZERO;
@@ -2901,7 +2902,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free) &&
+	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				   &init_on_free) &&
 	       !page_poisoning_enabled();
 }
 
-- 
2.25.1

