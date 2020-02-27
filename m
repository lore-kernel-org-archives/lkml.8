Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3292CC35E1E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B324246C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTDnhmVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgB0Sto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:49:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37368 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbgB0Sta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:49:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so286262pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46Z0N6nNFPIgM2OuwNgkHRjYe659IsqNoWw8FG0hdrY=;
        b=lTDnhmVnqQJEUJ5LnBGPuhXrnv05UkcjRDWNOX4WHR+p4aommd+S5U5/xJ9GYmjDyV
         D/5GwhtD18WW//fs2/5w1ghXIQm+EKFifaYUneu04fLN8/9y1Mj2SuFmDWjgLzxaen0O
         3tTOuDeaafS34wt+AZuoCBaUtcE3qzutj612k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46Z0N6nNFPIgM2OuwNgkHRjYe659IsqNoWw8FG0hdrY=;
        b=htVRKzOMpqwG4E3cSqRn1HSaXaJ0DbIgORtHA4QPo2SBCy1w91+U5uIZ0pM76GXj1T
         nKcKj+ZuuaUxYITdzC3q7plH76UHNylPJwIyWzYJimMJaDmMcHhG0txlrzayW2wFkFVX
         FLGhLtVy7TV+ytoQLeTjN4G7iQFKBLC5yqEVfpVMwEQWrMaEJRcmrl0vQGBa309pIPVj
         s5l7wlo88Okexgwg+GWch9xFFNigSQR+SOixSxTv3/kdFMXiRFNhEb5Gqzwu3SgTp5Jm
         z8BuOHbJrrxM/LGVxFdV5bJSW5Lz/kNiOERFoPpDxIMu52qbKL90Iic6VMWmf+eORy6S
         zkuA==
X-Gm-Message-State: APjAAAWsu/kX/d98Phm8yTxddEdGjKhDCB3/fobtMeCxTupx7x1R70be
        ZpKI279OFKYcfZjBTI66kn5XlA==
X-Google-Smtp-Source: APXvYqyp61REIsdWHH37oqm6TnnTLVpBM0r3x0E6/zmvpnUPvvoIlWHFgZSyISwmK1qp5zs0Rz23qw==
X-Received: by 2002:a63:3103:: with SMTP id x3mr677715pgx.209.1582829368829;
        Thu, 27 Feb 2020 10:49:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm7998669pff.188.2020.02.27.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:49:26 -0800 (PST)
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
Subject: [PATCH v4 4/6] ubsan: Check panic_on_warn
Date:   Thu, 27 Feb 2020 10:49:19 -0800
Message-Id: <20200227184921.30215-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227184921.30215-1-keescook@chromium.org>
References: <20200227184921.30215-1-keescook@chromium.org>
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

