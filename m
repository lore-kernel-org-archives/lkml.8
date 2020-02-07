Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D50C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F6E20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGSOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:14:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGSOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:14:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8E38AD3F;
        Fri,  7 Feb 2020 18:14:00 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com
Subject: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Date:   Fri,  7 Feb 2020 10:03:00 -0800
Message-Id: <20200207180305.11092-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the ll_rbtree interface to optimize rbtree users
that incur in frequent in-order tree iterations (even full traversals).
This can be seen as an abstraction to what is already done for dealing
with VMAs (albeit non-augmented trees).

Mainly, it trades off higher per-node memory footprint (two extra pointers)
for minimal runtime overhead to gain O(1) brachless next and prev node
pointers. See patch 1 for full details, but, for example, the following
tables show the benefits vs the costs of using this new interface.

   +--------+--------------+-----------+
   | #nodes | plain rbtree | ll-rbtree |
   +--------+--------------+-----------+
   |     10 |          138 |        24 |
   |    100 |        7,200 |       425 |
   |   1000 |       17,000 |     8,000 |
   |  10000 |      501,090 |   222,500 |
   +--------+--------------+-----------+

While there are other node representations that optimize getting such pointers
without bloating the nodes as much, such as keeping a parent pointer or threaded
trees where the nil prev/next pointers are recycled; both incurring in higher
runtime penalization for common modification operations as well as any rotations.
The overhead of tree modifications can be seen in the following table, comparing
cycles to insert+delete:

   +--------+--------------+------------------+-----------+
   | #nodes | plain rbtree | augmented rbtree | ll-rbtree |
   +--------+--------------+------------------+-----------+
   |     10 |          530 |              840 |       600 |
   |    100 |        7,100 |           14,200 |     7,800 |
   |   1000 |      265,000 |          370,000 |   205,200 |
   |  10000 |    4,400,000 |        5,500,000 | 4,200,000 |
   +--------+--------------+------------------+-----------+


Patch 1 introduces the ll_rbtree machinery.

Patches 2-5 convert users that might benefit from the new interface.

Full details and justifications for the conversion are in each
individual patch.

I am Cc'ing some of the maintainers of the users I have converted to the whole
series such that it can the numbers and interface details can be easily seen.

Please consider for v5.7.

Thanks!

Davidlohr Bueso (5):
  lib/rbtree: introduce linked-list rbtree interface
  proc/sysctl: optimize proc_sys_readdir
  regmap: optimize sync() and drop() regcache callbacks
  vfio/type1: optimize dma_list tree iterations
  uprobes: optimize build_probe_list()

 Documentation/rbtree.txt              |  74 ++++++++++++++++++++++++
 drivers/base/regmap/regcache-rbtree.c |  62 +++++++++++---------
 drivers/vfio/vfio_iommu_type1.c       |  50 +++++++++--------
 fs/proc/proc_sysctl.c                 |  37 ++++++------
 include/linux/ll_rbtree.h             | 103 ++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h                |   6 +-
 kernel/events/uprobes.c               |  47 ++++++++--------
 7 files changed, 286 insertions(+), 93 deletions(-)
 create mode 100644 include/linux/ll_rbtree.h

-- 
2.16.4

