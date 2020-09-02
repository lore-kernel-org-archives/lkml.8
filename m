Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91354C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF020C56
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBJp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBJpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:45:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AEB3AEAB;
        Wed,  2 Sep 2020 09:45:20 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/4] HWpoison: further fixes and cleanups
Date:   Wed,  2 Sep 2020 11:45:06 +0200
Message-Id: <20200902094510.10727-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The important bit of this patchset is patch#1, which is a fix to take off
HWPoison pages off a buddy freelist since it can lead to us having HWPoison
pages back in the game and no one noticing it is handling a HWPoison page.
So fix it (we did that already for soft_offline_page [1]).

The other patches are clean-ups and not that important, so if anything,
consider patch#1 for inclusion.

Thanks


Oscar Salvador (4):
  mm,hwpoison: Take free pages off the buddy freelists
  mm,hwpoison: Refactor madvise_inject_error
  mm,hwpoison: Drain pcplists before bailing out for non-buddy
    zero-refcount page
  mm,hwpoison: Drop unneeded pcplist draining

 mm/madvise.c        | 34 +++++++++++++---------------------
 mm/memory-failure.c | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 25 deletions(-)

-- 
2.26.2

