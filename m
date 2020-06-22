Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963ED2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jPi/b9t/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFVUxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgFVUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:53:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so8799643pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDXLfB+PQDLRQ6NmPDmR2JF3Ok4ZVjhNHcZbi8M58JY=;
        b=jPi/b9t/cgTj3qq2Y+w0Tp93JhZufwpflaLmvJiEevWxTi3dExayl9ry4eqVJN/fWa
         o8Dul0iXlzYg6sDsWr+LM+o6q4SVmNEyXDnChNwemh29HXQJQCorReaJsa0EvUAllkee
         p8bfk/EkllHSz3PZVmYDOYLn+iUf/LwJlmHSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDXLfB+PQDLRQ6NmPDmR2JF3Ok4ZVjhNHcZbi8M58JY=;
        b=lTuOqsnXZGthZKPv6lWNfR5DRuLLn4TLfFG4h/i5iHP1ZYcmEwbY+aleRiHovxTGLn
         K0Bx6yzMTZ1bKXi6OGK+HKMTE+kikGMTash7hrD/VZeYLE9gaQADd/fo7zlNOoof3c/i
         lYkTAHQuhBsYpS70MncRLQjWdlRiLombf7O54Gf4Hth41VSkW8gQaBjiuWjh7DIpgGSM
         4iWICISD8pMOw7P+74/vsLC7mG12d5IJrHhDCsZ5VDzTylX78hQILfrKEyrvvb7FE5ge
         DIRJD/rpnwM/RtzjV+N7bZpv9lJeoN0GwNYReObhtEaH5ln9LBUuHPfbp9HEWIs1xayD
         +wBQ==
X-Gm-Message-State: AOAM5307hnVAJoxJJqQ/H2C8stVYiC7VX38YaHXvM/xiqRmQSVwcqAWQ
        OObrqFIVpQ/pCtNCx4Ha5Ktkqw==
X-Google-Smtp-Source: ABdhPJzyxPTRZcNzcoXYNKkQYAQPnWOSEGrY4CLCWimk1cAn3PmhaciF3QcwlYv13B0JtnQ3oe6LXg==
X-Received: by 2002:a05:6a00:7c6:: with SMTP id n6mr20534999pfu.120.1592859226960;
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q22sm11005302pgn.91.2020.06.22.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] x86: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:53:38 -0700
Message-Id: <20200622205341.2987797-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- split by architecture, rebase to v5.8-rc2
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

A recent bug[1] was solved for builds linked with ld.lld, and tracking
it down took way longer than it needed to (a year). Ultimately, it
boiled down to differences between ld.bfd and ld.lld's handling of
orphan sections. Similarly, the recent FGKASLR series brough up orphan
section handling too[2]. In both cases, it would have been nice if the
linker was running with --orphan-handling=warn so that surprise sections
wouldn't silently get mapped into the kernel image at locations up to the
whim of the linker's orphan handling logic. Instead, all desired sections
should be explicitly identified in the linker script (to be either kept or
discarded) with any orphans throwing a warning. The powerpc architecture
actually already does this, so this series extends coverage to x86.

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/

Kees Cook (3):
  vmlinux.lds.h: Add .gnu.version* to DISCARDS
  x86/build: Warn on orphan section placement
  x86/boot: Warn on orphan section placement

 arch/x86/Makefile                      |  4 ++++
 arch/x86/boot/compressed/Makefile      |  3 ++-
 arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
 arch/x86/kernel/vmlinux.lds.S          |  6 ++++++
 include/asm-generic/vmlinux.lds.h      |  1 +
 5 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.25.1

