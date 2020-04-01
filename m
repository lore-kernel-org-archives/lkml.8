Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9992FC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D49E206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585743077;
	bh=H6mJUEYt2RgLh7EhkVIKX0tPJtCNY/3Cukp4TQLNqVk=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=HXM851UGLShmgT2ybFG+5fk4Y3L/xDvnThM/BJddSCjVlspcY+QL3WK80UO0pVQVO
	 xYGNLHuCO1bjj32Z7Sxs9ECae0fsmPFBfpyN259gHw4+dOEYfsYeD5EKtZhPRfrlBJ
	 gYQPHdEifoh2a9gC/nKXV/XMa4kVGb4pdjU6V7AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbgDAMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbgDAMLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:11:16 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0BC206F8;
        Wed,  1 Apr 2020 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585743075;
        bh=H6mJUEYt2RgLh7EhkVIKX0tPJtCNY/3Cukp4TQLNqVk=;
        h=Date:From:To:cc:Subject:From;
        b=tHHEwK4PSZD93ZFRz+mw19JHk6vzlukEjyJCyX7NCN93+bf0WBaB8p6V0K/KUSSsQ
         OEwhSl0fedMwX5gta2qHe1eX+gZCi9L8OPwScPcFjHo07sqvoFf6PdGrm+ibRyUmoT
         FJocH7baOVfkxugC2zYu/ALD62c8Y8pu3vNM+5po=
Date:   Wed, 1 Apr 2020 14:11:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] trivial tree revival
Message-ID: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

which contains 

=====
- my attempt to revitalize trivial queue I've been neglecting for years 
  (what a disaster that was for this world, right? :) ) with patches 
  collected from backlog that were still relevant and not applied 
  elsewhere in the meantime
=====

Thanks.

----------------------------------------------------------------
Gabriela Bittencourt (1):
      blk-mq: Fix typo in comment

Geert Uytterhoeven (5):
      HID: fix Kconfig word ordering
      mfd: wm8994: Fix comment spelling
      s390/dasd: Fix comment spelling
      sh: mach-highlander: Fix comment spelling
      x86/boot: Fix comment spelling

Lukas Bulwahn (1):
      err.h: remove deprecated PTR_RET for good

NeilBrown (1):
      list/hashtable: minor documentation corrections.

Romuald Brunet (1):
      docs: Add reference in binfmt-misc.rst

Wang Xiayang (1):
      drm/amdgpu: fix two documentation mismatch issues

Yunfeng Ye (1):
      genirq: fix kerneldoc comment for irq_desc

 Documentation/admin-guide/binfmt-misc.rst     | 4 ++--
 arch/sh/include/mach-common/mach/highlander.h | 4 ++--
 arch/x86/boot/apm.c                           | 2 +-
 block/blk-mq-virtio.c                         | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 4 ++--
 drivers/hid/Kconfig                           | 2 +-
 drivers/s390/block/dasd_3990_erp.c            | 2 +-
 include/linux/err.h                           | 3 ---
 include/linux/hashtable.h                     | 4 ++--
 include/linux/irqdesc.h                       | 2 +-
 include/linux/list.h                          | 2 +-
 include/linux/mfd/wm8994/pdata.h              | 2 +-
 12 files changed, 15 insertions(+), 18 deletions(-)

-- 
Jiri Kosina
SUSE Labs

