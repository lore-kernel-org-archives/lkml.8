Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7C52074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dbeS0MN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgDGUMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:12:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44298 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:12:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id i16so5645190edy.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ERdwo2RxKpDOK4p9sBgyD8EfDBQBiS1CeSk+4MbDuLo=;
        b=dbeS0MN9/EJQ3fggNXC1nK1uUYt10iU0apLVSEH2lCPObt7pASULUCRj1TKvWesF9I
         tXowpOaEr7WftjnKcNnCIB4CFb1nfq7F3xpZt25V0Ai46x3gA/vRVIatVe8OuIg2Rs9/
         kKGfqNxma3TP9sieXrLFktsbze97WTHdrk8gT1f58sPQYUTSReqS0aVL8y5OFkgTYO6J
         rNV9QVhFpR1ce36cDiGUVpLp2R+I1+ZU0fGC9Ydesw1/AfNOL1mj9MlqvO8VFjRyPs0+
         GMxNsQjRb2MDD6A81K6aw1NT1dowuIFjVNFzFcrmsAzJ54gd/IiDtwtMJQofT/YumJtg
         LETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ERdwo2RxKpDOK4p9sBgyD8EfDBQBiS1CeSk+4MbDuLo=;
        b=aRvQtLvfrfCYXlwYGvoSGuW/z5kuUJmAmENMK6Rl8khkLAJJBUSDHRHI14zgQq7u6y
         DtrzbdX5fB5KacITxBamoWoDkXI8uqVSt0hIwSgHrVYsEUGF9jsT0UYJwadRfXAm6yPV
         FjjJd4eMtfs7/QhrVVXfGUnEvWt1d+bD0IsAiVWTp9In5SBMq4HGsF16p83/YAzvGUmI
         NL86LzlQKS71aQm5HmpDbAWmDhy5JWaukBlieoKJ4VOyTqPbDiekApbyLPB6LtDQbZk2
         yhovY1FC5QVByOk0cIWpyZwG/7qRT0DVxce2Djx1BQIZ71khjxzazWMBqEY80jMqgAfV
         ublg==
X-Gm-Message-State: AGi0PuZIt63YVSoI2XgMxgKIM5pmQZKnD0/HKpvewz/tyWPGJZlJ+vHg
        dhJYTsrb72eewcFp9VzvLJY14dR7M0+QNSGcPImaPbN/5X4=
X-Google-Smtp-Source: APiQypLqMHbkAGx/soX1aAJZjS9L9/SvTpTczi6DQRJcOKfWMPKuekU/GfNR+TM93ozNNo+VwLWJ/pK9ZkYy174pSrA=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr3493057edq.93.1586290372385;
 Tue, 07 Apr 2020 13:12:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Apr 2020 13:12:41 -0700
Message-ID: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.7

...to receive the libnvdimm and dax update for this cycle. There were
multiple touches outside of drivers/nvdimm/ this round to add cross
arch compatibility to the devm_memremap_pages() interface, enhance
numa information for persistent memory ranges, and add a
zero_page_range() dax operation. This cycle I switched from the
patchwork api to Konstantin's b4 script for collecting tags (from x86,
PowerPC, filesystem, and device-mapper folks), and everything looks to
have gone ok there. This has all appeared in -next with no reported
issues.

Given the current environment where one might need to step away on
short notice I thought it would be a good idea to highlight to you and
others a backup maintainer for libnvdimm. Vishal, has agreed to step
in if circumstances make me non-responsive for multiple days. Not
expecting anything, just being proactive.

---

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.7

for you to fetch changes up to f6d2b802f80d0ca89ee1f51c1781b3f79cdb25d5:

  Merge branch 'for-5.7/libnvdimm' into libnvdimm-for-next (2020-04-02
19:55:17 -0700)

----------------------------------------------------------------
libnvdimm for 5.7

- Add support for region alignment configuration and enforcement to
  fix compatibility across architectures and PowerPC page size
  configurations.

- Introduce 'zero_page_range' as a dax operation. This facilitates
  filesystem-dax operation without a block-device.

- Introduce phys_to_target_node() to facilitate drivers that want to
  know resulting numa node if a given reserved address range was
  onlined.

- Advertise a persistence-domain for of_pmem and papr_scm. The
  persistence domain indicates where cpu-store cycles need to reach in
  the platform-memory subsystem before the platform will consider them
  power-fail protected.

- Promote numa_map_to_online_node() to a cross-kernel generic facility.

- Save x86 numa information to allow for node-id lookups for reserved
  memory ranges, deploy that capability for the e820-pmem driver.

- Pick up some miscellaneous minor fixes, that missed v5.6-final,
  including a some smatch reports in the ioctl path and some unit test
  compilation fixups.

- Fixup some flexible-array declarations.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      libnvdimm: Update persistence domain value for of_pmem and papr_scm device

