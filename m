Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1795D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCZFME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:12:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:58609 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgCZFME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:12:04 -0400
IronPort-SDR: JQr6JuZLhb+0/JUoQPPxxUzBwrneyUQLkprSs0u1sy3VSYJhpjMw93K6LutZOc6g0jWS1xfzmP
 EfFPnWrgnZvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 22:12:04 -0700
IronPort-SDR: TlQps1VyUGLcc2XLr97WGBIlZ4/+xeQOh2UcYxaxCA/KZKeASXQEhzU4jt5tqx0jdVERL9ZV4q
 8OnnP27Xc/TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="236155391"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 22:11:59 -0700
Subject: Re: [PATCH 0/2] Introduce Control-flow Enforcement opcodes
To:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200204171425.28073-1-yu-cheng.yu@intel.com>
 <20200303193550.692bf2be0ee800c21bd05215@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <684e6012-b433-4b61-936d-b5c3b71e246c@intel.com>
Date:   Thu, 26 Mar 2020 07:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303193550.692bf2be0ee800c21bd05215@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/03/20 12:35 pm, Masami Hiramatsu wrote:
> Hi,
> 
> On Tue,  4 Feb 2020 09:14:23 -0800
> Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
>> Control-flow Enforcement (CET) introduces 10 new instructions [1].  Add
>> them to the opcode map.  This series has been separated from the CET
>> patches [2] for ease of review.
>>
>> [1] Detailed information on CET can be found in "Intel 64 and IA-32
>>     Architectures Software Developer's Manual":
>>
>>     https://software.intel.com/en-us/download/intel-64-and-ia-32-
>>     architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4
>>
>> [2] CET patches:
>>
>>     https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
>>     https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/
> 
> Sorry, somewhat I've missed this series...
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for this series.
> 
> Thank you,

These are the correct patches for CET instructions.

Sorry for the confusion.
