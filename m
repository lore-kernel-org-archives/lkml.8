Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F622C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37ACF2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFAPqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:46:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42297C05BD43;
        Mon,  1 Jun 2020 08:46:02 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E352937B;
        Mon,  1 Jun 2020 15:46:01 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:46:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.8
Message-ID: <20200601094600.19c6fe0b@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
d98dbbe0d331b1a6dc1ca0b948c99d58cdba580c:

  scripts: documentation-file-ref-check: Add line break before exit (2020-04-15 15:13:13 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.8

for you to fetch changes up to e35b5a4c494a75a683ddf4901a43e0a128d5bfe3:

  Documentation: fixes to the maintainer-entry-profile template (2020-06-01 09:36:07 -0600)

----------------------------------------------------------------
A fair amount of stuff this time around, dominated by yet another massive
set from Mauro toward the completion of the RST conversion.  I *really*
hope we are getting close to the end of this.  Meanwhile, those patches
reach pretty far afield to update document references around the tree;
there should be no actual code changes there.  There will be, alas, more of
the usual trivial merge conflicts.

Beyond that we have more translations, improvements to the sphinx
scripting, a number of additions to the sysctl documentation, and lots of
fixes.

----------------------------------------------------------------
Adrian Freund (1):
      Documentation: scheduler: fix outdated information on sched groups

Alessia Mantegazza (1):
      doc:it_IT: translation of documents in process/

Arnd Bergmann (1):
      samples: fix binderfs sample

Björn Töpel (2):
      Documentation/features: Refresh the arch support status files
      Documentation/features: Correct RISC-V kprobes support entry

Bumsik Kim (1):
      watchdog: clarify that stop() is optional

Casey Schaufler (1):
      Documentation: LSM: Correct the basic LSM description

Chucheng Luo (1):
      doc: zh_CN: add translatation for debugfs.txt

Cristian Souza (1):
      docs: admin-guide: Clarify sentences

Federico Vaga (3):
      doc:it_IT: add RISC-V maintenance guidelines
      doc:it_IT: align Italian translation
      doc:locking: remove info about old behavior of locktorture

Flavio Suligoi (3):
      Documentation: x86: fix space instead of tab in uefi doc
      docs: filesystems: add info about efivars content
      docs: acpi: fix old http link and improve document format

Gal Pressman (1):
      dma-buf: Couple of documentation typo fixes

Jonathan Corbet (3):
      Merge branch 'mauro' into docs-next
      Merge branch 'mauro' into docs-next
      Revert "docs: sysctl/kernel: document ngroups_max"

Joshua Abraham (1):
      docs: kvm: Fix KVM_KVMCLOCK_CTRL API doc

Juan Manuel Méndez Rey (1):
      Update the documentation referencing Plan 9 from User Space.

Kevin Hao (1):
      docs: vm: page_frags.rst: Fix the reference of stale function

Leonardo Bras (1):
      mailmap: Add entry for Leonardo Bras

Matthew Wilcox (Oracle) (1):
      docs: Add rbtree documentation to the core-api

Mauro Carvalho Chehab (80):
      scripts: sphinx-pre-install: improve distro detection check
      scripts: sphinx-pre-install: improve openSuse Tumbleweed check
      scripts: sphinx-pre-install: fix a dependency hint with Ubuntu 16.04
      scripts: sphinx-pre-install: address some issues with Gentoo
      scripts: sphinx-pre-install: add support for OpenMandriva
      scripts: sphinx-pre-install: add support for python -m venv
      scripts: kernel-doc: proper handle @foo->bar()
      scripts: kernel-doc: accept negation like !@var
      scripts: kernel-doc: accept blank lines on parameter description
      docs: update recommended Sphinx version to 2.4.4
      docs: LaTeX/PDF: drop list of documents
      MAINTAINERS: dt: update display/allwinner file entry
      MAINTAINERS: dt: fix pointers for ARM Integrator, Versatile and RealView
      docs: dt: fix broken reference to phy-cadence-torrent.yaml
      docs: fix broken references to text files
      docs: fix broken references for ReST files that moved around
      docs: filesystems: fix renamed references
      docs: amu: supress some Sphinx warnings
      docs: arm64: booting.rst: get rid of some warnings
      docs: pci: boot-interrupts.rst: improve html output
      docs: ras: get rid of some warnings
      docs: ras: don't need to repeat twice the same thing
      docs: spi: spi.h: fix a doc building warning
      docs: drivers: fix some warnings at base/platform.c when building docs
      docs: mm: userfaultfd.rst: use ``foo`` for literals
      docs: mm: userfaultfd.rst: use a cross-reference for a section
      docs: vm: index.rst: add an orphan doc to the building system
      docs: dt: qcom,dwc3.txt: fix cross-reference for a converted file
      docs: dt: fix a broken reference for a file converted to json
      docs: powerpc: cxl.rst: mark two section titles as such
      docs: i2c: rename i2c.svg to i2c_bus.svg
      docs: Makefile: place final pdf docs on a separate dir
      docs: dt: rockchip,dwc3.txt: fix a pointer to a renamed file
      ata: libata-core: fix a doc warning
      firewire: firewire-cdev.hL get rid of a docs warning
      fs: inode.c: get rid of docs warnings
      futex: get rid of a kernel-docs build warning
      lib: bitmap.c: get rid of some doc warnings
      scripts: sphinx-pre-install: only ask to activate valid venvs
      scripts: sphinx-pre-install: change the warning for version < 2.4.4
      scripts: sphinx-pre-install: change recommendation text if venv exists
      scripts: sphinx-pre-install: fix a bug when using with venv
      scripts: sphinx-pre-install: change the output order
      docs: filesystems: convert caching/object.txt to ReST
      docs: filesystems: convert caching/fscache.txt to ReST format
      docs: filesystems: caching/netfs-api.txt: convert it to ReST
      docs: filesystems: caching/operations.txt: convert it to ReST
      docs: filesystems: caching/cachefiles.txt: convert to ReST
      docs: filesystems: caching/backend-api.txt: convert it to ReST
      docs: filesystems: convert cifs/cifsroot.txt to ReST
      docs: filesystems: convert automount-support.txt to ReST
      docs: filesystems: convert coda.txt to ReST
      docs: filesystems: convert devpts.txt to ReST
      docs: filesystems: convert dnotify.txt to ReST
      docs: filesystems: convert fiemap.txt to ReST
      docs: filesystems: convert files.txt to ReST
      docs: filesystems: convert fuse-io.txt to ReST
      docs: filesystems: convert locks.txt to ReST
      docs: filesystems: convert mandatory-locking.txt to ReST
      docs: filesystems: convert mount_api.txt to ReST
      docs: filesystems: convert quota.txt to ReST
      docs: filesystems: convert seq_file.txt to ReST
      docs: filesystems: convert sharedsubtree.txt to ReST
      docs: filesystems: split spufs.txt into 3 separate files
      docs: filesystems: convert spufs/spu_create.txt to ReST
      docs: filesystems: convert spufs/spufs.txt to ReST
      docs: filesystems: convert spufs/spu_run.txt to ReST
      docs: filesystems: convert sysfs-pci.txt to ReST
      docs: filesystems: convert sysfs-tagging.txt to ReST
      docs: filesystems: convert xfs-delayed-logging-design.txt to ReST
      docs: filesystems: convert xfs-self-describing-metadata.txt to ReST
      docs: filesystems: convert configfs.txt to ReST
      docs: move DMA kAPI to Documentation/core-api
      docs: move IPMI.txt to the driver API book
      docs: fix references for ipmi.rst file
      docs: debugging-via-ohci1394.txt: add it to the core-api book
      docs: add IRQ documentation at the core-api book
      docs: move the kref doc into the core-api book
      docs: move digsig docs to the security book
      docs: move locking-specific documents to locking/

Michal Suchanek (1):
      doc: nvdimm: remove reference to non-existent CONFIG_NFIT_TEST

Oded Gabbay (1):
      docs: ioctl-number.rst: add habanalabs driver IOCTL

Qi Zheng (1):
      kobject: documentation: Fix erroneous function example in kobject doc.

Randy Dunlap (3):
      nvdimm: fixes to maintainter-entry-profile
      Documentation: admin-guide: update bug-hunting.rst
      Documentation: fixes to the maintainer-entry-profile template

Ricardo Cañuelo (1):
      docs: pr_*() kerneldocs and basic printk docs

Ricardo Ribalda (1):
      mailmap: change email for Ricardo Ribalda

Rikard Falkeborn (1):
      docs: debugfs: Update struct debugfs_reg32 definition

Sedat Dilek (1):
      zswap: docs/vm: Fix typo accept_threshold_percent in zswap.rst

Stephen Kitt (9):
      docs: sysctl/kernel: document BPF entries
      docs: orangefs: fix pvfs2tab literal block
      docs: virt/kvm: close inline string literal
      docs: sysctl/kernel: document cad_pid
      docs: sysctl/kernel: document ftrace entries
      docs: sysctl/kernel: document firmware_config
      docs: sysctl/kernel: document ngroups_max
      docs: sysctl/kernel: document ngroups_max
      docs: sysctl/kernel: document unaligned controls

Tom Zanussi (1):
      tracing: Fix events.rst section numbering

Vitor Massaru Iha (3):
      doc: misc-device: add uacce to toctree(index)
      docs: coresight: fix `make htmldocs` warning
      docs: s390: Fix wrong label Guest2 instead of Guest3

Vlastimil Babka (1):
      Documentation: update numastat explanation

Waiman Long (1):
      doc: Fix some errors in ras.rst

Wang Wenhu (1):
      doc: thermal: add cpu-idle-cooling to index tree

Wolfram Sang (2):
      Documentation: zh_CN: convert to use i2c_new_client_device()
      watchdog: update email address in conversion doc

 .mailmap                                           |    5 +-
 CREDITS                                            |    6 +-
 Documentation/ABI/stable/sysfs-devices-node        |    2 +-
 Documentation/ABI/testing/procfs-smaps_rollup      |    2 +-
 Documentation/Makefile                             |    6 +-
 Documentation/PCI/boot-interrupts.rst              |   34 +-
 Documentation/admin-guide/acpi/ssdt-overlays.rst   |    2 +-
 Documentation/admin-guide/bug-hunting.rst          |   53 +-
 Documentation/admin-guide/cpu-load.rst             |    2 +-
 Documentation/admin-guide/hw-vuln/l1tf.rst         |    2 +-
 Documentation/admin-guide/init.rst                 |   76 +-
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 .../admin-guide/kernel-per-CPU-kthreads.rst        |    2 +-
 Documentation/admin-guide/mm/userfaultfd.rst       |  211 +--
 Documentation/admin-guide/nfs/nfsroot.rst          |    2 +-
 Documentation/admin-guide/numastat.rst             |   31 +-
 Documentation/admin-guide/ras.rst                  |   28 +-
 Documentation/admin-guide/sysctl/kernel.rst        |  157 +-
 Documentation/arm64/amu.rst                        |    5 +
 Documentation/arm64/booting.rst                    |   36 +-
 Documentation/conf.py                              |   38 -
 .../debugging-via-ohci1394.rst}                    |    0
 .../dma-api-howto.rst}                             |    0
 .../{DMA-API.txt => core-api/dma-api.rst}          |    0
 .../dma-attributes.rst}                            |    0
 .../{DMA-ISA-LPC.txt => core-api/dma-isa-lpc.rst}  |    0
 Documentation/core-api/index.rst                   |    9 +
 .../{IRQ.txt => core-api/irq/concepts.rst}         |    0
 Documentation/core-api/irq/index.rst               |   11 +
 .../irq/irq-affinity.rst}                          |    0
 .../irq/irq-domain.rst}                            |    3 +-
 .../irq/irqflags-tracing.rst}                      |    0
 Documentation/core-api/kobject.rst                 |   28 +-
 Documentation/{kref.txt => core-api/kref.rst}      |    0
 Documentation/core-api/printk-basics.rst           |  115 ++
 Documentation/core-api/printk-formats.rst          |    2 +
 Documentation/{rbtree.txt => core-api/rbtree.rst}  |    0
 .../devicetree/bindings/net/qualcomm-bluetooth.txt |    2 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |    2 +-
 .../devicetree/bindings/usb/qcom,dwc3.txt          |    4 +-
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |    2 +-
 Documentation/doc-guide/maintainer-profile.rst     |    2 +-
 Documentation/driver-api/dma-buf.rst               |    4 +-
 Documentation/driver-api/driver-model/device.rst   |    4 +-
 Documentation/driver-api/driver-model/overview.rst |    2 +-
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/{IPMI.txt => driver-api/ipmi.rst}    |    0
 Documentation/driver-api/nvdimm/nvdimm.rst         |    4 +-
 .../driver-api/thermal/cpu-idle-cooling.rst        |    3 +
 Documentation/driver-api/thermal/index.rst         |    1 +
 .../features/core/eBPF-JIT/arch-support.txt        |    2 +-
 .../features/debug/KASAN/arch-support.txt          |    6 +-
 .../debug/gcov-profile-all/arch-support.txt        |    2 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |    2 +-
 .../features/debug/kprobes/arch-support.txt        |    4 +-
 .../features/debug/kretprobes/arch-support.txt     |    2 +-
 .../features/debug/stackprotector/arch-support.txt |    2 +-
 .../features/debug/uprobes/arch-support.txt        |    2 +-
 .../features/io/dma-contiguous/arch-support.txt    |    2 +-
 .../features/locking/lockdep/arch-support.txt      |    2 +-
 .../features/perf/kprobes-event/arch-support.txt   |    4 +-
 .../features/perf/perf-regs/arch-support.txt       |    4 +-
 .../features/perf/perf-stackdump/arch-support.txt  |    4 +-
 .../seccomp/seccomp-filter/arch-support.txt        |    2 +-
 .../features/vm/huge-vmap/arch-support.txt         |    2 +-
 .../features/vm/pte_special/arch-support.txt       |    2 +-
 Documentation/filesystems/9p.rst                   |    2 +-
 ...automount-support.txt => automount-support.rst} |   23 +-
 .../caching/{backend-api.txt => backend-api.rst}   |  165 +-
 .../caching/{cachefiles.txt => cachefiles.rst}     |  139 +-
 Documentation/filesystems/caching/fscache.rst      |  565 +++++++
 Documentation/filesystems/caching/fscache.txt      |  448 ------
 Documentation/filesystems/caching/index.rst        |   14 +
 .../caching/{netfs-api.txt => netfs-api.rst}       |  172 +-
 .../filesystems/caching/{object.txt => object.rst} |   43 +-
 .../caching/{operations.txt => operations.rst}     |   45 +-
 .../cifs/{cifsroot.txt => cifsroot.rst}            |   56 +-
 Documentation/filesystems/coda.rst                 | 1670 +++++++++++++++++++
 Documentation/filesystems/coda.txt                 | 1676 --------------------
 .../{configfs/configfs.txt => configfs.rst}        |  131 +-
 Documentation/filesystems/dax.txt                  |    2 +-
 Documentation/filesystems/debugfs.rst              |    5 +-
 Documentation/filesystems/devpts.rst               |   36 +
 Documentation/filesystems/devpts.txt               |   26 -
 .../filesystems/{dnotify.txt => dnotify.rst}       |   13 +-
 Documentation/filesystems/efivarfs.rst             |   17 +
 .../filesystems/{fiemap.txt => fiemap.rst}         |  135 +-
 Documentation/filesystems/{files.txt => files.rst} |   15 +-
 .../filesystems/{fuse-io.txt => fuse-io.rst}       |    6 +
 Documentation/filesystems/index.rst                |   23 +
 Documentation/filesystems/{locks.txt => locks.rst} |   14 +-
 ...mandatory-locking.txt => mandatory-locking.rst} |   25 +-
 .../filesystems/{mount_api.txt => mount_api.rst}   |  329 ++--
 Documentation/filesystems/orangefs.rst             |    4 +-
 Documentation/filesystems/proc.rst                 |    2 +-
 Documentation/filesystems/{quota.txt => quota.rst} |   41 +-
 .../filesystems/ramfs-rootfs-initramfs.rst         |    2 +-
 .../filesystems/{seq_file.txt => seq_file.rst}     |   61 +-
 .../{sharedsubtree.txt => sharedsubtree.rst}       |  398 +++--
 Documentation/filesystems/spufs/index.rst          |   13 +
 Documentation/filesystems/spufs/spu_create.rst     |  131 ++
 Documentation/filesystems/spufs/spu_run.rst        |  138 ++
 .../filesystems/{spufs.txt => spufs/spufs.rst}     |  304 +---
 .../filesystems/{sysfs-pci.txt => sysfs-pci.rst}   |   23 +-
 .../{sysfs-tagging.txt => sysfs-tagging.rst}       |   22 +-
 Documentation/filesystems/sysfs.rst                |    2 +-
 ...g-design.txt => xfs-delayed-logging-design.rst} |   65 +-
 ...tadata.txt => xfs-self-describing-metadata.rst} |  190 +--
 Documentation/i2c/{i2c.svg => i2c_bus.svg}         |    2 +-
 Documentation/i2c/summary.rst                      |    2 +-
 Documentation/ia64/irq-redir.rst                   |    2 +-
 Documentation/iio/iio_configfs.rst                 |    2 +-
 .../futex-requeue-pi.rst}                          |    0
 .../{hwspinlock.txt => locking/hwspinlock.rst}     |    0
 Documentation/locking/index.rst                    |    7 +
 Documentation/locking/locktorture.rst              |    2 +-
 .../percpu-rw-semaphore.rst}                       |    0
 .../{pi-futex.txt => locking/pi-futex.rst}         |    0
 .../preempt-locking.rst}                           |    0
 .../robust-futex-ABI.rst}                          |    0
 .../robust-futexes.rst}                            |    0
 Documentation/locking/rt-mutex.rst                 |    2 +-
 .../maintainer/maintainer-entry-profile.rst        |   12 +-
 Documentation/memory-barriers.txt                  |    2 +-
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/networking/scaling.rst               |    4 +-
 Documentation/nvdimm/maintainer-entry-profile.rst  |   14 +-
 Documentation/powerpc/cxl.rst                      |    2 +
 Documentation/powerpc/firmware-assisted-dump.rst   |    2 +-
 Documentation/process/adding-syscalls.rst          |    2 +-
 Documentation/process/index.rst                    |    1 +
 Documentation/process/submit-checklist.rst         |    2 +-
 .../unaligned-memory-access.rst}                   |    0
 Documentation/s390/vfio-ap.rst                     |    2 +-
 Documentation/scheduler/sched-domains.rst          |   10 +-
 Documentation/{digsig.txt => security/digsig.rst}  |    0
 Documentation/security/index.rst                   |    1 +
 Documentation/security/lsm.rst                     |  202 +--
 Documentation/sphinx/requirements.txt              |    2 +-
 Documentation/trace/coresight/coresight-ect.rst    |    1 +
 Documentation/trace/events.rst                     |   28 +-
 .../translations/it_IT/doc-guide/kernel-doc.rst    |   25 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |   18 +
 .../translations/it_IT/kernel-hacking/locking.rst  |  172 +-
 .../translations/it_IT/process/2.Process.rst       |   95 +-
 .../translations/it_IT/process/adding-syscalls.rst |    2 +-
 .../translations/it_IT/process/coding-style.rst    |    6 +-
 .../translations/it_IT/process/deprecated.rst      |  130 +-
 .../translations/it_IT/process/email-clients.rst   |  332 +++-
 Documentation/translations/it_IT/process/index.rst |    1 +
 .../it_IT/process/management-style.rst             |  293 +++-
 .../it_IT/process/submit-checklist.rst             |    2 +-
 .../translations/it_IT/riscv/patch-acceptance.rst  |   40 +
 .../translations/ko_KR/memory-barriers.txt         |    2 +-
 Documentation/translations/zh_CN/IRQ.txt           |    4 +-
 .../translations/zh_CN/filesystems/debugfs.rst     |  221 +++
 .../translations/zh_CN/filesystems/index.rst       |    1 +
 .../translations/zh_CN/filesystems/sysfs.txt       |    8 +-
 .../zh_CN/process/submit-checklist.rst             |    2 +-
 .../zh_CN/video4linux/v4l2-framework.txt           |    2 +-
 Documentation/usb/gadget_configfs.rst              |    4 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/virt/kvm/amd-memory-encryption.rst   |    2 +-
 Documentation/virt/kvm/api.rst                     |   12 +-
 Documentation/virt/kvm/arm/pvtime.rst              |    2 +-
 Documentation/virt/kvm/devices/vcpu.rst            |    2 +-
 Documentation/virt/kvm/hypercalls.rst              |    4 +-
 Documentation/virt/kvm/mmu.rst                     |    2 +-
 Documentation/virt/kvm/review-checklist.rst        |    2 +-
 Documentation/vm/index.rst                         |    1 +
 Documentation/vm/page_frags.rst                    |    2 +-
 Documentation/vm/zswap.rst                         |    4 +-
 .../watchdog/convert_drivers_to_kernel_api.rst     |    4 +-
 Documentation/watchdog/watchdog-kernel-api.rst     |    2 +-
 Documentation/x86/x86_64/uefi.rst                  |    2 +-
 MAINTAINERS                                        |   35 +-
 arch/powerpc/include/uapi/asm/kvm_para.h           |    2 +-
 arch/x86/kvm/mmu/mmu.c                             |    2 +-
 drivers/ata/libata-core.c                          |    2 +-
 drivers/base/core.c                                |    2 +-
 drivers/base/platform.c                            |    6 +-
 drivers/char/ipmi/Kconfig                          |    2 +-
 drivers/char/ipmi/ipmi_si_hotmod.c                 |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |    2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |    2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |    2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |    2 +-
 drivers/gpu/drm/Kconfig                            |    2 +-
 drivers/gpu/drm/drm_ioctl.c                        |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |    2 +-
 drivers/hwtracing/coresight/Kconfig                |    2 +-
 drivers/iio/dac/ad5761.c                           |    4 +-
 drivers/iio/dac/ti-dac7612.c                       |    4 +-
 drivers/leds/leds-pca963x.c                        |    2 +-
 drivers/media/i2c/imx214.c                         |    4 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |    2 +-
 fs/Kconfig                                         |    2 +-
 fs/Kconfig.binfmt                                  |    2 +-
 fs/adfs/Kconfig                                    |    2 +-
 fs/affs/Kconfig                                    |    2 +-
 fs/afs/Kconfig                                     |    6 +-
 fs/bfs/Kconfig                                     |    2 +-
 fs/cachefiles/Kconfig                              |    4 +-
 fs/coda/Kconfig                                    |    2 +-
 fs/configfs/inode.c                                |    2 +-
 fs/configfs/item.c                                 |    2 +-
 fs/cramfs/Kconfig                                  |    2 +-
 fs/ecryptfs/Kconfig                                |    2 +-
 fs/fat/Kconfig                                     |    8 +-
 fs/fscache/Kconfig                                 |    8 +-
 fs/fscache/cache.c                                 |    8 +-
 fs/fscache/cookie.c                                |    2 +-
 fs/fscache/object.c                                |    4 +-
 fs/fscache/operation.c                             |    2 +-
 fs/fuse/Kconfig                                    |    2 +-
 fs/fuse/dev.c                                      |    2 +-
 fs/hfs/Kconfig                                     |    2 +-
 fs/hpfs/Kconfig                                    |    2 +-
 fs/inode.c                                         |    6 +-
 fs/isofs/Kconfig                                   |    2 +-
 fs/locks.c                                         |    2 +-
 fs/namespace.c                                     |    2 +-
 fs/notify/inotify/Kconfig                          |    2 +-
 fs/ntfs/Kconfig                                    |    2 +-
 fs/ocfs2/Kconfig                                   |    2 +-
 fs/overlayfs/Kconfig                               |    6 +-
 fs/proc/Kconfig                                    |    4 +-
 fs/romfs/Kconfig                                   |    2 +-
 fs/sysfs/dir.c                                     |    2 +-
 fs/sysfs/file.c                                    |    2 +-
 fs/sysfs/mount.c                                   |    2 +-
 fs/sysfs/symlink.c                                 |    2 +-
 fs/sysv/Kconfig                                    |    2 +-
 fs/udf/Kconfig                                     |    2 +-
 include/linux/configfs.h                           |    2 +-
 include/linux/fs_context.h                         |    2 +-
 include/linux/fscache-cache.h                      |    4 +-
 include/linux/fscache.h                            |   42 +-
 include/linux/kobject.h                            |    2 +-
 include/linux/kobject_ns.h                         |    2 +-
 include/linux/lsm_hooks.h                          |    2 +-
 include/linux/mm.h                                 |    4 +-
 include/linux/platform_data/ad5761.h               |    2 +-
 include/linux/printk.h                             |  112 +-
 include/linux/rbtree.h                             |    2 +-
 include/linux/rbtree_augmented.h                   |    2 +-
 include/linux/relay.h                              |    2 +-
 include/linux/spi/spi.h                            |    1 +
 include/linux/sysfs.h                              |    2 +-
 include/linux/watchdog.h                           |    4 +-
 include/uapi/linux/ethtool_netlink.h               |    2 +-
 include/uapi/linux/firewire-cdev.h                 |    2 +-
 include/uapi/linux/kvm.h                           |    4 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h           |    2 +-
 kernel/futex.c                                     |    3 +
 kernel/relay.c                                     |    2 +-
 lib/Kconfig                                        |    2 +-
 lib/Kconfig.debug                                  |    2 +-
 lib/bitmap.c                                       |   31 +-
 lib/kobject.c                                      |    4 +-
 mm/gup.c                                           |   12 +-
 samples/Kconfig                                    |    2 +-
 samples/binderfs/Makefile                          |    6 +-
 scripts/kernel-doc                                 |   41 +-
 scripts/sphinx-pre-install                         |  291 +++-
 tools/include/linux/rbtree.h                       |    2 +-
 tools/include/linux/rbtree_augmented.h             |    2 +-
 tools/include/uapi/linux/kvm.h                     |    4 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c                   |    2 +-
 virt/kvm/arm/vgic/vgic.h                           |    4 +-
 271 files changed, 6311 insertions(+), 4340 deletions(-)
 rename Documentation/{debugging-via-ohci1394.txt => core-api/debugging-via-ohci1394.rst} (100%)
 rename Documentation/{DMA-API-HOWTO.txt => core-api/dma-api-howto.rst} (100%)
 rename Documentation/{DMA-API.txt => core-api/dma-api.rst} (100%)
 rename Documentation/{DMA-attributes.txt => core-api/dma-attributes.rst} (100%)
 rename Documentation/{DMA-ISA-LPC.txt => core-api/dma-isa-lpc.rst} (100%)
 rename Documentation/{IRQ.txt => core-api/irq/concepts.rst} (100%)
 create mode 100644 Documentation/core-api/irq/index.rst
 rename Documentation/{IRQ-affinity.txt => core-api/irq/irq-affinity.rst} (100%)
 rename Documentation/{IRQ-domain.txt => core-api/irq/irq-domain.rst} (99%)
 rename Documentation/{irqflags-tracing.txt => core-api/irq/irqflags-tracing.rst} (100%)
 rename Documentation/{kref.txt => core-api/kref.rst} (100%)
 create mode 100644 Documentation/core-api/printk-basics.rst
 rename Documentation/{rbtree.txt => core-api/rbtree.rst} (100%)
 rename Documentation/{IPMI.txt => driver-api/ipmi.rst} (100%)
 rename Documentation/filesystems/{automount-support.txt => automount-support.rst} (92%)
 rename Documentation/filesystems/caching/{backend-api.txt => backend-api.rst} (87%)
 rename Documentation/filesystems/caching/{cachefiles.txt => cachefiles.rst} (90%)
 create mode 100644 Documentation/filesystems/caching/fscache.rst
 delete mode 100644 Documentation/filesystems/caching/fscache.txt
 create mode 100644 Documentation/filesystems/caching/index.rst
 rename Documentation/filesystems/caching/{netfs-api.txt => netfs-api.rst} (91%)
 rename Documentation/filesystems/caching/{object.txt => object.rst} (95%)
 rename Documentation/filesystems/caching/{operations.txt => operations.rst} (90%)
 rename Documentation/filesystems/cifs/{cifsroot.txt => cifsroot.rst} (72%)
 create mode 100644 Documentation/filesystems/coda.rst
 delete mode 100644 Documentation/filesystems/coda.txt
 rename Documentation/filesystems/{configfs/configfs.txt => configfs.rst} (87%)
 create mode 100644 Documentation/filesystems/devpts.rst
 delete mode 100644 Documentation/filesystems/devpts.txt
 rename Documentation/filesystems/{dnotify.txt => dnotify.rst} (88%)
 rename Documentation/filesystems/{fiemap.txt => fiemap.rst} (70%)
 rename Documentation/filesystems/{files.txt => files.rst} (95%)
 rename Documentation/filesystems/{fuse-io.txt => fuse-io.rst} (95%)
 rename Documentation/filesystems/{locks.txt => locks.rst} (91%)
 rename Documentation/filesystems/{mandatory-locking.txt => mandatory-locking.rst} (91%)
 rename Documentation/filesystems/{mount_api.txt => mount_api.rst} (79%)
 rename Documentation/filesystems/{quota.txt => quota.rst} (81%)
 rename Documentation/filesystems/{seq_file.txt => seq_file.rst} (92%)
 rename Documentation/filesystems/{sharedsubtree.txt => sharedsubtree.rst} (72%)
 create mode 100644 Documentation/filesystems/spufs/index.rst
 create mode 100644 Documentation/filesystems/spufs/spu_create.rst
 create mode 100644 Documentation/filesystems/spufs/spu_run.rst
 rename Documentation/filesystems/{spufs.txt => spufs/spufs.rst} (57%)
 rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (92%)
 rename Documentation/filesystems/{sysfs-tagging.txt => sysfs-tagging.rst} (72%)
 rename Documentation/filesystems/{xfs-delayed-logging-design.txt => xfs-delayed-logging-design.rst} (97%)
 rename Documentation/filesystems/{xfs-self-describing-metadata.txt => xfs-self-describing-metadata.rst} (83%)
 rename Documentation/i2c/{i2c.svg => i2c_bus.svg} (99%)
 rename Documentation/{futex-requeue-pi.txt => locking/futex-requeue-pi.rst} (100%)
 rename Documentation/{hwspinlock.txt => locking/hwspinlock.rst} (100%)
 rename Documentation/{percpu-rw-semaphore.txt => locking/percpu-rw-semaphore.rst} (100%)
 rename Documentation/{pi-futex.txt => locking/pi-futex.rst} (100%)
 rename Documentation/{preempt-locking.txt => locking/preempt-locking.rst} (100%)
 rename Documentation/{robust-futex-ABI.txt => locking/robust-futex-ABI.rst} (100%)
 rename Documentation/{robust-futexes.txt => locking/robust-futexes.rst} (100%)
 rename Documentation/{unaligned-memory-access.txt => process/unaligned-memory-access.rst} (100%)
 rename Documentation/{digsig.txt => security/digsig.rst} (100%)
 create mode 100644 Documentation/translations/it_IT/riscv/patch-acceptance.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/debugfs.rst
