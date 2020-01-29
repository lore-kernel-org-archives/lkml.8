Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BCC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23FB2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgA2QQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:16:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:50192 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgA2QQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:16:31 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 38032490;
        Wed, 29 Jan 2020 16:16:30 +0000 (UTC)
Date:   Wed, 29 Jan 2020 09:16:28 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.6
Message-ID: <20200129091628.0204a966@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.6

for you to fetch changes up to 77ce1a47ebca88bf1eb3018855fc1709c7a1ed86:

  docs: filesystems: add overlayfs to index.rst (2020-01-28 13:41:57 -0700)

----------------------------------------------------------------
It has been a relatively quiet cycle for documentation, but there's still a
couple of things of note:

 - Conversion of the NFS documentation to RST

 - A new document on how to help with documentation (and a maintainer
   profile entry too)

Plus the usual collection of typo fixes, etc.

----------------------------------------------------------------
Alex Shi (3):
      docs/zh_CN: add Chinese version of embargoed hardware issues
      docs/zh_CN: translate kernel driver statement into Chinese
      docs/zh_CN: translate kernel enforcement statement

Atish Patra (1):
      RISC-V: Typo fixes in image header and documentation.

Colin Ian King (1):
      devices.txt: fix spelling mistake: "shapshot" -> "snapshot"

Daniel W. S. Almeida (11):
      Documentation: boot.rst: fix warnings
      Documentation: filesystems: convert vfat.txt to RST
      Documentation: convert nfs.txt to ReST
      Documentation: nfsroot.txt: convert to ReST
      Documentation: nfsroot.rst: COSMETIC: refill a paragraph
      Documentation: nfs-rdma: convert to ReST
      Documentation: convert nfsd-admin-interfaces to ReST
      Documentation: nfs: idmapper: convert to ReST
      Documentation: nfs: convert pnfs-block-server to ReST
      Documentation: nfs: pnfs-scsi-server: convert to ReST
      Documentation: nfs: fault_injection: convert to ReST

Federico Vaga (1):
      doc:locking: fix locktorture parameter description

Frank A. Cancio Bello (4):
      docs: ftrace: Specifies when buffers get clear
      docs: ftrace: Clarify the RAM impact of buffer_size_kb
      docs: ftrace: Fix typos
      docs: ftrace: Fix small notation mistake

Geert Uytterhoeven (1):
      scripts/find-unused-docs: Fix massive false positives

Guoqing Jiang (1):
      docs: block/biovecs: update the location of bio.c

Jonathan Corbet (4):
      Merge branch 'nfs' into docs-next
      docs: Keep up with the location of NoUri
      Add a document on how to contribute to the documentation
      Add a maintainer entry profile for documentation

Konstantin Ryabitsev (1):
      Process: provide hardware-security list details

Lukas Bulwahn (1):
      docs: nvdimm: use ReST notation for subsection

Madhuparna Bhowmik (2):
      Documentation: filesystems: automount-support: Change reference to document autofs.txt to autofs.rst
      Documentation: kernel-hacking: hacking.rst: Change reference to document namespaces.rst to symbol-namespaces.rst

Masanari Iida (2):
      Doc: x86: Fix a typo in mm.rst
      docs: w1: Fix a typo in omap-hdq.rst

Mauro Carvalho Chehab (2):
      docs: usb: remove some broken references
      docs: filesystems: add overlayfs to index.rst

Randy Dunlap (3):
      Documentation: x86: fix boot.rst warning and format
      Documentation: fix Sphinx warning in xilinx_sdfec.rst
      Documentation: zram: various fixes in zram.rst

SeongJae Park (1):
      docs/memory-barriers.txt.kokr: Minor wordsmith

Will Deacon (1):
      Documentation: Call out example SYM_FUNC_* usage as x86-specific

