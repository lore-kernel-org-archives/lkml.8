Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E7C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B78F246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBkqK4RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgB0Tfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:35:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46591 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbgB0Tfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:35:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so189228pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVbVapbdvm9D9bZT8RLizJdch6+5SIEY/KYRYQVG8Tk=;
        b=YBkqK4RCOblb4V5cg2JjztQtg3wh+brHnQ/Xnw/4IBUFJRhh4GeFiQP9nVouaSw+sY
         Iq7R/urAShHZ7CPMQvKGeXyT+FOvmE0vy0gms+GZvnF1oUTIeAIqmZaTytVTOmRvhGYp
         9u4+wigHHHW5WR6VelBYcFCmp7ofnwGN7wT7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVbVapbdvm9D9bZT8RLizJdch6+5SIEY/KYRYQVG8Tk=;
        b=Y1b1JOs+84uh65699UGZmKrJBr6VQBQXg49RJd8yeSrdySan3AInoENZyiL+xsw0YC
         KdI6ZFVPUHwjEIMDOM4RO/0g3fnfjPNwGSgjbfpLzRuDRPp0ZVsC3455wv4Zm0elIPGc
         VMsA76B6WUWv0xeNEMHMDRdBXgpf3/V+0QPw8RxYoBS+w7t+rj31g8eXPBjJe+da4Bpc
         eOv/5mShxOCgNKxZjefNrVoS2HywaRWBBB/EL6sAYGoTLyt+XhUq22qkS3uBGNYMVlMN
         IdA5oN9jGHexzkYmeA6SGbQ2Ss642ZgclkrrtR3Fq2JfA8FDUEUtHnspnprlHGoAlwag
         bD+A==
X-Gm-Message-State: APjAAAXcwrXEITnaPPEj/DVdMt2VSUkYn8xV0BWIuXfmnpeB1U8Am1FV
        PVFMR/BHF5YRLrumXOpk7bwzog==
X-Google-Smtp-Source: APXvYqwJAU0YQCF3NBelWYbAkfjhxYyfXVhFnc+XRJm1wrTo2TVo3yr52ImKKRO716VR/awYEpFPlg==
X-Received: by 2002:a17:90a:3266:: with SMTP id k93mr527984pjb.23.1582832128663;
        Thu, 27 Feb 2020 11:35:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c26sm7957064pfi.46.2020.02.27.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:35:27 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v5 5/6] kasan: Unset panic_on_warn before calling panic()
Date:   Thu, 27 Feb 2020 11:35:15 -0800
Message-Id: <20200227193516.32566-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227193516.32566-1-keescook@chromium.org>
References: <20200227193516.32566-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done in the full WARN() handler, panic_on_warn needs to be cleared
before calling panic() to avoid recursive panics.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 mm/kasan/report.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..54bd98a1fc7b 100644
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

