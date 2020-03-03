Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B34C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936AE20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgCCHV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:21:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:1263 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgCCHVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:21:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 23:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="412644822"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2020 23:21:22 -0800
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Mingbo Zhang <whensungoes@gmail.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <931d8779-8b77-b75f-bb3a-ee2f9d75f149@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a9039e7c-db8f-ddda-8298-b89b66b65408@intel.com>
Date:   Tue, 3 Mar 2020 09:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <931d8779-8b77-b75f-bb3a-ee2f9d75f149@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/03/20 9:17 am, Adrian Hunter wrote:
> On 3/03/20 6:50 am, Mingbo Zhang wrote:
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
> 
> We have patches for that:
> 
> 	https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.com/
> 
> But they have not yet been applied.  Arnaldo, could you take them?
> 

For reference:

Subject: [PATCH 0/2] Introduce Control-flow Enforcement opcodes
Date: Tue,  4 Feb 2020 09:14:23 -0800
Message-ID: <20200204171425.28073-1-yu-cheng.yu@intel.com> (raw)

Control-flow Enforcement (CET) introduces 10 new instructions [1].  Add
them to the opcode map.  This series has been separated from the CET
patches [2] for ease of review.

[1] Detailed information on CET can be found in "Intel 64 and IA-32
    Architectures Software Developer's Manual":

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] CET patches:

    https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

Adrian Hunter (1):
  x86/insn: perf tools: Add CET instructions to the new instructions
    test

Yu-cheng Yu (1):
  x86/insn: Add Control-flow Enforcement (CET) instructions to the
    opcode map

 arch/x86/lib/x86-opcode-map.txt              |  17 +-
 tools/arch/x86/lib/x86-opcode-map.txt        |  17 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 112 +++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 196 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 236 +++++++++++++++++++
 5 files changed, 566 insertions(+), 12 deletions(-)
