Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73417C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 10:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534ED20656
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 10:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgFFKPQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 06:15:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgFFKPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 06:15:15 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id EEEDD7E626AAB48BA848;
        Sat,  6 Jun 2020 18:15:12 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Sat, 6 Jun 2020 18:15:06 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Philip Li <philip.li@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lkp@intel.com" <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: RE: [kbuild-all] Re: [PATCH 1/3] dma-direct: provide the ability to
 reserve per-numa CMA
Thread-Topic: [kbuild-all] Re: [PATCH 1/3] dma-direct: provide the ability
 to reserve per-numa CMA
Thread-Index: AQHWOVDkjt//8Ixq2UKuAS4YcS/rw6jH0AqAgAG65oD//6sagIABO3aAgADxzcA=
Date:   Sat, 6 Jun 2020 10:15:06 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24E1541@DGGEMI525-MBS.china.huawei.com>
References: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
 <20200604113631.GP30374@kadam>
 <B926444035E5E2439431908E3842AFD24E0011@DGGEMI525-MBS.china.huawei.com>
 <20200605085751.GQ30374@kadam> <20200606034655.GH2459@intel.com>
In-Reply-To: <20200606034655.GH2459@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.154]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Philip Li [mailto:philip.li@intel.com]
> Sent: Saturday, June 6, 2020 3:47 PM
> To: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> kbuild@lists.01.org; hch@lst.de; m.szyprowski@samsung.com;
> robin.murphy@arm.com; catalin.marinas@arm.com; lkp@intel.com; Dan
> Carpenter <error27@gmail.com>; kbuild-all@lists.01.org;
> iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; John Garry
> <john.garry@huawei.com>
> Subject: Re: [kbuild-all] Re: [PATCH 1/3] dma-direct: provide the ability to
> reserve per-numa CMA
> 
> On Fri, Jun 05, 2020 at 11:57:51AM +0300, Dan Carpenter wrote:
> > On Fri, Jun 05, 2020 at 06:04:31AM +0000, Song Bao Hua (Barry Song)
> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > > > Sent: Thursday, June 4, 2020 11:37 PM
> > > > To: kbuild@lists.01.org; Song Bao Hua (Barry Song)
> > > > <song.bao.hua@hisilicon.com>; hch@lst.de;
> > > > m.szyprowski@samsung.com; robin.murphy@arm.com;
> > > > catalin.marinas@arm.com
> > > > Cc: lkp@intel.com; Dan Carpenter <error27@gmail.com>;
> > > > kbuild-all@lists.01.org; iommu@lists.linux-foundation.org;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
> > > > Jonathan Cameron <jonathan.cameron@huawei.com>; John Garry
> > > > <john.garry@huawei.com>
> > > > Subject: Re: [PATCH 1/3] dma-direct: provide the ability to
> > > > reserve per-numa CMA
> > > >
> > > > Hi Barry,
> > > >
> > > > url:
> > > > https://github.com/0day-ci/linux/commits/Barry-Song/support-per-nu
> > > > ma-CM
> > > > A-for-ARM-server/20200603-104821
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> > > > for-next/core
> > > > config: x86_64-randconfig-m001-20200603 (attached as .config)
> > > > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > Dan, thanks! Good catch!
> > > as this patch has not been in mainline yet, is it correct to add these
> "reported-by" in patch v2?
> Hi Barry, we provides the suggestion here, but you may decide to add or not as
> appropriate for your situation. For the patch still under development, it is not
> that necessary to add i think.

Hi Philip, Dan,
Thanks for clarification.
> 
> >
> > These are just an automated email from the zero day bot.  I look over
> > the Smatch warnings and then forward them on.
> >
> > regards,
> > dan carpenter

Best regards
Barry

