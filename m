Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBA02065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913433;
	bh=LERIzcvbxVhDX2gmDEv+F+XnIKRI1tmhRZzNp2zDKak=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=o5NNcuQftw7Jzkpw7GbT/rFq91pFcwF2Nwf0X4hRsmmFw6Uor/Qjhi4GKmxWe7ATj
	 MrkVJQbSObrgfvC0saPLEarBCcoGZc8YN1PVe2PNOUU3knPRxA7CS0A3iOSzS1JJ1a
	 UfqMP3RsWp/JL9hrPRJMljvYZOUT4fQFeGasM3Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgGPPab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgGPPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:30:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F162065F;
        Thu, 16 Jul 2020 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913430;
        bh=LERIzcvbxVhDX2gmDEv+F+XnIKRI1tmhRZzNp2zDKak=;
        h=Date:From:To:Cc:Subject:From;
        b=k5vsxhMffMEzc9AUutiJUEVbnGRxRvV4wE+O8+mvSUp3T54FEfqKgY2jBdjyVSFzx
         4SpYButw7Mu6PqE4rXPyYnec4u2kP1olItveLJFV43gB++2MUQcxv+5fG5Gq8GCDCy
         GE3bDvdkYR3kk9gLQwQruUjULDYo2CxkTDv4NxUk=
Date:   Thu, 16 Jul 2020 17:30:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.8-rc6
Message-ID: <20200716153024.GA2379109@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc6

for you to fetch changes up to 897c44f0bae574c5fb318c759b060bebf9dd6013:

  virtio: virtio_console: add missing MODULE_DEVICE_TABLE() for rproc serial (2020-07-10 15:12:48 +0200)

----------------------------------------------------------------
Char/Misc fixes for 5.8-rc6

Here are number of small char/misc driver fixes for 5.8-rc6

Not that many complex fixes here, just a number of small fixes for
reported issues, and some new device ids.  Nothing fancy.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Lobakin (1):
      virtio: virtio_console: add missing MODULE_DEVICE_TABLE() for rproc serial

Alexander Shishkin (4):
      intel_th: pci: Add Jasper Lake CPU support
      intel_th: pci: Add Tiger Lake PCH-H support
      intel_th: pci: Add Emmitsburg PCH support
      intel_th: Fix a NULL dereference when hub driver is not loaded

Alexander Usyskin (1):
      mei: bus: don't clean driver pointer

Arnd Bergmann (1):
      phy: intel: fix enum type mismatch warning

Colin Ian King (1):
      phy: sun4i-usb: fix dereference of pointer phy0 before it is null checked

Dan Carpenter (1):
      coresight: cti: Fix error handling in probe

Dilip Kota (1):
      phy: intel: Fix compilation error on FIELD_PREP usage

Esben Haabendal (2):
      uio_pdrv_genirq: Remove warning when irq is not specified
      uio_pdrv_genirq: fix use without device tree and no interrupt

Greg Kroah-Hartman (2):
      Merge tag 'soundwire-5.8-fixes' of git://git.kernel.org/.../vkoul/soundwire into char--misc-linus
      Merge tag 'phy-fixes-5.8' of git://git.kernel.org/.../phy/linux-phy into char-misc-next

Hans de Goede (2):
      virt: vbox: Fix VBGL_IOCTL_VMMDEV_REQUEST_BIG and _LOG req numbers to match upstream
      virt: vbox: Fix guest capabilities mask check

Michał Mirosław (1):
      misc: atmel-ssc: lock with mutex instead of spinlock

Mike Leach (1):
      coresight: etmv4: Fix CPU power management setup in probe() function

Pierre-Louis Bossart (1):
      soundwire: intel: fix memory leak with devm_kasprintf

Rikard Falkeborn (2):
      phy: ti: am654-serdes: Constify regmap_config
      phy: ti: j721e-wiz: Constify structs

Tiezhu Yang (1):
      phy: rockchip: Fix return value of inno_dsidphy_probe()

Wade Mealing (1):
      Revert "zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()"

 drivers/block/zram/zram_drv.c                    |  3 +-
 drivers/char/virtio_console.c                    |  3 +-
 drivers/hwtracing/coresight/coresight-cti.c      | 96 +++++++++++++-----------
 drivers/hwtracing/coresight/coresight-etm4x.c    | 82 +++++++++++++-------
 drivers/hwtracing/intel_th/core.c                | 21 +++++-
 drivers/hwtracing/intel_th/pci.c                 | 15 ++++
 drivers/hwtracing/intel_th/sth.c                 |  4 +-
 drivers/misc/atmel-ssc.c                         | 24 +++---
 drivers/misc/mei/bus.c                           |  3 +-
 drivers/phy/allwinner/phy-sun4i-usb.c            |  5 +-
 drivers/phy/intel/phy-intel-combo.c              | 14 ++--
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  4 +-
 drivers/phy/ti/phy-am654-serdes.c                |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                   | 10 +--
 drivers/soundwire/intel.c                        |  5 +-
 drivers/uio/uio_pdrv_genirq.c                    |  4 +-
 drivers/virt/vboxguest/vboxguest_core.c          |  6 +-
 drivers/virt/vboxguest/vboxguest_core.h          | 15 ++++
 drivers/virt/vboxguest/vboxguest_linux.c         |  3 +-
 drivers/virt/vboxguest/vmmdev.h                  |  2 +
 include/uapi/linux/vboxguest.h                   |  4 +-
 21 files changed, 207 insertions(+), 118 deletions(-)
