Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F45C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FFF206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="jUWlX02L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgEOLQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:12 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:16:12 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o5so2218893iow.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fG9RJAdiQR3KRVbi1EfJRtogMSIdgoMp1F7l88z9wa0=;
        b=jUWlX02LSQ11rfJ6ZVLTgF5Vcv9IS6E6Er1PynDV1jN57S0PWqVwaItvlozJwFC7wq
         I2o04DU+ury1VNLTs5zv+Ojcq9fbllDEIydDEIFkKjMIll8OOfhn6joxrSIL+BDPCQNM
         Tunz7m5SspKk55ADs3bHcuDmxn7r8iTgNBionwhxuI3qrF6lWkOvO52UKwcJ6pmxDm/E
         JufS8YmlONgtbkXVWAgOEjLwvE71LJhxj6GpRzlROlLnB4+oCHHNZQficBhwSWRMJ5Kb
         OH7Fymgk27yDeRVLkLBuHkJjEi7pO265hEen8YlNPfnA/mLpjkDAFsv0Tr+BM4s/B1AR
         h0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fG9RJAdiQR3KRVbi1EfJRtogMSIdgoMp1F7l88z9wa0=;
        b=KUyRk24C/4JpPmtUy60V5aGYxJXI3AewCOoft+QZkdplCXrMWWlo9aEPBhnF7CTida
         rzB0oVL4LYFkOGc0snI1xY4gVur/NXGp8/j0JqDLuEtb1xFMrvNHc+EVpELVmN70eOzL
         9zlPRYwVkcwzSGdniTzKby8HIBMQ5k8wNin8aR2aYIJFkF0PGHtY4Ur7PgazYDywUv42
         2JWJA5dlNyzB5AXNe1WVnhe4ZDJsGuVNcvjKg1q1uaQ24iAWuhBTNS4uOw+3FcRKRtke
         NuDCWxvfVzVypSgfiAzDVuyfwkXlp4da8Od/errVjL+DT5tEHc6U70ETuUd+QX9uIs/I
         TiSA==
X-Gm-Message-State: AOAM531eQwN0I0t8aPERJsA45uGEHXHiwd4fwbAZzFLRfyg1/5zvNdEI
        AiqqoBcowxQbw12SAWdhz9EWAR8bsS6ZDTIpM6RbeAUXfkE=
X-Google-Smtp-Source: ABdhPJzR/BBg4yP9FlNiURi9PB43aqjraWAe8Mz6QOFhgtAH6GTFC0g6gOxZ0lmTiMqJgATJ2Mv6yW+UA4qIm8QKf5Q=
X-Received: by 2002:a6b:6b04:: with SMTP id g4mr2398603ioc.75.1589541371180;
 Fri, 15 May 2020 04:16:11 -0700 (PDT)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Fri, 15 May 2020 07:15:35 -0400
Message-ID: <CABV8kRyHrDMK4o=UZZZWJMuQNjPA8Xuoj-JFF-Lsx26fBTR0WA@mail.gmail.com>
Subject: PTRACE_SYSEMU behavior difference on arm64
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior of PTRACE_SYSEMU on arm64
appears to differ substantially from that of x86 and powerpc
(the other two architectures on which this feature is implemented).
In particular, after PTRACE_SYSEMU the syscall will always
be skipped on x86 and powerpc, but executed on arm64 unless
the syscall-entry stop was again continued using PTRACE_SYSEMU.
The skipping behavior is also documented in the manpage,
so I suspect this may just be a bug (the skipping behavior
makes sense to me and is what I would expect).
The reason this happens is that `syscall_trace_enter`
re-checks TIF_SYSCALL_EMU after the ptrace stop, but at that
point it may have already been superseded by a new ptrace
request. x86 and power save the original value of the flag,
rather than acting on the new value. I can submit a patch to
fix this, but wanted to check first whether this was intentional.
If it is, I can fix the man page instead.

Keno
