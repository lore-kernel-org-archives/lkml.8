Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915BAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC220739
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGIBL0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:11:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:8914 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGIBLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:11:25 -0400
IronPort-SDR: 94hMBoD0m+AMZ6mUz0YUTWhvx1/snZLpN9HyBOxRn5RrWduNlX1Ol6Xg+ytbRNDQcLC0QHgUo+
 FR+sTi8F6W7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="127992112"
X-IronPort-AV: E=Sophos;i="5.75,330,1589266800"; 
   d="scan'208";a="127992112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 18:10:54 -0700
IronPort-SDR: V/LDRUR7VdRY695O68h4SRbkp0nfu+PKiZSc936BqdNcz6qsCahAd9SUOlwBaQZ2tEDZGBs5UW
 V0MyXKcXSylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,330,1589266800"; 
   d="scan'208";a="297897450"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2020 18:10:54 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 18:10:54 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 18:10:53 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.43]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.22]) with mapi id 14.03.0439.000;
 Thu, 9 Jul 2020 09:10:50 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     lkp <lkp@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [kbuild-all] Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page
 aligned address
Thread-Topic: [kbuild-all] Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page
 aligned address
Thread-Index: AQHWVGM7alDg6pQwY02mLjQJxnTgwqj+cXsg
Date:   Thu, 9 Jul 2020 01:10:49 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E66249527796C8@shsmsx102.ccr.corp.intel.com>
References: <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <202007072152.EVgFqx18%lkp@intel.com>
In-Reply-To: <202007072152.EVgFqx18%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [kbuild-all] Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned
> address
> 
> Hi Jacob,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on iommu/next]
> [also build test WARNING on linux/master linus/master v5.8-rc4 next-20200707]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/iommu-vt-d-Misc-
> tweaks-and-fixes-for-vSVA/20200707-081026
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: x86_64-randconfig-m031-20200707 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
Kindly ignore this, which is related to [-Wtype-limits], and is under
discussion to move such warning from W=1 to W=2 as it may not
suitable to fix which can hurt code readability.

Refer to https://lore.kernel.org/lkml/CAHk-=wiKCXEWKJ9dWUimGbrVRo_N2RosESUw8E7m9AEtyZcu=w@mail.gmail.com/
for the discussion.


> 
>    In file included from include/linux/string.h:6,
>                     from include/linux/uuid.h:12,
>                     from include/linux/mod_devicetable.h:13,
>                     from include/linux/pci.h:27,
>                     from drivers/iommu/intel/dmar.c:19:
>    drivers/iommu/intel/dmar.c: In function 'qi_flush_dev_iotlb_pasid':
>    include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is
> always false [-Wtype-limits]
>       26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>          |                            ^
>    include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
>       58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) :
> __trace_if_value(cond))
>          |                                                    ^~~~
> >> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |  ^~
>    include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>          |   ^~~~~~~~~~~~~~~~~
>    include/linux/bits.h:45:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
>       45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>          |   ^~~~~~~~~~~~~~~~~~~
>    drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro
> 'GENMASK_ULL'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |             ^~~~~~~~~~~
>    include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is
> always false [-Wtype-limits]
>       26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>          |                                        ^
>    include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
>       58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) :
> __trace_if_value(cond))
>          |                                                    ^~~~
> >> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |  ^~
>    include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>          |   ^~~~~~~~~~~~~~~~~
>    include/linux/bits.h:45:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
>       45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>          |   ^~~~~~~~~~~~~~~~~~~
>    drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro
> 'GENMASK_ULL'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |             ^~~~~~~~~~~
>    include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is
> always false [-Wtype-limits]
>       26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>          |                            ^
>    include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
>       58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) :
> __trace_if_value(cond))
>          |                                                             ^~~~
> >> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |  ^~
>    include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>          |   ^~~~~~~~~~~~~~~~~
>    include/linux/bits.h:45:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
>       45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>          |   ^~~~~~~~~~~~~~~~~~~
>    drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro
> 'GENMASK_ULL'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |             ^~~~~~~~~~~
>    include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is
> always false [-Wtype-limits]
>       26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>          |                                        ^
>    include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
>       58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) :
> __trace_if_value(cond))
>          |                                                             ^~~~
> >> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |  ^~
>    include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>          |   ^~~~~~~~~~~~~~~~~
>    include/linux/bits.h:45:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
>       45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>          |   ^~~~~~~~~~~~~~~~~~~
>    drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro
> 'GENMASK_ULL'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |             ^~~~~~~~~~~
>    include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is
> always false [-Wtype-limits]
>       26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>          |                            ^
>    include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
>       69 |  (cond) ?     \
>          |   ^~~~
>    include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
>       56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>          |                            ^~~~~~~~~~~~~~
> >> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |  ^~
>    include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>          |   ^~~~~~~~~~~~~~~~~
>    include/linux/bits.h:45:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
>       45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>          |   ^~~~~~~~~~~~~~~~~~~
>    drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro
> 'GENMASK_ULL'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |             ^~~~~~~~~~~
>    include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is
> always false [-Wtype-limits]
>       26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>          |                                        ^
>    include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
>       69 |  (cond) ?     \
>          |   ^~~~
>    include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
>       56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>          |                            ^~~~~~~~~~~~~~
> >> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |  ^~
>    include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>          |   ^~~~~~~~~~~~~~~~~
>    include/linux/bits.h:45:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
>       45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>          |   ^~~~~~~~~~~~~~~~~~~
>    drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro
> 'GENMASK_ULL'
>     1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>          |             ^~~~~~~~~~~
> 
> vim +/if +1459 drivers/iommu/intel/dmar.c
> 
>   1438
>   1439	/* PASID-based device IOTLB Invalidate */
>   1440	void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16
> pfsid,
>   1441				      u32 pasid,  u16 qdep, u64 addr, unsigned int
> size_order)
>   1442	{
>   1443		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order -
> 1);
>   1444		struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
>   1445
>   1446		desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> QI_DEV_EIOTLB_SID(sid) |
>   1447			QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>   1448			QI_DEV_IOTLB_PFSID(pfsid);
>   1449
>   1450		/*
>   1451		 * If S bit is 0, we only flush a single page. If S bit is set,
>   1452		 * The least significant zero bit indicates the invalidation address
>   1453		 * range. VT-d spec 6.5.2.6.
>   1454		 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
>   1455		 * size order = 0 is PAGE_SIZE 4KB
>   1456		 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
>   1457		 * ECAP.
>   1458		 */
> > 1459		if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>   1460			pr_warn_ratelimited("Invalidate non-aligned address %llx,
> order %d\n", addr, size_order);
>   1461
>   1462		/* Take page address */
>   1463		desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
>   1464
>   1465		if (size_order) {
>   1466			/*
>   1467			 * Existing 0s in address below size_order may be the
> least
>   1468			 * significant bit, we must set them to 1s to avoid having
>   1469			 * smaller size than desired.
>   1470			 */
>   1471			desc.qw1 |= GENMASK_ULL(size_order +
> VTD_PAGE_SHIFT,
>   1472						VTD_PAGE_SHIFT);
>   1473			/* Clear size_order bit to indicate size */
>   1474			desc.qw1 &= ~mask;
>   1475			/* Set the S bit to indicate flushing more than 1 page */
>   1476			desc.qw1 |= QI_DEV_EIOTLB_SIZE;
>   1477		}
>   1478
>   1479		qi_submit_sync(iommu, &desc, 1, 0);
>   1480	}
>   1481
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
