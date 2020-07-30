Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF423C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF7F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Clq9pCyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgG3WqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbgG3WqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:46:11 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EDFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:46:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p4so19362181pls.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KdqtOivFw0hOYBvN6JG/eE86OTCksnrTLbBlBCKnAW0=;
        b=Clq9pCyrD4jp/Sj5+lm69DMDICi41yD/lsu2/6hRwTN/5OuS0NgJZMNR/ztFwYhEW3
         ji/1O6m0hjUMyc/5iSC5twth0au8JCORRS527jsKZCSmmMWh/t5YBkYkeTASu5tkLbqL
         b+cRGHNlXxaypFSLGAJoNXOfkSyIocDnT8TjDydDMHIuCzUnbtWz6EjpQrucxM1JzF01
         yxlvCcfhj9yY8wSbdM3yQPu/ZYStWFNNYzQ1hn1+ylMiueiiVJ4+se9n0bGmH7gcb+M+
         1yQQQeTgVme52gJyJRnEwvNmZVA0yi5NmrdBG1BMeDLS/Uo4JTV/IGaxP70skLq0PSPy
         HC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KdqtOivFw0hOYBvN6JG/eE86OTCksnrTLbBlBCKnAW0=;
        b=UzgSCV4TqshZENdNrRvR3jaXI8gm3ivlr1C3FN3WimtOhy9bJuq7KS3syoFWeq6mRo
         0RLTzyqVRWMxUCOOWeOkNMryaC8OVzgYkQoc3PdUE7S4fvqPsr2GCg/vQ9VIQ9pactLT
         Ho6T7AGkpawKge9hfW3GKUIVrwOJRoCCjhivCdsCE2vkZY91nq9Fg9X/8Zbw7ZW70qig
         UcYh7HQBkqz62OsNIWgffU+uQnOZUjNIBjQJ2wSGz0AmQsqfe8em6jLme2ajeUDouTqy
         2NfkBSkj4ofUF7PbSxwwm/Qme0rcvKaY3UEIorTenCceSHPhYwfPblTNbpgCwZfQpf3M
         GKwg==
X-Gm-Message-State: AOAM532XqAXQ1tUCkUK3MzM76zEukf6EeArDwIj+WW0r0y4vLRvFGRJz
        A40OYlenT1t0PhaY6QoIgAIhcPnxEfkDgP1TBmg=
X-Google-Smtp-Source: ABdhPJx40HpCHnedOlhvE3oA2+UUEC/fD+fec58mHLry9tzk8bl7UVUCXFp4Ia0CNWBrYVF5RS9nJPx1JYQYN/snPyI=
X-Received: by 2002:a17:90a:784c:: with SMTP id y12mr1196857pjl.16.1596149170366;
 Thu, 30 Jul 2020 15:46:10 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:45:53 -0700
Message-Id: <20200730224555.2142154-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 0/2] tracepoint bugfix and cleanup
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a reported bug in iterating the
tracing/printk_formats sysfs node, and is tagged for stable.

The second patch is a small cleanup and is less important than the
first.

Resending since I messed up the list of cc's on the cover letter last
week; picked up Miguel's Ack on 0002.

Nick Desaulniers (2):
  tracepoint: mark __tracepoint_string's __used
  tracepoint: used attribute definitions from compiler_attributes.h

 include/linux/tracepoint.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.28.0.163.g6104cc2f0b6-goog

