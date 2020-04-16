Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EF9C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D37020784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502779AbgDPInw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:43:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:12452 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502551AbgDPIiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:38:25 -0400
IronPort-SDR: NA/ynhL3iCMIkdNNHsBTSAuS3MBlund7S1oeUWQVBHmxUJKW/GxqsvS3feZhLRB+lsTcOE9Fhu
 VJACoFc1VhVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:38:23 -0700
IronPort-SDR: rdm/YyN9bcHeb9GkMPmye0GRmbe4rYsAjLnoGkIXuxjYDrG319KjtNuSgE3re9qKzAukkPKeqO
 HMYr5Dl8YcUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="427756139"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.171]) ([10.254.209.171])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 01:38:20 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-7-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8209CE@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <acf26559-49d2-653c-156d-3ef383b43879@linux.intel.com>
Date:   Thu, 16 Apr 2020 16:38:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D8209CE@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2020/4/15 19:10, Tian, Kevin wrote:
> the completion of above sequence ensures that previous queued
> page group responses are sent out and received by the endpoint
> and vice versa all in-fly page requests from the endpoint are queued
> in iommu page request queue. Then comes a problem - you didn't
> wait for completion of those newly-queued requests and their
> responses.

I thought about this again.

We do page request draining after PASID table entry gets torn down and
the devTLB gets invalidated. At this point, if any new page request for
this pasid comes in, IOMMU will generate an unrecoverable fault and
response the device with IR (Invalid Request). IOMMU won't put this page
request into the queue. [VT-d spec 7.4.1]

Hence, we don't need to worry about the newly-queued requests here.

Best regards,
baolu
