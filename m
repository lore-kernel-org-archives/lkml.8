Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F0FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF0A2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFcoOTAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgFPMg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:36:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16785C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:36:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l26so16601987qtr.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2PngY9rpSrc/JWo0nu1D3c8c8eSsxwN0TWotJmkVNDg=;
        b=rFcoOTAe6hi4+lQ6ohn94dlqr18PB5MM4QzM3aHx9fRnxf/v16KcmbB5JsBymdf1vn
         glOpV1tqm7Ma6F1lMFPQl8mPxvNWGD9xGXfxaHOTFK6bB3tsXTMCv7OWam0ahZzaCwNB
         GnfAw+a8ZMutGNK7aOT5RkNcbj+TyW2D3NO2rvZTvw4dL7YVc7kqypXKF6EVtRtsWfGP
         ax9IuZAvRrIqGSoDeIxD6erg78V9vBhe7pVbznDHhcpYwl7p5syFgKHs7sjUSW6YP+Hw
         NEUTX5slDOz7Ffmujv7TZ81+d8+U7sfx2jlHtdVkn9AiRnzut9jO/nEgDznzruSnhi9+
         sLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2PngY9rpSrc/JWo0nu1D3c8c8eSsxwN0TWotJmkVNDg=;
        b=ijpg/j6qfZg7AkXQkda6Bmma8QPLKd71xpuMOeKOhCCbOV42ddRZ5phVzj4IR+Y+mR
         s3IZoPD8ZDrD+53GucT5QJg+3TcH0l7NErf0+QZV51YQqLAbxLEU5SiQJbfskksN0SRi
         rBi23xN5i5vZFq9Mc3qY9ZamVhNOgdAWiIzRyPxM095yrhRn2B4skHxqb5K7ACg25Tjb
         fPbSX4m138pXZivDKbt/Zsm7JIKC+fF+dPBpccCNXjyP6cmtFk8FM494hCLzTI2yWMzh
         pEmfGZszOle0O8Lgq3TkIf20TPJg+x2+ePPLs2LBOiuKLqe4IP5gbXExs7TQQJTFueKs
         /YpQ==
X-Gm-Message-State: AOAM532P0tqef9phvrcy73e5pqTzONJXl6Z2tf5PZILxwJYvg9740qsT
        D8O8G0Z6DxeuQnG16j/w5bMSzLShoQ==
X-Google-Smtp-Source: ABdhPJxHGYT2QEruRpC9/ArOrE7DHRStsb11OHzvJjDuCK4BkPODlbmJ9+teI5JNH6lbMRunxtbuOEVt5A==
X-Received: by 2002:a05:6214:11a1:: with SMTP id u1mr2008197qvv.91.1592311013195;
 Tue, 16 Jun 2020 05:36:53 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:36:21 +0200
Message-Id: <20200616123625.188905-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 0/4] kcsan: Minor cleanups
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor KCSAN cleanups, none of which should affect functionality.

Marco Elver (4):
  kcsan: Silence -Wmissing-prototypes warning with W=1
  kcsan: Rename test.c to selftest.c
  kcsan: Remove existing special atomic rules
  kcsan: Add jiffies test to test suite

 kernel/kcsan/Makefile               |  2 +-
 kernel/kcsan/atomic.h               |  6 ++----
 kernel/kcsan/core.c                 |  9 +++++++++
 kernel/kcsan/kcsan-test.c           | 23 +++++++++++++++++++++++
 kernel/kcsan/{test.c => selftest.c} |  0
 5 files changed, 35 insertions(+), 5 deletions(-)
 rename kernel/kcsan/{test.c => selftest.c} (100%)

-- 
2.27.0.290.gba653c62da-goog

