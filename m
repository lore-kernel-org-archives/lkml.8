Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9783C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8602F2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDkM67lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGGRwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGGRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:52:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39B1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:52:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so51007412ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/nLHP/a64QASjJIAOtt8ipI7UU8QCW6oWvo4l1cggo=;
        b=ZDkM67lxowhQftwo2fr4VRbpqt97Y6UFmgbkf27HOImXfi3YyD+s8bPZPt/EjIpGkB
         nmTNdVHBFvy41HqE03tLmcuzBxc8cEQWKWp980b0XL2mrguXcBWOK5lox+lCWNREQ/A3
         wx1MHW9Fs4svwt8ZepMQN5MoFPygNHBgUYIwJIJD5lcpoLrn3VfNRYqwmNYEnIXcT2v9
         WNOG37rCksUqsBLha5kNlLfn+ki5TNHXd07cF49OGt6BF6N5Afzv2z5rKd4bSj2Dsmih
         Z452EAh2SkwTASgBtKyahaXJy51MgohKtYwC+rLpKzH9LQC2zAjWGA3xMtK4AjYeaJ80
         xrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/nLHP/a64QASjJIAOtt8ipI7UU8QCW6oWvo4l1cggo=;
        b=Ml2Q4zbLyuFz7wycShASpv6e+npobGfhAmhD2gFK32/Fybfl+bBVnzMCct59xpjr1D
         EKDEtKKswD6Fu4GRAymR6pZfQfLy6XdWz1y+OCPU0robvHUulwxVswsCNMXCBM9Uljb+
         rDmJljVOm/J+xd6999jbwuZM6xPxF5KYpKjB6TlHcJCBOYfmjsyzGYz14w3JIKQ0xWrI
         sqFbLqH6v1DqFw0bwPox077Ib/v8ZQv8zJFRXIiA0w3lxP2Y5lKNS8g7WiKMTFdxdg/t
         1rkPi4qXDOkD3/q8uOigdkMydZcP2GT+qGHt8wuntBNIjVi93FEDROL3ltkMvYtucNWd
         9ang==
X-Gm-Message-State: AOAM532fdAcWycyKqiZgIZwy53WAjWcc2pVu8y8l2NvoQ1d6D2nPFuf/
        R15w2jGJmz9dLTAf5V8AARUqUxi3WLtgMG/VMoOh3Q==
X-Google-Smtp-Source: ABdhPJxmEviU4ufhbV7r3K3OAkUAqQc0pZDEiuTDPx1mQ5sjBFGPtYcHmchmvbDtsXiaWKN0VPnhHGNbl0jM+9b7egs=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr19271931lji.270.1594144367221;
 Tue, 07 Jul 2020 10:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707173612.124425-1-guro@fb.com> <20200707173612.124425-3-guro@fb.com>
In-Reply-To: <20200707173612.124425-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Jul 2020 10:52:36 -0700
Message-ID: <CALvZod5Hka4VBgmoQNJXLwiohFAt8tR3FwNzd=9pnuhO7NaxJQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: kmem: switch to static_branch_likely() in memcg_kmem_enabled()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 10:36 AM Roman Gushchin <guro@fb.com> wrote:
>
> Currently memcg_kmem_enabled() is optimized for the kernel memory
> accounting being off. It was so for a long time, and arguably the
> reason behind was that the kernel memory accounting was initially an
> opt-in feature. However, now it's on by default on both cgroup v1
> and cgroup v2, and it's on for all cgroups. So let's switch over
> to static_branch_likely() to reflect this fact.
>
> Unlikely there is a significant performance difference, as the cost
> of a memory allocation and its accounting significantly exceeds the
> cost of a jump. However, the conversion makes the code look more
> logically.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
