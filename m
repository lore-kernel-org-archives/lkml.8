Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9179222C9F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrOzapY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHFSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHFSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C76CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so17686473pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RzCR8eOyGZpHLydYs0qnEBF3ql3Tt87KmFjZ6QFWP+0=;
        b=HrOzapY58HGT/QHFZ2Ar3eHGxaNQBne46zo/lYKat8FzI+hw3SWo56er1DkIwL+30D
         1fav0XJZzhxLEOCZbOJxYSt+b6Gv5d7+U/zsZ6BPh01SV9Lfa9U9+Y/hM3OTKQ2KF05C
         Qr0/O7nzG7mD7ireeuYHehgI4o6pQ/K9ZSt+ESoVmDDelsk84B1gVs0luwnkthHlWZoK
         K1/tLWNmiuN1QjpA0XOuFHIgTWXw9etIwXQ6N4oM/ohR4cIojBhZrbopqbOTQMiUkDhs
         nKRtwIDZf5MSzRcrDojl/fWt8rEYOTcCgBZEOFBgtrPaeO7Tx7Mji6wCKtQIGpuAWvSL
         ndNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RzCR8eOyGZpHLydYs0qnEBF3ql3Tt87KmFjZ6QFWP+0=;
        b=DEDdNRWJ6tr6byM4M7qwMQjIl5qdl3zm9y2dIlexl8Qt3A3WcSi3hlwn4VPEMT+QMk
         5CU6a0OpZZZpC+gLfvmXk+IQGj1DAF+XnPGwJzJEp+V9WCjI6EiTUM8ALlmCq6+z3bTY
         6Cn/jZ/5B87xyBadTg3UPHq3m9Kw9hMbSpP4CyxYkDURsDi9i/lUbgDLCQPSb49NxXDn
         IwsJVuRHk071508kUvXS1Pd0kkJExeI+wvyJcMQTBzRuo226OyVnczn4ff6KB3zZWzh+
         nabibxLqE6jhYFHEuLTkNYtPlmw2DMPPD+OOq43niH9FDpUu4VFmBqhsYAmy3xDlKfvp
         RP9Q==
X-Gm-Message-State: AOAM533qWoostOnTQ8tuUdZI2mb/Cj18Wrb8le2GXwWIC3pfYHN+FhEE
        +6UPHoF17v3CKS7qcW409A==
X-Google-Smtp-Source: ABdhPJwwWS0/MG9ulSnZhDQM2qzYL9cXvhe9nZ4acBdeqU8xXU5hMDmpWXhEhM2l/9LO9LWZ5oAnDA==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr9809084pfd.202.1596739768843;
        Thu, 06 Aug 2020 11:49:28 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:28 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/12] HWPOISON: soft offline rework
Date:   Thu,  6 Aug 2020 18:49:11 +0000
Message-Id: <20200806184923.7007-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is the latest version of soft offline rework patchset
targetted for v5.9.

Since v5, I dropped some patches which tweak refcount handling in
madvise_inject_error() to avoid the "unknown refcount page" error.
I don't confirm the fix (that didn't reproduce with v5 in my environment),
but this change surely call soft_offline_page() after holding refcount,
so the error should not happen any more.

Dropped patches
- mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
- mm,madvise: Refactor madvise_inject_error
- mm,hwpoison: remove MF_COUNT_INCREASED
- mm,hwpoison: remove flag argument from soft offline functions

Thanks,
Naoya Horiguchi

Quoting cover letter of v5:
----
Main focus of this series is to stabilize soft offline.  Historically soft
offlined pages have suffered from racy conditions because PageHWPoison is
used to a little too aggressively, which (directly or indirectly) invades
other mm code which cares little about hwpoison.  This results in unexpected
behavior or kernel panic, which is very far from soft offline's "do not
disturb userspace or other kernel component" policy.

Main point of this change set is to contain target page "via buddy allocator",
where we first free the target page as we do for normal pages, and remove
from buddy only when we confirm that it reaches free list. There is surely
race window of page allocation, but that's fine because someone really want
that page and the page is still working, so soft offline can happily give up.

v4 from Oscar tries to handle the race around reallocation, but that part
seems still work in progress, so I decide to separate it for changes into
v5.9.  Thank you for your contribution, Oscar.

---
Previous versions:
  v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
  v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
  v3: https://lore.kernel.org/linux-mm/20200624150137.7052-1-nao.horiguchi@gmail.com/
  v4: https://lore.kernel.org/linux-mm/20200716123810.25292-1-osalvador@suse.de/
  v5: https://lore.kernel.org/linux-mm/20200805204354.GA16406@hori.linux.bs1.fc.nec.co.jp/T/#t
---
Summary:

Naoya Horiguchi (5):
      mm,hwpoison: cleanup unused PageHuge() check
      mm, hwpoison: remove recalculating hpage
      mm,hwpoison-inject: don't pin for hwpoison_filter
      mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
      mm,hwpoison: double-check page count in __get_any_page()

Oscar Salvador (7):
      mm,hwpoison: Un-export get_hwpoison_page and make it static
      mm,hwpoison: Kill put_hwpoison_page
      mm,hwpoison: Unify THP handling for hard and soft offline
      mm,hwpoison: Rework soft offline for free pages
      mm,hwpoison: Rework soft offline for in-use pages
      mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
      mm,hwpoison: Return 0 if the page is already poisoned in soft-offline

 include/linux/mm.h         |   3 +-
 include/linux/page-flags.h |   6 +-
 include/ras/ras_event.h    |   3 +
 mm/hwpoison-inject.c       |  18 +--
 mm/madvise.c               |   5 -
 mm/memory-failure.c        | 307 +++++++++++++++++++++------------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  60 +++++++--
 8 files changed, 203 insertions(+), 210 deletions(-)
