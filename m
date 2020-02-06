Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C46CC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEBE214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEvZG1SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgBFSm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:42:56 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:43778 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:42:56 -0500
Received: by mail-lj1-f175.google.com with SMTP id a13so7175937ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHsO+0/8LajrVbD9VL04DBObBDuJ7d62JzOKBievMgg=;
        b=IEvZG1SA2fzmUXie/3PzLLZq3nfIYNpk+n3oHzzUbT+/OVLOwdZZo+zM1WmZqoIK4e
         BLYDN15OeDcCch6f0oqjMjMzrFYMBAd/kPiOADNXt6yccLMhFB8gqiOygsOUlv6Ansiq
         IUmLC3NVTwN/TEPQXaPoLmwFrg29qk/aoTB0OYmt1Mh70M3weTLCP9cISmaRPfORI7rv
         sJeAeNAsKbGLw9p9lNhsINU9NvwKW69n1gY4nAl8DBot1QcZTgFteFH5OOs9wOe1pl/K
         ntCTx5Yu5suEygSSxQ04EVuBLxRZp3Gy8+lgDcQemktnSgg2oXMY2Yq18cBRo4qfB1Fz
         0K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHsO+0/8LajrVbD9VL04DBObBDuJ7d62JzOKBievMgg=;
        b=blxR4UAFUSO231Cem//gpe5mo1eddlKGDvvG08eN5++fJniyDVxOvzihu2Gvgw2ogN
         8EoSNlpAEtafYGA/l3wZahllrhp+nxMCGfGK8NcKcTmJbxq53DgaQB0a6XiidXUK/YCo
         zIb7796VY8QZnR3P+wWm7GLpVAaPMHQ9k+xXgSx0fccGpsOA8XtO3oQ8VoOirSWlZdaO
         xLNfpzDZzRYSKyaRc79odZ8G9mYWIOJxflB8e53B3WxmszhZw6H/PywDeZNV+82FudHn
         hi1sAPrJRGTL9pN9WwaNvc7GwfqkyMxzMgCCX0vbw05cnQko+wteS/wEA52/SqFiUJm7
         BDKA==
X-Gm-Message-State: APjAAAXJwl6V9f8LUf9E/wV6LYs2YnEs3HVtVm9I0cDYYKBYU+5QjyYp
        KSvM2m8OJ57XiH+ndNvRlE9FKTJG
X-Google-Smtp-Source: APXvYqyfXKlD6zQAcndBiWJ43KIQXbLxoNLTeZfhm0MVx/tFPRWKX/XIELp906n4LjqfOyejCB6kUQ==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr2842218ljh.42.1581014573922;
        Thu, 06 Feb 2020 10:42:53 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id h9sm81307ljg.3.2020.02.06.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 10:42:53 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/11] xtensa updates for v5.6
Date:   Thu,  6 Feb 2020 10:42:24 -0800
Message-Id: <20200206184224.25833-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of updates for the Xtensa architecture.

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200206

for you to fetch changes up to c74c0fd2282e0e3ce891cb571f325b9412cbaa3f:

  xtensa: ISS: improve simcall assembly (2020-02-04 21:57:05 -0800)

----------------------------------------------------------------
Xtensa updates for v5.6:

- reorganize exception vectors placement;
- small cleanups (drop unused functions/headers/defconfig entries,
  spelling fixes).

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      xtensa: configs: Cleanup old Kconfig IO scheduler options

Max Filippov (9):
      xtensa: drop set_except_vector declaration
      xtensa: clean up platform headers
      xtensa: drop empty platform_* functions from platforms
      xtensa: drop unused function fast_coprocessor_double
      xtensa: clean up optional XCHAL_* definitions
      xtensa: move fast exception handlers close to vectors
      xtensa: separate SMP and XIP support
      xtensa: reorganize vectors placement
      xtensa: ISS: improve simcall assembly

Randy Dunlap (1):
      arch/xtensa: fix Kconfig typos for HAVE_SMP

 arch/xtensa/Kconfig                                |  44 +++++++--
 arch/xtensa/configs/audio_kc705_defconfig          |   2 -
 arch/xtensa/configs/cadence_csp_defconfig          |   2 -
 arch/xtensa/configs/generic_kc705_defconfig        |   2 -
 arch/xtensa/configs/iss_defconfig                  |   2 -
 arch/xtensa/configs/nommu_kc705_defconfig          |   2 -
 arch/xtensa/configs/smp_lx200_defconfig            |   3 -
 arch/xtensa/configs/virt_defconfig                 |   1 -
 arch/xtensa/include/asm/asmmacro.h                 |   2 +
 arch/xtensa/include/asm/core.h                     |   8 ++
 arch/xtensa/include/asm/platform.h                 |   2 -
 arch/xtensa/include/asm/processor.h                |   4 -
 arch/xtensa/include/asm/vectors.h                  |   6 +-
 arch/xtensa/include/uapi/asm/setup.h               |   2 -
 arch/xtensa/kernel/coprocessor.S                   |  12 +--
 arch/xtensa/kernel/entry.S                         |  18 ++--
 arch/xtensa/kernel/platform.c                      |   5 +-
 arch/xtensa/kernel/setup.c                         |   8 +-
 arch/xtensa/kernel/vectors.S                       |   3 +-
 arch/xtensa/kernel/vmlinux.lds.S                   | 102 ++++++++++++---------
 .../platforms/iss/include/platform/simcall.h       |   8 +-
 arch/xtensa/platforms/iss/setup.c                  |  25 +----
 arch/xtensa/platforms/xtfpga/setup.c               |  17 +---
 23 files changed, 141 insertions(+), 139 deletions(-)

Thanks.
-- Max
