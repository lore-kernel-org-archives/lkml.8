Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B2C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CCF20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WByMlRz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgBUIFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:05:20 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39331 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbgBUIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:05:17 -0500
Received: by mail-pf1-f202.google.com with SMTP id x189so681448pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 00:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lJCRugs+SKiTF05UsjaUNwsXqM1ZzyFTGD9XzVlyBHc=;
        b=WByMlRz52Nmp1IGPxjamKAUcsKUnasLYvyrNlurVGdfHRXaGk/JveOeWxA5Jhbv3rS
         jDeeWiEJgLKoFNZs9qTtVYJpuHqCIkVCu4BXD6nE+2Ckf2Ypp8i9JeeLBM0ssgMMoaCe
         Oh1Y+0Dcikz3pk8fvr8IrvCIWUTMurS+JvREmmM5GRWGGDwO4but6cidynBySscFZiDV
         06jKu8xxsX5VyqeD6ld/d29/FMQdzbA9xQLUhuIy3wuNIkxP95mDP9RtCj49D/eNmo7q
         ggBiRg3rIxiC56TXGZmmvN3X1PeDCN/2oxsz62/WU8TU80y2lqR18RL5jWRYA08iq1xI
         4NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lJCRugs+SKiTF05UsjaUNwsXqM1ZzyFTGD9XzVlyBHc=;
        b=EV1uu5Aj00wmzbmjEkVGQp7HNocXwj4wU3znrTeaTXKLw+gh03KZov76OTjkntqTKC
         xJtnDt0oSmlI5fWiYTPlDvEvhRXB8bp+eHtkFS2hN4nHRktf5p2S30tOUDAlMts+2fMU
         xSm4FlvJs6sHyK/IzOLOm+UuwHxWhg0gaBeJPxunIHauStVA9pNi7dvA7T14muGocayc
         +1+4ZciFXTefKZgZLwnnNizJZdBN7W0zkRRtW+nLyivNsFAGB7RA8K4FYGb6xx7+mRH+
         9/mw0565pmUOBt7ettYLT+ju/aBipXuIw2Fx6FJi9/HizcQXT4EbU1I4vf9PqXgd0v3T
         XXIA==
X-Gm-Message-State: APjAAAWdWQSsv88Q7H12JgODuVGZZF2SIyp8q4S0JQ0DQbRJVtgZm2bq
        7qZMuWhPcUFYGwF+4hBUly4noIHK4tzcALs=
X-Google-Smtp-Source: APXvYqzTX8nZSaJHdZ8aVWZ5tpFCDSVuM1KXpi4KXLgiwgBNfF8R/WQMHxysQ3Iogi+BVucL3jKbuXMVp8yEVAg=
X-Received: by 2002:a65:68d8:: with SMTP id k24mr38403896pgt.208.1582272316676;
 Fri, 21 Feb 2020 00:05:16 -0800 (PST)
Date:   Fri, 21 Feb 2020 00:05:07 -0800
Message-Id: <20200221080510.197337-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 0/3] driver core: sync state fixups
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/3 fixes a bug where sync_state() might not be called when it
should be. Patches 2/3 and 3/3 are just minor fix ups that I'm grouping
together. Not much to say here.

-Saravana

v1->v2:
- Fix compilation issue in 3/3 (forgot to commit --amend in v1)

Saravana Kannan (3):
  driver core: Call sync_state() even if supplier has no consumers
  driver core: Add dev_has_sync_state()
  driver core: Skip unnecessary work when device doesn't have
    sync_state()

 drivers/base/core.c    | 27 ++++++++++++++++++++-------
 include/linux/device.h | 11 +++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

