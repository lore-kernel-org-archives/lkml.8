Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A2C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC5920684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CW4CvWsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgASRwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 12:52:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36768 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgASRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 12:52:20 -0500
Received: by mail-io1-f66.google.com with SMTP id d15so31320639iog.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=iYWEA7Nwdx9KjiEDDgBrOJ2jGr9aQ4qoZGBtlzHjvk0=;
        b=CW4CvWsHyBNUDaDJwPytZLKUerbejYxDQBLCcEom9yUWFDSfiCkys2vhZeNP1wdxWQ
         I1uRiaBLUsanTdej8NQgM6+rsJqg0zfdUKev2Ac7nb+Y4VcgOqTQJ064S6geRa0rN5BA
         6mxANYcMW048VtBa7HyNY0iZhqsfhbnT/sEtipG7Qgp9W6OTA6CzmorwJLMNDvn75/4G
         /T7hiy3mP7uYjlhWNAbNooOhGmLrLFYCCRxtxOPvuajWFOeAwrcmbZYqag21tNB+ZbVz
         2ASk22LVOZhA1Xnj9ohUKNo9MgrkOovN/55kzVQzRKpL8t5FDAUlyjLnG3mIfNqQmw31
         G2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=iYWEA7Nwdx9KjiEDDgBrOJ2jGr9aQ4qoZGBtlzHjvk0=;
        b=GZq5EwXdqN9LiI53O79AbWM+t+H5xelLoozv52ES7LR5byG8Y80LZOmVPudOqzi9FH
         vqlMXxCr50XmIgkJJZWay7wneqxCWAHcuxvfY+RBSuTDPCpWcky70Xe8mJUZcx3AE+Fw
         LQIpvUV4EoF1SKcfBYhFIFCrtP4EMXeZfFGNjYnyIP66fjnp2IdwiCQjayPzWe3CTCV4
         CqSb9KBAlrumjh2YiVKtv9WjKltrjSHIrPltW1nvBxC2uau7HZHGtFj9l572x5Fnr2eb
         zXkyPNfXK02MT2+9651lM81SWnOvqryRGIwXvNDQPouzHn/yeOOMNQ5KIslyWsgRrrEi
         b93A==
X-Gm-Message-State: APjAAAUxm6bUylsojyIx0oxblCcjSBwmMdX/xnzZZKp7fe7DywYrpfPD
        N23za8zebSigRXs8oTCqgvuxss5B8fk=
X-Google-Smtp-Source: APXvYqw6GVJqwdnTZ5jJY5cb6qqQoglMjP0jUWj5PPUbWGrWb8CpsVRfHD35o6Qhc9mPreAls420vg==
X-Received: by 2002:a05:6638:38f:: with SMTP id y15mr42234285jap.17.1579456339427;
        Sun, 19 Jan 2020 09:52:19 -0800 (PST)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id a12sm7716352ion.73.2020.01.19.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 09:52:19 -0800 (PST)
Date:   Sun, 19 Jan 2020 09:52:16 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.5-rc7
Message-ID: <alpine.DEB.2.21.9999.2001190951380.106116@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc7

for you to fetch changes up to fc585d4a5cf614727f64d86550b794bcad29d5c3:

  riscv: Less inefficient gcc tishift helpers (and export their symbols) (2020-01-18 19:13:41 -0800)

----------------------------------------------------------------
RISC-V updates for v5.5-rc7

Three fixes for RISC-V:

- Don't free and reuse memory containing the code that CPUs parked at
  boot reside in.

- Fix rv64 build problems for ubsan and some modules by adding logical
  and arithmetic shift helpers for 128-bit values.  These are from
  libgcc and are similar to what's present for ARM64.

- Fix vDSO builds to clean up their own temporary files.

----------------------------------------------------------------
Greentime Hu (1):
      riscv: make sure the cores stay looping in .Lsecondary_park

Ilie Halip (1):
      riscv: delete temporary files

Olof Johansson (1):
      riscv: Less inefficient gcc tishift helpers (and export their symbols)

 arch/riscv/include/asm/asm-prototypes.h |  4 ++
 arch/riscv/kernel/head.S                | 16 ++++---
 arch/riscv/kernel/vdso/Makefile         |  3 +-
 arch/riscv/lib/tishift.S                | 75 +++++++++++++++++++++++++--------
 4 files changed, 73 insertions(+), 25 deletions(-)

Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6896935	2329912	 313920	9540767	 91949f	vmlinux.rv64.orig
6897193	2325848	 313920	9536961	 9185c1	vmlinux.rv64.patched
6657458	1939044	 257576	8854078	 871a3e	vmlinux.rv32.orig
6657464	1939044	 257576	8854084	 871a44	vmlinux.rv32.patched
1171666	 353420	 130024	1655110	 194146	vmlinux.nommu_virt.orig
1171758	 353420	 130024	1655202	 1941a2	vmlinux.nommu_virt.patched
