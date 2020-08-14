Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC19A2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHNNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:42600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgHNNjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:39:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BAC8B02A;
        Fri, 14 Aug 2020 13:40:03 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc1b
Date:   Fri, 14 Aug 2020 15:39:39 +0200
Message-Id: <20200814133939.21185-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc1b-tag

xen: branch for v5.9-rc1, 2nd batch

It contains 2 series:

- Removal of support for running as 32-bit Xen PV-guest. 32-bit PV
  guests are rarely used, are lacking security fixes for Meltdown, and
  can be easily replaced by PVH mode. Another series for doing more
  cleanup will follow soon (removal of 32-bit-only pvops functionality).

- Fixes and additional features for the Xen display frontend driver.


Thanks.

Juergen

 arch/x86/entry/entry_32.S                | 109 +------
 arch/x86/entry/vdso/vdso32/note.S        |  30 --
 arch/x86/include/asm/proto.h             |   2 +-
 arch/x86/include/asm/segment.h           |   2 +-
 arch/x86/kernel/head_32.S                |  31 --
 arch/x86/xen/Kconfig                     |   3 +-
 arch/x86/xen/Makefile                    |   3 +-
 arch/x86/xen/apic.c                      |  17 --
 arch/x86/xen/enlighten_pv.c              |  78 +----
 arch/x86/xen/mmu_pv.c                    | 492 ++++++-------------------------
 arch/x86/xen/p2m.c                       |   6 +-
 arch/x86/xen/setup.c                     |  36 +--
 arch/x86/xen/smp_pv.c                    |  18 --
 arch/x86/xen/vdso.h                      |   6 -
 arch/x86/xen/xen-asm.S                   | 194 +++++++++++-
 arch/x86/xen/xen-asm_32.S                | 185 ------------
 arch/x86/xen/xen-asm_64.S                | 192 ------------
 arch/x86/xen/xen-head.S                  |   6 -
 arch/x86/xen/xen-ops.h                   |   1 -
 drivers/gpu/drm/xen/xen_drm_front.c      |  10 +-
 drivers/gpu/drm/xen/xen_drm_front.h      |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c |   1 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c  |  11 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c  |   2 +-
 drivers/xen/Kconfig                      |   4 +-
 drivers/xen/gntdev-dmabuf.c              |   8 +
 include/xen/interface/io/displif.h       |  91 +++++-
 27 files changed, 397 insertions(+), 1143 deletions(-)

Juergen Gross (3):
      x86/xen: remove 32-bit Xen PV guest support
      x86/xen: eliminate xen-asm_64.S
      x86/xen: drop tests for highmem in pv code

Oleksandr Andrushchenko (5):
      xen/gntdev: Fix dmabuf import with non-zero sgt offset
      drm/xen-front: Fix misused IS_ERR_OR_NULL checks
      drm/xen-front: Add YUYV to supported formats
      xen: Sync up with the canonical protocol definition in Xen
      drm/xen-front: Pass dumb buffer data offset to the backend
