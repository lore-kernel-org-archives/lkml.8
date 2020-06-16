Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9017FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784B1206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgFPPQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:16:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:33129 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgFPPQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:16:07 -0400
IronPort-SDR: DiptdiALfr/RUg2ynULvmmC60UIMqEDmmq+L8rMAMZWVyy+ku/XJV67zzH+6r+KdWYu8fj6u1D
 VwJ074i8v1zw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:15:44 -0700
IronPort-SDR: n1885/AvwQW6RHQ0gOhNxz+f6MggStKTc9mydEKv3qqA/HV3Ui8qqtqJd04eZ19F61nluF+pUP
 wNsPZKWJuJGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449871882"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2020 08:15:44 -0700
Date:   Tue, 16 Jun 2020 08:22:12 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
Message-ID: <20200616082212.0c1611dd@jacob-builder>
In-Reply-To: <20200611172727.78dbb822@jacob-builder>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611094741.6d118fa8@w520.home>
        <20200611125205.1e0280d3@jacob-builder>
        <20200611144047.79613c32@x1.home>
        <20200611172727.78dbb822@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 17:27:27 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > 
> > But then I thought it even better if VFIO leaves the entire
> > copy_from_user() to the layer consuming it.
> >   
> OK. Sounds good, that was what Kevin suggested also. I just wasn't
> sure how much VFIO wants to inspect, I thought VFIO layer wanted to
> do a sanity check.
> 
> Anyway, I will move copy_from_user to iommu uapi layer.

Just one more point brought up by Yi when we discuss this offline.

If we move copy_from_user to iommu uapi layer, then there will be
multiple copy_from_user calls for the same data when a VFIO container
has multiple domains, devices. For bind, it might be OK. But might be
additional overhead for TLB flush request from the guest.

Thoughts?

Jacob
