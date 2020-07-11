Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC96DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFC22075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="tQOPOFgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGKD70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGKD7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:59:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA90C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id i14so3384488pfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Wf2KClM6Tk5kmhkj4X2FnIK/p9JJMcXyJrf5eWEAU70=;
        b=tQOPOFgtewhe4q5nXYz43DV8Ob8tcit3pVPeQ5TjI8XCSGeWy0QqpfT1poT6OTp9qZ
         YjFz2pfaGqF7Im0Xa0etUyPumohyomrxVS6dAiZjGplSskgBqcJ0W4i3tH4EqmgTAuLI
         ray0SmDHhfL0JbGHQmiGEkARHu/0ZLfEjKmfczdYDEi+Tcg619FSyL6RkdvSs0W+Wimc
         egdq14P+9oRqZeBP0QFzd73I+cTpaCrwB0w8T86McEFZgKrVKr43mtk2lMzhnGnCOlot
         mGekL5N/WGkfxCgmTsZV1BlX/R4q2iZ1fZuZTMXA02bsAG5A6A+6o11l/VbpxUFuQpn8
         OU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Wf2KClM6Tk5kmhkj4X2FnIK/p9JJMcXyJrf5eWEAU70=;
        b=tpOB8gH2tJDyuUSHzpkCWG7inx6914qA+zJEQ4TYdxEQgGC7tNcH2NNqiwpzRpW6LK
         UF03LlQs9Zyju91kIiTVAOcjiQ4kI+BmivW2hxN5BHfa9nT3DJeq+POf+htvBH+6J01E
         6+P3/Wvh+4KtnHB9i/wkLMimPD7HCdLm5mVFaU1zVjaeNvmnBW9TtLnCSdlLSKFCg5Zx
         h7BSgThyHeag8ogvArMrFb3StTSiIDCBLn2H+Qq8/EWR14eK8tuJX+8rfTSUFxdwlQO/
         I++pOCum5ctN3cMg4Q8rGImv3A50x8s7ytvxlZE1JGrlgmV906RTPDW710m7wUohJCrT
         FzRg==
X-Gm-Message-State: AOAM531f6v4TVmlQjuPJmvrHzdU3KJqD0vu6nU2MdtUb1uZVvfQNWBMJ
        fKEX1vWIWwx83WncJOBHBTMa0w==
X-Google-Smtp-Source: ABdhPJzMofsLQD9Z2uTdicmms83eUcQQbTxAg1eUW9k4rQlfm5rNXPzgR+F3lg7A+gscikb7UdwrtQ==
X-Received: by 2002:aa7:9ec5:: with SMTP id r5mr17529907pfq.86.1594439963157;
        Fri, 10 Jul 2020 20:59:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j17sm6811709pgn.87.2020.07.10.20.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 20:59:22 -0700 (PDT)
Subject: [PATCH 3/3] arm64: Use the new generic copy_oldmem_page()
Date:   Fri, 10 Jul 2020 20:55:44 -0700
Message-Id: <20200711035544.2832154-4-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200711035544.2832154-1-palmer@dabbelt.com>
References: <20200711035544.2832154-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rppt@linux.ibm.com,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com,
        Palmer Dabbelt <palmerdabbelt@google.com>, mingo@kernel.org,
        ben-linux@fluff.org, peterz@infradead.org, broonie@kernel.org,
        davem@davemloft.net, rdunlap@infradead.org, uwe@kleine-koenig.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        willy@infradead.org, krzk@kernel.org, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, keescook@chromium.org,
        glider@google.com, elver@google.com, davidgow@google.com,
        mark.rutland@arm.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is exactly the same as the arm64 code, which I just into lib/ to
avoid copying it into the RISC-V port.  This builds with defconfig.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/crash_dump.c | 39 ----------------------------------
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..55b27d56b163 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1109,6 +1109,7 @@ comment "Support for PE file signature verification disabled"
 
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
+	select GENERIC_LIB_COPY_OLDMEM_PAGE
 	help
 	  Generate crash dump after being started by kexec. This should
 	  be normally only set in special crash dump kernels which are
diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index e6e284265f19..197b92c249ba 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -13,45 +13,6 @@
 #include <linux/uaccess.h>
 #include <asm/memory.h>
 
-/**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is in a user address space
- *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
-{
-	void *vaddr;
-
-	if (!csize)
-		return 0;
-
-	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
-	if (!vaddr)
-		return -ENOMEM;
-
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
-			memunmap(vaddr);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, vaddr + offset, csize);
-	}
-
-	memunmap(vaddr);
-
-	return csize;
-}
-
 /**
  * elfcorehdr_read - read from ELF core header
  * @buf: buffer where the data is placed
-- 
2.27.0.383.g050319c2ae-goog

