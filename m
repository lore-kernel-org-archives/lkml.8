Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44797C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DCD2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qh11zXig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgG3K4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3K4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:56:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD6C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:56:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id e20so1267144uav.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Pz+XF4LuMpD4SOnO7P3982Wzu2NRanctqI7j+4Bsl5s=;
        b=qh11zXigfHiMLpASvjCp25S6/H8+X3aXYvsrtDgw222WdukwHtmIcbp6MViEMmesRG
         zv4Sc18lHyLkFvt8u0voUU4PeKnynpo6sApmiVCDzIqy5cGquXcAOn6DSiDsyV9m74SA
         dGSpy6RThO3BxgVmNUfC1vorqy8iB5/eYab5fDGZdpftvG4Y259FwBqY+9yqpSJLbzY2
         8pVOklekTuKdH9N5a1fkjpzACOxYSLgAZlAYhZWP+TmUjwkMUCw2AHdnV1fg00aHv4HG
         OFHZ3is81r0rJpybsE2MtiR3p5c64GhS3p+SPvYspeRoV7sWGr8ds0kEN3Dal0pc+10C
         oTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Pz+XF4LuMpD4SOnO7P3982Wzu2NRanctqI7j+4Bsl5s=;
        b=o+F2fS5OcEMVeg6wDowWG6tV9KSL8jZX/WF7JH4V85P73xKv2BYoCls4+Drp0+IOj+
         uu5hDxrnkV+AmZt9LBrXncSwV8r1Ejg0IwxN/W+3eZGMC8UpIzojPCsIZGHAZ5Pnl/z1
         MRLvayDrSejdtMihio3PTM17eQvNKPGHHC5lRzi++CwRhbBf0Evu+qbWh3mNXm1fk8M9
         LQROoxL/3DJplWEcAYdbc6kG7ytBdqwAyxKd2Tj9Kbi7S3xL9BUTI+dKX6SUA/lXiKMY
         wSRerqRewENAL+WRv7GbRd1yrv6E/rSgox8xnKRQl89+jPWyKIbtufxDyKUKcJ2he/OI
         ggkg==
X-Gm-Message-State: AOAM530XNpyONKQ2DnaY0jePWZUNwnU8CNhlHkKh/ZwvXa5noZwtKMlL
        WlYNx5509nfhVZcIc6Nb0kmkwS8ekdFNHVT784/nyw==
X-Google-Smtp-Source: ABdhPJyeLsc1i+441toO3uBkjnCjITzWEjCldgRhmqdu/EZlq5DRSBSxqrme7lD/zrFdJNtMnzzTA+yLPiAWHb4M0Ts=
X-Received: by 2002:ab0:53d8:: with SMTP id l24mr1631482uaa.14.1596106561431;
 Thu, 30 Jul 2020 03:56:01 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 30 Jul 2020 16:25:49 +0530
Message-ID: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
Subject: =?UTF-8?B?YXJtNjQ6IHBvaW50ZXJfYXV0aC5oOjQwOjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdA==?=
        =?UTF-8?B?aW9uIG9mIGZ1bmN0aW9uIOKAmGdldF9yYW5kb21fYnl0ZXPigJk7IGRpZCB5b3UgbWVhbiDigJhnZXRf?=
        =?UTF-8?B?cmFuZG9tX29uY2XigJk/?=
To:     linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>, re.emese@gmail.com,
        Kees Cook <keescook@chromium.org>, w@1wt.eu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        "Theodore Ts'o" <tytso@mit.edu>, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus master branch failed to build the arm64 architecture due to
below error and warnings.

kernel config:
https://builds.tuxbuild.com/Dp3s1p4uYnGpImQwCvhzEw/kernel.config

git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
target_arch: arm64
toolchain: gcc-9
git_short_log:
83bdc7275e62 (\random32: remove net_rand_state from the latent entropy
gcc plugin\)
git_describe: v5.8-rc7-40-g83bdc7275e62

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image
#
In file included from ../arch/arm64/include/asm/smp.h:33,
                 from ../include/linux/smp.h:82,
                 from ../include/linux/percpu.h:7,
                 from ../include/linux/random.h:14,
                 from ../arch/arm64/kernel/pointer_auth.c:5:
../arch/arm64/include/asm/pointer_auth.h: In function =E2=80=98ptrauth_keys=
_init_user=E2=80=99:
../arch/arm64/include/asm/pointer_auth.h:40:3: error: implicit
declaration of function =E2=80=98get_random_bytes=E2=80=99; did you mean
=E2=80=98get_random_once=E2=80=99? [-Werror=3Dimplicit-function-declaration=
]
   40 |   get_random_bytes(&keys->apia, sizeof(keys->apia));
      |   ^~~~~~~~~~~~~~~~
      |   get_random_once
In file included from ../arch/arm64/kernel/pointer_auth.c:5:
../include/linux/random.h: At top level:
../include/linux/random.h:41:13: warning: conflicting types for
=E2=80=98get_random_bytes=E2=80=99
   41 | extern void get_random_bytes(void *buf, int nbytes);
      |             ^~~~~~~~~~~~~~~~
In file included from ../arch/arm64/include/asm/smp.h:33,
                 from ../include/linux/smp.h:82,
                 from ../include/linux/percpu.h:7,
                 from ../include/linux/random.h:14,
                 from ../arch/arm64/kernel/pointer_auth.c:5:
../arch/arm64/include/asm/pointer_auth.h:40:3: note: previous implicit
declaration of =E2=80=98get_random_bytes=E2=80=99 was here
   40 |   get_random_bytes(&keys->apia, sizeof(keys->apia));
      |   ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

build log link,
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/662908458

--=20
Linaro LKFT
https://lkft.linaro.org
