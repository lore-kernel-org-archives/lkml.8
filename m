Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B7C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB292067C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cld/dSe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHUXuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:50:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726706AbgHUXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598053805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M/hJ2+3QuvuuDTv/txt7lwY07Jv7xqj8w65baH7PTCg=;
        b=cld/dSe0wBciF4/frtOPvtAufDIYGotBzHyl86IUO5/VAaC/6JfzAjqZrMoCG5+saMVEuP
        SNR8S31/AI6l95GgDksHCd4ZrX+0yVJvL1HFAyQWAY4y1tJzbkR2QfNkPFveDgVRtC95O7
        7i4xRIbQQM16FGGmlHTlP2GlxUpvl3Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-p2QlI8maORmyXzqRCjUZPA-1; Fri, 21 Aug 2020 19:50:03 -0400
X-MC-Unique: p2QlI8maORmyXzqRCjUZPA-1
Received: by mail-qv1-f71.google.com with SMTP id l18so2295118qvq.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/hJ2+3QuvuuDTv/txt7lwY07Jv7xqj8w65baH7PTCg=;
        b=Vfv9bE8TAV1/kHJf3lcmDw91iYmGzP5hmhvziIaCFQEb968z6FXxNCysMjnCZLUSUs
         TBTiUAdSlu/gsHxRHFnoUS6XsGf6/qjrblDPZisvcR4mmtRV1/6B6S8ZJ1JeZsodpRSl
         vy8RfKkQIBt8p67aj5wC4eYtMbpNr6eH5LYVlRbqDu1RG1zAT+hWOiavyxZ0Z/0llvZi
         mLLz9b0SCPTzhIhmiwjHFyhRjScPqHKafClWG6spHa2g+HrAWsBWhGr0CAM7S/SpkHeI
         u1HTLn2NRm7WbRKy2QI+LyeBCTZGTT76jLymAOJ1cCqgvMEEKS1VOw5nJ/CNtAcfmcNg
         Nbvw==
X-Gm-Message-State: AOAM531D9dEn8mfzgOCumtNEz/KuYioX2KPtG4w+wqkDq6NIRQUXFRc9
        fu6BwOijTle2WSHAiCB5RBlDpnLNk4KRO73kJmMDmZ3XlA/UyNZDqggOvDM/FWK/JHjBLA2LdWT
        QN0Tvt5irFnFtyS8HWbD5C90x
X-Received: by 2002:a05:620a:1122:: with SMTP id p2mr5231550qkk.45.1598053802632;
        Fri, 21 Aug 2020 16:50:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf9TcOFofVzIprDNuH38y7NKdVN1zPjbaOB0+mpCLdI95pwNyzpBVw9WbSMeBuklFfpgnsnA==
X-Received: by 2002:a05:620a:1122:: with SMTP id p2mr5231526qkk.45.1598053802338;
        Fri, 21 Aug 2020 16:50:02 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t69sm2821600qka.73.2020.08.21.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:50:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>, peterx@redhat.com,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] mm: Simplfy cow handling
Date:   Fri, 21 Aug 2020 19:49:54 -0400
Message-Id: <20200821234958.7896-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small series that I picked up from Linus's suggestion [0] to simp=
lify=0D
cow handling (and also more strict) by checking against page refcounts rath=
er=0D
than mapcounts.=0D
=0D
I'm CCing the author and reviewer of commit 52d1e606ee73 on ksm ("mm: reuse=
=0D
only-pte-mapped KSM page in do_wp_page()", 2019-03-05).  Please shoot if=0D
there's any reason to keep the logic, or it'll be removed in this series.  =
For=0D
more information, please refer to [3,4].=0D
=0D
The new mm counter in the last patch can be seen as RFC, depending on wheth=
er=0D
anyone dislikes it... I used it majorly for observing the page reuses, so i=
t is=0D
kind of optional.=0D
=0D
Two tests I did:=0D
=0D
  - Run a busy loop dirty program [1] that uses 6G of memory, restrict to 1=
G=0D
    RAM + 5G swap (cgroup).  A few hours later, all things still look good.=
=0D
    Make sure to observe (still massive) correct page reuses using the new=
=0D
    counter using the last patch, probably when swapping in.=0D
=0D
  - Run umapsort [2] to make sure uffd-wp will work again after applying th=
is=0D
    series upon master 5.9-rc1 (5.9-rc1 is broken).=0D
=0D
In all cases, I must confess it's quite pleased to post a series with diffs=
tat=0D
like this...  Hopefully this won't break anyone but only to make everything=
=0D
better.=0D
=0D
Please review, thanks.=0D
=0D
[0] https://lore.kernel.org/lkml/CAHk-=3Dwjn90-=3Ds6MBerxTuP=3D-FVEZtR-LpoH=
9eenEQ3A-QfKTZw@mail.gmail.com=0D
[1] https://github.com/xzpeter/clibs/blob/master/bsd/mig_mon/mig_mon.c=0D
[2] https://github.com/LLNL/umap-apps/blob/develop/src/umapsort/umapsort.cp=
p=0D
[3] https://lore.kernel.org/lkml/CAHk-=3Dwh0syDtNzt9jGyHRV0r1pVX5gkdJWdenwm=
vy=3Ddq0AL5mA@mail.gmail.com=0D
[4] https://lore.kernel.org/lkml/CAHk-=3Dwj5Oyg0LeAxSw_vizerm=3DsLd=3DsHfcV=
ecZMKPZn6kNbbXA@mail.gmail.com=0D
=0D
Linus Torvalds (1):=0D
  mm: Trial do_wp_page() simplification=0D
=0D
Peter Xu (3):=0D
  mm/ksm: Remove reuse_ksm_page()=0D
  mm/gup: Remove enfornced COW mechanism=0D
  mm: Add PGREUSE counter=0D
=0D
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  8 ---=0D
 include/linux/ksm.h                         |  7 ---=0D
 include/linux/vm_event_item.h               |  1 +=0D
 mm/gup.c                                    | 40 ++------------=0D
 mm/huge_memory.c                            |  7 +--=0D
 mm/ksm.c                                    | 25 ---------=0D
 mm/memory.c                                 | 60 +++++++--------------=0D
 mm/vmstat.c                                 |  1 +=0D
 8 files changed, 29 insertions(+), 120 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

