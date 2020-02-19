Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1CC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C446B2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBPLYa8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBSAbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:31:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40783 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgBSAbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:31:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so26141477wru.7;
        Tue, 18 Feb 2020 16:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UHaPN0DZu1fxS+M0vlQ6OnOtCLQym/jYIkBeP1Ud8+E=;
        b=FBPLYa8qSF1TjjZnYfw2tJppeOUpIbGdtVRiliBaQqmiNjFxJfyZeJ1KneAeVH1wuz
         71e0KkTvuJrusRMQ5QrXvQksiw6/ATDZERsiLbN/mHyZDv4a2g8gKls7DIFvIsO9hUQf
         4ilBuNvzR8XxGn6evl3VgjvRtWusjJwZsgKboCwEDOR8HOWf25XL8pzgbxmzYW4vkGqP
         R2N1IatXyA1hGzuf5VQMrw1T2Qs73e4jMsCWbY2+Sf7Vgt/aDryxhlBJ+cKNGN/kvy6q
         dDsVLY3dlWS4JqXXpam1QJkmvNuovzaLo6Cso1Ni/MzDyWo1iKsLVMuhxcS33e1UjrMZ
         eYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UHaPN0DZu1fxS+M0vlQ6OnOtCLQym/jYIkBeP1Ud8+E=;
        b=pRSwvV9n9CHrhd4C7d0T5kuQSqDe6GJKWBOh3K8qrdKwRg+Wn59IuoqyAL6QCN0mTn
         UiqoqjhS+hHosgz73KZnRogXW79Fuo097zFcouwVyGlB2aruoO/MnPUJBaoKbEbA5NWz
         Ro0U+7o2QRzo/aEusLgmQgfuIPv3WdusHDGPGOsboOBufz8rZ1YJNwlj+2F7jUChAfri
         ahna6salKjCYiEV97vanPCSS28clNa44j/6Fh0VrhGaKjAwyoIbu7HQL/mAjNfu2N1OL
         Zqz9SgkvnPyU72uUVXS54p8SEbbTzer74WAHoVyE2AEhsNMeZDDPIQO8z2D1/iabjUag
         nzUQ==
X-Gm-Message-State: APjAAAULuttJEJ7rIDq8+3dFnpJdBCRbq2Ee5pxH0zIDl067OSm1Gpv+
        jzh1SXFudFbwi+nPVXAI1+jy4n9ORgm6MP4g7/AFdDtVfDs=
X-Google-Smtp-Source: APXvYqzJ4OM4IWZg/0jbA8gz1iT9obfQTHotphWhtXWd7kYWI9cCCgmPh/uIJq2MCjgG9qtTheImBfFIzN206KXAblo=
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr30780329wrw.31.1582072290537;
 Tue, 18 Feb 2020 16:31:30 -0800 (PST)
MIME-Version: 1.0
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 18 Feb 2020 16:31:17 -0800
Message-ID: <CAKi4VAL0R+rzTirDQmFGVTRYLL6ACYN3oXVegfPgovvN5ibR6A@mail.gmail.com>
Subject: [ANNOUNCE] kmod 27
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmod 27 is out:

        https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-27.tar.xz
        https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-27.tar.sign

- Improvements
        - Link to libcrypto rather than requiring openssl

        - Print a better error message when kernel doesn't support module unload

        - Use PKCS#7 instead of CMS for parsing module signature to be
          compatible with LibreSSL and OpenSSL < 1.1.0

        - Teach modinfo to parse modules.builtin.modinfo. When using
Linux kernel
          >= v5.2-rc1 it's possible to get module information from
this new file. Now
          modinfo is able to show it instead of an error message that
the module is
          built-in:

          Before:
          $ modinfo ext4
          modinfo: ERROR: Module ext4 not found.

          After:
          $ modinfo ext4
          name:           ext4
          filename:       (builtin)
          softdep:        pre: crc32c
          license:        GPL
          description:    Fourth Extended Filesystem
          author:         Remy Card, Stephen Tweedie, Andrew Morton,
Andreas Dilger, Theodore Ts'o and others
          alias:          fs-ext4
          alias:          ext3
          alias:          fs-ext3
          alias:          ext2
          alias:          fs-ext2

- Bug fixes
        - Do not link python bindings with libpython to be compatible with
          python3.8

        - Fix module removal with `modprobe -r` when a dependency is built-in.
          Now it properly ignores them and proceed with removal of other
          dependencies

        - Fix propagation of return code from install/remove commands to the
          the probe function. The return values of
kmod_module_probe_insert_module()
          have very specific meanings, do not confuse the caller by return codes
          from system()

        - Fix softdep config parsing leading to buffer overflow

Shortlog is below:

Lucas De Marchi (5):
      testsuite: update gitignore
      travis: remove old compiler failing to build kernel module
      modprobe: use flags rather than bool args
      libkmod: reset was_space on second pass
      kmod 27

Alexey Gladkov (4):
      libkmod: Add parser for modules.builtin.modinfo
      libkmod: Add function to get list of built-in modules
      Lookup aliases in the modules.builtin.modinfo
      modinfo: Show information about built-in modules

Adrian Bunk (1):
      build: Stop using dolt

Dave Reisner (1):
      Link against libcrypto, not all of openssl

Ezequiel Garcia (1):
      tools: Print a message if refcnt attribute is missing

Fabrice Fontaine (1):
      Makefile.am: filter -Wl,--no-undefined

Stefan Strogin (1):
      libkmod-signature: use PKCS#7 instead of CMS

Thomas Petazzoni (1):
      Do not check for undefined symbols when building the Python modules

Topi Miettinen (1):
      libkmod-module: convert return value from system() to errno

Yauheni Kaliuta (1):
      modprobe: ignore builtin module on recursive removing


Thank you all for the contributions.


Lucas De Marchi
