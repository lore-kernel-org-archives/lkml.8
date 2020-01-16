Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E75C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB322467E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBfsq7Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgAPBYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:24:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgAPBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:24:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so9040707pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8H0Ju2Tzkc7Hi4GTApYP4I+j3crkZ0C4oDWnN2FFbsw=;
        b=YBfsq7Ezv9QYWZccbUoWAnosaxltJReREbQgD47d8e4wJ+Ejg4Gn/vs3HhD5eYzXQr
         oJSYxgIJL4FY50iMU0/0GHsjGfjdVuL9/LFpgrcASS5CbKRGtx4pLqrpDWIs3X6BUzT1
         x8tB+7PXLZLkr6MHrizsmnC10IzFOgJdvcjV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8H0Ju2Tzkc7Hi4GTApYP4I+j3crkZ0C4oDWnN2FFbsw=;
        b=Xexqw4PoXsMyfeL3Z4RvVw2h4KrSFFstwBPIdde+L6s1uJZfJpSEqi6KELG8gZMqe+
         /9pGSp09JVjJrv+N/NRpljAIcRuD9RZUxy3WraRMyqLb2KIVXHrvAmPw7kcN3XK2VpR3
         ePv0IlDsxQbw2KmNXjAegqRtfa/Tr7YPMXXMDktShxds9Qf/B2z+gCA7RU8Qd9i4JDor
         oCeaotH3NsvqpKkjYxFyT8odQ+6zGg8UxxU1WC/vVv68LNmykUB+QvdMvmq/lc6V3mto
         uKdA1cBVrnR7hQZuHuO4Sm4cDI1RHitrO1p6z9MS6JNzc4AkJ+77lWA5YihXjrGvgqMO
         h9jg==
X-Gm-Message-State: APjAAAXJm9CSEofY3uCnoY3c/efTIyXTI+BdpoN7RbFdLe3lmvXWYkr3
        +UNp9iJOo1Eg9yvTl6CpStXTzw==
X-Google-Smtp-Source: APXvYqyCry89U8JhHB2JmnnGGqfqp6e2/sFNsw+rUzw40rZSQ9y3ohq76mRbxz8eJb3EdmcaMK/hOw==
X-Received: by 2002:aa7:98d0:: with SMTP id e16mr33457061pfm.77.1579137865146;
        Wed, 15 Jan 2020 17:24:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm1046181pjx.6.2020.01.15.17.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 17:24:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v3 5/6] kasan: Unset panic_on_warn before calling panic()
Date:   Wed, 15 Jan 2020 17:23:20 -0800
Message-Id: <20200116012321.26254-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116012321.26254-1-keescook@chromium.org>
References: <20200116012321.26254-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done in the full WARN() handler, panic_on_warn needs to be cleared
before calling panic() to avoid recursive panics.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/kasan/report.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 621782100eaa..844554e78893 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -92,8 +92,16 @@ static void end_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn)
+	if (panic_on_warn) {
+		/*
+		 * This thread may hit another WARN() in the panic path.
+		 * Resetting this prevents additional WARN() from panicking the
+		 * system on this thread.  Other threads are blocked by the
+		 * panic_mutex in panic().
+		 */
+		panic_on_warn = 0;
 		panic("panic_on_warn set ...\n");
+	}
 	kasan_enable_current();
 }
 
-- 
2.20.1

