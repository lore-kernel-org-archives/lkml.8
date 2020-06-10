Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF75C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00702072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgFJQby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:31:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgFJQbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C13F8ACAE;
        Wed, 10 Jun 2020 16:31:53 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vinmenon@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH 0/9] slub_debug fixes and improvements
Date:   Wed, 10 Jun 2020 18:31:26 +0200
Message-Id: <20200610163135.17364-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series puts together the recent series "replace runtime slub_debug
toggling with more capable boot parameter" [4] (no longer RFC, thanks for
reviews), with older RFC [5] to introduce a static key for slub_debug. It's
because the removal of runtime toggling makes the static key addition simpler.
The last patch improves cache_from_obj() based on recent debugging effort [6].

We had recently reports [1,2] of troubles with runtime writes to various SLUB
per-cache sysfs files related to slub_debug or tuning leading to crashes. I have
inspected all those writable files and the rather unfortunate result is that
most of them are made read-only by this patchset, as fixing the issues doesn't
seem viable. Details for each are given in each patch (2-5)

The runtime toggles were however necessary for the use case described in [3],
so the first patch extends the slub_debug boot parameter syntax to achieve the
same configuration without runtime toggles. That should hopefully make the
changes more feasible.

Patches 6-9 reduce slub_debug overhead in cases where it's compiled in but not
enabled during boot, with a static key. Patch 9 also improves bug reporting
in cache_from_obj().

[1] https://lkml.kernel.org/r/1580379523-32272-1-git-send-email-vjitta@codeaurora.org
[2] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
[3] https://lore.kernel.org/r/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org
[4] https://lore.kernel.org/r/20200602141519.7099-1-vbabka@suse.cz
[5] https://lore.kernel.org/r/20190404091531.9815-1-vbabka@suse.cz
[6] https://lore.kernel.org/r/4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com

Vlastimil Babka (9):
  mm, slub: extend slub_debug syntax for multiple blocks
  mm, slub: make some slub_debug related attributes read-only
  mm, slub: remove runtime allocation order changes
  mm, slub: make remaining slub_debug related attributes read-only
  mm, slub: make reclaim_account attribute read-only
  mm, slub: introduce static key for slub_debug()
  mm, slub: introduce kmem_cache_debug_flags()
  mm, slub: extend checks guarded by slub_debug static key
  mm, slab/slub: move and improve cache_from_obj()

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/vm/slub.rst                     |  37 +-
 mm/slab.c                                     |   8 +
 mm/slab.h                                     |  23 --
 mm/slub.c                                     | 374 +++++++++---------
 5 files changed, 222 insertions(+), 222 deletions(-)

-- 
2.26.2

