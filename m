Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09A20759
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIFEog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 00:44:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:43356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgIFEof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 00:44:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9613AAC2B;
        Sun,  6 Sep 2020 04:44:34 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc4
Date:   Sun,  6 Sep 2020 06:44:33 +0200
Message-Id: <20200906044433.24820-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc4-tag

xen: branch for v5.9-rc4

It contains a small series for fixing a problem with Xen PVH guests
when running as backends (e.g. as dom0). Mapping other guests' memory
now is working via ZONE_DEVICE, thus not requiring to abuse the memory
hotplug functionality for that purpose.

Thanks.

Juergen

 drivers/dax/device.c                    |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c |   9 +-
 drivers/xen/Kconfig                     |  10 ++
 drivers/xen/Makefile                    |   1 +
 drivers/xen/balloon.c                   |   4 +-
 drivers/xen/grant-table.c               |   4 +-
 drivers/xen/privcmd.c                   |   4 +-
 drivers/xen/unpopulated-alloc.c         | 183 ++++++++++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_client.c      |   6 +-
 drivers/xen/xlate_mmu.c                 |   4 +-
 include/linux/memremap.h                |   9 +-
 include/xen/balloon.h                   |   4 +
 include/xen/xen.h                       |   9 ++
 mm/memremap.c                           |   2 +-
 14 files changed, 229 insertions(+), 22 deletions(-)

Roger Pau Monne (3):
      xen/balloon: add header guard
      memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
      xen: add helpers to allocate unpopulated memory
