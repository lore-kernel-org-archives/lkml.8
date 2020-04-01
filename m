Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31BC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9554420719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Butm8Lf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgDAW51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:57:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42299 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgDAW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:57:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id t9so1703010qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id;
        bh=Fr5c/ragAVqoPhAj8NFEVaSf2mmmhXDNtaNDfYaZpB0=;
        b=Butm8Lf3trAaVGldpxElE3TjUtcIcC8OA+RqJ2IN7fclHc8L1yvE5E2rQAGG2g+cdW
         GCCButdF5qJQo+zF3Pdri0rxgZwxl4rnm9fR7vTbnVHzn9droTbQUBjeE7OrbcyHAcpo
         LTSe737+Bt6Zrnnx6INttdgaQwHl08f7OQCkXUdtfPnV3iogiJrx64xpgVtWa6vUCxO2
         rBARTk/9OtsyBzM7YP3J5xl93kp4BU3jyoow9xYgGkoglnIFgJqSLYazW7GAQcGTPJxF
         BSHKuxtICWzXSEorHQ9KFmB/EtYpbqJmCJDqHLEUX7AHbXkraUQbZdcB8XFi1/FARcK4
         YZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Fr5c/ragAVqoPhAj8NFEVaSf2mmmhXDNtaNDfYaZpB0=;
        b=oD1Cx8nBgrawJ/C5rxrb8TvTe5xn9vZUz+5BFnrDKhHFhqGpiVt1rPcdGU/G/Y5+MZ
         ZbziXjoWGOt1Z+SKkZmkuUGXGFWYSvoOipDYE/T9CZ2MgcXgqBpFhaYvGaZxVvp3Xzo+
         1bn1elf5ptKHBaEgKjw7AjNI8v/5i1P7Cbp9i9cGzmdI17BUdbvyceSocCF58lAysEjd
         CgJMhKFvosHxD+TCsCBA0wpvIZrYa0Y4UoD7PqpEIA/aMY/E4RzcRQSOrKGgVCHa1XmG
         q/Zn+KkCe06GjcwD3OM8BQhms6zCp9BgtfZQ/3hNu8RIfOw2LTvqMe+OuGOkg3hOlKZM
         Z1yg==
X-Gm-Message-State: AGi0PuaXwI/qLFBO7d7NxCmTh9ljnpW6Tl09a2p9ppNgy8D3/P46sa9G
        lbbA7ccUEo/pq8Ez7DHEmMPdoPdFCU7ziA==
X-Google-Smtp-Source: APiQypIZpJLkXrKkwi2EvjaU6hhBoJqV7Dd9fUZa8bBfcurX1ZSGpN7QEnATFiFPcio+FRJa8KDPdA==
X-Received: by 2002:ac8:7ca6:: with SMTP id z6mr146163qtv.52.1585781845800;
        Wed, 01 Apr 2020 15:57:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q5sm2402635qkq.17.2020.04.01.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 15:57:24 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v2 0/2] initialize deferred pages with interrupts enabled
Date:   Wed,  1 Apr 2020 18:57:21 -0400
Message-Id: <20200401225723.14164-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep interrupts enabled during deferred page initialization in order to
make code more modular and allow jiffies to update.

Original approach, and discussion can be found here:
https://lore.kernel.org/linux-mm/20200311123848.118638-1-shile.zhang@linux.alibaba.com

Changelog

v2:
- Addressed comments Daniel Jordan. Replaced touch_nmi_watchdog() to cond_resched().
  Added reviewed-by's and acked-by's.

v1:
https://lore.kernel.org/linux-mm/20200401193238.22544-1-pasha.tatashin@soleen.com

Daniel Jordan (1):
  mm: call touch_nmi_watchdog() on max order boundaries in deferred init

Pavel Tatashin (1):
  mm: initialize deferred pages with interrupts enabled

 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 27 +++++++++++----------------
 2 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.17.1

