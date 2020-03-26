Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDFC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F6B20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgCZRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:37:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:10737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:37:14 -0400
IronPort-SDR: apyPiRvDy0MUyL9GuGnPpWYlxiurke3ApppjDAFqJBJ+7va9hnck1CowSK3bRD8KnuiiuBoyB8
 8g56xIZxiZIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:37:12 -0700
IronPort-SDR: Rf8tWKJt5t723ausfpo3FPrMmYgpgF8T4FXVT7vUs8LAJMN9af91YTGAtfQkqg03pgnM08PsX+
 oigxuMvtzRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="240737743"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2020 10:37:09 -0700
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
 <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
 <20200326135547.GA20397@redhat.com>
 <363DA0ED52042842948283D2FC38E4649C72EFF3@IRSMSX106.ger.corp.intel.com>
 <20200326145726.GC6411@kernel.org> <20200326150137.GD6411@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4a2a3582-21a0-f3fc-102e-42ec67d0aafa@intel.com>
Date:   Thu, 26 Mar 2020 19:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200326150137.GD6411@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 5:01 pm, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 26, 2020 at 11:57:26AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Mar 26, 2020 at 02:19:07PM +0000, Hunter, Adrian escreveu:
>>>>> But they have not yet been applied.
> 
>>>>> Sorry for the confusion.
> 
>>>> I'll collect them, thanks for pointing this out.
> 
>>> The patches are in tip courtesy of Borislav Petkov thank you!
>  
>> Ok, thanks Borislav,
> 
> I didn't notice because it didn't made into tip/perf/core :-\ In what
> branch is it btw, I couldn't find any cset with substr summary "Add
> Control-flow Enforcement" in, tip/master also doesn't have it.
> 
> - Arnaldo
> 


x86/misc

