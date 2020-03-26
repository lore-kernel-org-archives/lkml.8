Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD3C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0822070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCZFKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:10:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:61663 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgCZFKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:10:31 -0400
IronPort-SDR: 9Xw2adtp3WYnvGXsKYTJOCngdipvVu3qMN+8osfdPX2G5RgPiWvL2PwtnTvb2J4Oz0EPpZZBJp
 JIzzSQBZfr6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 22:10:30 -0700
IronPort-SDR: zf5CqwFnxTOg3sh5TRaazSLIfVMuCUgKEflGEMgQUX/098vyc2VV7pFSAoMFjLBrNEByJ9vX4e
 koV2fMmlIjWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="236155018"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 22:10:26 -0700
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
Date:   Thu, 26 Mar 2020 07:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200326103153.de709903f26fee0918414bd2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 3:31 am, Masami Hiramatsu wrote:
> Hi,
> 
> On Mon,  2 Mar 2020 23:50:30 -0500
> Mingbo Zhang <whensungoes@gmail.com> wrote:
> 
>> Intel CET instructions are not described in the Intel SDM. When trying to
>> get the instruction length, the following instructions get wrong (missing
>> ModR/M byte).
>>
>> RDSSPD r32
>> RSDDPQ r64
>> ENDBR32
>> ENDBR64
>> WRSSD r/m32, r32
>> WRSSQ r/m64, r64
>>
>> RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which is
>> described in SDM as Reserved-NOP with no encoding characters, and got an
>> empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got an empty slot.
>>
> 
> This looks good to me. BTW, wouldn't we need to add decode test cases to perf?
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you,
> 

We have correct patches that you ack'ed for CET here:

	https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.com/

But they have not yet been applied.

Sorry for the confusion.
