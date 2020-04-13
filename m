Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76475C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DFF2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgDMPCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:02:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:53115 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgDMPCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:02:37 -0400
IronPort-SDR: sE7JwDQdbfdLHPPIcuKujTVuWz02qUAQK4bnmgafDl+3I2XXGhs5xN/b/ipi1NphZOD1PT1KsR
 WOMnWBGlXI8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:02:37 -0700
IronPort-SDR: cnaDuKRQWnamSf/48gjMLEbtBgWKY6Sv7QzD/G6VBIV/bDJ8fnqnH1o0bLzxpemi2Lunf/MY73
 HEVzRgbpmrhA==
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="453182767"
Received: from ahduyck-mobl1.amr.corp.intel.com (HELO [10.254.29.128]) ([10.254.29.128])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:02:36 -0700
Subject: Re: [RFC PATCH 3/4] mm: add sys fs configuration for page reporting
To:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200412090919.GA19580@open-light-1.localdomain>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <64985d09-d11e-5fc0-64b0-b56ef514448a@linux.intel.com>
Date:   Mon, 13 Apr 2020 08:02:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412090919.GA19580@open-light-1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2020 2:09 AM, liliangleo wrote:
> This patch add 'delay_millisecs', 'mini_order', 'batch_size',
> in '/sys/kernel/mm/page_report/'. Usage:
> 
> "delay_millisecs":
> Time delay interval between page free and work start to run.
> 
> "mini_order":
> Only pages with order equal or greater than mini_order will be
> reported.
> 
> "batch_size"
> Wake up the worker only when free pages total size are greater
> than 'batch_size'.
> 
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: liliangleo <liliangleo@didiglobal.com>

I am not really a fan of making these configurable globally. Especially 
since the existing virtio-balloon is relying on some of this being 
configured the way it is.

It would make much more sense to push these configuration options out to 
the registration interface so that the thing that is registering for 
page reporting can configure them when it is registered.
