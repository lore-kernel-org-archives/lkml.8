Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C39C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6B2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmM8TNdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgFVU6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgFVU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:58:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E488C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:58:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so319559pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sr/y4QHqS3xWZ21Wk9dmfyjZQ6LCrqk5iTqq4P6aiwo=;
        b=WmM8TNdWG84hPEFWUDsKw34SbwMoHJGCkVUzXg3ZdgN8UD/bP+6rBTWVdCr5Wsp15J
         6AlfmTpIQhIMClVDzD8TwSa8yS2rDMux5VFEp8jrbqJuUaaJ39FhfqqQTFV/X17VWWAr
         K2XYiZnqvq6p6KDoguyzLJH2rGdaXwGqh+hHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sr/y4QHqS3xWZ21Wk9dmfyjZQ6LCrqk5iTqq4P6aiwo=;
        b=XWOsMfFI4ID+rk20clTR+wbLlflszEO1cG1v67mS9LZw96Yl//41AvKMP7V9CxyvlA
         P7JCiPoiGCBYJAwsH1mucz/JtNGW8b3po6x8nwPcm2tBWJygRjYAa3ooMDaARvh0qYr6
         FVuFTEoxxNdLENonh2RQsf0tgUtcidXmkvHQv82gA5VbSrDQGydghkCPwvTBPGK/hR5I
         JkUApipmj5QEIuzEh/j/QNRWhOhDsX99xHLXzmMxkjSnGDwU3eKNVJVFnCD8KlPFKzhK
         2yG/bmY1LiByrc9T2cOZjI9pxJE9cHrgefrHZWXmHcdAIQNIqWqWsn7EL4Kx7e5vrsdG
         zFbg==
X-Gm-Message-State: AOAM532uJLogbZ/fHR002ltJX0VvHyaP6g/73GkJwVBoyBsKeTWLtikt
        mPaN16l7CsjnTp2EDezD0wKtTg==
X-Google-Smtp-Source: ABdhPJx/lBXKAYI7OT5DdVExc1fQfkJQ4YxcA7LRSDhA9xjX0BHqXWPN7q+irCe1VtLaI9esWOsLKA==
X-Received: by 2002:a05:6a00:1342:: with SMTP id k2mr21694841pfu.32.1592859499131;
        Mon, 22 Jun 2020 13:58:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u25sm14560176pfm.115.2020.06.22.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:58:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:58:13 -0700
Message-Id: <20200622205815.2988115-1-keescook@chromium.org>
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
actually already does this, so this series extends coverage to arm64.

This series needs one additional commit that is not yet in
any tree, but I hope to have it landed via x86 -tip shortly:
https://lore.kernel.org/lkml/20200622205341.2987797-2-keescook@chromium.org

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/

Kees Cook (2):
  arm64/build: Use common DISCARDS in linker script
  arm64/build: Warn on orphan section placement

 arch/arm64/Makefile             |  4 ++++
 arch/arm64/kernel/vmlinux.lds.S | 10 ++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.25.1

