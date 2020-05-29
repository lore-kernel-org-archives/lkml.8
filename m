Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D299206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jD98fIBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgE2PLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:11:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590765108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4W0zV7ShLoJwMyDedm9KJ8SqbP/FjVOYnVv8NifDQHw=;
        b=jD98fIBcid5wBPRlLIsF4yQNxJ8JoxYQ1wZaBQZhMA5HFK8wx7NHgkBzlGug1jpvu3JrGH
        +mHQ9VK8F4SA0ieO3ho8lYxiR3eMBUJPWpUo9oJTBsJpo6ysQyS0itrbI92n9+cc09CZNL
        csNXpqfBNoMAzqh2wsywj4w4qSh+xuU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-VB9foG2aPz2xc8gZEoQayg-1; Fri, 29 May 2020 11:11:46 -0400
X-MC-Unique: VB9foG2aPz2xc8gZEoQayg-1
Received: by mail-oi1-f200.google.com with SMTP id u128so1553800oia.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4W0zV7ShLoJwMyDedm9KJ8SqbP/FjVOYnVv8NifDQHw=;
        b=stpJVuiLg3MT4tKw0/3vPuAINpaMfnfSKFnEa11yBVtGSEaw4BfubQG0jyfZ0uxExI
         HEpoDJD1kbradm085qVm2SyzDGTOFWK1geWQDm74UKN4wFHP7W+KjYOh3IJDSxRVKSAO
         tzuDFoJ74fy7ztvCdYEOZh5V1TCKj77r533qMM8SoKpJ0En3kTRXHUQnpacBhH0zw2Ny
         +EORbX3y39uil3nLoQN5amLHAicw9/irtFS4a6DXWbftCgpa57aORdAw5Fb0/UyZjbyX
         Zhs9wQtt4wDjmwRvXN6AqvcLsqVzrcvo1388ol98rscrcqpQ6e514MAb/awngDfnjSRR
         Uczw==
X-Gm-Message-State: AOAM532Cvoqm/T6o7FPrxSRL0Q1ebvYWBJ8Y6hyfLffNlPBg13x2rMd7
        1nnHR2CxlRcyKpS8a3Qlsm+NjU5V6qHKAfwRfwoPhWA+SFaMI1boVUTOr86dhud6UuhFosGtW6D
        kdMYYuKG2mNEimqTrXZGOdJAqXvUFAO4smycWGtcf
X-Received: by 2002:a05:6830:130d:: with SMTP id p13mr882739otq.95.1590765104854;
        Fri, 29 May 2020 08:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2zQDgYULMFpy9p6awx5V9rsziPlwX1/XoESwXNBALAkWYK09eTCs92hFzVjSe31uaobwZx8OcIfKWyHXx9Zo=
X-Received: by 2002:a05:6830:130d:: with SMTP id p13mr882723otq.95.1590765104587;
 Fri, 29 May 2020 08:11:44 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 29 May 2020 17:11:33 +0200
Message-ID: <CAHc6FU6RofgpBz0t_DxGMKDbHJrVMcwHVBh63Pa6Tu2Wbiuaww@mail.gmail.com>
Subject: [GIT PULL] GFS2 fix for v5.7-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've screwed up commit aa83da7f47b ("gfs2: More gfs2_find_jhead
fixes") which went into v5.7-rc6. Could you please consider pulling
the following fix?

Thanks a lot,
Andreas

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-v5.7-rc7.fixes

for you to fetch changes up to 20be493b787cd581c9fffad7fcd6bfbe6af1050c:

  gfs2: Even more gfs2_find_jhead fixes (2020-05-29 17:00:24 +0200)

----------------------------------------------------------------
Fix the previous, flawed gfs2_find_jhead commit

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Even more gfs2_find_jhead fixes

 fs/gfs2/lops.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

