Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4460C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F8020823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnUmvbVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbgFXIdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFXIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C081C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so1099632pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3fO9Mu+HuWEWm+fvcMx22Y5exUaMbO9Z/LIyBW6OgqY=;
        b=HnUmvbVRCsgkvVykV2zyqGjs1Z1LBqIhrCu4OcR/Bijk7f1Oz5AvumKsTxNUb2JkWp
         pGntsl0IIa/v5KdzuCrstomRYRAtJBkW+qYubLlC7qO5EKYuNR5L7HKGFvyDpaK2bt0C
         XI9LpZJ+1tAsKEUQdDcBfstwe8D9wBUhsKKeWW6SsxcoNCh0GStCa1k3goNAsTp4boR1
         VIZmK+vE6UUqziLYmu3DCF7AawwjR9PSnxlPnn4EGwO0MfKH1LyjJPLreeo8No7IizsJ
         dd/vSUr3oPTgQOjjtHHa4mm8rMCYqYGHaLfTBgBV/5xpxfUSbaIlnuSeBaBrCsICMFiI
         BtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fO9Mu+HuWEWm+fvcMx22Y5exUaMbO9Z/LIyBW6OgqY=;
        b=r5TY3o6GVhRmdOAB/skSORT0+KO4IHZOzdHV6j2JpHS0mHzsCoxIdy8ZpafuFG4W3e
         KXgKRHI/CKNKMAl8PU5CBkZYHaxnHQj5sqhCLqPaJgKhSQDFE7VDlD4TsOYXuDCRphjm
         JJ5klopxOKpA9qy7Ti2C4tJ1Mq2LGcNxyp7jdi3z8z20VVc12xVRU0mgvu8AczS6lE7f
         GVXkEcDoFZzJqlVZZaMs9ZKIZrkUErtwSG4ey7KrEXjVy3lNeNrizV69eymoMn2YhHNW
         ytdVkqHt+v3eAeoJutjZJF/qMt8MbwfgjW5EhgRVUdX7Q/rqtquP9VYSayrO7bsuypCP
         Ml/w==
X-Gm-Message-State: AOAM530OUl7Qu3T4q/asbe0L2a3/iailjrkYtx23NXu2kyxwQrpZzv6V
        RbAVIIDZb2DYFEiv7ImxLz4=
X-Google-Smtp-Source: ABdhPJx/c9g5gjqL+l6D+vxa9t+FUQFuiTBv0BGCgsREQX6XZXPfHJfjokjLMvL8f+xhERlq42GXzw==
X-Received: by 2002:aa7:8b4b:: with SMTP id i11mr1127212pfd.123.1592987603594;
        Wed, 24 Jun 2020 01:33:23 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:22 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v5 0/6] arm64: add the time namespace support
Date:   Wed, 24 Jun 2020 01:33:15 -0700
Message-Id: <20200624083321.144975-1-avagin@gmail.com>
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
v4: - fix an issue reported by the lkp robot.
    - vvar has the same size with/without CONFIG_TIME_NAMESPACE, but the
      timens page isn't allocated on !CONFIG_TIME_NAMESPACE. This
      simplifies criu/vdso migration between different kernel configs.
v5: - Code cleanups suggested by Mark Rutland.
    - In vdso_join_timens, mmap_write_lock is downgraded to
      mmap_read_lock. The VMA list isn't changed there, zap_page_range
      doesn't require mmap_write_lock.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <dima@arista.com>

v5 on github (if someone prefers `git pull` to `git am`):
https://github.com/avagin/linux-task-diag/tree/arm64/timens-v5

Andrei Vagin (6):
  arm64/vdso: use the fault callback to map vvar pages
  arm64/vdso: Zap vvar pages when switching to a time namespace
  arm64/vdso: Add time namespace page
  arm64/vdso: Handle faults on timens page
  arm64/vdso: Restrict splitting VVAR VMA
  arm64: enable time namespace support

--
2.24.1

