Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B80C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21902076F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCQoUMIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCSVp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:45:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50486 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCSVp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:45:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id z13so4456640wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N4ZopA6jxYwy2PnkatOwlcBFmsjw5EoOzX8MW2R1axk=;
        b=SCQoUMIyZ8Vbw+wdNtsMzgerp4TLRYoqfv9UdEI8qiiG2yej5r9RHT3QG3KuEakprQ
         QlVMh79lPcgD52TLIjS02rbPaOmN3pzIWtOjDQSPxBl3MG029b9ZhSqcKGQtfFGgB9Nr
         ETOO8pn5WfF8KQgR4ayiEWfDyr5kJU4XUyx3ym3e8SbXbUNGaj9HClhMarzLaoYW7kke
         hO0uQf2m7qGJekB50ULI8hd1uMBqHxhsp47xVxMyyU4Yvj2SKl1kJOhAE6JiDuIpTUO1
         UHa/VY8gHYgzqbeDGJGM0JDufqHDdIfOMD1dH91pSkZKPythVlpFVPy4QxEPTJDcCXgE
         HRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N4ZopA6jxYwy2PnkatOwlcBFmsjw5EoOzX8MW2R1axk=;
        b=j+l4l5/qX0+r7OUJq/r5Cg9svKTuXM7EFRNMLMNDQB3kKCxfu9tYWHbhGTV+6p8zb+
         ZEAHBwGHs8zUQkh5X6ORq0vf9v0Uc4huqbMyujfemTEcLYx0y+HOZTh0u+z0Uhvljai9
         kbB9m4t0g+MFa9OhSmpRs5T2wG9dl6S+rA4k4EwsRXbqgThDR6YWwXAAEZzW4pH41LgF
         mlBZ6kYe3+HW7/xHvRP3pHUUywCbBDIaeUnk7Pv/emsC8F/GNYqLp6/S7gB0rSsEIF5E
         5e6OaTPCQY4fiiCOFLy56bjDI36FpZZoAmyqZgBb+waG9rC3eBKsC8EBw82qd7BsMT/d
         aI3Q==
X-Gm-Message-State: ANhLgQ0GgBWN7cb4+iEbYaygJaUTV44dDxGNU9uS3NcC05ZdOfcktrQn
        OFc35ppywy0U8knz9gww/jE=
X-Google-Smtp-Source: ADFU+vuUf/dMXXmerrEFIGVyIYt/t73qo9oj9x54KMu2VIM2+RSkINpbNE8HG8y9a2oI2vKGuxTOsg==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr6330915wmc.73.1584654354401;
        Thu, 19 Mar 2020 14:45:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8532:8700:6c17:119f:1ee1:b2f0])
        by smtp.gmail.com with ESMTPSA id h10sm5360793wrb.24.2020.03.19.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 14:45:53 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ilie Halip <ilie.halip@gmail.com>, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] arm64: alternative: fix build with clang integrated assembler
Date:   Thu, 19 Mar 2020 23:45:28 +0200
Message-Id: <20200319214530.2046-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building an arm64 defconfig with clang's integrated assembler, this error
occurs:
    <instantiation>:2:2: error: unrecognized instruction mnemonic
     _ASM_EXTABLE 9999b, 9f
     ^
    arch/arm64/mm/cache.S:50:1: note: while in macro instantiation
    user_alt 9f, "dc cvau, x4", "dc civac, x4", 0
    ^

While GNU as seems fine with case-sensitive macro instantiations, clang
doesn't, so use the actual macro name (_asm_extable) as in the rest of
the file.

Also checked that the generated assembly matches the GCC output.

Fixes: 290622efc76e ("arm64: fix "dc cvau" cache operation on errata-affected core")
Link: https://github.com/ClangBuiltLinux/linux/issues/924
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 arch/arm64/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 324e7d5ab37e..5e5dc05d63a0 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -221,7 +221,7 @@ alternative_endif
 
 .macro user_alt, label, oldinstr, newinstr, cond
 9999:	alternative_insn "\oldinstr", "\newinstr", \cond
-	_ASM_EXTABLE 9999b, \label
+	_asm_extable 9999b, \label
 .endm
 
 /*
-- 
2.17.1

