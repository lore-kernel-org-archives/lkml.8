Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F3D22363
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgFSW2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:28:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:16431 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgFSW2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:28:21 -0400
IronPort-SDR: oGKu26Ow0nic1FVt3/qG37oZOSzIBp5mB4C1+tEJ4ZufQ8uN4NN5Yw+7TlvEbaLnk3W34At5cn
 KqX2CkDTJJTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="161235693"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="161235693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 15:28:21 -0700
IronPort-SDR: a/tejF8oErUwkk6RPL4/qL16zzAr1iPWvpBgso33pfeHwI3w0TbMVxLVhJMXQN8fV/JCmknOd5
 8pS5UFlQ7ODg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="265978666"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 19 Jun 2020 15:28:21 -0700
Received: from [10.251.1.53] (kliang2-mobl.ccr.corp.intel.com [10.251.1.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2FE57580426;
        Fri, 19 Jun 2020 15:28:19 -0700 (PDT)
Subject: Re: [PATCH 20/21] perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR
 context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-21-git-send-email-kan.liang@linux.intel.com>
 <20200619194115.GJ576888@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <14bfb569-d43f-abc7-8767-d530a9037ec2@linux.intel.com>
Date:   Fri, 19 Jun 2020 18:28:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619194115.GJ576888@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2020 3:41 PM, Peter Zijlstra wrote:
> On Fri, Jun 19, 2020 at 07:04:08AM -0700, kan.liang@linux.intel.com wrote:
>> The XSAVE instruction requires 64-byte alignment for state buffers. A
>> 64-byte aligned kmem_cache is created for architecture LBR.
> 
>> +		pmu->task_ctx_cache = create_lbr_kmem_cache(size,
>> +							    XSAVE_ALIGNMENT);
> 
>> +struct x86_perf_task_context_arch_lbr_xsave {
>> +	struct x86_perf_task_context_opt	opt;
>> +	union {
>> +		struct xregs_state		xsave;
> 
> Due to x86_perf_task_context_opt, what guarantees you're actually at the
> required alignment here?

Now it relies on the compiler. The struct xregs_state has 'aligned(64)' 
attribute applied.
I think we probably need a padding to get rid of the dependency for the 
compiler.

+	union {
+		struct x86_perf_task_context_opt	opt;
+		u8 padding[64];
+	};

Thanks,
Kan

> 
>> +		struct {
>> +			struct fxregs_state	i387;
>> +			struct xstate_header	header;
>> +			struct arch_lbr_state	lbr;
>> +		};
>> +	};
>> +};
