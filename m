Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA9C35E1D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF69246DC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5i1lW7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgB0Stf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:49:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40880 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgB0Std (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:49:33 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so165535pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVbVapbdvm9D9bZT8RLizJdch6+5SIEY/KYRYQVG8Tk=;
        b=X5i1lW7gtygxaUBwIXKTt8fYX5fEWxVzi2XPmciBRut8OEFBUEudCWo+YccEh6f6ny
         /0Cptj90ru+QtzO+Jm5B066x0Pd+9dPxjKr3EyADF+7U55O/GYlCWSY7ZOhdLMBJq8sg
         t4LNOFIll7WZncnYRr9YoMxDx9eWQGNfzgmqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVbVapbdvm9D9bZT8RLizJdch6+5SIEY/KYRYQVG8Tk=;
        b=VwqPXIOdWv+4UllSyTOpU8h41V8kVsnEFrK/1uHvIsdrkGLPucBmRAcPV9rH8ip/yq
         9RCR4lGvfW9sVDugsub/pMP2FCjRsujaTqc/blNgUMZKIMVsFAwwLE8icP8HxAhMjo4+
         dDzT7Gio5MBzrv3Y9m3KuTf/AMomWyliSTgCvJQvtczGZEmMiu+1K9NkAkNpV47HRPBD
         H2RIztLQw+wF3tzvvWL/NSD6UQLzXduaQQtt7jlC1zylyg7gpUvaM8Rk6nIu7vGrZJ3w
         WTqwiU3YrSSAWWZ7wrP5KMFAJ6MiUJhmAq92aSj74y/sDwHWA/+6twBI7Hm7L65nl5CC
         NMaA==
X-Gm-Message-State: APjAAAXD5r0kkf4ejt6UGupSyPs7+Wqu38vsUHNZiMAyXkhVZEIbMDgm
        Aw1ZXRTCf0dkv2xrraFgp9VFrA==
X-Google-Smtp-Source: APXvYqzw71xoeQerxYnDZjCdeGbLhe11Auq1JT6Ex87ZaButtE9AiRc/KemYe2G4Nel9rk6gdI8HaQ==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr352661pjb.33.1582829372673;
        Thu, 27 Feb 2020 10:49:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm7629675pfo.187.2020.02.27.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:49:31 -0800 (PST)
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
Subject: [PATCH v4 5/6] kasan: Unset panic_on_warn before calling panic()
Date:   Thu, 27 Feb 2020 10:49:20 -0800
Message-Id: <20200227184921.30215-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227184921.30215-1-keescook@chromium.org>
References: <20200227184921.30215-1-keescook@chromium.org>
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

