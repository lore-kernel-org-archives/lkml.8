Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BD5C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D904E2469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgB0SUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:20:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:17243 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgB0SUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:20:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 10:20:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="437128240"
Received: from unknown (HELO [134.134.177.87]) ([134.134.177.87])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2020 10:20:37 -0800
Subject: Re: [PATCH] x86/pkeys: Manually set X86_FEATURE_OSPKE to preserve
 existing changes
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200226231615.13664-1-sean.j.christopherson@intel.com>
 <a492b4f4-4a54-5e5a-b79f-e21f9038f259@intel.com>
 <20200227180100.GB18629@zn.tnic>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <fbf2b74e-bc37-985a-11f0-03e5ae5e390c@intel.com>
Date:   Thu, 27 Feb 2020 10:20:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227180100.GB18629@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2020 10:01 AM, Borislav Petkov wrote:
> On Wed, Feb 26, 2020 at 04:16:13PM -0800, Jacob Keller wrote:
>> I tested this and it resolves my report! Thanks for a timely fix.
> 
> Adding your Tested-by.
> 

Yep, thanks.

>> I agree with the analysis. Perhaps it would make sense in the long term
>> to find a solution where get_cpu_cap can remember what was cleared for
>> each CPU and restore those? It already does this using the global
>> variables...
> 
> get_cpu_cap() remembers if you use setup_force_cpu_cap() but I agree
> that that whole feature bit handling is a bit, hm, "strange". It had its
> raisins.

Right. Nothing quite equivalent to that for per-CPU changes though.

> 
> FWIW, we had started cleaning those up but then the security nightmares
> happened so on the backburner it went...
> 
> Thx.
> 

Completely understandable. Especially since changes here are tricky to
get right, this being a case in point.

Thanks,
Jake
