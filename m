Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA93C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78470214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJAn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:43:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:57022 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgBJAn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 19:43:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 16:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="280491112"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040) ([10.239.13.16])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2020 16:43:54 -0800
Date:   Sun, 9 Feb 2020 19:34:36 -0500
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "He, Shaopeng" <shaopeng.he@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC PATCH v2 1/9] vfio/pci: split vfio_pci_device into public
 and private parts
Message-ID: <20200210003436.GA3520@joy-OptiPlex-7040>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20200131020803.27519-1-yan.y.zhao@intel.com>
 <20200131020956.27604-1-yan.y.zhao@intel.com>
 <20200207124831.391d5f70@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207124831.391d5f70@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 03:48:31AM +0800, Alex Williamson wrote:
> On Thu, 30 Jan 2020 21:09:56 -0500
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > split vfio_pci_device into two parts:
> > (1) a public part,
> >     including pdev, num_region, irq_type which are accessible from
> >     outside of vfio.
> > (2) a private part,
> >     a pointer to vfio_pci_device_private, only accessible within vfio
> > 
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c         | 209 +++++++++++++++-------------
> >  drivers/vfio/pci/vfio_pci_config.c  | 157 +++++++++++----------
> >  drivers/vfio/pci/vfio_pci_igd.c     |  16 +--
> >  drivers/vfio/pci/vfio_pci_intrs.c   | 171 ++++++++++++-----------
> >  drivers/vfio/pci/vfio_pci_nvlink2.c |  16 +--
> >  drivers/vfio/pci/vfio_pci_private.h |   5 +-
> >  drivers/vfio/pci/vfio_pci_rdwr.c    |  36 ++---
> >  include/linux/vfio.h                |   7 +
> >  8 files changed, 321 insertions(+), 296 deletions(-)
> 
> I think the typical solution to something like this would be...
> 
> struct vfio_pci_device {
> 	...
> };
> 
> struct vfio_pci_device_private {
> 	struct vfio_pci_device vdev;
> 	...
> };
> 
> External code would be able to work with the vfio_pci_device and
> internal code would do a container_of() to get access to the private
> fields.  What's done here is pretty ugly and not very cache friendly.
> Thanks,
>
got it, it's much better!
will change it. Thanks!

Yan

