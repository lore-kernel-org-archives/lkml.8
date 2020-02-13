Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8292C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867BA20714
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgBMBEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:04:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:16308 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgBMBEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:04:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 17:04:23 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="406480973"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 17:04:22 -0800
Subject: [PATCH v2 0/4] libnvdimm: Cross-arch compatible namespace alignment
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Feb 2020 16:48:18 -0800
Message-ID: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:

- Fix build errors with the PowerPC override for memremap_compat_align()

- Move the memremap_compat_align() override definition to
  arch/powerpc/mm/ioremap.c (Aneesh)

[1]: http://lore.kernel.org/r/158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com

---

Explicit review requests, but any other feedback is of course
appreciated:

Patch1 needs an ack from ppc arch maintainers, and I'd like a tested-by
from Aneesh that this still works to solve the ppc issue. Jeff, does
this look good to you?

---

Aneesh reports that PowerPC requires 16MiB alignment for the address
range passed to devm_memremap_pages(), and Jeff reports that it is
possible to create a misaligned namespace which blocks future namespace
creation in that region. Both of these issues require namespace
alignment to be managed at the region level rather than padding at the
namespace level which has been a broken approach to date.

Introduce memremap_compat_align() to indicate the hard requirements of
an arch's memremap_pages() implementation. Use the maximum known
memremap_compat_align() to set the default namespace alignment for
libnvdimm. Consult that alignment when allocating free space. Finally,
allow the default region alignment to be overridden to maintain the same
namespace creation capability as previous kernels.

The ndctl unit tests, which have some misaligned namespace assumptions,
are updated to use the alignment override where necessary.

Thanks to Aneesh for early feedback and testing on this improved
alignment handling.

---

Dan Williams (4):
      mm/memremap_pages: Introduce memremap_compat_align()
      libnvdimm/namespace: Enforce memremap_compat_align()
      libnvdimm/region: Introduce NDD_LABELING
      libnvdimm/region: Introduce an 'align' attribute


 arch/powerpc/Kconfig                      |    1 
 arch/powerpc/mm/ioremap.c                 |   12 +++
 arch/powerpc/platforms/pseries/papr_scm.c |    2 
 drivers/acpi/nfit/core.c                  |    4 +
 drivers/nvdimm/dimm.c                     |    2 
 drivers/nvdimm/dimm_devs.c                |   95 +++++++++++++++++----
 drivers/nvdimm/namespace_devs.c           |   21 ++++-
 drivers/nvdimm/nd.h                       |    3 -
 drivers/nvdimm/pfn_devs.c                 |    2 
 drivers/nvdimm/region_devs.c              |  132 ++++++++++++++++++++++++++---
 include/linux/libnvdimm.h                 |    2 
 include/linux/memremap.h                  |    8 ++
 include/linux/mmzone.h                    |    1 
 lib/Kconfig                               |    3 +
 mm/memremap.c                             |   13 +++
 15 files changed, 260 insertions(+), 41 deletions(-)

--

base-commit: 543506a2936aaced94bcc8731aae5d29d0442e90
