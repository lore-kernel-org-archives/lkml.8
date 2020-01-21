Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2EA24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cy2ZL6bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgAUTsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:48:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAUTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:48:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so2030404pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6S1l36NbAZVh9wLCgsbOly2e7bEjrTaiZ7L36rQuzeg=;
        b=cy2ZL6biivpAGorQ6u1DBqUyqW1vq4oF8EcL47Rhrtk7aKkXYB28+a9WqoAI4OzzmN
         kgt+QLtwUQqkUawa39RUC8iSJ+GLUPqpt9pg1tnJu5EkvIxWkHe4ydtYCZR605wRu9Yh
         ShPld/Rf86RKNpFwptmk3WdZm4uCtSQZrd8E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6S1l36NbAZVh9wLCgsbOly2e7bEjrTaiZ7L36rQuzeg=;
        b=N/fNiN0tZdhOFNSgvCZDhQCIi0964ZAczHMTnXTP3OrnAsIZK2VoWMywEGG09CICnA
         wlZYh6WtV/sxJv0fDemKs6oeE9T/bZcP8+3TuCxcCZrZxYvENJpGtuoziRQdmNv/qgHU
         qGa19je2XgUAcGoVHM7Ez8z0gAtRjFKQO+8H7AApPlArGOIKeMVMlOX674vnLDbeILMy
         8Y4wK7WPk4KqyvnzJNkyRzVRhwZWqw9ObBJUVVs7KxfXDGQz+v3oVd6CCys5rb9sx8z9
         7MF4Qa0Vi7LVBcEn27h//AXlBSj0Ef5py7pXm6L3cnvCmKU/snGCk8QrMXa2qsQcoS1P
         35Ow==
X-Gm-Message-State: APjAAAWr/KXYS27wDIIcgjqM/d5WaI9Zk68tv+MO398v10aUYDWyhbyI
        aA/1U7Lpc7WGomUs9e2U7HgIzFaRhdzmXw==
X-Google-Smtp-Source: APXvYqzxf3iITbl6NWb1XnDzqWrM8ve1PChmz4DB6L5e/DnnX3uGZfia9wzwQijKQI1mom6nJsBUcQ==
X-Received: by 2002:aa7:9315:: with SMTP id 21mr6280169pfj.162.1579636092638;
        Tue, 21 Jan 2020 11:48:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u7sm44004674pfh.128.2020.01.21.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 11:48:12 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 0/3] Fix alarmtimer suspend failure
Date:   Tue, 21 Jan 2020 11:48:08 -0800
Message-Id: <20200121194811.145644-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently ran into a suspend problem where the alarmtimer platform
driver's suspend function fails because the RTC that it's trying
to program is already suspended. This patch series fixes that problem
by making the platform device a child of the RTC.

The last two patches are non-critical changes to how we do the wakeup
and some code cleanup.

Changes from v1:
 * Dropped first patch that got picked up
 * Reworked second patch to autogenerate the device id and use IS_ERR()

Stephen Boyd (3):
  alarmtimer: Make alarmtimer platform device child of RTC device
  alarmtimer: Use wakeup source from alarmtimer platform device
  alarmtimer: Always export alarmtimer_get_rtcdev() and update docs

 kernel/time/alarmtimer.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)


base-commit: bc80e6ad8ee12b0ee6c7d05faf1ebd3f2fb8f1e5
-- 
Sent by a computer, using git, on the internet

