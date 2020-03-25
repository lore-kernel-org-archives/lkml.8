Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB689C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 06:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EF1206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 06:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgCYGLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:11:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:50568 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCYGLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:11:22 -0400
IronPort-SDR: uzJlxEzN9g9yNRszG0zAbdm9sPcDVkyJhO/czCdrOHUlb0EBwnqUJNB6HbM83hC6LUPf+Htk3G
 Z+iy/V3J4NJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 23:11:21 -0700
IronPort-SDR: Ki5JpDid7RDImR7N+0d5vf2HPkKv2ebEyM/aljPblzyoS+RZ7Y5WtcrEY5kpimaL61M9gTZ8xD
 Ii1ybdc+QqGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="420212956"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2020 23:11:18 -0700
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
        linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <931d8779-8b77-b75f-bb3a-ee2f9d75f149@intel.com>
 <a384009b-0b5d-22da-5613-870c85c546df@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <06eec783-733c-c8e1-441b-2d25b897485c@intel.com>
Date:   Wed, 25 Mar 2020 08:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a384009b-0b5d-22da-5613-870c85c546df@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/20 9:10 am, Adrian Hunter wrote:
> On 3/03/20 9:17 am, Adrian Hunter wrote:
>> On 3/03/20 6:50 am, Mingbo Zhang wrote:
>>> Intel CET instructions are not described in the Intel SDM. When trying to
>>> get the instruction length, the following instructions get wrong (missing
>>> ModR/M byte).
>>>
>>> RDSSPD r32
>>> RSDDPQ r64
>>> ENDBR32
>>> ENDBR64
>>> WRSSD r/m32, r32
>>> WRSSQ r/m64, r64
>>>
>>> RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which is
>>> described in SDM as Reserved-NOP with no encoding characters, and got an
>>> empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got an empty slot.
>>
>> We have patches for that:
>>
>> 	https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.com/
>>
>> But they have not yet been applied.  Arnaldo, could you take them?
>>
> 
> Any takers?
> 

:-)
