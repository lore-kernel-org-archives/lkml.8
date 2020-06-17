Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E580C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA832085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILtTzXAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFQCTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQCTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:19:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:19:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d66so380571pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tm2OIAC2wPHIu+J0I11lcX2FQUkFHhPNaZd+SgdUmOc=;
        b=ILtTzXAiow+nG+MFZnQxYWUg0LNfix/Aw1/05PPUVjdMuFqOGCxjCh3sm63ghEyZ1v
         36776c6ULt26LiAbw+qWf/O48btNGUIzyqiHlR+9X9TRaDqUspIX9mIXjlOjzMPdXjfO
         L4EDGYqTtFvGqBnRb0nBPLw1ZsCm3/z7A0EzqdCBMw9fy1IVHPfilrmKgM5ojiY4EBAI
         XXdklcC9hRxhLUYvxAcYOzddiBR/zLp4VGscS7p8wJQ2okzR0DEiWTh/mriR5UoHq7id
         9txgG2P+OSe1swKbcFdfNG+PdO5xkrKX4H2DlILHrrBU9QySckTsyFQyTE08nlkwUsSd
         1HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tm2OIAC2wPHIu+J0I11lcX2FQUkFHhPNaZd+SgdUmOc=;
        b=Lga1pcAdZvTBavO+WLsmPL0diuO825QCzqQi7e5ngl5KZ8T4iyf84UTFyWCP1e0mFo
         KBNoeVUvHIi9FzZ2H/Bud0YJXIWlaijuw7hSeMBtv826fxGDxl3P+optNd469VzG0m5D
         GyMb3/LYV6M3iLzO60UhhFlqHa/4ri8S1NoGU57xqa9Ty3v7bU6B+iaV9s+xzS37cE4Q
         hnfeOvCp3zUKJI9fKxvCNBVKO8n0rLyqA3es7IV2rAEa8lI2EEpg2w6ZomhwdKPemu5F
         vpFdUESfeQ+MAMLcQO3g3dRayOmBoPGy7ikEEm1b67FOFlcGe8DnW09BHutYC3AXheYH
         /H6Q==
X-Gm-Message-State: AOAM533EM03Tq8t7XtIGKGm1iAKtaA9H/2swmz3ehyugRcudSg5U5e6m
        G1+HlOkmTQktbSWc29XQCHg=
X-Google-Smtp-Source: ABdhPJyupGoqunIqWLgfQKt3nF8HlXkYClkFyrB5g8cPk2QdQYtD7/lKzqzLythjC071dea+D5OJPQ==
X-Received: by 2002:a62:75cc:: with SMTP id q195mr4677936pfc.256.1592360363283;
        Tue, 16 Jun 2020 19:19:23 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id h9sm1203208pfe.32.2020.06.16.19.19.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:19:22 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com, pakki001@umn.edu,
        ldufour@linux.ibm.com, harshjain32@gmail.com, simon@nikanor.nu,
        walken@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 0/4] staging: kpc2000: kpc_dma: Few clean up and Convert to pin_user_pages()
Date:   Wed, 17 Jun 2020 07:57:19 +0530
Message-Id: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains few clean up, minor bug fixes and
Convert get_user_pages() to pin_user_pages().

I'm compile tested this, but unable to run-time test,
so any testing help is much appriciated.

Souptick Joarder (4):
  staging: kpc2000: Unpin partial pinned pages
  staging: kpc2000: kpc_dma: Convert set_page_dirty() -->    
    set_page_dirty_lock()
  staging: kpc2000: kpc_dma: Convert get_user_pages() -->
    pin_user_pages()
  staging: kpc2000: kpc_dma: Remove excess goto statement

 drivers/staging/kpc2000/kpc_dma/fileops.c | 33 ++++++++++++++-----------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
1.9.1

