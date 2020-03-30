Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B80C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E86920780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgC3Fko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:40:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:27452 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgC3Fko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:40:44 -0400
IronPort-SDR: yfvNHuRJGtwl2uV/V7jnEP9wa1uTWADclieEVyN45jNlL4lwVa5JQzurfvOgA5WVPmmt80nS1q
 t0+X2JwtTwsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 22:40:43 -0700
IronPort-SDR: KDuq/8rh8ShxvxI24X4QrSsJUHtOH6r8q3F8rh85Sj1ZDizd/xQbpfH5hM0QN48/GbglFrTCva
 vYa2p3RKQvXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; 
   d="scan'208";a="239668276"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2020 22:40:43 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 29 Mar 2020 22:40:42 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 13:40:41 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIA==
Date:   Mon, 30 Mar 2020 05:40:40 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200326092316.GA31648@infradead.org>
        <20200326094442.5be042ce@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
        <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
In-Reply-To: <20200327165335.397f24a3@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, March 28, 2020 7:54 AM
> 
> On Fri, 27 Mar 2020 00:47:02 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> > > If those API calls are inter-dependent for composing a feature
> > > (e.g. SVA), shouldn't we need a way to check them together before
> > > exposing the feature to the guest, e.g. through a
> > > iommu_get_uapi_capabilities interface?
> >
> > Yes, that makes sense.  The important bit is to have a capability
> > flags and not version numbers.
> 
> The challenge is that there are two consumers in the kernel for this.
> 1. VFIO only look for compatibility, and size of each data struct such
> that it can copy_from_user.
> 
> 2. IOMMU driver, the "real consumer" of the content.
> 
> For 2, I agree and we do plan to use the capability flags to check
> content and maintain backward compatibility etc.
> 
> For VFIO, it is difficult to do size look up based on capability flags.
> 

Can you elaborate the difficulty in VFIO? if, as Christoph Hellwig
pointed out, version number is already avoided everywhere, it is 
interesting to know whether this work becomes a real exception
or just requires a different mindset.

btw the most relevant discussion which I can find out now is here:
	https://lkml.org/lkml/2020/2/3/1126

It mentioned 3 options for handling extension:
--
1. Disallow adding new members to each structure other than reuse
padding bits or adding union members at the end.
2. Allow extension of the structures beyond union, but union size has
to be fixed with reserved spaces
3. Adopt VFIO argsz scheme, I don't think we need version for each
struct anymore. argsz implies the version that user is using assuming
UAPI data is extension only.
--

the first two are both version-based. Looks most guys agreed with 
option-1 (in this v2), but Alex didn't give his opinion at the moment. 
The last response from him was the raise of option-3 using argsz to 
avoid version. So, we also need hear from him. Alex?

Thanks
Kevin
