Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FCE2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOD4bmbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgFVUtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgFVUtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:49:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AFAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:49:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h10so8773354pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PH47MJnT9iMtyTipendvYX/j3g8mD6+p2C6HpOMAS2s=;
        b=WOD4bmbDBmCvKG9VPJe1yBY5F6RA/C5d94+rIsCOMC/AhYzvpHVOI31fkouMGWmnNs
         WAaT2BCHxMTDm8CF9kN1Yzmk7+OiQZeiaaHVykdf/5VG9I+XluQq+BWZ7hsb8EYRz9Sj
         4FyDsma3WccZgUj17OvcILKa/Y9C4tSpDet5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PH47MJnT9iMtyTipendvYX/j3g8mD6+p2C6HpOMAS2s=;
        b=Y4dYMHik3OdtbmUhEvkDR7Ast+1yTfCU+rbhbj818u9L6mDc6pP1EhoPcBN7Rafrzl
         k1qzGxSKQWCuAUaXaUxEikGiT3e2+gNYP5+YF/kSTIzks1Ld62jMIfJIRPv07/UdjsA3
         E5mgDwtNNPl9Ij0ljRilQVyKhtyOzWo2IrKDUaFWKFSW+pQliPXBduZvXPQ1gOe9zD1V
         Pdkh1SecsgYe+0WTeDDmliu0FMC3tqNFJdvR2j9U5HXuGGZhzVmJT2Tng5BxS+YNRDJu
         UyyOl9tiIFBn/DCMmM6U2p9nhJdimbtfWbXnneLzUKgqZG36Km/tvc0hddG60Cu+XTqj
         Q6bQ==
X-Gm-Message-State: AOAM532yTYl3/XKmpZrsOczfDApD2A3y+5IZ68O840fjqcWLLehYM5a8
        oVMx++j3OtRfo/5fQrxxvfoTqQ==
X-Google-Smtp-Source: ABdhPJx5Gl45//R2Ig0yurEEEVbHIR0XqfcdMn9gku7cjBoQNNfGNtFadJk52dJy3Fh27YYKIlXgsA==
X-Received: by 2002:a63:6643:: with SMTP id a64mr11612472pgc.246.1592858958665;
        Mon, 22 Jun 2020 13:49:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s30sm11975161pgn.34.2020.06.22.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:49:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:49:13 -0700
Message-Id: <20200622204915.2987555-1-keescook@chromium.org>
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
actually already does this, so this series extends coverage to arm.

This series needs one additional commit that is not yet in
any tree, but I hope to have it landed via x86 -tip shortly:
https://lore.kernel.org/lkml/20200228002244.15240-3-keescook@chromium.org/

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/

Kees Cook (2):
  arm/build: Warn on orphan section placement
  arm/boot: Warn on orphan section placement

 arch/arm/Makefile                             |  4 ++++
 arch/arm/boot/compressed/Makefile             |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S        | 17 ++++++--------
 .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
 arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
 arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
 6 files changed, 34 insertions(+), 21 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)

-- 
2.25.1

