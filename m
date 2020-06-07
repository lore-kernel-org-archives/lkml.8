Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3B2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591536501;
	bh=WaUvRryG8UPp34ZsmyNMOUuCo2+/kOORUXjGwYv/K+Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ENhPKQoFqLivDRTuHtyvzAGYLEr6/MEJfeH1//mBYTUiDV1gSvV8MoYV7GWEsI9Rv
	 xvuPtV+lwWKGrCrOEdgciPbBLz5UPeJzyFTFw72T1ayd8zZzIAUTy2jnnWBKcMpz4t
	 u9E81DzxHGrwC1A86pLI3JvU1kF+QSf6/ZMLQbDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFGN2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFGN2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:28:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1167C20723;
        Sun,  7 Jun 2020 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591536498;
        bh=WaUvRryG8UPp34ZsmyNMOUuCo2+/kOORUXjGwYv/K+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=2nbrYCa93ft+tMrBiaG8tG1JHY/y8wWkDUVGxPPzf0TSYe9T3ua6K78j81VR/sqds
         mpK5yf5SHXi4dcsUjvU4FWHhssvE+v1lj9/O5B+E68lx0Jo4dIdKjLJ3NCwXIdfe+z
         7Y6ZYZWABpfCMbVcckLl/uFRIM/vie7qXhC8v434=
Date:   Sun, 7 Jun 2020 15:28:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.8-rc1
Message-ID: <20200607132816.GA168380@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.8-rc1

for you to fetch changes up to 8c3e315d4296421cd26b3300ee0ac117f0877f20:

  driver core: Update device link status correctly for SYNC_STATE_ONLY links (2020-05-27 12:20:47 +0200)

----------------------------------------------------------------
Driver core patches for 5.8-rc1

Here is the set of driver core patches for 5.8-rc1.

Not all that huge this release, just a number of small fixes and
updates:
	- software node fixes
	- kobject now sends KOBJ_REMOVE when it is removed from sysfs,
	  not when it is removed from memory (which could come much
	  later)
	- device link additions and fixes based on testing on more
	  devices
	- firmware core cleanups
	- other minor changes, full details in the shortlog

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      drivers property: When no children in primary, try secondary

Christophe JAILLET (1):
      driver core: Add missing '\n' in log messages

Colin Ian King (1):
      driver core: platform: remove redundant assignment to variable ret

Grant Likely (1):
      Add documentation on meaning of -EPROBE_DEFER

Greg Kroah-Hartman (5):
      Merge 5.7-rc3 into driver-core-next
      Merge v5.7-rc5 into driver-core-next
      Merge 5.7-rc7 into driver-core-next
      kobject: send KOBJ_REMOVE uevent when the object is removed from sysfs
      software node: implement software_node_unregister()

Kuppuswamy Sathyanarayanan (1):
      drivers: base: Fix NULL pointer exception in __platform_driver_probe() if a driver developer is foolish

Luis Chamberlain (1):
      firmware_loader: move fw_fallback_config to a private kernel symbol namespace

Nishad Kamdar (1):
      debugfs: Use the correct style for SPDX License Identifier

Saravana Kannan (8):
      Revert "Revert "driver core: Set fw_devlink to "permissive" behavior by default""
      driver core: Move code to the right part of the file
      driver core: Look for waiting consumers only for a fwnode's primary device
      driver core: fw_devlink: Add support for batching fwnode parsing
      of: platform: Batch fwnode parsing when adding all top level devices
      driver core: Remove check in driver_deferred_probe_force_trigger()
      driver core: Remove unnecessary is_fwnode_dev variable in device_add()
      driver core: Update device link status correctly for SYNC_STATE_ONLY links

Scott Branden (2):
      test_firmware: remove unnecessary test_fw_mutex in test_dev_config_show_xxx
      firmware_loader: change enum fw_opt to u32

Takashi Iwai (1):
      firmware: Drop unused pages field from struct firmware

Tang Bin (1):
      driver core: platform: Fix spelling errors in platform.c

Waiman Long (1):
      kernfs: Change kernfs_node lockdep name to "kn->active"

zhouchuangao (1):
      driver/base/soc: Use kobj_to_dev() API

 Documentation/driver-api/driver-model/driver.rst |  32 ++-
 drivers/base/base.h                              |   1 +
 drivers/base/core.c                              | 235 +++++++++++++++++------
 drivers/base/dd.c                                |  33 ++--
 drivers/base/firmware_loader/fallback.c          |  15 +-
 drivers/base/firmware_loader/fallback.h          |   8 +-
 drivers/base/firmware_loader/fallback_platform.c |   2 +-
 drivers/base/firmware_loader/fallback_table.c    |   2 +-
 drivers/base/firmware_loader/firmware.h          |   3 +-
 drivers/base/firmware_loader/main.c              |  14 +-
 drivers/base/platform.c                          |   6 +-
 drivers/base/property.c                          |  13 +-
 drivers/base/soc.c                               |   2 +-
 drivers/base/swnode.c                            |  27 ++-
 drivers/of/platform.c                            |   2 +
 fs/debugfs/internal.h                            |   2 +-
 fs/kernfs/file.c                                 |   2 +-
 include/linux/firmware.h                         |   1 -
 include/linux/fwnode.h                           |   2 +
 include/linux/property.h                         |   1 +
 lib/kobject.c                                    |  14 +-
 lib/test_firmware.c                              |  26 +--
 lib/test_printf.c                                |   4 +-
 23 files changed, 303 insertions(+), 144 deletions(-)
