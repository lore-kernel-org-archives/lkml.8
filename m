Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372D20788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vpxmpa7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCXUcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:32:39 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39053 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCXUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:32:39 -0400
Received: by mail-pj1-f68.google.com with SMTP id ck23so40587pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtcXhojXdvVAaDeWfB/KlcDfMVh9eKi/T1lC0sMYq8g=;
        b=Vpxmpa7ys0bod0SNGpU9HyY796q3xE/M3orNp8yw116/0ZyHjlZKj+WNR92bTLQ7N7
         mX5GB7DrOSUiWFgL9zFZ9VSSzsyJoLgWbC4sD0apXV2JjP55GWJ/SQRkk+tLe9BdjdAA
         RdWbcxQUkap+TOsmpSxq5+j6/AOKEweKlqbt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtcXhojXdvVAaDeWfB/KlcDfMVh9eKi/T1lC0sMYq8g=;
        b=Lk/kIjxoVv1/QFttSONLA8xjRG/1rEXW+TQd+Y+ThCBCxjDpn8Sw0nC85Q4NaKJ6s2
         K/HOMxRvoHy4jkpWUeEQulgGQRJG/3UvVpFVNcknUDWck7+JHr8kL1QH3B79LubY57su
         bMjs4cdDh0tJLt8UOwK4nyYJDHeDVmhNZvmhzVsh6EXRL8CafqtZbEd3uutBOrwfX+Vn
         7o6VZfWUFLQSBN9sejuJ8hlKJLaRRYaV9BVSkoyC5+YdwT412fwKqsokIj4fdXXlUXdp
         /dxx9MqF50rcanTuXRA+LouCgzsSBimlP76DamXHVXgPbF/7LU0TNBKadbr6hDicdDQ4
         goRA==
X-Gm-Message-State: ANhLgQ0eTE7i4neZD5/9ylXoJKYjm+l28TvUJjP5njHFiwfkqgw65W0n
        Y2Oi3dF7teWBoihjBG6rkAKjTQ==
X-Google-Smtp-Source: ADFU+vtPSvkZ9yb3NUUQBsFHC9q7zD81H0YjIqBGW1aGNMgqBP877n5HImnbQzQDRnrTS9OMqHYFgg==
X-Received: by 2002:a17:90b:124a:: with SMTP id gx10mr7434930pjb.117.1585081958466;
        Tue, 24 Mar 2020 13:32:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17sm10418685pfl.104.2020.03.24.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:32:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] init_on_alloc: Unpessimize default-on builds
Date:   Tue, 24 Mar 2020 13:32:28 -0700
Message-Id: <20200324203231.64324-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324203231.64324-1-keescook@chromium.org>
References: <20200324203231.64324-1-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 059658604dd6..64e911159ffa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2665,7 +2665,8 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc) &&
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc) &&
 	    !page_poisoning_enabled())
 		return true;
 	return flags & __GFP_ZERO;
@@ -2674,7 +2675,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free) &&
+	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				   &init_on_free) &&
 	       !page_poisoning_enabled();
 }
 
-- 
2.20.1

