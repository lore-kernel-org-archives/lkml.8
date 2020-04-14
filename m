Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6443BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4300D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbgDNQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:00:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:62246 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbgDNQAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:00:43 -0400
IronPort-SDR: rAoPiR6Jwz0pKodcymUPpxHa3wTHTeLH7JleYHAuMP9K2elvznXHLSWuSo1vLPs/epi+GfDx11
 zfGhTrRl3cBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 09:00:42 -0700
IronPort-SDR: FM4ZlxhcT/aVlmT/AZL2mrP/IwuvOXgnjOtMwfo/CPoCI2buYptuu+D3vIGFEttw4e8azX4WEW
 IGORjgXUp+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="399994497"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2020 09:00:41 -0700
Date:   Tue, 14 Apr 2020 09:06:36 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200414090636.1798d0c2@jacob-builder>
In-Reply-To: <20200414081107.GA7315@infradead.org>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
        <20200327074702.GA27959@infradead.org>
        <20200327165335.397f24a3@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
        <20200330090746.23c5599c@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
        <20200331085444.44bee0bb@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
        <20200402113604.6eea1e6f@jacob-builder>
        <20200413134157.395981a6@jacob-builder>
        <20200414081107.GA7315@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 01:11:07 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Apr 13, 2020 at 01:41:57PM -0700, Jacob Pan wrote:
> > Hi All,
> > 
> > Just a gentle reminder, any feedback on the options I listed below?
> > New ideas will be even better.
> > 
> > Christoph, does the explanation make sense to you? We do have the
> > capability/flag based scheme for IOMMU API extension, the version is
> > mainly used for size lookup. Compatibility checking is another use
> > of the version, it makes checking easy when a vIOMMU is launched.  
> 
> No.  If you truely need different versions use different ioctl
> identifiers.
OK. I will drop the global version and keep the current per API/IOCTL
struct.

>  If it really is just the size pass the size and not a
> version.
OK, I think we have a path forward. I will remove the size-version
lookup.

My concern was that since we cannot trust the size provided by
userspace. We must sanity check the argsz based on knowledge of the
struct within the kernel. AFAIK, VFIO does this check by looking at
offsetofend(user_struct, last_element). But in this case, VFIO is not
the end consumer, and last_element can be a variable size union.
So we'd better let IOMMU driver deal with it.
