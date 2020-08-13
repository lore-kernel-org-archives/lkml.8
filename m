Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC86C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBC72087C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="uUIbeQu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHMVEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgHMVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DFC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x69so6557161qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kryP9CMRERhxjHXYUJJ5unILmVrUDLbEfiJn+WYFXUw=;
        b=uUIbeQu5s9OW5iHr+pCPYAXz/CSSz4P9kNQ0rBqq+yAwy0zTaykqtDaSaw5lTVIRJT
         jw/V3xSvPx8WTFmOzd1XZoNWNxIOhVpytQ3wnlosebXn0DG1Lmq8wrmHvcoLXGLyQZwr
         Hcg4ILR7pxp256m8B2LzX1Pe5NQ1F7FChXUmAcHdstTtMzqkA6UKCf35D9T4tMsGxurd
         97SjTi0BayFrzC5fsX9NP1ymdiPJkXLpzy+nHbG4QlCPqf+Lib1ljMJzjDnG6e+E9uXm
         QAW+P59bR2cacpAt72W1G1zakTa+fJcn8gGJDQF5pyBayJX1KBOjyo+JWT8IU0GDYceD
         czKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kryP9CMRERhxjHXYUJJ5unILmVrUDLbEfiJn+WYFXUw=;
        b=HwsONacXA8cU8ftRH/f61bsAPAbTmNM8yMFTq0Tdd6teWyys7x9LR9AyncpoKFMAIb
         9or6nipVsQD0rMNjHMcjUv7qGUVa+FkVkzMO2QxGXeurwO1QsAyOtZuICujHZ+UT90QJ
         tKJJJGiz1W91PCWsLZQJ7o6X45kDFb/J0vsCJxFp22fkO+6YKbclc/H+N3XhBZ87hmN+
         nak01Nt03L3Cl/Lvk/qCrYJiFEyz5lUzvzfIAtmOrR7Sovw/6+6rYzC8K/S1z/yfL20s
         q34BAc0Pu9Ij+4ulXOHdz79loMdSkaUsFhseYDFPht8dqCsMlYfgdW+U5jvb750nQ76O
         du/g==
X-Gm-Message-State: AOAM533W/23OlmK9EAbRuiT3VA6nq8CtxTQ+yXeB3+Koo9X26Dpdr99h
        xBLrS/t5JYK++XxslXbWhZwCZQ==
X-Google-Smtp-Source: ABdhPJxf8apNiTkUJW6vWPW1cGHwMErH8cmAsedPKOsxETEESQQUbXcRE3m9PY/f5Na0uHKxbLX0XQ==
X-Received: by 2002:a37:9945:: with SMTP id b66mr6469671qke.51.1597352656499;
        Thu, 13 Aug 2020 14:04:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a6sm6705666qka.5.2020.08.13.14.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 0/6] Some buffer management fixes for proc
Date:   Thu, 13 Aug 2020 17:04:05 -0400
Message-Id: <20200813210411.905010-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This initialy started with

  [PATCH 1/6] proc: use vmalloc for our kernel buffer

Which came about because we were getting page alloc failures when cat tried to
do a read with a 64kib buffer, triggering an order 4 allocation.  We need to
switch to kvmalloc for this buffer to avoid these high order allocations.  Then
Christoph suggested renaming vmemdup_user to kvmemdup_user, so then we have this

  [PATCH 2/6] tree-wide: rename vmemdup_user to kvmemdup_user

And then finally Viro noticed that if we allocate an extra byte for the NULL
terminator then we can use scnprintf() in a few places, and thus the next set of
patches

  [PATCH 3/6] proc: allocate count + 1 for our read buffer
  [PATCH 4/6] sysctl: make proc_put_long() use scnprintf
  [PATCH 5/6] parport: rework procfs handlers to take advantage of the
  [PATCH 6/6] sunrpc: rework proc handlers to take advantage of the new

There's one case that I didn't convert, _proc_do_string, and that's because it's
one of the few places that takes into account ppos, and so we'll skip forward in
the string we're provided with from the caller.  In this case it makes sense to
just leave it the way it is.  I'm pretty sure I caught all the other people who
directly mess with the buffer, but there's around 800 ->proc_handler's, and my
eyes started to glaze over after a while.

Josef

