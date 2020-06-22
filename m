Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C202075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFVTLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:11:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:9054 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFVTLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:11:12 -0400
IronPort-SDR: tu1ySlj4Yy8IGOr6ioeztoCedHMDhV77fNhJYPkvY2VxdytcZJr3jKb66bz6IGXQnXx5wzIjgH
 5XmkUMwe5PFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131255571"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131255571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 12:11:11 -0700
IronPort-SDR: w4oM3UeUGZyczLf4AXYjD7uSpQVe7388THFRfu+yisn/HnIJkMcPCMBI0c8cIjL6DcA0UyYnjF
 kuTzs82uH/cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="310201190"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2020 12:11:11 -0700
Received: from [10.251.30.218] (kliang2-mobl.ccr.corp.intel.com [10.251.30.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1552D5804D6;
        Mon, 22 Jun 2020 12:11:08 -0700 (PDT)
Subject: Re: [PATCH 21/21] perf/x86/intel/lbr: Support XSAVES for arch LBR
 read
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dave.hansen@intel.com, yu-cheng.yu@intel.com,
        bigeasy@linutronix.de, hpa@zytor.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-22-git-send-email-kan.liang@linux.intel.com>
 <20200622184937.GV134822@grain>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3492fcad-344d-174e-7e38-46f2e543b065@linux.intel.com>
Date:   Mon, 22 Jun 2020 15:11:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622184937.GV134822@grain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2020 2:49 PM, Cyrill Gorcunov wrote:
> On Fri, Jun 19, 2020 at 07:04:09AM -0700, kan.liang@linux.intel.com wrote:
> ...
>> +static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
>> +{
>> +	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
>> +	struct arch_lbr_entry *lbr;
>> +	int i;
>> +
>> +	if (!xsave)
>> +		goto rollback;
> 
> Why not make it simplier?
> 
> 	if (!xsave) {
> 		intel_pmu_arch_lbr_read(cpuc);
> 		return;
> 	}
> 
> The goto and "return" statement before the "rollback" label
> looks pretty ugly. I'm sorry I didn't follow the series
> in details so if you plan to add more handlers at "rollback"
> then sure.
> 

There were several handlers when I first implemented the function, but 
they are removed now. I don't think I will add more handlers in the next 
version.
I will remove the "rollback" label.

Thanks for pointing it out.

Kan
