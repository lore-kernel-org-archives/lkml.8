Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8220716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585565103;
	bh=oX+FP6UKfA8Wo473vrBcKjo0kZNeyPSyw6ZHoXrO5E0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WrBD/TAShSvCYYL27/c8OUc8s8YireQe+v81AITp0PSNpt8Gks+An/OvgcDWNxEoG
	 wgDK8xh2isKvB/2CrVUBRXm3eOPU8ljmaA/nJO4w9n3D8KJq68IqgOoyY7pBPA9A1n
	 Ra8hdYfUxzOoOp4PgA83tZEVNcP0sM4NeMS49NFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgC3KpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgC3KpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:45:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46E19205ED;
        Mon, 30 Mar 2020 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585565100;
        bh=oX+FP6UKfA8Wo473vrBcKjo0kZNeyPSyw6ZHoXrO5E0=;
        h=Date:From:To:Cc:Subject:From;
        b=RGAWNBClLElOTvw/kkvIhLidK+PAw0nL24bNCttcnGgcTxpuxAPy8nOlAj8DAHW9i
         STPtpZlQ5tdVPbrlDrn8FJAeTGdDIF8HwJo4dtRjqGhlOgHGHGYfm+UQr3YoFpdjWx
         0dEpQZyhsgNQdXG/U9x4kOkTPPc3ksHhIXNDiPa4=
Date:   Mon, 30 Mar 2020 12:44:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.7-rc1
Message-ID: <20200330104456.GA739463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc1

for you to fetch changes up to 18555cb6db2373b9a5ec1f7572773fd58c77f9ba:

  Revert "driver core: Set fw_devlink to "permissive" behavior by default" (2020-03-27 16:17:30 +0100)

----------------------------------------------------------------
Driver core patches for 5.7-rc1

Here is the "big" set of driver core changes for 5.7-rc1.

Nothing huge in here, just lots of little firmware core changes and use
of new apis, a libfs fix, a debugfs api change, and some driver core
deferred probe rework.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      driver core: Read atomic counter once in driver_probe_done()
      driver core: Replace open-coded list_last_entry()

Dietmar Eggemann (2):
      drivers base/arch_topology: Remove 'struct sched_domain' forward declaration
      drivers base/arch_topology: Reformat topology_get_[cpu/freq]_scale() function name

Eric Biggers (1):
      libfs: fix infoleak in simple_attr_read()

Greg Kroah-Hartman (5):
      Merge 5.6-rc5 into driver-core-next
      debugfs: remove return value of debugfs_create_file_size()
      Revert "drivers: base: power: wakeup.c: Use built-in RCU list checking"
      Merge tag 'stable-shared-branch-for-driver-tree' of git://git.kernel.org/.../efi/efi into driver-core-next
      Revert "driver core: Set fw_devlink to "permissive" behavior by default"

Hans de Goede (9):
      efi: Export boot-services code and data as debugfs-blobs
      efi: Add embedded peripheral firmware support
      firmware: Add new platform fallback mechanism and firmware_request_platform()
      test_firmware: add support for firmware_request_platform
      selftests: firmware: Add firmware_request_platform tests
      Input: silead - Switch to firmware_request_platform for retreiving the fw
      Input: icn8505 - Switch to firmware_request_platform for retreiving the fw
      platform/x86: touchscreen_dmi: Add EFI embedded firmware info support
      platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet

Jeffy Chen (2):
      arch_topology: Adjust initial CPU capacities with current freq
      arch_topology: Fix putting invalid cpu clk

John Stultz (6):
      driver core: Fix driver_deferred_probe_check_state() logic
      driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
      pinctrl: Remove use of driver_deferred_probe_check_state_continue()
      driver core: Remove driver_deferred_probe_check_state_continue()
      driver core: Rename deferred_probe_timeout and make it global
      regulator: Use driver_deferred_probe_timeout for regulator_init_complete_work

Jules Irenge (2):
      driver core: Add missing annotation for device_links_read_lock()
      driver core: Add missing annotation for device_links_write_lock()

Junyong Sun (1):
      firmware: fix a double abort case with fw_load_sysfs_fallback

Madhuparna Bhowmik (1):
      drivers: base: power: wakeup.c: Use built-in RCU list checking

Marco Felsch (1):
      component: allow missing unbind callback

