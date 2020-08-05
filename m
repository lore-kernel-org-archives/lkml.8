Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2024C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A2F23130
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z16S5uzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHEQUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHEQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:18:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC969C001FE3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 09:18:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f9so4540626pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqOtscQ7oL8M2OV7/AS+H9zd7WlGhrndY3fKEhcVkr8=;
        b=Z16S5uzNX2DvMz74/erd60XfGe/qiJuePgZbU2/7UfhnQ/Qoymj6EdculFdgg2vGEX
         3fTmauJt1sMneAs8tuDbHwWDS+31gQTsUEdZXymQKlE1ejSnpzSsvpc4R92U92Krqgle
         MMowi9Pq+WB4jaAMMfguxv9c/+9o9hYNXu/eHcwKpo6AX+fFPX+Me8YYGEeQIyZrkNk3
         KwiQexVYYlrZGJlKULnx4ClxyPM8fRrj33Rp2fmvttuvITxCIUvZFfPRc0NhPEjaXiZF
         rgtrA3e7hjEdgOxdVYJ9v8G6rhl+QzqKUY8Va286aepOq2TtIMXP2+TIOYWIstIVYtdz
         1vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqOtscQ7oL8M2OV7/AS+H9zd7WlGhrndY3fKEhcVkr8=;
        b=X33WcmXVjr4gXuLIXy4JahybRFcGvBrMgpGRjiE0xQjNR6MyXbkU38OFjHqUi+RNQ1
         PbuZFQL4LiRsL4cqOcjnX1kIvbW9JVDQgYYjRSpzk2YhuR6ATtBsp/TVO8d76Bq7xfVR
         iy4xtTH1JMnoVHa5A3SHMh5hmydCOac8SyPzEJMbQXl3lF39sTpiz4rZ+rX2wB2+P4ZZ
         t0/Ai9p4ufegVV6ptseYv3JqiZCfNqeBisy/PzTQshSeD9Zn2d8UpuB1hhSZ+V1Qw+TZ
         pluRnT3lqAEgjQ/gLdmSXSDC7lZK2edLTKL/VZpwzAYN/qzfWNMfgySaUVDR/tvy18IV
         TY/Q==
X-Gm-Message-State: AOAM531XAzgEBHg7NOaq35bqBrbjDPhKlsQQ2ieNUcFmODCpdZcYUmRX
        Uw4yN2h+M07UWeSPbAfnx7rDZNBV
X-Google-Smtp-Source: ABdhPJxnvCWGyOLOGhyjS1AovH1VKezcgn5lf5r4MjNi2ROoheSsEQeaohrlkMnWfJWyLEVc8tmGGw==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr3737409plk.69.1596644300042;
        Wed, 05 Aug 2020 09:18:20 -0700 (PDT)
Received: from octofox.metropolis ([2607:fb90:a68f:7793:eeed:6380:da93:8dbc])
        by smtp.gmail.com with ESMTPSA id q17sm4061261pfh.32.2020.08.05.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 09:18:19 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/10] xtensa updates for v5.9
Date:   Wed,  5 Aug 2020 09:17:13 -0700
Message-Id: <20200805161713.7476-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture updates for v5.9.
There are trivial conflicts in the seccomp selftests with the csky
and sh trees.

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200805

for you to fetch changes up to a0fc1436f1f4f84e93144480bf30e0c958d135b6:

  xtensa: add missing exclusive access state management (2020-07-31 14:15:57 -0700)

----------------------------------------------------------------
Xtensa updates for v5.9:

- add syscall audit support
- add seccomp filter support
- clean up make rules under arch/xtensa/boot
- fix state management for exclusive access opcodes
- fix build with PMU enabled

----------------------------------------------------------------
Masahiro Yamada (1):
      xtensa: add boot subdirectories build artifacts to 'targets'

Max Filippov (8):
      xtensa: add audit support
      xtensa: expose syscall through user_pt_regs
      xtensa: add seccomp support
      selftests/seccomp: add xtensa support
      xtensa: move vmlinux.bin[.gz] to boot subdirectory
      xtensa: add uImage and xipImage to targets
      xtensa: fix xtensa_pmu_setup prototype
      xtensa: add missing exclusive access state management

Randy Dunlap (1):
      xtensa: initialize_mmu.h: fix a duplicated word

 .../features/seccomp/seccomp-filter/arch-support.txt     |  2 +-
 arch/xtensa/Kconfig                                      | 16 ++++++++++++++++
 arch/xtensa/boot/Makefile                                | 12 +++++++-----
 arch/xtensa/boot/boot-elf/Makefile                       |  5 +++--
 arch/xtensa/boot/boot-redboot/Makefile                   |  5 +++--
 arch/xtensa/include/asm/Kbuild                           |  1 +
 arch/xtensa/include/asm/initialize_mmu.h                 |  2 +-
 arch/xtensa/include/asm/thread_info.h                    | 11 ++++++++++-
 arch/xtensa/include/uapi/asm/ptrace.h                    |  3 ++-
 arch/xtensa/kernel/asm-offsets.c                         |  3 +++
 arch/xtensa/kernel/entry.S                               | 11 +++++++++++
 arch/xtensa/kernel/perf_event.c                          |  2 +-
 arch/xtensa/kernel/ptrace.c                              | 14 +++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c            | 16 +++++++++++++++-
 14 files changed, 87 insertions(+), 16 deletions(-)

-- 
Thanks.
-- Max
