Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4A3C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E411020720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580292908;
	bh=g92/ne7yvhNCuLkf0+UurS/3al2Kd8gROpV3SFcQ2pY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ojUWSlzN0YdicSNadu68H4rnqquQGIOHuUw+5gcSPARuBPDnKI8oymse3bXoQR7lk
	 a9+aweW0d0tgHwk/3WAhWQZ2+TgaqPZcgAj8jRqiaiXVGJn7mkyfDWiN8crWBMS1jb
	 DHU588XHFl23jiYe15iqq5mMBQFBlYATeh0g10b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgA2KPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgA2KPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:15:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B45720716;
        Wed, 29 Jan 2020 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580292905;
        bh=g92/ne7yvhNCuLkf0+UurS/3al2Kd8gROpV3SFcQ2pY=;
        h=Date:From:To:Cc:Subject:From;
        b=atW3ZI3SIilP6bIsix99A9a7/ZwFODHyfN/GEgCo+uTMs2hkXBfX5hAvDNAJd6yJ/
         nquxR32LfVyXniRZ2vroFyM11l4bZ7LlqJTACYPW87lpuuxg2E8PnQYXKRitlYuIia
         IpOOaPTV0a3XKpp2kSRRztpynRgtq0CmLT1ZLalw=
Date:   Wed, 29 Jan 2020 11:15:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.6-rc1
Message-ID: <20200129101503.GA3858516@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.6-rc1

for you to fetch changes up to 85db1cde825344cc1419d3adadaf4187154ad687:

  firmware: Rename FW_OPT_NOFALLBACK to FW_OPT_NOFALLBACK_SYSFS (2020-01-24 09:56:58 +0100)

----------------------------------------------------------------
Driver core changes for 5.6-rc1

Here is a small set of changes for 5.6-rc1 for the driver core and some
firmware subsystem changes.

Included in here are:
	- device.h splitup like you asked for months ago
	- devtmpfs minor cleanups
	- firmware core minor changes
	- debugfs fix for lockdown mode
	- kernfs cleanup fix
	- cpu topology minor fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      driver core: platform: fix u32 greater or equal to zero comparison

Daniel W. S. Almeida (1):
      debugfs: Fix warnings when building documentation

Eric Snowberg (1):
      debugfs: Return -EPERM when locked down

Geert Uytterhoeven (1):
      driver core: Print device when resources present in really_probe()

Greg Kroah-Hartman (7):
      drivers/base: base.h: add proper copyright and header info
      Merge 5.5-rc2 into driver-core-next
      device.h: move devtmpfs prototypes out of the file
      device.h: move dev_printk()-like functions to dev_printk.h
      device.h: move 'struct bus' stuff out to device/bus.h
      device.h: move 'struct class' stuff out to device/class.h
      device.h: move 'struct driver' stuff out to device/driver.h

Guenter Roeck (1):
      driver core: Fix test_async_driver_probe if NUMA is disabled

Hans de Goede (1):
      firmware: Rename FW_OPT_NOFALLBACK to FW_OPT_NOFALLBACK_SYSFS

Lubomir Rintel (1):
      component: do not dereference opaque pointer in debugfs

Masahiro Yamada (1):
      drivers/component: remove modular code

Mateusz Nosek (1):
      fs/kernfs/dir.c: Clean code by removing always true condition

Rasmus Villemoes (5):
      devtmpfs: fix theoretical stale pointer deref in devtmpfsd()
      devtmpfs: factor out setup part of devtmpfsd()
      devtmpfs: simplify initialization of mount_dev
      devtmpfs: initify a bit
      devtmpfs: factor out common tail of devtmpfs_{create,delete}_node

Simon Schwartz (1):
      driver core: platform: Prevent resouce overflow from causing infinite loops

Zeng Tao (1):
      cpu-topology: Don't error on more than CONFIG_NR_CPUS CPUs in device tree

 drivers/base/arch_topology.c                |  20 +-
 drivers/base/base.h                         |  19 +
 drivers/base/bus.c                          |   1 +
 drivers/base/class.c                        |   1 +
 drivers/base/component.c                    |  11 +-
 drivers/base/dd.c                           |   5 +-
 drivers/base/devtmpfs.c                     |  79 ++-
 drivers/base/driver.c                       |   1 +
 drivers/base/firmware_loader/fallback.c     |  11 +-
 drivers/base/firmware_loader/firmware.h     |  16 +-
 drivers/base/firmware_loader/main.c         |   2 +-
 drivers/base/platform.c                     |  12 +-
 drivers/base/test/test_async_driver_probe.c |   3 +-
 fs/debugfs/file.c                           |  38 +-
 fs/debugfs/inode.c                          |   9 +-
 fs/kernfs/dir.c                             |   2 +-
 include/linux/dev_printk.h                  | 235 +++++++
 include/linux/device.h                      | 999 +---------------------------
 include/linux/device/bus.h                  | 288 ++++++++
 include/linux/device/class.h                | 266 ++++++++
 include/linux/device/driver.h               | 292 ++++++++
 init/main.c                                 |   2 +-
 22 files changed, 1219 insertions(+), 1093 deletions(-)
 create mode 100644 include/linux/dev_printk.h
 create mode 100644 include/linux/device/bus.h
 create mode 100644 include/linux/device/class.h
 create mode 100644 include/linux/device/driver.h
