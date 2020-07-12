Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C614C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD732067D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 19:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDJtHFl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgGLTzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 15:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgGLTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 15:55:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D1C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 12:55:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o22so5097775pjw.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIetUemoKxubLIYPWxy8SSfRsMLA5iGT0+nNiwpoC8E=;
        b=hDJtHFl+cs7wxiwlm/QzWtMohfBYx6eBi9chJv3S6i1ej30kh6SApEDRMKcoBel7j/
         pEwVHjAFsNMGYaw3qx44QHbKs1MXZCTyC10bdU+IMyMKmDKln4SZ667XpNyKhZsyXANy
         96ne/wRADtz/JeT4w0ej0Q5ZD2YQ3fHnb97m2Kk6O/9xyx/3G9E2HxSMSzvw2eKhQatS
         EEdGKx1dS4W91yvgqXSeN6QaRip+kHwPyh+0j84pSLdT0v/u7tjYzUfc8CqbaKd9wtRK
         09LOk4XAGwquNkzMZFt1SJAVJwU/KKyRYvlr+CGS3nEvKRAyBfEHKXo2K3GzJtsXsD6w
         50bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIetUemoKxubLIYPWxy8SSfRsMLA5iGT0+nNiwpoC8E=;
        b=W7dX6FgIIdCz8oIlScXxFWi3i07/upDmdOU6akJ9ljODm9+A7AIjZe2mSvRXEhtj0U
         2rh1bBGdnXvD//VX46nfgSobBOjSZ9nw4huvwV45MI0gXZr0ikBm1RhPsIYGnNpmnS27
         si/rcLwbSUMghLgJBU2umwWpyAmGlnawYWwkb/MK3YJv4F4qtwokgesmvDj20dygvD4m
         YjQHjjlKWi4qM8yy2eDahSF9B2ddbLPR7UYR45/DMdPPsoRCFY6dLbnOdjidRRpjP55R
         2NoFGJjXZ6tbMx2tIAllSAtYYTJBycZT+taTfNOh4sGTPo0XXitvVJansHpBm/laEG/J
         RsdA==
X-Gm-Message-State: AOAM5323OhCFb17XBd+DKURaaDIz2ksYDAjcJ8qg0WRz84WXGpbWLwbp
        oemTo43Y47DWbG4Rx8XTNqc=
X-Google-Smtp-Source: ABdhPJxt/3avMldT/5sRUPLXyx9n2Xa19Em9/z1ugiHkq8+HTiCY6i+RomfItIhd8PA51kYGUbWiUA==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr69685235plr.132.1594583736545;
        Sun, 12 Jul 2020 12:55:36 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id nl11sm31314271pjb.0.2020.07.12.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 12:55:35 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa fixes for v5.8
Date:   Sun, 12 Jul 2020 12:55:23 -0700
Message-Id: <20200712195523.6411-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture fixes for v5.8:

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200712

for you to fetch changes up to ee769ebbe9e5fc7219e979fb7c5ed5bb5722649e:

  xtensa: simplify xtensa_pmu_irq_handler (2020-07-08 00:18:15 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.8:

- fix __sync_fetch_and_{and,or}_4 declarations to avoid build warning
- update *pos in cpuinfo_op.next to avoid runtime warning
- use for_each_set_bit in xtensa_pmu_irq_handler instead of open-coding
  it

----------------------------------------------------------------
Max Filippov (2):
      xtensa: fix __sync_fetch_and_{and,or}_4 declarations
      xtensa: update *pos in cpuinfo_op.next

Xu Wang (1):
      xtensa: simplify xtensa_pmu_irq_handler

 arch/xtensa/kernel/perf_event.c   | 4 +---
 arch/xtensa/kernel/setup.c        | 3 ++-
 arch/xtensa/kernel/xtensa_ksyms.c | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
Thanks.
-- Max
