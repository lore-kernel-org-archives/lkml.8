Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F6720674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="wjS/YEdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbgHQTmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgHQPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:24:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700F8C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:24:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o22so12632405qtt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wpjFdhMNWCz1OoEOw1sNOB2ATr37xxpA0VcQ/rpzNt8=;
        b=wjS/YEddcrTt0TwUl4STi3hdSDfKMwHDJPmkG2duqqroVErfzpgY9a6M9JQrj0fUcz
         DvNR5qx5szPuyrB3gvn5LmcLiLCLuQFZaGvnDx6hpJ70ppgRqX71P8K/RCLcTroKaAxY
         pyJ/0rnC/yMvdOiQwxA38L54so/duzrQyLns0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wpjFdhMNWCz1OoEOw1sNOB2ATr37xxpA0VcQ/rpzNt8=;
        b=H1HxihPRq34AQnKOmY4Xbgg+JS+MZJ/pKi5zEK3NqtDa2zmPID6A8cN4/sWeI0+hvC
         Dvd1AVlogNEQ/N4uUtts7mXuMxmZZph3zT/6GWYFgBRVBUJDfRUnPVoMxG0FZxI2RD7Q
         Mrgb7r1aVtv+DfTwfacTtz2ViQ8tMAf/d3gL7bpylq8SMKTUtWoI0SJaobbC6uFevU8/
         cpxRrXuqv/uhM7/8bq7c97UTG73sHvjgBb0/uf88arxya8kfiBP1TTd7WYneCOtfDBHb
         yFjCTjQj4Sg5KSo7ss55k6mbIx489mXwi9GDXju5Yi9TnZv2cVWWIZO8FmAL52YvaLWw
         RYNQ==
X-Gm-Message-State: AOAM533LfD/G/rc8XbYC0SHgSFe6q6gnMkNTth5iR1XwY1omsM62vKWj
        C9UasFe5XM+dlL8bsMH5Ne7HnSVFOhbEvdalgPU=
X-Google-Smtp-Source: ABdhPJxMUZ+gCnSCq5ix1mrxrPzEKdVJXy8XJC/J+jB54EdKD6pxTu3QP5svxJbvGB+0IZHl4HoYlw==
X-Received: by 2002:ac8:614b:: with SMTP id d11mr13837585qtm.271.1597677860987;
        Mon, 17 Aug 2020 08:24:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:47cc])
        by smtp.gmail.com with ESMTPSA id 15sm17368296qkm.112.2020.08.17.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:24:20 -0700 (PDT)
Date:   Mon, 17 Aug 2020 16:24:18 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH 0/2] a couple of userspace MSR filtering improvements
Message-ID: <cover.1597677395.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in Message-ID <20200714165621.GA3622@nazgul.tnic>.

We all agree that userspace MSR twiddling is non-ideal, but we should be
a bit cautious of taking up too much kmsg buffer if applications do
repeated writes. `allow_writes=1` is possible, but is non-ideal (see
patch 1 changelog).

Also added pid information to the message, since it makes identification
of the source (more or less) unambiguous.

Chris Down (2):
  x86: Prevent userspace MSR access from dominating the console
  x86: Make source of unrecognised MSR writes unambiguous

 arch/x86/kernel/msr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.28.0

