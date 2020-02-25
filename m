Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B98C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625A221744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM6uBKhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgBYHhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33038 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBYHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so5146736plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lIxGPgoTK3aJQJLA5pnDmNIdVeln7jtxgkVrg2vFgh0=;
        b=gM6uBKhO2Vo923sJ6TwGOJPnjLGhvZUvAjqh3qVP66woh1w+O6Ncxx/F77fmblUIw7
         a5b/5lvwlu9456yQBBktiRLpoGTG8bj6zqskfQExhACrDS+8g8Inb3i77BEl0V5GF7sq
         5KjjmSvO3R+PMpC4LW7X0SLApXxORAUP47mcZE/fGqeeEtCc9Axwjq7C1GqqARZgS4lK
         M0vMgtwh47Ss6drVJlwzfgoaqRjShywDKE9erLxGilTHOd83zTPv6Iq/6sPf4th/6t0k
         ILoWvCLZV3U+Ff6snNv6a3gVUcY2oQoRJG6hGJ2B7gbTTuE8blwy7JVa6Jxa/r4Vgson
         GXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lIxGPgoTK3aJQJLA5pnDmNIdVeln7jtxgkVrg2vFgh0=;
        b=qKO60M6neQ5cBHsQzynE84/wOqoFUzXhBBj83zHTOQKjyknGu6GyT1pztcFME3vi1B
         DC9n4ai/FV8exDpZa6O3xcoKZQNffFpZRajMkFZw5xnPsfatswktRrUc32NPqcMoii+5
         7Z3LKJ0foarvfQV2AbtyybSY4famOiuiwwI7IemV9ky+hcKtsfkn0Vbj1JzKgm6TWHMg
         j+KQA/XBSzYVu6tU0th1V5tqqY46ORwkS/ch8qdHpSDWKiXUGVnY7j7JDKktz1JxCydy
         sKo3BtFpeLSSFETDbnox7I8e9OIIjrdNeOFFVP0OQ3NvljDpruonX4bhE48gVDdN5KVj
         Dxlg==
X-Gm-Message-State: APjAAAXUzaKrVhOPnGpNtqcJRmd4R2PB/oeo0WQqdTDHp5WsSMKtUnHh
        WJDWO2jeH5/9B6WPpD2Yc9A=
X-Google-Smtp-Source: APXvYqy8qXgI+AZB+dK+FooUA6k5KupvgH/ZlMIeqENAlrF6NuJDjGZsjZxrGnTGWGT6YH7MIKt1zQ==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr51052157plb.4.1582616259822;
        Mon, 24 Feb 2020 23:37:39 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:39 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 0/6] arm64: add the time namespace support
Date:   Mon, 24 Feb 2020 23:37:25 -0800
Message-Id: <20200225073731.465270-1-avagin@gmail.com>
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

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <dima@arista.com>

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

