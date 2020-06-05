Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F146C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AE6206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWAHvL8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgFENWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFENWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:22:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E2C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:22:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so8419190wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyRjljUpDkkPT0X2xA5gUgYnRQ59vhQhn5X65KNC7rQ=;
        b=tWAHvL8W04kR4YL2QU/YKUyrSEk9ARg1cFFClA1ukhQB1s6XrqnCnldv3bY66c6cmT
         fa/LlGyHGZ8bH1ZalJoWS83dLtPEj8gr73UYnWhRarT38YUMwymJeXKXsaXKrBJIYtDL
         2uixWuTe3XwlcDlztHuPlREun36iBUB284UEqkKAHiIKf/jylPAMA2W/VlC3d4lFk5bN
         NAcnJgstabA6TYJ5cvzp2Ix63m1A6/HRPXohHzICl39NxJah2FUqP6lGcTRoY4xfZ7UF
         kgzbf9f01FqsMV7mZCGkbYbjriWUm3LsJ6xspuLj0RNSagObE700+fa2wtc2gnfDMmDD
         lCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyRjljUpDkkPT0X2xA5gUgYnRQ59vhQhn5X65KNC7rQ=;
        b=QL4nq7XLdLX4Lbg0t/SioHUiu9Jl47fdcpip73gl5ebtT8wcwhdvs4mGAvSzyvYuqu
         /aKPI0bnrLYK6udVO1kTaTMBlAuFYmfQ2T4A87UjAwxl4VG04P3RnL4z+j4fFPpaRFVq
         JmCaTplWfH4lNRIKkfsU5ZWQo4FwehZy5dJ495F0qy3OliCt9nc+UteeOY+uRCJ5ClKz
         E2T8fhB3mqkaYsqoCepUMRvaZDFBpGc1oIkQFTWEyxITWvMqzeD+tndxmqWNfyU7Q06j
         iwOdXJsaI+lblYFpOHPq6/Hj6i/7xASpYm7cjmkIicYnRbF52UuHEfz9mxk9LqhgQ7pE
         +TPA==
X-Gm-Message-State: AOAM532Sw+DiOGdQ/oN4uLgKXDzClgzr3tEtRZzYKy9Dxcji75BqvP4E
        /IgQ4VcxtZSaZyeVJpj8lbN6mw==
X-Google-Smtp-Source: ABdhPJyD2N+8/KLPeltMYhSgqYV0q1j45k/hgbvLUvQmsugDxdxYuMfU7CHginJ5acv3Vmlk6qFVzw==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr2905652wme.117.1591363341962;
        Fri, 05 Jun 2020 06:22:21 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 1sm11419211wmz.13.2020.06.05.06.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:22:21 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting breakpoints
Date:   Fri,  5 Jun 2020 14:21:26 +0100
Message-Id: <20200605132130.1411255-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kgdb has traditionally adopted a no safety rails approach to breakpoint
placement. If the debugger is commanded to place a breakpoint at an
address then it will do so even if that breakpoint results in kgdb
becoming inoperable.

A stop-the-world debugger with memory peek/poke does intrinsically
provide its operator with the means to hose their system in all manner
of exciting ways (not least because stopping-the-world is already a DoS
attack ;-) ) but the current no safety rail approach is not easy to
defend, especially given kprobes provides us with plenty of machinery to
mark parts of the kernel where breakpointing is discouraged.

This patchset introduces some safety rails by using the existing
kprobes infrastructure. It does not cover all locations where
breakpoints can cause trouble but it will definitely block off several
avenues, including the architecture specific parts that are handled by
arch_within_kprobe_blacklist().

This patch is an RFC because:

1. My workstation is still chugging through the compile testing.

2. Patch 4 needs more runtime testing.

3. The code to extract the kprobe blacklist code (patch 4 again) needs
   more review especially for its impact on arch specific code.

To be clear I do plan to do the detailed review of the kprobe blacklist
stuff but would like to check the direction of travel first since the
change is already surprisingly big and maybe there's a better way to
organise things.


Daniel.


Daniel Thompson (4):
  kgdb: Honour the kprobe blacklist when setting breakpoints
  kgdb: Use the kprobe blacklist to limit single stepping
  kgdb: Add NOKPROBE labels on the trap handler functions
  kprobes: Allow the kprobes blacklist to be compiled independently

 arch/Kconfig                            |   6 +-
 arch/arm/probes/kprobes/Makefile        |   1 +
 arch/arm/probes/kprobes/blacklist.c     |  37 ++++
 arch/arm/probes/kprobes/core.c          |  10 -
 arch/powerpc/kernel/Makefile            |   1 +
 arch/powerpc/kernel/kprobes-blacklist.c |  34 ++++
 arch/powerpc/kernel/kprobes.c           |   8 -
 include/asm-generic/kprobes.h           |   2 +-
 include/asm-generic/vmlinux.lds.h       |   2 +-
 include/linux/kgdb.h                    |   1 +
 include/linux/kprobes.h                 |  29 ++-
 kernel/Makefile                         |   1 +
 kernel/debug/debug_core.c               |  31 +++
 kernel/debug/gdbstub.c                  |  10 +-
 kernel/debug/kdb/kdb_bp.c               |  17 +-
 kernel/debug/kdb/kdb_main.c             |  10 +-
 kernel/kprobes.c                        | 204 +------------------
 kernel/kprobes_blacklist.c              | 260 ++++++++++++++++++++++++
 lib/Kconfig.kgdb                        |   1 +
 19 files changed, 427 insertions(+), 238 deletions(-)
 create mode 100644 arch/arm/probes/kprobes/blacklist.c
 create mode 100644 arch/powerpc/kernel/kprobes-blacklist.c
 create mode 100644 kernel/kprobes_blacklist.c

--
2.25.4

