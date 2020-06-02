Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF81C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270F4207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgFBOQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:16:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgFBOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:16:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B78A7AC53;
        Tue,  2 Jun 2020 14:16:12 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vinmenon@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [RFC PATCH 0/5] replace runtime slub_debug toggling with more capable boot parameter
Date:   Tue,  2 Jun 2020 16:15:14 +0200
Message-Id: <20200602141519.7099-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we had recently reports [1,2] of troubles with runtime writes to various SLUB
per-cache sysfs files related to slub_debug or tuning leading to crashes. I have
inspected all those writable files and the rather unfortunate result is that
most of them are made read-only by this patchset, as fixing the issues doesn't
seem viable. Details for each are given in each patch. I expect some
resistance, hence the RFC.

The runtime toggles were however necessary for the use case described in [3],
so the first patch extends the slub_debug boot parameter syntax to achieve the
same configuration without runtime toggles. That should hopefully make the
changes more feasible.

[1] https://lkml.kernel.org/r/1580379523-32272-1-git-send-email-vjitta@codeaurora.org
[2] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
[3] https://lore.kernel.org/r/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org

Vlastimil Babka (5):
  mm, slub: extend slub_debug syntax for multiple blocks
  mm, slub: make some slub_debug related attributes read-only
  mm, slub: remove runtime allocation order changes
  mm, slub: make remaining slub_debug related attributes read-only
  mm, slub: make reclaim_account attribute read-only

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/vm/slub.rst                     |  36 +-
 mm/slub.c                                     | 315 ++++++++----------
 3 files changed, 163 insertions(+), 190 deletions(-)

-- 
2.26.2