Dan Carpenter (2):
      acpi/nfit: improve bounds checking for 'func'
      libnvdimm: Out of bounds read in __nd_ioctl()

Dan Williams (15):
      ACPI: NUMA: Up-level "map to online node" functionality
      mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
      powerpc/papr_scm: Switch to numa_map_to_online_node()
      x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
      x86/NUMA: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info
      mm/memremap_pages: Kill unused __devm_memremap_pages()
      mm/memremap_pages: Introduce memremap_compat_align()
      libnvdimm/pfn: Prevent raw mode fallback if pfn-infoblock valid
      libnvdimm/namespace: Enforce memremap_compat_align()
      libnvdimm/region: Introduce NDD_LABELING
      libnvdimm/region: Introduce an 'align' attribute
      Merge branch 'for-5.6/libnvdimm-fixes' into libnvdimm-for-next
      Merge branch 'for-5.7/numa' into libnvdimm-for-next
      Merge branch 'for-5.7/libnvdimm' into libnvdimm-for-next

Gustavo A. R. Silva (3):
      ACPI: NFIT: Replace zero-length array with flexible-array member
      libnvdimm/label: Replace zero-length array with flexible-array member
      libnvdimm/region: Replace zero-length array with flexible-array member

Jan Kara (1):
      tools/testing/nvdimm: Fix compilation failure without
CONFIG_DEV_DAX_PMEM_COMPAT

Lukas Bulwahn (1):
      MAINTAINERS: clarify maintenance of nvdimm testing tool

Santosh Sivaraj (1):
      tools/test/nvdimm: Fix out of tree build

Vivek Goyal (7):
      pmem: Add functions for reading/writing page to/from pmem
      dax, pmem: Add a dax operation zero_page_range
      s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
      dm,dax: Add dax zero_page_range operation
      dax: Use new dax zero page method for zeroing a page
      dax,iomap: Add helper dax_iomap_zero() to zero a range
      dax: Move mandatory ->zero_page_range() check in alloc_dax()

YueHaibing (1):
      libnvdimm/region: Fix build error

 MAINTAINERS                               |   1 +
 arch/powerpc/Kconfig                      |   1 +
 arch/powerpc/mm/ioremap.c                 |  21 +++++
 arch/powerpc/platforms/pseries/papr_scm.c |  27 ++-----
 arch/x86/Kconfig                          |   1 +
 arch/x86/mm/numa.c                        |  67 +++++++++++----
 drivers/acpi/nfit/core.c                  |  14 ++--
 drivers/acpi/nfit/nfit.h                  |  13 +--
 drivers/acpi/numa/srat.c                  |  41 ----------
 drivers/dax/bus.c                         |   4 +-
 drivers/dax/super.c                       |  28 ++++++-
 drivers/md/dm-linear.c                    |  18 +++++
 drivers/md/dm-log-writes.c                |  17 ++++
 drivers/md/dm-stripe.c                    |  23 ++++++
 drivers/md/dm.c                           |  32 +++++++-
 drivers/nvdimm/bus.c                      |   6 +-
 drivers/nvdimm/dimm.c                     |   2 +-
 drivers/nvdimm/dimm_devs.c                |  95 +++++++++++++++++-----
 drivers/nvdimm/e820.c                     |  18 +----
 drivers/nvdimm/label.h                    |   2 +-
 drivers/nvdimm/namespace_devs.c           |  28 ++++++-
 drivers/nvdimm/nd.h                       |   7 +-
 drivers/nvdimm/of_pmem.c                  |   4 +-
 drivers/nvdimm/pfn.h                      |  12 +++
 drivers/nvdimm/pfn_devs.c                 |  40 +++++++--
 drivers/nvdimm/pmem.c                     | 101 ++++++++++++++---------
 drivers/nvdimm/region_devs.c              | 130 ++++++++++++++++++++++++++----
 drivers/s390/block/dcssblk.c              |  20 ++++-
 fs/dax.c                                  |  59 ++++++--------
 fs/iomap/buffered-io.c                    |   9 +--
 include/linux/acpi.h                      |  23 +++++-
 include/linux/dax.h                       |  21 ++---
 include/linux/device-mapper.h             |   3 +
 include/linux/io.h                        |   2 -
 include/linux/libnvdimm.h                 |   2 +
 include/linux/memremap.h                  |   8 ++
 include/linux/mmzone.h                    |   1 +
 include/linux/numa.h                      |  30 ++++++-
 lib/Kconfig                               |   3 +
 mm/Kconfig                                |   5 ++
 mm/mempolicy.c                            |  26 ++++++
 mm/memremap.c                             |  23 ++++++
 tools/testing/nvdimm/Kbuild               |   4 +-
 tools/testing/nvdimm/test/Kbuild          |   4 +-
 tools/testing/nvdimm/test/nfit.c          |   2 +
 45 files changed, 737 insertions(+), 261 deletions(-)
