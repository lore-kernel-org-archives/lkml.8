Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B3AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B97B207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgFPBAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:00:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:49269 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgFPBAG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:00:06 -0400
IronPort-SDR: uaJChRE/DjNPX6dkt1XG5rLJeV8zFAYjFhjMnPOpqq+exQqfEVfXefJ+XERi7edxyv4Kuo7bNe
 IXSXGQX573ow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 18:00:03 -0700
IronPort-SDR: E4i51lK6Nnfius5or4vA0k8B+UlwlkpyeAfovOKQavxW0WzkdYhSuhtWbgskWoGSdk9aPGYy73
 tT/hLaq3rh5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="382712297"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 18:00:00 -0700
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
Date:   Tue, 16 Jun 2020 08:59:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603021818.27028-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Can I get an ACK for this patchset?

Thanks
Jin Yao

On 6/3/2020 10:18 AM, Jin Yao wrote:
> This patchset updates CascadelakeX events to v1.08 and
> updates SkylakeX events to v1.21.
> 
> The events have been tested on CascadelakeX and SkylakeX
> servers with latest perf/core branch.
> 
> Jin Yao (2):
>    perf vendor events: Update CascadelakeX events to v1.08
>    perf vendor events: Update SkylakeX events to v1.21
> 
>   .../arch/x86/cascadelakex/cache.json          |   28 +-
>   .../arch/x86/cascadelakex/clx-metrics.json    |  153 +-
>   .../arch/x86/cascadelakex/frontend.json       |   34 +
>   .../arch/x86/cascadelakex/memory.json         |  704 ++---
>   .../arch/x86/cascadelakex/other.json          | 1100 ++++----
>   .../arch/x86/cascadelakex/pipeline.json       |   10 -
>   .../arch/x86/cascadelakex/uncore-other.json   |   21 +
>   .../pmu-events/arch/x86/skylakex/cache.json   | 2348 +++++++++--------
>   .../arch/x86/skylakex/floating-point.json     |   96 +-
>   .../arch/x86/skylakex/frontend.json           |  656 ++---
>   .../pmu-events/arch/x86/skylakex/memory.json  | 1977 +++++++-------
>   .../pmu-events/arch/x86/skylakex/other.json   |  172 +-
>   .../arch/x86/skylakex/pipeline.json           | 1206 +++++----
>   .../arch/x86/skylakex/skx-metrics.json        |  141 +-
>   .../arch/x86/skylakex/uncore-memory.json      |   26 +-
>   .../arch/x86/skylakex/uncore-other.json       |  730 ++++-
>   .../arch/x86/skylakex/virtual-memory.json     |  358 +--
>   17 files changed, 5198 insertions(+), 4562 deletions(-)
> 
