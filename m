Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31DCC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 09:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6020726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 09:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJpJ5/bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBHJEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:04:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33382 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgBHJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 04:04:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so1714960otp.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KuIxnvjt6h0/H52RMaBXWo+aQbQdJji5KOSpX8NKI8A=;
        b=IJpJ5/bs4Rt3W7H4kqEUY/PUKkd1zUaZ//UF0L74xfFF+6fnVpx/pzld0njI9CDTOU
         OXexv9wL6SKoLBjJBIe46l9zrM6VuVLgo+fHCBjCEzZZh6M2uX6yWUfmbIOMxCrthQFh
         nsTUw0ooF8TXkEpKg1Joj8kRUOJyZ+LmZ5SJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KuIxnvjt6h0/H52RMaBXWo+aQbQdJji5KOSpX8NKI8A=;
        b=lees/0lf5Zw5LKZgWs4QcrvTKpvm9EI9zt8ROMIGfYt78Wb+fjwDc1ytjReVoYBOt7
         qGpXJ1ga9wWlMwrhiM04dRy0ca2Jvw4Zy7PZzCV5Y7k32O0JQ3MAAzZdpt3nVWWQ6lQT
         3FU08jjvHWnpCktIbk1zP39bUSk0rmrozY+nNTd9y7rAmEGUXqMh7TAi3/7/lLbr3Kzg
         aZjxkwJZeP100EOz9QlPzADHF46DkG1Cw4QitaMeiDqwadniTFk8WrSXAVBS/hPl37P0
         8gy7X23Ap1iQovbL0YRGGaNGWqHr6XAiJmpMYEUWoqc75M1XszbIPcCmgBxM+dd8ZHgT
         xxfA==
X-Gm-Message-State: APjAAAWzFUjmh0fI6i67YnCLxqGD2cOlMhNPzHKiLYAp6/0MTZm5OjX3
        2tj9gS3drFTX8ugbXOlybU8Ssg==
X-Google-Smtp-Source: APXvYqxRR97Ajif5f660+DpaiHeBGdc2vP78nseFCsG8QHbGHFtYcvZLw67BGJrVLuScBxugs3/LWg==
X-Received: by 2002:a9d:12a8:: with SMTP id g37mr2785428otg.261.1581152660852;
        Sat, 08 Feb 2020 01:04:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm2094085oti.2.2020.02.08.01.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 01:04:20 -0800 (PST)
Date:   Sat, 8 Feb 2020 01:04:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Remove unused .fixup section in boot stub
Message-ID: <202002080058.FD1DDB1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot stub does not emit a .fixup section at all anymore, so remove
it.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/lkml/CAKwvOdnRhx=SgtcUCyX2ZOGATM8OzG6hSOY9wGQZcwtp+P5WBQ@mail.gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index fc7ed03d8b93..b247f399de71 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -36,7 +36,6 @@ SECTIONS
     *(.start)
     *(.text)
     *(.text.*)
-    *(.fixup)
     *(.gnu.warning)
     *(.glue_7t)
     *(.glue_7)
-- 
2.20.1


-- 
Kees Cook
