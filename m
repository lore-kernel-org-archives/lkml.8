Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92625C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C4920722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596473806;
	bh=94qYdrFANLnLuExN2tjY4RLWek2wZXuC8x5zY+gLy14=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LfEvF8POLut3V+cj/gCjfn0bE0IrxMH/iU5VG4u4VHXJii7Hoh3BMy9qfRklngM9L
	 fQ5rSHPlZcduVDRreHRh3yBZAtEwf1hxyR6HZfZR6pzAGeMfdLOPkbiVab3mRvYmdM
	 w655OkLWssKrf9o+IIa8JOFlWmqyKdJNSyedhn8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHCQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:56:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57021C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:56:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f24so18880980ejx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6+fGKxE1m4XGSQA7Q8dw0Rlx4v9PLCSSYkkcczofnDU=;
        b=WxXSHX+DT1q5c9ND7SjzfJK2JtUBybCFk01JsiaJufIVLiCOvqA/rPAg3SJfZYPXpE
         ZP+CYwOR38VvE9o40fAhDv9H2cpLvYJSiSmruojxfAZaF4uAG7id7QAzCXQ7vSykQz9W
         8b9x/d1E1dtbmNjpuC+6krr9cjvN0nbzgBcIMB2LjhqeXWxjG4s/WY/yCTpj9G+G3ffB
         z5n2zgDKJppINxpcruWTWNTfYqF7hsM+kSwWtpb63lM95xTVwSuXeArV6zeoSsfW/BYq
         aRfGVWYJDSNdOYT+T4U94OkrrhxMc0NDUwmorRyteRWqnKUGcS1hw4BCAo6n6W2cOnp/
         WhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=6+fGKxE1m4XGSQA7Q8dw0Rlx4v9PLCSSYkkcczofnDU=;
        b=nxDHeudGRkABGEv9EH7FsvBg+mnExlL4kaS4XOcTpSbKA72AR3xYPYGNOldu3rW8Zo
         OTG4fDX/Mxj40xuGGpMxEH80oMx809rf6TRUATU5TjXwlxhbxkjF9VGwh+HfMB3gT1Iw
         7llw8FyuS0wGxGG//uFPkxAe3LOyBn5p1tLQh0k5p7h77AUFAOHcRoXWHqtu1c23bBEy
         7/rqFpJKDPaw/EUXqUNrHfMfOwfITOzmOuV+zEzlkf+0lzgjZQC72cenq3YX8Rw4Nh61
         VBBTxunM4yskTejJuuQ8K8XuGRj2ayn1Ih1qXcn4DsLFCM5oDhPwkRwqWQHguHH5G+Ho
         Kfqg==
X-Gm-Message-State: AOAM531NCTAv3EKtNG1RZr0LwajrXVvGMRpRPAwcWIZJsDz7fDpgbkw+
        jgQs9J/feEIMZz0neCThsdMnG3VE
X-Google-Smtp-Source: ABdhPJy7ELdtgTWOo5jL5K2SDxj+kq+m7Y+AKg/lcg8uRq4aPoLcw5RNinjvz8d4Ycx+8uk0kVtnmQ==
X-Received: by 2002:a17:906:924d:: with SMTP id c13mr16902675ejx.518.1596473803662;
        Mon, 03 Aug 2020 09:56:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d23sm16242068ejj.74.2020.08.03.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:56:43 -0700 (PDT)
Date:   Mon, 3 Aug 2020 18:56:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v5.9
Message-ID: <20200803165641.GA823733@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2020-08-03

   # HEAD: 1ac1efa5f6950f8f126f2c1921bb699ce009ec7d Documentation: dontdiff: Add zstd compressed files

The main change in this cycle was to add support for ZSTD-compressed
kernel and initrd images.

ZSTD has a very fast decompressor, yet it compresses better than gzip.

  out-of-topic modifications in x86-boot-2020-08-03:
  ----------------------------------------------------
  .gitignore                         # 6f3decabaff0: .gitignore: Add ZSTD-compres
  Makefile                           # 48f7ddf785af: init: Add support for zstd c
  include/linux/decompress/unzstd.h  # 4963bb2b8988: lib: Add zstd support to dec
  init/Kconfig                       # 48f7ddf785af: init: Add support for zstd c
  lib/Kconfig                        # 4963bb2b8988: lib: Add zstd support to dec
  lib/Makefile                       # 4963bb2b8988: lib: Add zstd support to dec
  lib/decompress.c                   # 4963bb2b8988: lib: Add zstd support to dec
  lib/decompress_unzstd.c            # 4963bb2b8988: lib: Add zstd support to dec
  lib/zstd/fse_decompress.c          # 6d25a633ea68: lib: Prepare zstd for preboo
  lib/zstd/zstd_internal.h           # 6d25a633ea68: lib: Prepare zstd for preboo
  scripts/Makefile.lib               # 48f7ddf785af: init: Add support for zstd c
  usr/Kconfig                        # a30d8a39f057: usr: Add support for zstd co
  usr/Makefile                       # a30d8a39f057: usr: Add support for zstd co

 Thanks,

	Ingo

------------------>
Adam Borowski (1):
      .gitignore: Add ZSTD-compressed files

Nick Terrell (7):
      lib: Prepare zstd for preboot environment, improve performance
      lib: Add zstd support to decompress
      init: Add support for zstd compressed kernel
      usr: Add support for zstd compressed initramfs
      x86: Bump ZO_z_extra_bytes margin for zstd
      x86: Add support for ZSTD compressed kernel
      Documentation: dontdiff: Add zstd compressed files


 .gitignore                        |   1 +
 Documentation/dontdiff            |   1 +
 Documentation/x86/boot.rst        |   6 +-
 Makefile                          |   3 +-
 arch/x86/Kconfig                  |   1 +
 arch/x86/boot/compressed/Makefile |   6 +-
 arch/x86/boot/compressed/kaslr.c  |   7 -
 arch/x86/boot/compressed/misc.c   |   4 +
 arch/x86/boot/header.S            |   8 +-
 arch/x86/include/asm/boot.h       |  11 +-
 include/linux/decompress/unzstd.h |  11 ++
 init/Kconfig                      |  15 +-
 lib/Kconfig                       |   4 +
 lib/Makefile                      |   1 +
 lib/decompress.c                  |   5 +
 lib/decompress_unzstd.c           | 345 ++++++++++++++++++++++++++++++++++++++
 lib/zstd/fse_decompress.c         |   9 +-
 lib/zstd/zstd_internal.h          |  14 +-
 scripts/Makefile.lib              |  22 +++
 usr/Kconfig                       |  20 +++
 usr/Makefile                      |   1 +
 21 files changed, 469 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/decompress/unzstd.h
 create mode 100644 lib/decompress_unzstd.c
