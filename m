Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98041C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6932C204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZflZ2Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgHOVwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgHOVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B561C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so4913655plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMnjca4p9ZkAZ+txa6OpLNgt++FirBA6I98AAuoh0Ks=;
        b=XZflZ2GuxBXDgM9Nam2w3gPI8GSBIUCY/gIJLaAhRRJ+IgFQmuLm6Ibtioj2rYGz8n
         k6QdbtTZnxweC+s11Wejk9Br8ULNThSXe5C44PxUj4Oq9psEl+seUSCqobgh2195d551
         Z+qc1or7FW8AaG8cyeH/XLefGirM+iLvL84Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMnjca4p9ZkAZ+txa6OpLNgt++FirBA6I98AAuoh0Ks=;
        b=rlMJla2r3t3UNL0YVZrIKTLXuUG/+L3DBSt2fm4BT7lQhdwDEGop+vV63rep8Jh/cE
         5RDBgcDNvHwb0ttfZDgleVhpvHqIzBznyJRcpAM1EVsOTMO0bhFxRMgskVx/OBXwamvb
         7Rf/vi7sQPNsD9l5/IzTSdzgD1o6mDiZyU4zVeexHtB7Z7tkJps6TYRAXwub9g+XEAhW
         TeP/GhtyTKpi4FHsCWe70E1S5mgq7NUl3KV7F4ZLLqr7gVObU0yWgCrvNJjPqBYxxUj0
         3uN2JXK5vvQQNEPtwdqbGMbXedJ1eBMQTrCd3zemH5CN2lZ5wL6Hqd4Be+H8icmDei8E
         XkQg==
X-Gm-Message-State: AOAM530ep6c2P3UDwMEHHu9xIbV0CQbJp5OPtliq7ZwefdE7M5PwUjqY
        g5f00B6tLoSvieNcXSZFIRKSgg==
X-Google-Smtp-Source: ABdhPJyFQhCGmecOOzOt5IIhpdXkE3DRVjiIhqp7xOOGebadOYCesaLZxvWQcw5urdi1cSrpAUs1Bw==
X-Received: by 2002:a17:90b:10f:: with SMTP id p15mr4330338pjz.171.1597452028586;
        Fri, 14 Aug 2020 17:40:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x6sm10577131pfd.53.2020.08.14.17.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 17:40:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Make debug_obj_descr const
Date:   Fri, 14 Aug 2020 17:40:25 -0700
Message-Id: <20200815004027.2046113-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches make debug_obj_descr into a const pointer. The second
patch can be split up into many patches if desired and sent to
respective susbsytem maintainers.

Stephen Boyd (2):
  debugobjects: Allow debug_obj_descr to be const
  treewide: Make all debug_obj_descr's const

 drivers/gpu/drm/i915/i915_active.c   |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c |  2 +-
 include/linux/debugobjects.h         | 32 ++++++++++++++--------------
 kernel/rcu/rcu.h                     |  2 +-
 kernel/rcu/update.c                  |  2 +-
 kernel/time/hrtimer.c                |  4 ++--
 kernel/time/timer.c                  |  4 ++--
 kernel/workqueue.c                   |  4 ++--
 lib/debugobjects.c                   | 30 +++++++++++++-------------
 lib/percpu_counter.c                 |  4 ++--
 10 files changed, 43 insertions(+), 43 deletions(-)


base-commit: c9c9735c46f589b9877b7fc00c89ef1b61a31e18
-- 
Sent by a computer, using git, on the internet

