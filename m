Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A138C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9C22070A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNH0aJZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404320AbgFXPDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404131AbgFXPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E7C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so1164376plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6s3VpyoFsgSZ3B6oAIdOh3RdCzhKLfaICUHf9hDLF48=;
        b=LNH0aJZTIpw3O3toEvTwUb5sMIlFp6cAUGwKSbwkjKkQ/jzXvNQWLmAnScro//yCPY
         O1WdRzwSYzOgItXdBWAqxJg9VeNSOSvyey1jqUY0fQtWjs4EM2mFeom7U5+5jjlmNcYH
         JystW330pb4PhzoD8EpVBvVgLkYu8/3OtYawwVE3flpaPEWDmIBnVTaP1EULUbV/FfJD
         iPW2EBMWOQvH8ZoqbreMFGKnl3CI+Fmp0XhNlRMv1QORa41VG3HkF1ocPo+SRvjK4guS
         oeNbXdD/kMtG70lRpL7QQ/WWoiBof0jT3tBpjPlyjgcmhy/qu2SHCPt5CzkDIpw6VM0Q
         sfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6s3VpyoFsgSZ3B6oAIdOh3RdCzhKLfaICUHf9hDLF48=;
        b=BCFPvZnrTDweCmwE2F37vqM69PecrprcHYOVpUcKYqT7emN8wIv2B5PLy/V0hDk2DW
         5uqDt473AtLqXBba0VCR45rEXevMWtD7a/U6jzRI/mzCPtN3qeudri/Kb4DJ9Nu3Xdkd
         ZfCNRhyazjN/IZaQKDF2nzT6dgCdKKnByPiBCNuYczFztihS2DlfbKQkvbQV/ReMRHdj
         DKPSP1gcAbZmdb3CaC5uW+xwed/0BAQFgE9hdc3hpkQN+Z/kFE32YUEX/yFf7+Oleomn
         V1pJf7GNT26TCHy4j5AetL4IuF2lmggmUV7xcJSg1UrRquEd/fFM90kJ7h7j4losZZeS
         sAFA==
X-Gm-Message-State: AOAM532kzrXNoG3pc0xcjoDcAXdQfRVEKC/pCdDzebQz6DECnF5NWV2u
        QqEaaTJVa2mYBNrJH92L8w==
X-Google-Smtp-Source: ABdhPJy0MIbYK35VfmoGi9P4OYaen8i194NRhzg25e9pkT997Hdx1akqVNawblxcg8nBy/kJHn6hkg==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr30269606pjq.225.1593010902533;
        Wed, 24 Jun 2020 08:01:42 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:01:42 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] HWPOISON: soft offline rework
Date:   Wed, 24 Jun 2020 15:01:22 +0000
Message-Id: <20200624150137.7052-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I rebased soft-offline rework patchset [1][2] onto the latest mmotm.  The
rebasing required some non-trivial changes to adjust, but mainly that was
straightforward.  I confirmed that the reported problem doesn't reproduce on
compaction after soft offline.  For more precise description of the problem
and the motivation of this patchset, please see [2].

I think that the following two patches in v2 are better to be done with
separate work of hard-offline rework, so it's not included in this series.

  - mm,hwpoison: Take pages off the buddy when hard-offlining
  - mm/hwpoison-inject: Rip off duplicated checks

These two are not directly related to the reported problem, so they seems
not urgent.  And the first one breaks num_poisoned_pages counting in some
testcases, and The second patch needs more consideration about commented point.

Any comment/suggestion/help would be appreciated.

[1] v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
[2] v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (7):
      mm,hwpoison: cleanup unused PageHuge() check
      mm, hwpoison: remove recalculating hpage
      mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
      mm,hwpoison-inject: don't pin for hwpoison_filter
      mm,hwpoison: remove MF_COUNT_INCREASED
      mm,hwpoison: remove flag argument from soft offline functions
      mm,hwpoison: introduce MF_MSG_UNSPLIT_THP

Oscar Salvador (8):
      mm,madvise: Refactor madvise_inject_error
      mm,hwpoison: Un-export get_hwpoison_page and make it static
      mm,hwpoison: Kill put_hwpoison_page
      mm,hwpoison: Unify THP handling for hard and soft offline
      mm,hwpoison: Rework soft offline for free pages
      mm,hwpoison: Rework soft offline for in-use pages
      mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
      mm,hwpoison: Return 0 if the page is already poisoned in soft-offline

 drivers/base/memory.c      |   2 +-
 include/linux/mm.h         |  12 +-
 include/linux/page-flags.h |   6 +-
 include/ras/ras_event.h    |   3 +
 mm/hwpoison-inject.c       |  18 +--
 mm/madvise.c               |  39 +++---
 mm/memory-failure.c        | 331 ++++++++++++++++++++-------------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  63 +++++++--
 9 files changed, 233 insertions(+), 252 deletions(-)
