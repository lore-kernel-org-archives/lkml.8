Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD89CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD4A207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PYaGIC/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHCSvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCSvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:51:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF07C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:51:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so2530920pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BsEgPEuWxPot+NjZbzUbvZI7wPQ90QV+Bo897F+Xb+M=;
        b=PYaGIC/zqukBk7/VfhOApHlzjpl6h9bs3Qt/qOPYNji5Kv2hMe8FiKZZsmV+bcG7kj
         /+je8CwsSrBtmp1ie4YYuLpzv+XcEeAwVNaHItc123d5TE/Oq9P+4zhr4ii8luM4hpeF
         K5ZatAxHUxM08034mZcjG4h1JqtKPx8Yhiw34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BsEgPEuWxPot+NjZbzUbvZI7wPQ90QV+Bo897F+Xb+M=;
        b=V3QL2DtpURzqoJkHH+fpEtZAwtG0RTTl5UceARIHxJRpz23uJiDq7R7lnIv+K4b6uF
         kUntabxNpvP0OCsGDkgB/636fZIvDjC4bH5u5lzcnBeMqA9Z55NDCfTvpqCQ5Dg9JpSW
         AYsAAQmwUMY0t/ZWXXhbSVTPtaAeJeZx41gAUZhgddutvjBdukT7UzSs+i8vnTg0LYam
         PNEjW2G2TlwNSlXaoDhdbkiiwojFrTT0ubtj2ICtBDWzS44KzuqdwsWLHwYeuluGeOYM
         CcgZR7K9hGLM0t+KCZkqDesxcGOMfqgDS9IsidR64hjRvDBbBC9folL9mMU/qfwuQpkJ
         sNkA==
X-Gm-Message-State: AOAM530VTaLSd66i8ABPEtdsfkVlrNIl/bNHZGnR46ja5f3Vl9HDLxvL
        LPkHCMbMTKfjlzn13xgEb2JHgbuHcsY=
X-Google-Smtp-Source: ABdhPJxu9iFRKMyP6AGWzhzaM3NL4IC7Xf4qjyWphyvaL0Mi651oIJQ4hUfQ2R4rdjuWIyUJXWCHTQ==
X-Received: by 2002:a65:6703:: with SMTP id u3mr15651743pgf.254.1596480691795;
        Mon, 03 Aug 2020 11:51:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r191sm21241800pfr.181.2020.08.03.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:51:30 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:51:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [GIT PULL] gcc-plugins updates for v5.9-rc1
Message-ID: <202008031150.63BAD93@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugins updates for v5.9-rc1. It is primarily
improvements to STACKLEAK from Alexander Popov, along with some additional
cleanups.

Thanks!

-Kees

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.9-rc1

for you to fetch changes up to 496b24ec6d47f2d304a0c5836ba4b1bb5d30bab8:

  gcc-plugins: Replace HTTP links with HTTPS ones (2020-07-13 09:29:09 -0700)

----------------------------------------------------------------
GCC plugins updates for v5.9-rc1

- Update URLs for HTTPS scheme where available (Alexander A. Klimov)
- Improve STACKLEAK code generation on x86 (Alexander Popov)

----------------------------------------------------------------
Alexander A. Klimov (1):
      gcc-plugins: Replace HTTP links with HTTPS ones

Alexander Popov (4):
      gcc-plugins/stackleak: Don't instrument itself
      ARM: vdso: Don't use gcc plugins for building vgettimeofday.c
      gcc-plugins/stackleak: Use asm instrumentation to avoid useless register saving
      gcc-plugins/stackleak: Add 'verbose' plugin parameter

 arch/arm/vdso/Makefile                      |   2 +-
 include/linux/compiler_attributes.h         |  13 ++
 kernel/Makefile                             |   1 +
 kernel/stackleak.c                          |  16 +-
 scripts/Makefile.gcc-plugins                |   2 +
 scripts/gcc-plugins/cyc_complexity_plugin.c |   2 +-
 scripts/gcc-plugins/sancov_plugin.c         |   2 +-
 scripts/gcc-plugins/stackleak_plugin.c      | 248 ++++++++++++++++++++++++----
 scripts/gcc-plugins/structleak_plugin.c     |   2 +-
 9 files changed, 241 insertions(+), 47 deletions(-)

-- 
Kees Cook
