Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C192C433EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADD5206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595762057;
	bh=yTiu3aElFugfkgQka/4eiqlgwGCOo4kpJ+dj714Rhf4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=P1Dkh1p8MM1zwU2U5y4IEv8ekql2VJ1yNGXk+x1+PzrQwtVq8GoB4G7Jt/frp2Hps
	 mJnraws+HBQi/vDxq2lDyjaCrgg4MLLu2CxaM0FODcoVW7b+O+YhfxXY6e/59RFN5+
	 hlyRZaKqjakEPTq35uJx6Nm1N72Ik+xMtU2O/qdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGZLOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgGZLON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:14:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD912065C;
        Sun, 26 Jul 2020 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595762052;
        bh=yTiu3aElFugfkgQka/4eiqlgwGCOo4kpJ+dj714Rhf4=;
        h=Date:From:To:Cc:Subject:From;
        b=me9y+wFyf81uaSMGXOSJkldHDBH5UsaVbsnDcQbxmAsRUt17OpsMmSqFINgsNhFbZ
         LbBLkTjO1Iob5J4jAz5aPPqvgYyweEy3AqekvX1c7RCDvcVgNhY67NINBRRHjuyWTg
         IiVbSS0vJlrBqYkSN3jQLcuUzQ7RHJYHUJ9ShNCw=
Date:   Sun, 26 Jul 2020 13:14:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.8-rc7
Message-ID: <20200726111410.GA1283983@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3e543a4d30014d45b6bb5d2095554be02153cefc:

  Merge tag 'char-misc-5.8-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc into master (2020-07-16 11:26:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc7

for you to fetch changes up to 92d232d176041db5b033dd7b7f7f2cf343f82237:

  interconnect: msm8916: Fix buswidth of pcnoc_s nodes (2020-07-23 10:45:24 +0200)

----------------------------------------------------------------
Char/misc driver fixes for 5.8-rc7

Here are a few small driver fixes for 5.8-rc7

They include:
	- habanalabs fixes
	- tiny fpga driver fixes
	- /dev/mem fixup from previous changes
	- interconnect driver fixes
	- binder fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Eric Biggers (1):
      /dev/mem: Add missing memory barriers for devmem_inode

Georgi Djakov (2):
      interconnect: Do not skip aggregation for disabled paths
      interconnect: msm8916: Fix buswidth of pcnoc_s nodes

Greg Kroah-Hartman (3):
      Merge tag 'misc-habanalabs-fixes-2020-07-10' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus
      Merge tag 'fpga-late-fixes-for-5.8' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-linus
      Merge tag 'misc-habanalabs-fixes-2020-07-19' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus

Matthew Gerlach (1):
      fpga: dfl: fix bug in port reset handshake

Oded Gabbay (4):
      habanalabs: block WREG_BULK packet on PDMA
      habanalabs: set clock gating per engine
      habanalabs: set 4s timeout for message to device CPU
      habanalabs: prevent possible out-of-bounds array access

Tetsuo Handa (1):
      binder: Don't use mmput() from shrinker function.

Xu Yilun (1):
      fpga: dfl: pci: reduce the scope of variable 'ret'

 .../ABI/testing/debugfs-driver-habanalabs          |  11 +-
 drivers/android/binder_alloc.c                     |   2 +-
 drivers/char/mem.c                                 |  10 +-
 drivers/fpga/dfl-afu-main.c                        |   3 +-
 drivers/fpga/dfl-pci.c                             |   3 +-
 drivers/interconnect/core.c                        |  12 +-
 drivers/interconnect/qcom/msm8916.c                |  14 +--
 drivers/misc/habanalabs/command_submission.c       |  14 ++-
 drivers/misc/habanalabs/debugfs.c                  |  23 ++--
 drivers/misc/habanalabs/device.c                   |   2 +-
 drivers/misc/habanalabs/firmware_if.c              |  10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 123 ++++++++++++++-------
 drivers/misc/habanalabs/goya/goya.c                |  20 ++--
 drivers/misc/habanalabs/habanalabs.h               |  19 +++-
 drivers/misc/habanalabs/habanalabs_drv.c           |   2 +-
 drivers/misc/habanalabs/hwmon.c                    |  19 ++--
 drivers/misc/habanalabs/sysfs.c                    |  11 +-
 17 files changed, 186 insertions(+), 112 deletions(-)