Saravana Kannan (7):
      driver core: Reevaluate dev->links.need_for_probe as suppliers are added
      driver core: Add fw_devlink kernel commandline option
      efi/arm: Start using fw_devlink_get_flags()
      of: property: Start using fw_devlink_get_flags()
      of: property: Delete of_devlink kernel commandline option
      driver core: Add device links from fwnode only for the primary device
      driver core: Set fw_devlink to "permissive" behavior by default

Taehee Yoo (1):
      debugfs: Check module state before warning in {full/open}_proxy_open()

Takashi Iwai (2):
      drivers/base/cpu: Use scnprintf() for avoiding potential buffer overflow
      drivers/base/cpu: Simplify s*nprintf() usages

Tomas Winkler (1):
      platform: constify properties in platform_device

Topi Miettinen (1):
      firmware_loader: load files from the mount namespace of init

Zeng Tao (1):
      cpu-topology: Fix the potential data corruption

kbuild test robot (1):
      driver core: fw_devlink_flags can be static

 Documentation/admin-guide/kernel-parameters.txt    |  24 +++-
 .../driver-api/firmware/fallback-mechanisms.rst    | 103 ++++++++++++++
 Documentation/driver-api/firmware/lookup-order.rst |   2 +
 .../driver-api/firmware/request_firmware.rst       |   5 +
 Documentation/filesystems/debugfs.txt              |   8 +-
 arch/x86/platform/efi/efi.c                        |   2 +
 arch/x86/platform/efi/quirks.c                     |   4 +
 drivers/base/arch_topology.c                       |  44 ++++--
 drivers/base/component.c                           |   3 +-
 drivers/base/core.c                                |  45 +++++-
 drivers/base/cpu.c                                 |  19 +--
 drivers/base/dd.c                                  |  91 +++++--------
 drivers/base/firmware_loader/Makefile              |   1 +
 drivers/base/firmware_loader/fallback.c            |   2 +-
 drivers/base/firmware_loader/fallback.h            |  10 ++
 drivers/base/firmware_loader/fallback_platform.c   |  36 +++++
 drivers/base/firmware_loader/firmware.h            |   4 +
 drivers/base/firmware_loader/main.c                |  33 ++++-
 drivers/firmware/efi/Kconfig                       |   5 +
 drivers/firmware/efi/Makefile                      |   1 +
 drivers/firmware/efi/arm-init.c                    |   2 +-
 drivers/firmware/efi/efi.c                         |  57 ++++++++
 drivers/firmware/efi/embedded-firmware.c           | 150 ++++++++++++++++++++
 drivers/input/touchscreen/chipone_icn8505.c        |   2 +-
 drivers/input/touchscreen/silead.c                 |   2 +-
 drivers/of/property.c                              |   8 +-
 drivers/pinctrl/devicetree.c                       |   9 +-
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/touchscreen_dmi.c             |  65 ++++++++-
 drivers/regulator/core.c                           |  25 ++--
 fs/debugfs/file.c                                  |  18 ++-
 fs/debugfs/inode.c                                 |  18 +--
 fs/exec.c                                          |  26 ++++
 fs/libfs.c                                         |   8 +-
 include/linux/arch_topology.h                      |   7 +-
 include/linux/debugfs.h                            |  20 ++-
 include/linux/device/driver.h                      |   2 +-
 include/linux/efi.h                                |   7 +
 include/linux/efi_embedded_fw.h                    |  43 ++++++
 include/linux/firmware.h                           |   9 ++
 include/linux/fs.h                                 |   3 +
 include/linux/fwnode.h                             |   2 +
 include/linux/platform_device.h                    |   2 +-
 lib/test_firmware.c                                |  55 ++++++++
 tools/testing/selftests/firmware/Makefile          |   9 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |  23 ++++
 tools/testing/selftests/firmware/fw_namespace.c    | 151 +++++++++++++++++++++
 tools/testing/selftests/firmware/fw_run_tests.sh   |   4 +
 48 files changed, 996 insertions(+), 174 deletions(-)
 create mode 100644 drivers/base/firmware_loader/fallback_platform.c
 create mode 100644 drivers/firmware/efi/embedded-firmware.c
 create mode 100644 include/linux/efi_embedded_fw.h
 create mode 100644 tools/testing/selftests/firmware/fw_namespace.c
