Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F86C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A35206CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RHjhmExy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIBCyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgIBCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:53:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F808C061251
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 19:53:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1639036pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqktUKjWMSHZ7i2u+s16x0sbSP9VPDjkmXRnw4GPeg4=;
        b=RHjhmExyg+rpKyv5Nc9ZaYdn2DDJqjk8uDuYweNqZFU1j+qj3H0V4lh98xtDwrZCOQ
         v535m4lYwgRAkju+Q23kPxEFj0WUXNg/5bty5jvMQrEg8y9c7PPEG+wW8D0rM+8L60/H
         hDYiteu/ngFeVisaqnjEhGrnjlZIlr1hy/6d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqktUKjWMSHZ7i2u+s16x0sbSP9VPDjkmXRnw4GPeg4=;
        b=Poq2ziJQG9Jh7BOCVU4KhDUqTd1VDYMvov+28alzchaIwGbZoX46bEvi8eDlf7Hz0P
         eBzGZxopkl6EngqjKsEYLn4Tz1ZQXgdQVh0FOW7xviSnO2j8rK8YlQReP5I/pHFHHX2w
         ISGpxd8OyAWNH2gGa6y8Cn1Lv+vaop5HixVkh/+E5+Tt1MPuyK9j/PmMW8Ic1LcStnoy
         plR5N+4eIyCHA5MK1kN+RDxlAjNNlYYp2deEqEbJZ/cJXElaKN+p8BGTB8HhC5nupMjc
         A/9xb2EFvjv3GgzCKDIjZ3ErkT9KVQWFyyKYSzhO3hFdZCFZybsnVmymZIH4IR2rz0bB
         UqhQ==
X-Gm-Message-State: AOAM532Zac7Opt56MuLvDwZmCYmCT62yxQfrPCO8ElgQLF8pctHy/6/Y
        j9CXezyYOnlWKAuQNLNy7Nv07g==
X-Google-Smtp-Source: ABdhPJwag7uthri0Mn2pyA9vD0vrAX4zwO2oNYtPUmO8FPFRZu7rxMxErll80vPwkn1YAidGcFN4NA==
X-Received: by 2002:a17:90a:17e8:: with SMTP id q95mr220525pja.161.1599015233232;
        Tue, 01 Sep 2020 19:53:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k88sm2949999pjk.19.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:42 -0700
Message-Id: <20200902025347.2504702-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

The ever-shortening series. ;) Here is "v7", which is just the remaining
Makefile changes to enable orphan section warnings, now updated to
include ld-option calls.

Thanks for getting this all into -tip!

-Kees

v6: https://lore.kernel.org/lkml/20200821194310.3089815-1-keescook@chromium.org/
v5: https://lore.kernel.org/lkml/20200731230820.1742553-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200629061840.4065483-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

Kees Cook (5):
  arm64/build: Warn on orphan section placement
  arm/build: Warn on orphan section placement
  arm/boot: Warn on orphan section placement
  x86/build: Warn on orphan section placement
  x86/boot/compressed: Warn on orphan section placement

 arch/arm/Makefile                 | 4 ++++
 arch/arm/boot/compressed/Makefile | 2 ++
 arch/arm64/Makefile               | 4 ++++
 arch/x86/Makefile                 | 4 ++++
 arch/x86/boot/compressed/Makefile | 1 +
 5 files changed, 15 insertions(+)

-- 
2.25.1

