Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ADBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AD62067B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlECE+b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgEVOzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbgEVOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:55:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:55:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so1844770wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgzE6vmodHXJVgkKRydSUcePpApP1sHs6gyeaxLAapY=;
        b=nlECE+b5yqlKJA6jFTmww2E3QJ5WbURdCUstW1I6PIZDCOg7WHcBF8kQGWXownwX8q
         cx47KBJ7D3Kpgz7C/7gSay4yxudmJQeS0U6UpnN8yikGE80+hrwjyvSeR1qtaT3ZgFKE
         ieRGgX9H7LAdv95xfmKHwW8jV2ZRnxqpjjBf4NZx4nvPLuUu/BJTHWw7eqV6Koa9/qkr
         JB0fkVDznqDDtD+xlGCIU0gIk7VJ0Xuww0a46q46q0i/o3SnK7lYEd4BfRs87OX6KBp/
         Ym+angsnPVjD1w6IrheE1cC8TpDgg2vBCMdQt6/wtp8Cdjk+KOybz62XMS/vl1SaHje7
         ZRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgzE6vmodHXJVgkKRydSUcePpApP1sHs6gyeaxLAapY=;
        b=N7F9pWw8TBRZ/zSjshxOm7HXC5iYM3qIAeZtfeEdyHEP21oHfCQafLk4yINmv71f41
         5BJkCixGld4XwYKIq/bEmHOyspNAYz/qfL9QHPSScVtRJUFf2mouMf80R2LjZ5AiVKHj
         Ug3G3bVgpPGRmGW8SmmiWdjacxU7DzEHmpxAuGAVFgOGOaPQxZoMuzMSO6Hrxy/TXlIF
         4HmOeLAcEXzFK88mN/A+aZLEGjeLvom1bR7CRBtFZLOzcZGWYrU9PiR2dipliy9PXUFP
         HklAXRLY+C8QF+v09Oa46CxgZCSxUUcCgXf1bXE2ChBtXfJju85fjOK27OGav2orCExQ
         ynAQ==
X-Gm-Message-State: AOAM530OQ0Ns6QJHyf9ZNdHN2XyhYFJpx6sO0EGzXpNL/bL2yfdPW+R/
        xSYp2+zf/4frVoGbWNL+5RkURQ==
X-Google-Smtp-Source: ABdhPJx3E/Vjh2T3jdWf3YQgn4TzMfj6PDDxH6vq8U6IEpR89l/Y7afo7n+52RmZLhGuPaW2lu7RlA==
X-Received: by 2002:a1c:6583:: with SMTP id z125mr13863329wmb.102.1590159314476;
        Fri, 22 May 2020 07:55:14 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i21sm9746911wml.5.2020.05.22.07.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:55:13 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [RFC PATCH 0/2] Introduce KGDB_DEBUG_SPINLOCKS
Date:   Fri, 22 May 2020 15:55:08 +0100
Message-Id: <20200522145510.2109799-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The execution context for kgdb/kdb is pretty much unique. We are running
a debug trap handler with all CPUs parked in a holding loop and with
interrupts disabled. At least one CPU is in an unknowable execution
state (could be NMI, IRQ, irqs disabled, etc) and the others are either
servicing an IRQ or NMI depending on architecture.

Breakpoints (including some implicit breakpoints when serious errors
are detected) can happen on more or less any context, including when we
own important spin locks.

As such spin lock waits should never happen whilst we are executing the
kgdb trap handler used except, occasionally, via an explicit command
from a (forewarned?) local operator.

Currently kdb doesn't meet this criteria (although I think kgdb does)
so I started thinking about what tooling we could employ to reinforce
code review and bring problems to the surface.

The result is a patch that extends DEBUG_SPINLOCKS and checks whether
the execution context is safe. The "except via an explicit command"
aspect (mentioned above) convinced me to make the checks conditional
on KGDB_DEBUG_SPINLOCKS.

Daniel Thompson (2):
  debug: Convert dbg_slave_lock to an atomic
  locking/spinlock/debug: Add checks for kgdb trap safety

 include/linux/kgdb.h            | 16 ++++++++++++++++
 kernel/debug/debug_core.c       |  8 ++++----
 kernel/locking/spinlock_debug.c |  4 ++++
 lib/Kconfig.kgdb                | 11 +++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
--
2.25.4

