Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AC3206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6CR7Lc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgFPH42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFPHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:55:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F3C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:55:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so8037196plk.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MGBpT33yn/vsqpImYxBbTXSn9VvA8+sRFWMD9F5bOps=;
        b=K6CR7Lc/iOsVuBI+I9/0ETWVHGHIJRof5CHq1yBWTVs+N/cs+P2jvmARrC3NA5kKKR
         fos/dfLtk/pGCPgVuRr/bcdtxoh8VsQFShcKPvStGCSTUB2P0VRIFscu6kMrEm/tNN8S
         al+d1LlmZ68cMlZHUW98nwk6/BKJ4q8vbRY1CbIRGXQ56FdbR9fjlj7zUMoIaRyDM3r2
         bWTo56r6dA0OeWTWTvJwJBLo/MeKsZ1A3NiqclIN47SKYjcp1HhznarrkNg8el+WKyuG
         +oYewDGhczadCIrvXsMeb4kE+XUYZ1+NLL86Ag4mSpucx9EAUm1/EuKn6V2liQ2vFM66
         BG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MGBpT33yn/vsqpImYxBbTXSn9VvA8+sRFWMD9F5bOps=;
        b=IZtVZh20LaEuj0o+veoLgcFZelu9JeN95NjZ4sXce/KSsAwUtnsYbCMfhH7CsfWqo2
         GmglEZOwHr8MJoQk5rYs9W2h3AvpMP6Ztv4bsT8HjPsaBOpeDzgQUbGra/k3jEsLwGQn
         LBsNkq0C2l5v8fwf68rhk/KZp7eBkmSvZMaRatFsNOnfv4HKAjJMcTjH7I9ZQaoYfm2k
         77h9uh6cZwjF2zTVk6UeFjYWKFJqm13nJrw6B/Pd8+RxUg15Jh1BP7nJi8Ic3BXNaEXe
         3TZcfoip9sYAjW5T4/f5Ajw6FwScWX1NraLmh0CqoNuXGicmVw9ssB5I1j599wQ/sMj3
         Ly8g==
X-Gm-Message-State: AOAM530selj0p/7LAqqDe56jllslbnR3DtGJ1lJsuEu84xrm6XeqmKxn
        e4M493dDh9T5vb8kVoth/tM=
X-Google-Smtp-Source: ABdhPJzKhSnuZ0J+8Wq7Oq6dgAfWqUIKg0hZeM/FrTZ1mRcJrAoTw0ADNZQuBRPRU79aWybHbw4iAA==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15mr991112plr.164.1592294154879;
        Tue, 16 Jun 2020 00:55:54 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id g6sm16168984pfb.164.2020.06.16.00.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:55:54 -0700 (PDT)
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
Subject: [PATCH v4 0/6] arm64: add the time namespace support
Date:   Tue, 16 Jun 2020 00:55:39 -0700
Message-Id: <20200616075545.312684-1-avagin@gmail.com>
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


Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <dima@arista.com>

v4 on github (if someone prefers `git pull` to `git am`):
https://github.com/avagin/linux-task-diag/tree/arm64/timens-v4

Andrei Vagin (6):
  arm64/vdso: use the fault callback to map vvar pages
  arm64/vdso: Zap vvar pages when switching to a time namespace
  arm64/vdso: Add time namespace page
  arm64/vdso: Handle faults on timens page
  arm64/vdso: Restrict splitting VVAR VMA
  arm64: enable time namespace support

--
2.24.1

