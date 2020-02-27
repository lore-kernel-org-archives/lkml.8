Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23DAC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750202468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/0EvsSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgB0TfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:35:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40334 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgB0TfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:35:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so202215plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46Z0N6nNFPIgM2OuwNgkHRjYe659IsqNoWw8FG0hdrY=;
        b=g/0EvsSAMFLQMs3F4fsuSd2nVZEd0UnWu4D3Sl3dqAK2cD5B2JP/5fjn+Xf0mTTCA1
         5qBJKz6rexuU4wD/Fm2T6RKX1mqL5z11ejipV8pBRRNCR/z0fgr1nevk9cbdozCY3z4J
         CEEvmhdGXWUBzU64x5LbmMXX3iFxMU4Y/Igq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46Z0N6nNFPIgM2OuwNgkHRjYe659IsqNoWw8FG0hdrY=;
        b=br3DEoZLqaefuKh2WouQ/LEs6Fwy7LpqcaQjH2pPRfjO7lj1Dey4p4TxMQrWJTRGmY
         wEkeatiImw9ctS3vo84xV2MglPUAfdaWBIviERBDRFlAyaIhzjqZULwywFJsYjhFzf4x
         7wxCwmYeJS3lA3v4z8TGynChsJPR2Gg+Ld+iQ3VZrQVo1IrIgw+DNipoqJTCoTPJG2n8
         4ekTP721WEsJZBNbtoHeF8glPERloIARBT+WNJq6nVJaf56gdQTRY9c6CV+HSBgif8wa
         OEPPXimhXmKgfD7+j3i3UWkgj3PxfcHqWJTUcH8sBBZTHo7vPYO0ykYv+q+Ht0oHtydk
         J9VA==
X-Gm-Message-State: APjAAAX0203ItIYRUkgXCV+JnUA2JNEvZrgoPcupF2yXUwIknZ+jcXna
        ayjjVT0uiaw99MrUJXQTiCcU+A==
X-Google-Smtp-Source: APXvYqyO3xXE1iYRbSHC6/Q9hVVz43xR0biiVO0z4es+cZucLAEsJlQuw4NFe3BlB1tUhIBv2xxm2g==
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr520844pjx.113.1582832121953;
        Thu, 27 Feb 2020 11:35:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p18sm11620140pjo.3.2020.02.27.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:35:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v5 4/6] ubsan: Check panic_on_warn
Date:   Thu, 27 Feb 2020 11:35:14 -0800
Message-Id: <20200227193516.32566-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227193516.32566-1-keescook@chromium.org>
References: <20200227193516.32566-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller expects kernel warnings to panic when the panic_on_warn
sysctl is set. More work is needed here to have UBSan reuse the WARN
infrastructure, but for now, just check the flag manually.

Link: https://lore.kernel.org/lkml/CACT4Y+bsLJ-wFx_TaXqax3JByUOWB3uk787LsyMVcfW6JzzGvg@mail.gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/ubsan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 7b9b58aee72c..429663eef6a7 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -156,6 +156,17 @@ static void ubsan_epilogue(void)
 		"========================================\n");
 
 	current->in_ubsan--;
+
+	if (panic_on_warn) {
+		/*
+		 * This thread may hit another WARN() in the panic path.
+		 * Resetting this prevents additional WARN() from panicking the
+		 * system on this thread.  Other threads are blocked by the
+		 * panic_mutex in panic().
+		 */
+		panic_on_warn = 0;
+		panic("panic_on_warn set ...\n");
+	}
 }
 
 static void handle_overflow(struct overflow_data *data, void *lhs,
-- 
2.20.1

