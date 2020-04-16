Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67955C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D9D20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QELZQSbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406592AbgDPF04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406053AbgDPF0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C871DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 188so1093599pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=whCb8irywOuOLwB8N8qhV6UwE4acib9+m+so6yyRikQ=;
        b=QELZQSbXoSNyL/seMqWzdkBoeEd+0wFPXQobGjaol+a9xdYz27jWvpgenJ/Qdmuh/m
         /6B7BdeECI7p4ERE4F12hwfMTiJY8wNsI9rN0e+fFZedSRIAZxautnVTbXpeAAlaTFds
         mTgBqLd46BOYrLsQuhkmRedcbuwPV6rASchv1Uc9YVXdiYnFWNG/+tLuJUu4WNKB0osv
         WbLU4sLPwCk7Gs/cKlnu9km7uq+4vOUew5Hl+Q+HuWL7EKBPDSfjNWIJNUehyekMwt+5
         z02QK4tYJxRzG0Yr9nBOsINJYteBRNWLmfzni5xwptZOPAtPYHaOFal1+rJXIRJbA3HJ
         wQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=whCb8irywOuOLwB8N8qhV6UwE4acib9+m+so6yyRikQ=;
        b=X7SGQX9uIRlJyMcoAleW4v5lBcXPSJCf+jQFKJ93HaG0uC8trTQXck5m630C5FBpIS
         JIB3GlDAnqpM5BxD+gNWSPZxHcqjcgHBLU5NLZcWXKf8bnlHA2OfsyUN3Y/mdB9w96EP
         Vm5gMplx2T5mqGMCJCmkY2a8TmM/vL/CFT9/vZkyDLis2GCwc9BJEuqJsfju4eHeDu8K
         +2llvCkAh35Jpfmwc+ptaU7Gi2/KISdPZBGrnx5Dbu4mk0TelWH40zqWc+40+xrJkP4S
         eocUW6oUjGHimLOsX3r9iZBwCqtxBTMwBXncMqi+OBnKJ5efhNUoTPoT/6JasTQiVnxJ
         /Rww==
X-Gm-Message-State: AGi0PuZKzcrssw2aFA/QkIoJupFzx6ujbH2O8Zgz6lVdcGGiyjTt+ScQ
        /oG/wxrdKQEw2Akji4+Zb9Q=
X-Google-Smtp-Source: APiQypI0XWGmSYiUQba6K3Au35KB4iQuijM8E5F7+7+sKdq/m068EfL3ofmqOO5Zw7bPDY13fYAwHA==
X-Received: by 2002:a63:8ec7:: with SMTP id k190mr6073705pge.163.1587014801882;
        Wed, 15 Apr 2020 22:26:41 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:41 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v3 0/6] arm64: add the time namespace support
Date:   Wed, 15 Apr 2020 22:26:12 -0700
Message-Id: <20200416052618.804515-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the time namespace page among VVAR pages and add the logic
to handle faults on VVAR properly.

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page. That page has vdso_data->seq
set to 1 to enforce the slow path and vdso_data->clock_mode set to
VCLOCK_TIMENS to enforce the time namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the VDSO data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

v2: Code cleanups suggested by Vincenzo.
v3: use OPTIMIZER_HIDE_VAR() instead of inline assembly in
    __arch_get_timens_vdso_data.

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <dima@arista.com>

v3 on github (if someone prefers `git pull` to `git am`):
https://github.com/avagin/linux-task-diag/tree/arm64/timens-v3

Andrei Vagin (6):
  arm64/vdso: use the fault callback to map vvar pages
  arm64/vdso: Zap vvar pages when switching to a time namespace
  arm64/vdso: Add time napespace page
  arm64/vdso: Handle faults on timens page
  arm64/vdso: Restrict splitting VVAR VMA
  arm64: enable time namespace support

 arch/arm64/Kconfig                            |   1 +
 .../include/asm/vdso/compat_gettimeofday.h    |  11 ++
 arch/arm64/include/asm/vdso/gettimeofday.h    |   8 ++
 arch/arm64/kernel/vdso.c                      | 134 ++++++++++++++++--
 arch/arm64/kernel/vdso/vdso.lds.S             |   3 +-
 arch/arm64/kernel/vdso32/vdso.lds.S           |   3 +-
 include/vdso/datapage.h                       |   1 +
 7 files changed, 147 insertions(+), 14 deletions(-)

-- 
2.24.1

