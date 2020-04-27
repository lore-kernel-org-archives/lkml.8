Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB10C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2B9205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0D9RdpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgD0QAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E2C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j92so11058202qva.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5K2KfWGbdPDvciUxJWKmXs8jymeyhVJTI52mBn5Jn2U=;
        b=Z0D9RdpHbbOHHtNvqHRo52aZbZAj07cdZRmpWEeU3iQTueml5HmYOfEBcmC2kKVIKm
         gi/I42ma62LvSvGNYMm2NpEhpa6fsNrdLgOepXOs2lXtqi4B13V7mob+8FE88DmkGTAj
         cIfoOAEzDwtio1vu3/bEbEwVj3iXpD61m74J35yn1WLDpR++aGJg9GG9gk87kfObQfaq
         2Fr6/vhs+4bP5L3TBzKyaTEUUQB4mwZj8HZ3pjL3rr671/M4/cAQ1XkhNhG0tTSV5H0Y
         Lghd93Heuw59N+AcYzl5+VmFD+sORBxuAIoCgApPPsaEMCghNZl1+DyNOu8XOZdSuzS/
         tqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5K2KfWGbdPDvciUxJWKmXs8jymeyhVJTI52mBn5Jn2U=;
        b=jG6XT2sHoRVAfGKGhbkbAYnd28Li7pxUfAgPfemVPF/EdBf9YnhY3VE5ai39WwzpNp
         qXGndfWpSHAQV+YTXhLNvL6Ul4t3EDpQTSR6K452282pyBrL2R5GSFq20i8aLD1OdkZ4
         8t1ADe05txaVIiEVbtBfwj6dIOnswpPGdKkHROnX3314H/BidUj0xiB8kkpjbvDkqK1n
         JufjTQPoumDmcOhhCyGWWbj1MsY8/eSySZdCnTwx7lHqOOHpQho0dLU/o8g4yOL5sqys
         jQaUWBtoBW7SyK9nLPNbedI/ZzVnv3fb1DLDgo9k5NY+T2M9gkBBVi5gxew/wKAgZb06
         CDAA==
X-Gm-Message-State: AGi0PuaCm5SUMpIYKO2Vyf0QpzVKCrgjZeUMWt1gSSR3uE71cnSstPtB
        zfKz1IwPkk17X0//gsc2ob8F/sDTlwcbSTM9h/w=
X-Google-Smtp-Source: APiQypKZHPN6pHK1vtX6gJq9lobiR8zzmYnoXCSFDICaarTBdgedlZVYx+cSajiHci65J+75kJpbiA+ZLbes2n1w/OI=
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr23363061qvj.26.1588003248063;
 Mon, 27 Apr 2020 09:00:48 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:13 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 07/12] arm64: efi: restore x18 if it was corrupted
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we detect a corrupted x18, restore the register before jumping back
to potentially SCS instrumented code. This is safe, because the wrapper
is called with preemption disabled and a separate shadow stack is used
for interrupt handling.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 3fc71106cb2b..6ca6c0dc11a1 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -34,5 +34,14 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldp	x29, x30, [sp], #32
 	b.ne	0f
 	ret
-0:	b	efi_handle_corrupted_x18	// tail call
+0:
+	/*
+	 * With CONFIG_SHADOW_CALL_STACK, the kernel uses x18 to store a
+	 * shadow stack pointer, which we need to restore before returning to
+	 * potentially instrumented code. This is safe because the wrapper is
+	 * called with preemption disabled and a separate shadow stack is used
+	 * for interrupts.
+	 */
+	mov	x18, x2
+	b	efi_handle_corrupted_x18	// tail call
 ENDPROC(__efi_rt_asm_wrapper)
-- 
2.26.2.303.gf8c07b1a785-goog

