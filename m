Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D102078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYXp6v0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgHNQIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:08:14 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2FC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:08:13 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id g1so2013309oop.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEjpt3avegoeq/yo9z0eRNeUEGWkiks+1S3/2ReTlws=;
        b=NYXp6v0Fwci4MavLvQK2y2NigX3OOXxqnKI1YbnEkR5I8VT5f0S5geYYwxcn0RbY+A
         tg5wkD+OpeYryl0ujUMIMcnY0Yj1oFZ+p3H1tIHguYBPkCMaB6F1vsZj9ni8dAtLgecE
         B2DiJE/UBMtYvZaihmVQn5t1Q24xYESVWrpJA4YDT6a4Uh7V6DryARjbhgHb6bZaf+VT
         2HYIR1Me/c+35hjpI34W2u7FNwKNUMMfbW1p5Uc6ikPLQ6jq5hIgSeOFDGTdL4RbKcj1
         jIevllobZnDj4h9tPmhNEh2jsJAvPQrmOR2FAAOku1bDRW4SU1Z6GXpGTwM30GtrU0Ch
         2+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEjpt3avegoeq/yo9z0eRNeUEGWkiks+1S3/2ReTlws=;
        b=UjDHCwkFrNifzb28X3XYqcyNwXknwgqRLEiBYgN3BrdKO8+hgJduZKS6IaVtZQd+O0
         9tIIcxMnLqDVi8LVmN13D2f/KYBorR8Zw//S8VKXxR3L3ZmqVLcVGroDU4YqiPQttLk3
         YGWAoU9KPvNTgU1L5NSCuAYzoxhQecVmtfjwKDTKNNq29PUvIExSD5wCFR1mkB/1MOKg
         lqOv6N8d2U9mll6ZuxIEBrVewtqTNPYQFFlxWUYDYzkvRhFGrDL9O8Uq1j1TKSFwpVVW
         xagc8tgd1PUa2ZXewZAu6TF5xTh9de7HQ0um9NJ1DCPoMpSR37UbKiCqg36jD+EZSrGo
         wyLg==
X-Gm-Message-State: AOAM531JH0ZHI0GM9nGPpBDU5AkXFlwJZdG+Ygm8+Zpvr/V07b/ovgLW
        pPvxMPWHu9Y7pSHkD78dvqE=
X-Google-Smtp-Source: ABdhPJxoB4TwzhYzaUMgeWidRKdu4CRd3UanDd7rtxrfdhip1u5YcqxWqtOTyoC2DGZxVOijgkn2Fg==
X-Received: by 2002:a4a:9441:: with SMTP id j1mr2237091ooi.46.1597421292451;
        Fri, 14 Aug 2020 09:08:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id 143sm1900648oie.11.2020.08.14.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:08:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] for-5.9rc1 dyndbg fixes
Date:   Fri, 14 Aug 2020 10:07:58 -0600
Message-Id: <20200814160800.3298765-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 items for v5.9-rc1
  fix sparse complaint about exported ddebug_exec_queries
  fixed width format %3u

Jim Cromie (2):
  dyndbg: add decl for exported ddebug_exec_queries()
  dyndbg: give %3u width in pr-format, cosmetic only

 include/linux/dynamic_debug.h | 3 +++
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.26.2

