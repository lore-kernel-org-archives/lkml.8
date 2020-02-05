Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA43BC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829A12253D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBEOLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:11:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgBEOLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:11:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8DE1AB87;
        Wed,  5 Feb 2020 14:11:36 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.6-rc1
Date:   Wed,  5 Feb 2020 15:11:35 +0100
Message-Id: <20200205141135.31595-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6-rc1-tag

xen: branch for v5.6-rc1

It contains:

- a fix of a bug introduced in 5.5 for the Xen gntdev driver
- a fix of the Xen balloon driver when running on ancient Xen versions
- a patch allowing Xen stubdoms to control interrupt enable flags of
  passed-through PCI cards
- a series for releasing resources in Xen backends under memory pressure


Thanks.

Juergen

 Documentation/ABI/testing/sysfs-driver-pciback     | 13 ++++
 Documentation/ABI/testing/sysfs-driver-xen-blkback | 10 +++
 drivers/block/xen-blkback/blkback.c                | 42 +++++-----
 drivers/block/xen-blkback/common.h                 |  1 +
 drivers/block/xen-blkback/xenbus.c                 | 26 ++++++-
 drivers/xen/gntdev.c                               | 24 +++---
 drivers/xen/xen-balloon.c                          |  2 +-
 drivers/xen/xen-pciback/conf_space.c               | 37 +++++++++
 drivers/xen/xen-pciback/conf_space.h               |  7 ++
 drivers/xen/xen-pciback/conf_space_capability.c    | 89 ++++++++++++++++++++++
 drivers/xen/xen-pciback/conf_space_header.c        | 19 +++++
 drivers/xen/xen-pciback/pci_stub.c                 | 66 ++++++++++++++++
 drivers/xen/xen-pciback/pciback.h                  |  1 +
 drivers/xen/xenbus/xenbus_probe.c                  |  8 +-
 drivers/xen/xenbus/xenbus_probe_backend.c          | 38 +++++++++
 include/xen/xenbus.h                               |  2 +
 16 files changed, 346 insertions(+), 39 deletions(-)

Boris Ostrovsky (1):
      xen/gntdev: Do not use mm notifiers with autotranslating guests

Juergen Gross (1):
      xen/balloon: Support xend-based toolstack take two

Marek Marczykowski-Górecki (1):
      xen-pciback: optionally allow interrupt enable flag writes

SeongJae Park (5):
      xenbus/backend: Add memory pressure handler callback
      xenbus/backend: Protect xenbus callback with lock
      xen/blkback: Squeeze page pools if a memory pressure is detected
      xen/blkback: Remove unnecessary static variable name prefixes
      xen/blkback: Consistently insert one empty line between functions
