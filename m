Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F5C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D8C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEVWFg31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgBUFKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:10:34 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43843 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:10:33 -0500
Received: by mail-yb1-f194.google.com with SMTP id b141so574426ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qx1TzrvyogNiRSqJXStGPZvREBzcHURDJFmU6BgZWjc=;
        b=KEVWFg314052tWozaaoNWzgxDGtQyUG7wPc9cMULhcvnHXywOY4cueaHFTxGmlsH5T
         D5SmiZKF6kx10F20kCX55hIsMzvVEzbAq421MUKShN8ooaGcmXz59DV7UHVqcqggVWDC
         1oIyxLOooSav+dBD0Esace/XpwNd16TkTXL+BluYL6oxdg6Ub+Uk99kG5CXxmM3Z3QHc
         0eSpNX2cWC2JEh07k7PO5ZRCsMHloL/MRiwAsmZlyQ9H4Uw/wpfincNf13ahzd8sWAgk
         RYDfU9YLhTmshBk4BSrvTq/Y+q2RjdyxivOGoE11athr20lWc1RQMuGSm9PnGMNabBY6
         XB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qx1TzrvyogNiRSqJXStGPZvREBzcHURDJFmU6BgZWjc=;
        b=n9h3SmcxPq5NLzm5mLcaxs3clxDEw7zBSrjVfrab+3EcFy8A3de1drm5PCBtfQIYb1
         yWFypVrH4TmBzF51whS8mw2lzQAH6nWoiehLYRPK1Fos4TcpNBDHXIAeD89jBfbvoDp/
         A796I0PXiQrbvAuTCw1UocpIlvZJ4V9hz7eS+qKG7X+h8gZ/PAGAnF82lUjvQb0Pp7bX
         8A2HotsIRiHJ7sp2+rpviEzW3hrZrGH6Fs0w9SLinz3VuZXt35bdxxHygyeVjbSq45JI
         VzpQbKnPa5un2KPYtPO1KXrZRkKo7F7ZUwWzSHRbdQYxqyGWsM5RZX64bI0kGNNFtOrC
         wuRw==
X-Gm-Message-State: APjAAAW43cmHZ7Qk+nuSU77+Dt85HtuTfJE8Dofxogx3jFTR3VZrGO/1
        iq3f+QRIYZW2vmSlZtCKUz7k9qY=
X-Google-Smtp-Source: APXvYqx0fIgfhpDqFFTxznqGCiuskeOmsCNweaY0t6etMlfGpvFta+bHSs7nGE/mCTiDE1333/gsgQ==
X-Received: by 2002:a25:74d3:: with SMTP id p202mr29238862ybc.493.1582261832671;
        Thu, 20 Feb 2020 21:10:32 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id a12sm840904ywa.95.2020.02.20.21.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 21:10:32 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/5] Enable pt_regs based syscalls for x86-32 native
Date:   Fri, 21 Feb 2020 00:09:29 -0500
Message-Id: <20200221050934.719152-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the x86 syscall wrapper code and converts
the 32-bit native kernel over to pt_regs based syscalls.

Brian Gerst (5):
  x86: Refactor syscall_wrapper.h
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
 arch/x86/include/asm/syscall_wrapper.h | 372 +++++------
 arch/x86/include/asm/syscalls.h        |  29 -
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/signal.c               |   2 +-
 arch/x86/{ia32 => kernel}/sys_ia32.c   | 130 ++--
 arch/x86/um/sys_call_table_32.c        |  10 +
 16 files changed, 722 insertions(+), 735 deletions(-)
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (83%)

-- 
2.24.1

