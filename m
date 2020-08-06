Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A98C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9925E22CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgHFGPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:15:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:13679 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgHFGPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:15:49 -0400
IronPort-SDR: FzdIOrhCEVJEVNStAXUSbqNDmuUoFPCO0ug62Gjo8+vkNA57+7+1tXqHeZp6DfwkVDcNaYfBCH
 lU2o+tXvlsYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="132286575"
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="132286575"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 23:15:34 -0700
IronPort-SDR: psBcpFRPS/T1+BeZPwSHC2pI4x8dzWgV9wzmPm9RIIyirra8V4qbeojVA2SfwcemEaOeSte8xa
 PE0iydH2NRzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="493561482"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2020 23:15:32 -0700
Subject: Re: [PATCH 0/2] perf: Allow closing siblings' file descriptors
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <32ad7700-3d4e-6c20-31c9-8b002fea5cbc@intel.com>
Date:   Thu, 6 Aug 2020 09:15:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/07/20 6:16 pm, Alexander Shishkin wrote:
> Hi guys,
> 
> I've been looking at reducing the number of open file descriptors per perf
> session. If we retain one descriptor per event, in a large group they add
> up. At the same time, we're not actually using them for anything after the
> SET_OUTPUT and maybe SET_FILTER ioctls. So, this series is a stab at that.

I am wondering if instead we should be looking at creating a kernel API that
allows associating a multitude of tracepoints with a single event.  Thoughts
anyone?
