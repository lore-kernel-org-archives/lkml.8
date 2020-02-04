Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE896C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900B42084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTvxoRFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBDR7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:59:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBDR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:59:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so10042458pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jbEbwOgo7ENCwWxsnPJP8SPkXj10iYhhwUubuuIQGpU=;
        b=aTvxoRFiBebcpxpfT28nCZjCnxMHAde5s0Gwzhhz7aM9dn6pzTFRQofnf3ecqFSI8D
         eMlAaT0BNAFswRWePkJS0Q1CK41c2C6gPpAp2fJMco2yBO9zlcz9VJnXupigVxYkJnFv
         bSGHFpr8YK2Dio6gyxW0JmAChekk6Mq/wheYOsCnxZvA/MC5z5P+sHyUaDGSkFDKTNPU
         7bb1L0P/hUpNNCFLSH0Kez79DlcMyuEVZMTA7wyUVQLmxJ7Puw2TNXIFA1jUk7kYzVJt
         TrsgC8DZriaeOksvbbRG0FwjN9x3kWnCGqjs/6JZiS+Avc8Q/Fq3gnNDF21vgzontS90
         s9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jbEbwOgo7ENCwWxsnPJP8SPkXj10iYhhwUubuuIQGpU=;
        b=WJ9HVXgrK2AWkyU6uAhS/30hrnejpV2hhhuzvBG9oBnbStQchEPmaWnu0TzRu32Oy7
         1MVI1AuzsZ2f9lsd2fkHHBusIzP14xBUrPwJL6sbxmBN/eZt1SzbhtYvJ/apjyDeZUYg
         +Tjt1DKUeFMhk3fFjdUMMhlBT6nObDHyFvOPPU78pwTiuveqINwyid0KEOirWRxkAaWw
         FbZwr/xUMhKrtivFYM3Wf00QsBUAnm77qAG4xjD1TP9le1zylfbUEc3GFlXTCwRI3yOY
         rJn+DK4TC3jwMM2ol9QUDx4XwaBwMVzDnMETtG52t9JaeInm7Ot5yAlbvJmHc21XDVHI
         r7cg==
X-Gm-Message-State: APjAAAWWvBgw+IGx51u2HrYCSICUxVjIHtz4F3S/kr5U36a8aKn2hOiH
        5fT/8EimCXmyxO2W/4L4rgU=
X-Google-Smtp-Source: APXvYqxcrSIfmbjS9s7ArRFpumpHY7MXaw0phOSNLdABf42PWMJi52QVUpc2eRXUbUhDgU/SFtdxGQ==
X-Received: by 2002:a63:7454:: with SMTP id e20mr32353159pgn.192.1580839162631;
        Tue, 04 Feb 2020 09:59:22 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id d73sm25414465pfd.109.2020.02.04.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 09:59:20 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 0/5] arm64: add the time namespace support
Date:   Tue,  4 Feb 2020 09:59:08 -0800
Message-Id: <20200204175913.74901-1-avagin@gmail.com>
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

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <dima@arista.com>

Andrei Vagin (5):
  arm64/vdso: use the fault callback to map vvar pages
  arm64/vdso: Zap vvar pages when switching to a time namespace
  arm64/vdso: Add time napespace page
  arm64/vdso: Handle faults on timens page
  arm64/vdso: Restrict splitting VVAR VMA

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

