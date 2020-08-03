Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA3A207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvVYUsR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCS5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91132C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:57:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 189so3029223pfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mBNoGK1P6y+zeGkNK3NKzb71H+HfL1lu2cYKmoiU/Hw=;
        b=mvVYUsR8i/Ebh70vHwDyfqZV7UFmRkzpUZAkY0AFsBk3S7YK3svFa9J2vr1+NKc3rH
         YMLTaHqm7ZMs8BD69NyiZXvm1MrAJqCrBPwZRI4Vg7s1ir3lvXyis1FqRgxbH2Fe+asJ
         gFd0CG/MOtIXYpmTZ1gGcWVxzVtCXezKcVxHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mBNoGK1P6y+zeGkNK3NKzb71H+HfL1lu2cYKmoiU/Hw=;
        b=aEgg5BX4RCFEbp/F4wl+buyN7fV0/YeciRBoUj3jfR110NErFZCYI046cJtJUa19Pc
         Mp9IcINMscwPJ6KER1CeuJHUa4ySG3FcTYhjJ2Gppf5WPsZVr0a1YZfeZJFwqOggHUt6
         sH0wjblGWfAezQWV1fhiZZsltihWTgMwIsqoZhxS1ODb5l27U8V7Y+t+BAif0ggqfHzf
         /oWS3lReMYBNm1Hu1yu9I9GLgGIi20pqG13C676L3kTpZ3UPxEyTB117CZJBA832obag
         LDFWnH+ZEdELhZMcMKY1jGx5FBj3cYrSe9c19ZZH0m0rnLXFUmY+r9H1UIfzmZCB7V2s
         qjTw==
X-Gm-Message-State: AOAM532VE3UfhX0g3lShnmAWxYXFo7ia4NeRsXE7bAcZIdzleXOt4Tci
        EwBod//0S8dF9kltQYVg2QLi9w==
X-Google-Smtp-Source: ABdhPJw71yX58Q/DPXq6W1gFKOHfuX6FIXcCVOabg1qaT9hCKlcFy9xIu9bV1LEoRRTkECfeogNcIg==
X-Received: by 2002:aa7:9155:: with SMTP id 21mr16065004pfi.306.1596481030156;
        Mon, 03 Aug 2020 11:57:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm19769574pgr.70.2020.08.03.11.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:09 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:57:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] var-init update for v5.9-rc1
Message-ID: <202008031155.E07E37D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this var-init update for v5.9-rc1. (This is the tree formerly
known as "mem-init", which you correctly pointed out was not a good
name.) This adds the "zero" init option from Clang, which is being used
widely in production builds of Android and Chrome OS (though it keeps the
"pattern" init, which is better for debug builds).

Thanks!

-Kees

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/var-init-v5.9-rc1

for you to fetch changes up to f0fe00d4972a8cd4b98cc2c29758615e4d51cdfe:

  security: allow using Clang's zero initialization for stack variables (2020-06-16 02:06:23 -0700)

----------------------------------------------------------------
Automatic variable initialization updates for v5.9-rc1

- Introduce CONFIG_INIT_STACK_ALL_ZERO (Alexander Potapenko)

----------------------------------------------------------------
glider@google.com (1):
      security: allow using Clang's zero initialization for stack variables

 Makefile                   | 13 +++++++++++--
 init/main.c                | 12 +++++++-----
 security/Kconfig.hardening | 29 +++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 11 deletions(-)

-- 
Kees Cook
