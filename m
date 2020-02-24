Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD82FC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F41420732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrHu6pp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBXSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:14 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44862 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:14 -0500
Received: by mail-yb1-f194.google.com with SMTP id g206so4123901ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+SFPaw3C1NfsYD07E9fToSs6hUMFU4silGa9zhvCjA=;
        b=DrHu6pp8Rsg5dQgaE63XTn2Maj1ZH+Jqw/XbaPAZiPOOHF5uCwPhQQvEOeK0gX9BY/
         mOjUvWXmvah2S5EPLqQGTYRqurXPIH66E8trucw0AyWmR4SnoYkDRIfRYCBl/Yn+NyAp
         hMFaVLgOY5lr0lw7hEloAb76dkXN/JAriWXoLYspGiCZbwgh47rEuzz3HiDfM9+HqTb1
         YACZ/FSrpm8DT9LMKODBZIkYd7/QGj+lvSaRucbtR3yxFMuWN9UU1v6/UP9Vbu0A7DsR
         CbGA4eaYdjGiQpU4eqPk1rFdWFv4MubuO2l0vXKF+V6NfwepAEytcwzzjvUmgn5qRtSR
         4hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+SFPaw3C1NfsYD07E9fToSs6hUMFU4silGa9zhvCjA=;
        b=Tq9ZGM52tWvvYGyzN7eC6dC6IaAlmD9okr0LFyu4uj+jx4oB67ipDq+Hy8DwY6jC2M
         +wBi/sUsItvrRgH04GLGgmwsXtY2QF+PNCz3jqzxxjnpZHmZ5OCA4VpuXlP9WoPBcCnF
         pk8CJz0AiYdWRmKTtaYaP3ye7o1lC+Tw6pDSnsxK1SO3v38HUED3FBCqqc2QSFhs/0vU
         Rlcoka6BvxhEr+VIf7uRB6VHoBBFi3nnuQ6W+Q5IqK2dfHZnwltdbWPyTMPaQWiYz88O
         +EIbzYQYe80Dcd4I6lBypwG5jcBzJGpALkSpfL9BM19o4D+OlqG0E68ZDLvHXDVZxLxG
         +3kA==
X-Gm-Message-State: APjAAAWi7nXLWe6pyKhgVtWB3rhp0Isc9Qt7nw0qSuflwo1tEY06KMGL
        HVK9W8Yxin/VK0ypPAX47uTwQvk=
X-Google-Smtp-Source: APXvYqzEyLWHIEFbIC467NfMXpzRw9b//z49nkZV1gJuZDkPFl43J04CiCiNR9nbAZxiGdoai1kLYw==
X-Received: by 2002:a5b:d05:: with SMTP id y5mr2863274ybp.255.1582568293236;
        Mon, 24 Feb 2020 10:18:13 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:12 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 0/8] Enable pt_regs based syscalls for x86-32 native
Date:   Mon, 24 Feb 2020 13:17:49 -0500
Message-Id: <20200224181757.724961-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the x86 syscall wrapper code and converts
the 32-bit native kernel over to pt_regs based syscalls.  This makes
the 32-bit syscall interface consistent with 64-bit, and a bit more
effecient by not blindly pushing all 6 potential arguments onto the
stack.

Changes since v1:
- Split patch 1 into multiple patches
- Updated comments and patch notes to clarify changes

Brian Gerst (8):
  x86, syscalls: Refactor SYSCALL_DEFINEx macros
  x86, syscalls: Refactor SYSCALL_DEFINE0 macros
  x86, syscalls: Refactor COND_SYSCALL macros
  x86, syscalls: Refactor SYS_NI macros
  x86: Move 32-bit compat syscalls to common location
  x86-32: Enable syscall wrappers
  x86-64: Use syscall wrappers for x32_rt_sigreturn
  x86: Drop asmlinkage from syscalls

 arch/x86/Kconfig                       |   2 +-
 arch/x86/entry/common.c                |  20 +-
 arch/x86/entry/syscall_32.c            |  13 +-
 arch/x86/entry/syscall_64.c            |   9 +-
 arch/x86/entry/syscalls/syscall_32.tbl | 818 ++++++++++++-------------
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +-
 arch/x86/entry/syscalls/syscalltbl.sh  |  33 +-
 arch/x86/ia32/Makefile                 |   2 +-
 arch/x86/include/asm/sighandling.h     |   5 -
 arch/x86/include/asm/syscall.h         |   8 +-
 arch/x86/include/asm/syscall_wrapper.h | 317 +++++-----
 arch/x86/include/asm/syscalls.h        |  29 -
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/signal.c               |   2 +-
 arch/x86/{ia32 => kernel}/sys_ia32.c   | 130 ++--
 arch/x86/um/sys_call_table_32.c        |  10 +
 16 files changed, 690 insertions(+), 712 deletions(-)
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (83%)

-- 
2.24.1

