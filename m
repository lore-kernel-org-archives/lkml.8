Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B896B206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFBUTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:19:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:35834 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgFBUTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:19:53 -0400
IronPort-SDR: 85vdbTejo40HvfL2TCVMgqYGVkjhm1Npx2srmKJ7kkUUI2mHWnLQaxt5paRS7+M++CRIMSBWwm
 M3sD5+jIuAig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 13:19:52 -0700
IronPort-SDR: suWFequyiB4FMrmPrmoOl+BWU7ncwyzr9QXxGnTG8pVc5JrkgS3IG2sNn1ZcuYbR4jIN/BD82S
 zQ1ZbE4YMz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="272489927"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2020 13:19:52 -0700
Date:   Tue, 2 Jun 2020 13:19:52 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Alex Levin <levinale@google.com>,
        Zubin Mithra <zsm@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Todd Broch <tbroch@google.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200602201952.GB17363@otc-nc-03>
References: <20200602054517.191244-1-rajatja@google.com>
 <20200602095003.GI247495@lahna.fi.intel.com>
 <CACK8Z6F2n6yx7Fs43rmUQko3PAHZYcnc_eyE_xPdUHXwf2hhLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6F2n6yx7Fs43rmUQko3PAHZYcnc_eyE_xPdUHXwf2hhLw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 06:43:00PM +0000, Rajat Jain wrote:
> Hi MIka,
> 
> Thanks for taking a look.
> 
> On Tue, Jun 2, 2020 at 2:50 AM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Mon, Jun 01, 2020 at 10:45:17PM -0700, Rajat Jain wrote:
> > > Currently, an external malicious PCI device can masquerade the VID:PID
> > > of faulty gfx devices, and thus apply iommu quirks to effectively
> > > disable the IOMMU restrictions for itself.
> > >
> > > Thus we need to ensure that the device we are applying quirks to, is
> > > indeed an internal trusted device.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > >  drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > index ef0a5246700e5..f2a480168a02f 100644
> > > --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
> > >
> > >  static void quirk_iommu_igfx(struct pci_dev *dev)
> > >  {
> > > +     if (dev->untrusted) {
> > > +             pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
> >
> > I think you should be consistent with other messages. For example iommu
> > should be spelled IOMMU as done below.
> >
> > Also this is visible to users so maybe put bit more information there:
> >
> >   pci_warn(dev, "Will not apply IOMMU quirk for untrusted graphics device\n");
> >
> > Ditto for all the other places. Also is "untrusted" good word here? If
> > an ordinary user sees this will it trigger some sort of panic reaction.
> > Perhaps we should call it "potentially untrusted" or something like
> > that?

Wish we called it external_facing rather than untrusted attribute, so its
description is consistent with the spec that defines it. Once we have
Platform Component Security Enhancements. 

to be correct, maybe call "Device located on an untrusted link" rather than
assert blame on the device.

Since the information is harvsted from BIOS tables and there are chances
this could be wrongly grouped such, add "Check with your BIOS/Platform
Vendor.



> 
> Fixed it, posted new patch at
> https://lkml.org/lkml/2020/6/2/822
> 
> Thanks,
> 
> Rajat
> 
> >
> > > +             return;
> > > +     }
> > > +
> > >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> > >       dmar_map_gfx = 0;
