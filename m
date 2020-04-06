Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E83C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3332082D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DETEeYLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDFXQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:16:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39259 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgDFXQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:16:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id g32so792003pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjDe4Hi7TtVO/wKC4Ixr8yGihHqa400mWL0wehOCRBk=;
        b=DETEeYLUPrHDWmX+mgf3XfkHhQ8bXZ4JQ20xi9rnXY3vkREikPg39QMkW+FwOTZOB6
         ad3hnyhmQW1o2fY8ksqfVaf3PHYZJN+QwgTMVfcpg7yFW8qoLnAx5xje3nNlmfgKQLKi
         xbiidiGJHcDcOJhrAq91ofcxuchLHrHgbpU+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjDe4Hi7TtVO/wKC4Ixr8yGihHqa400mWL0wehOCRBk=;
        b=b1QKFAyph8Hh/od6f3bDmrb93FoBlu5ImqWNufqM3DkTxiLSe/Mp/46NyqNYdO0jT8
         5abWML7oH5Ooos7MLgusbglSJ/pK4jHwBNEgNYKDFqXA429R+TFssHML5CVocOj02jxJ
         RCEsuUDJvCYeS96uKW8UKbXyi1waQYbkNoNix/d7xptyFzn8FVijpjg9LzLY0FVYW93U
         Poa82aS3yIRRSoL/BA0yQiBRcihI68+pKuTVyYmeGMeG7QSl1XHoMmH5WJcEoH0Jda4b
         V3pxafH/uZUZ7m3uCIpGg/4vS8EOlb3eHnXMJd/MeyjKj6v+s/IsO2lZSG6GeOHj6TXH
         fkDA==
X-Gm-Message-State: AGi0PuataagXpcPbNT19t7yLd6CrOrWwmNRU9K3LhMTgtrA5ViFcAElh
        lKF+0IsGu7HrBGb0kqNPLOfm+A==
X-Google-Smtp-Source: APiQypJOAJUD5o/cOCh1/7iAsdO0knHWBcNha6PAtRGiz4cvm/tS0aBBSt7jxUfJb4cvKE69NcjkTA==
X-Received: by 2002:a63:7b5e:: with SMTP id k30mr1393245pgn.209.1586214971506;
        Mon, 06 Apr 2020 16:16:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 74sm12190832pfy.120.2020.04.06.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:16:10 -0700 (PDT)
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
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] init_on_alloc: Unpessimize default-on builds
Date:   Mon,  6 Apr 2020 16:16:03 -0700
Message-Id: <20200406231606.37619-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406231606.37619-1-keescook@chromium.org>
References: <20200406231606.37619-1-keescook@chromium.org>
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
Reviewed-by: Alexander Potapenko <glider@google.com>
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

