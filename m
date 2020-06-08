Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2EE20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fkp+65jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHWXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:23:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600AC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 15:23:35 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p5so18428208ile.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IOyE3fBHvQo+Zh3CkzprspTxqYRTQ3yhT6gGhhPfw24=;
        b=Fkp+65jhAAgZa79YFMGfjElTF9GgmQcCScA2uqf0Ea6WUTRgOtscQZjGHo9fd4wmpi
         Wi+XgtegOPCLMu4T4NJX8TS3Ls38Po3hPSvtU0wtkN9UEM+89lMjAqEPVjDdU96S42Rb
         Q5JUczLAHWtvX/KddbxK2X7/opnC8sAwNAXLHF4ragapUS9oHytChcBrM6PRvDVY324f
         f7TAGf684QnrHiCZUDV1reAJ6XXM9B5vEAz0B6hvUe6RLSHG+vM2JZrTXca7vuuI9NVz
         1hriAp3TTaViEg3nX1q9mXlkdij6mn6XtvZ/ftTlFCh12ODjYr5yn0NGdOvzM7K8dYps
         xwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IOyE3fBHvQo+Zh3CkzprspTxqYRTQ3yhT6gGhhPfw24=;
        b=bD8P10BckknWUeZ0OaQoGV4FS3QEwSHh0jjJToyfCGR4qOKNk6Mn2Yy1tILKqPzhOF
         PB+WoKzut5IwtbZ4+AJODKYcNqpKe+C7zcS2ZcPIyJZL0MRIlCXzarC1D6Cqm+Mn4Ira
         AyXajlFQm8bC6bSUpWb8pnM6OHjDegVsyT8FF/ECpan3iLvGn7El7+Y18/POPvPU4e9g
         hoF2doyA+GYWx9/H8Ye+XDnhiRRGJq9BWzijO0VIwgCBt9rta5+ibZwd1wKK6wwYlSBb
         ivM53Us73nIO+kHzvXTtjsoIHlX5tbDObbcSgRanduxd+vfe6ZqGGoN1zO/+3BDFZbfq
         0x2Q==
X-Gm-Message-State: AOAM531lAi5R9vkwMdQ83K7Jvmf+ApbLDoNqPPUpvbQGFaIaxoTYS5XO
        AkxfajXqH66Jb1z3vqH/boCCmjXj8ZQ8t+sT79oUog==
X-Google-Smtp-Source: ABdhPJzsZ9TDVgDy3gIz3iyJ4NkEHSDSi7Yj5G4NoSs+wvihQTtx2FHPNlKzSR0PDqTRe+hISmuO9fUvRw7w4Ihe2cQ=
X-Received: by 2002:a92:cd11:: with SMTP id z17mr23379483iln.55.1591655014745;
 Mon, 08 Jun 2020 15:23:34 -0700 (PDT)
MIME-Version: 1.0
From:   Luigi Semenzato <semenzato@google.com>
Date:   Mon, 8 Jun 2020 15:23:22 -0700
Message-ID: <CAA25o9QUtut3+nEs0H8H5qa2H7tQokq+_UoOrAaVGhmYvMTz0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PM: hibernate: introduce opportunistic memory reclaim
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

1. This mechanism is quite general.  It is possible that, although
hibernation may be an important use, there will be other uses for it.
I suggest leaving the hibernation example and performance analysis,
but not mentioning PM or hibernation in the patch subject.

2. It may be useful to have run_show() return the number of pages
reclaimed in the last attempt.  (I had suggested something similar in
https://lore.kernel.org/linux-mm/CAA25o9SxajRaa+ZyhvTYdaKdXokcrNYXgEUimax4sUJGCmRYLA@mail.gmail.com/).

3. It is not clear how much mm_reclaim/release is going to help.  If
the preloading of the swapped-out pages uses some kind of LIFO order,
and can batch multiple pages, then it might help.  Otherwise demand
paging is likely to be more effective.  If the preloading does indeed
help, it may be useful to explain why in the commit message.

Thanks!