Yue Hu (1):
      zram: correct documentation about sysfs node of huge page writeback

 Documentation/admin-guide/blockdev/zram.rst        |  63 ++--
 Documentation/admin-guide/devices.txt              |   2 +-
 Documentation/admin-guide/index.rst                |   1 +
 .../nfs/fault_injection.rst}                       |   5 +-
 Documentation/admin-guide/nfs/index.rst            |  15 +
 .../nfs/nfs.txt => admin-guide/nfs/nfs-client.rst} |  85 ++---
 .../nfs/nfs-idmapper.rst}                          |  31 +-
 Documentation/admin-guide/nfs/nfs-rdma.rst         | 292 ++++++++++++++++
 .../nfs/nfsd-admin-interfaces.rst}                 |  19 +-
 .../nfsroot.txt => admin-guide/nfs/nfsroot.rst}    | 151 ++++----
 .../nfs/pnfs-block-server.rst}                     |  25 +-
 .../nfs/pnfs-scsi-server.rst}                      |   1 +
 Documentation/asm-annotations.rst                  |   9 +-
 Documentation/block/biovecs.rst                    |   2 +-
 Documentation/doc-guide/contributing.rst           | 294 ++++++++++++++++
 Documentation/doc-guide/index.rst                  |   2 +
 Documentation/doc-guide/maintainer-profile.rst     |  44 +++
 Documentation/filesystems/automount-support.txt    |   2 +-
 Documentation/filesystems/index.rst                |   2 +
 Documentation/filesystems/nfs/nfs-rdma.txt         | 274 ---------------
 Documentation/filesystems/vfat.rst                 | 387 +++++++++++++++++++++
 Documentation/filesystems/vfat.txt                 | 347 ------------------
 Documentation/kernel-hacking/hacking.rst           |   4 +-
 Documentation/locking/locktorture.rst              |   3 +-
 .../maintainer/maintainer-entry-profile.rst        |   1 +
 Documentation/misc-devices/xilinx_sdfec.rst        |   1 +
 Documentation/nvdimm/maintainer-entry-profile.rst  |   3 +-
 .../process/embargoed-hardware-issues.rst          |  25 +-
 Documentation/riscv/boot-image-header.rst          |   4 +-
 Documentation/sphinx/automarkup.py                 |   7 +-
 Documentation/trace/ftrace.rst                     |  18 +-
 Documentation/trace/ring-buffer-design.txt         |   2 +-
 .../translations/ko_KR/memory-barriers.txt         |   4 +-
 .../zh_CN/process/embargoed-hardware-issues.rst    | 228 ++++++++++++
 Documentation/translations/zh_CN/process/index.rst |   3 +
 .../zh_CN/process/kernel-driver-statement.rst      | 199 +++++++++++
 .../zh_CN/process/kernel-enforcement-statement.rst | 151 ++++++++
 Documentation/usb/index.rst                        |   2 -
 Documentation/usb/text_files.rst                   |   6 -
 Documentation/w1/masters/omap-hdq.rst              |   2 +-
 Documentation/x86/boot.rst                         |  45 +--
 Documentation/x86/x86_64/mm.rst                    |   6 +-
 MAINTAINERS                                        |   2 +-
 arch/riscv/include/asm/image.h                     |   4 +-
 scripts/find-unused-docs.sh                        |   2 +-
 45 files changed, 1904 insertions(+), 871 deletions(-)
 rename Documentation/{filesystems/nfs/fault_injection.txt => admin-guide/nfs/fault_injection.rst} (98%)
 create mode 100644 Documentation/admin-guide/nfs/index.rst
 rename Documentation/{filesystems/nfs/nfs.txt => admin-guide/nfs/nfs-client.rst} (75%)
 rename Documentation/{filesystems/nfs/idmapper.txt => admin-guide/nfs/nfs-idmapper.rst} (81%)
 create mode 100644 Documentation/admin-guide/nfs/nfs-rdma.rst
 rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)
 rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (80%)
 rename Documentation/{filesystems/nfs/pnfs-block-server.txt => admin-guide/nfs/pnfs-block-server.rst} (80%)
 rename Documentation/{filesystems/nfs/pnfs-scsi-server.txt => admin-guide/nfs/pnfs-scsi-server.rst} (97%)
 create mode 100644 Documentation/doc-guide/contributing.rst
 create mode 100644 Documentation/doc-guide/maintainer-profile.rst
 delete mode 100644 Documentation/filesystems/nfs/nfs-rdma.txt
 create mode 100644 Documentation/filesystems/vfat.rst
 delete mode 100644 Documentation/filesystems/vfat.txt
 create mode 100644 Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
 create mode 100644 Documentation/translations/zh_CN/process/kernel-driver-statement.rst
 create mode 100644 Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst
