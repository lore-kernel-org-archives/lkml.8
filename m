Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A9622B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596562642;
	bh=GgFzo0Py+sLPysoYaQyYrymfieB2gRhNbvYX1216wIY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jjBISZyBEp1Adl5TpaLjbSHy/OYJPZ/WToO4i4/Rq9UdI2Xr91NlV7Q4K6rVrzNhg
	 49Xu6WnR9cQZ9igPxFLpjd/2Y5vl1B2YGcqUSBcegD4+GM/2p+TmeFOSbpbnYLzJIE
	 BPGeZdf3XN/S6FTZk8fqz/O4vuVDecVmnpLugrZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgHDRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbgHDRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:37:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076CE21744;
        Tue,  4 Aug 2020 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596562640;
        bh=GgFzo0Py+sLPysoYaQyYrymfieB2gRhNbvYX1216wIY=;
        h=Date:From:To:Cc:Subject:From;
        b=HBMozIg94l3MfC2LaELTMSf05p2GFLgJsGUzU6fLuI4qZpSNRxTOcCN6ghVc2B3lu
         CEZc1z0EUyAlMc6j9IKJWco+2wWnPh9J8q1dGCTWLMRfD0600UtYO79Vy8cgo7LIlE
         Jg2xG3bnSuz3dATfP8ig+j91cI697pCWs8lYYoEU=
Date:   Tue, 4 Aug 2020 19:37:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.9-rc1
Message-ID: <20200804173740.GA513646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.9-rc1

for you to fetch changes up to 76acb5ee76b1ae5870cac9c8125ca09e9106d5b2:

  drm/bridge: lvds-codec: simplify error handling (2020-07-30 09:03:44 +0200)

----------------------------------------------------------------
Driver core changes for 5.9-rc1

Here is the "big" set of changes to the driver core, and some drivers
using the changes, for 5.9-rc1.

"Biggest" thing in here is the device link exposure in sysfs, to help
to tame the madness that is SoC device tree representations and driver
interactions with it.

Other stuff in here that is interesting is:
	- device probe log helper so that drivers can report problems in
	  a unified way easier.
	- devres functions added
	- DEVICE_ATTR_ADMIN_* macro added to make it harder to write
	  incorrect sysfs file permissions
	- documentation cleanups
	- ability for debugfs to be present in the kernel, yet not
	  exposed to userspace.  Needed for systems that want it
	  enabled, but do not trust users, so they can still use some
	  kernel functions that were otherwise disabled.
	- other minor fixes and cleanups

The patches outside of drivers/base/ all have acks from the respective
subsystem maintainers to go through this tree instead of theirs.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrzej Hajda (4):
      driver core: add device probe log helper
      driver core: add deferring probe reason to devices_deferred property
      drm/bridge/sii8620: fix resource acquisition error handling
      drm/bridge: lvds-codec: simplify error handling

Andy Shevchenko (1):
      software node: Use software_node_unregister() when unregistering group of nodes

Barry Song (2):
      driver core: platform: need consistent spacing around '-'
      driver core: platform: expose numa_node to users in sysfs

Bartosz Golaszewski (4):
      devres: remove stray space from devm_kmalloc() definition
      devres: move the size check from alloc_dr() into a separate function
      device: remove 'extern' attribute from function prototypes in device.h
      devres: handle zero size in devm_kmalloc()

Christophe JAILLET (1):
      topology: mark a function as __init to save some memory

Dan Carpenter (1):
      lib: devres: add a comment about the devm_of_iomap() function

Dan Williams (1):
      driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}

Garrit Franke (1):
      kobject: remove unused KOBJ_MAX action

Greg Kroah-Hartman (3):
      Merge 5.8-rc6 into driver-core-next
      Revert "test_firmware: Test platform fw loading on non-EFI systems"
      Merge 5.8-rc7 into driver-core-next

Heikki Krogerus (1):
      kobject: Avoid premature parent object freeing in kobject_cleanup()

Kees Cook (3):
      test_firmware: Test platform fw loading on non-EFI systems
      selftest/firmware: Add selftest timeout in settings
      firmware_loader: EFI firmware loader must handle pre-allocated buffer

Lukas Wunner (2):
      driver core: Drop mention of obsolete bus rwsem from kernel-doc
      driver core: Avoid binding drivers to dead devices

Matthias Brugger (1):
      drivers: base: Convert to printk alias functions

Matthias Maennich (1):
      scripts: add dummy report mode to add_namespace.cocci

Peter Enderborg (2):
      tracefs: Remove unnecessary debug_fs checks.
      debugfs: Add access restriction option

Randy Dunlap (1):
      Documentation/driver-api: driver-model/platform: drop doubled word

Saravana Kannan (5):
      driver core: Expose device link details in sysfs
      driver core: Add state_synced sysfs file for devices that support it
      driver core: Add waiting_for_supplier sysfs file for devices
      driver core: Fix sleeping in invalid context during device link deletion
      driver core: Change delimiter in devlink device's name to "--"

Tetsuo Handa (1):
      driver core: Fix probe_count imbalance in really_probe()

Vladimir Oltean (1):
      devres: keep both device name and resource name in pretty name

Wei Yang (2):
      drivers/base/memory: init_memory_block() first parameter is not necessary
      drivers/base/memory: rename base_memory_block_id to memory_block_id

Wolfram Sang (2):
      firmware: improve description of firmware_request_nowarn
      lib: update DEBUG_SHIRQ docs to match reality

Xu Wang (1):
      debugfs: file: Remove unnecessary cast in kfree()

 Documentation/ABI/testing/sysfs-bus-platform       |  10 +
 Documentation/ABI/testing/sysfs-class-devlink      | 126 ++++++++
 Documentation/ABI/testing/sysfs-devices-consumer   |   8 +
 .../ABI/testing/sysfs-devices-state_synced         |  24 ++
 Documentation/ABI/testing/sysfs-devices-supplier   |   8 +
 .../ABI/testing/sysfs-devices-waiting_for_supplier |  17 ++
 Documentation/admin-guide/kernel-parameters.txt    |  15 +
 Documentation/driver-api/driver-model/platform.rst |   2 +-
 drivers/base/base.h                                |   3 +
 drivers/base/core.c                                | 324 +++++++++++++++++++--
 drivers/base/dd.c                                  |  63 +++-
 drivers/base/devres.c                              |  25 +-
 drivers/base/driver.c                              |   4 +-
 drivers/base/firmware_loader/fallback_platform.c   |   5 +-
 drivers/base/firmware_loader/main.c                |  12 +-
 drivers/base/memory.c                              |  15 +-
 drivers/base/platform.c                            |  28 +-
 drivers/base/swnode.c                              |   8 +-
 drivers/base/topology.c                            |   2 +-
 drivers/gpu/drm/bridge/lvds-codec.c                |  10 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |  21 +-
 fs/debugfs/file.c                                  |   2 +-
 fs/debugfs/inode.c                                 |  39 +++
 fs/debugfs/internal.h                              |  14 +
 include/linux/device.h                             | 288 +++++++++---------
 include/linux/kobject.h                            |   1 -
 include/linux/sysfs.h                              |   7 +
 kernel/trace/trace.c                               |   4 +-
 lib/Kconfig.debug                                  |  40 ++-
 lib/devres.c                                       |  17 +-
 lib/kobject.c                                      |  33 ++-
 scripts/coccinelle/misc/add_namespace.cocci        |   8 +-
 scripts/nsdeps                                     |   2 +-
 tools/testing/selftests/firmware/settings          |   8 +
 tools/testing/selftests/kselftest/runner.sh        |   6 +-
 35 files changed, 945 insertions(+), 254 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-devlink
 create mode 100644 Documentation/ABI/testing/sysfs-devices-consumer
 create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
 create mode 100644 Documentation/ABI/testing/sysfs-devices-supplier
 create mode 100644 Documentation/ABI/testing/sysfs-devices-waiting_for_supplier
 create mode 100644 tools/testing/selftests/firmware/settings
