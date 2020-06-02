Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D428C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233C32072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBKF7aNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBSDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:03:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F462C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:03:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so4433977pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LqqP+fCBEpc/gpW2bM0qsawU9eAMfAXXBH14Fdira24=;
        b=bBKF7aNg2fySoOb6ttSQ11xvrTHokXCKtjJz1mu0mC8FjEsrdftUBVb/s/0Q67Rz2w
         ltPmZirT8vBG7x0Q0SQCuxe+bQNrvLkr/BDYfqT9KJxLYQ/HShqcQ4ONqMy92BpJ6bQC
         xqDgXsiNDcdA4earA6K1w9Iy40XIL1BHGE4UW/lquDnW8G7AJFYEAMUAd/C+1Go1qNKB
         83pODOROVBPnjacUFgp2rEXwUNV+TREpLlyLR+Syjj9LKzxeom6X4dYny+NSMHKJXS06
         Px/N6SQhYYmeQ2QpNNr3mQvhl3UgL4x52Nqq7CxsTXtO75lj+tjQQ1aKsRcG89wia2bC
         +wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LqqP+fCBEpc/gpW2bM0qsawU9eAMfAXXBH14Fdira24=;
        b=hS4b2OTWMoxkRdpdPG0RGYA27IF9VPyuqsc+UtIJwZxU/BKQ/WzqQKBRXziuY7tucg
         hxBJqATlhU7C+L14poqEJZL0gShM6LjBPVPRh5NRBLp0GWMmXYWXfdMClwL+tNysUvuZ
         hzSkB3tfG8WloUd1Fq+imj88TrWLRLnpxZ7/7Q5OwHNa4eBFbmS2yf1pPC5Nh5T1jK6U
         KoTb4gAno+sfVUwROiylWXFIX1a6LU6gT8WdVwWfrZMHR7igRic5E9Swp+U0TJQk5vIf
         qjTt3bZB8r4tB97SXxeLE+V5fKyEJ0uguqeHiLmzao+tfoh5PpNSd0sAsTrmqfLQ9CEy
         4XaQ==
X-Gm-Message-State: AOAM5331dlmRDGv0XAVg+b4O4P+obhbHO7PhUCxJfGC1c1MXZVggzNAj
        UmmBUhFis4QmRZnUeOmFdjc=
X-Google-Smtp-Source: ABdhPJwo4mTczar9tEK3KvUezbiNQ8f58zT0h9JcwBT8hfRdPJbuvqIe8wPBBbll4RvPUioempxIaA==
X-Received: by 2002:a63:34cd:: with SMTP id b196mr23583126pga.2.1591120984192;
        Tue, 02 Jun 2020 11:03:04 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id p8sm2740053pgs.29.2020.06.02.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:03 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH RESEND v3 0/6] arm64: add the time namespace support
Date:   Tue,  2 Jun 2020 11:02:53 -0700
Message-Id: <20200602180259.76361-1-avagin@gmail.com>
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
v3: add a comment in __arch_get_timens_vdso_data.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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

