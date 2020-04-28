Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63546C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FED2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD1BrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:47:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:30711 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgD1BrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:47:12 -0400
IronPort-SDR: 3k1w4RYi2o+1b8HmbTiH1yXkJvKfpKCGr7Fxwl8qR+kejPu/MDbxkhWs5enP7qr58Y8U5x4f6n
 QM1+0AWaijig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 18:47:11 -0700
IronPort-SDR: HHrSf2zNwP3Z3RdFg6IPqorcVVnRcv8CQUZlxIpElwsFxEhIW4hgKIVeSHPlUpIKgKgfaU1bzD
 H6EaVfMXZcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="367345195"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.128]) ([10.254.212.128])
  by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2020 18:47:09 -0700
Cc:     Joerg Roedel <joro@8bytes.org>, baolu.lu@linux.intel.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iommu/vt-d: Add page request draining support
To:     kevin.tian@intel.com
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <714e0552-ae31-fa4a-76fe-d3c38e064e0a@linux.intel.com>
Date:   Tue, 28 Apr 2020 09:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422080611.15689-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2020/4/22 16:06, Lu Baolu wrote:
> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in the software and
> remapping hardware. The pending page requests must be drained
> so that the pasid could be reused. The chapter 7.10 in the VT-d
> specification specifies the software steps to drain pending page
> requests and responses.
> 
> This includes two parts:
>   - PATCH 1/4 ~ 2/4: refactor the qi_submit_sync() to support multiple
>     descriptors per submission which will be used in the following
>     patch.
>   - PATCH 3/4 ~ 4/4: add page request drain support after a pasid entry
>     is torn down.
> 
> Please help to review.
> 
> Best regards,
> baolu
> 
> Change log:
>   v2->v3:
>    - Address Kevin's review comments
>      - Squash the first 2 patches together;
>      - The prq thread is serialized, no need to consider reentrance;
>      - Ensure no new-coming prq before drain prq in queue;
>      - Handle page request overflow case.

Very appreciated for your review comments.

How about these changes? Any comments?

Best regards,
baolu
