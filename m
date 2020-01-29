Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D8CC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E537207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgA2MSF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:18:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:59557 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgA2MSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:18:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 04:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; 
   d="scan'208";a="429662333"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2020 04:18:03 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jan 2020 04:18:03 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jan 2020 04:18:02 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.202]) with mapi id 14.03.0439.000;
 Wed, 29 Jan 2020 20:18:01 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d
 support
Thread-Topic: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d
 support
Thread-Index: AQHV1mjm+L2VVYcVTkms4SxIhsuAo6gBjx2g
Date:   Wed, 29 Jan 2020 12:18:00 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A196172@SHSMSX104.ccr.corp.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmZhZTY2MzItODRlMC00YjBmLWEzZjUtNWQwOTJiYzUyMGY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid1V5ZjlycjBxcVFSV2VhaUNqSU1PaE1hRTdvMm0ycTNYbnV4cVNrMFk3cWdWdk14aUJUblhFYVlaS0VIeU1pRSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Wednesday, January 29, 2020 2:02 PM
> Subject: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d support
> 
> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel platforms
> allow address space sharing between device DMA and applications.
> SVA can reduce programming complexity and enhance security.
> This series is intended to enable SVA virtualization, i.e. enable use of SVA within a
> guest user application.
> 
> This is the remaining portion of the original patchset that is based on Joerg's x86/vt-
> d branch. The preparatory and cleanup patches are merged here.
> (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git)
> 
> Only IOMMU portion of the changes are included in this series. Additional support is
> needed in VFIO and QEMU (will be submitted separately) to complete this
> functionality.
> 
> To make incremental changes and reduce the size of each patchset. This series does
> not inlcude support for page request services.
> 
> In VT-d implementation, PASID table is per device and maintained in the host.
> Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> This is the remaining VT-d only portion of V5 since the uAPIs and IOASID common
> code have been applied to Joerg's IOMMU core branch.
> (https://lkml.org/lkml/2019/10/2/833)
> 
> The complete set with VFIO patches are here:
> https://github.com/jacobpan/linux.git:siov_sva

The complete QEMU set can be found in below link:
https://github.com/luxis1999/qemu.git: sva_vtd_v9_rfcv3

Complete kernel can be found in:
https://github.com/luxis1999/linux-vsva: vsva-linux-5.5-rc3

Regards,
Yi Liu
