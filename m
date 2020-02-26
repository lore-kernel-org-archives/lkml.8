Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDAC4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B431020658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBZXkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:40:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:38495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgBZXkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:40:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 15:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="350513012"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.84]) ([134.134.177.84])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 15:40:30 -0800
Subject: Re: [PATCH] x86/pkeys: Manually set X86_FEATURE_OSPKE to preserve
 existing changes
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200226231615.13664-1-sean.j.christopherson@intel.com>
 <950b249a-f47d-0adc-80dd-68d397e4de4f@intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <3d869bdf-5ca7-d2ea-cc85-eb461b37b207@intel.com>
Date:   Wed, 26 Feb 2020 15:40:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <950b249a-f47d-0adc-80dd-68d397e4de4f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2020 3:32 PM, Dave Hansen wrote:
> On 2/26/20 3:16 PM, Sean Christopherson wrote:
>> Explicitly set X86_FEATURE_OSPKE via set_cpu_cap() instead of calling
>> get_cpu_cap() to pull the feature bit from CPUID after enabling CR4.PKE.
> 
> First of all,
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I don't remember whether it was you or someone else inside Intel, but
> someone was tripping over this recently.
> 
> I do think we need a bit more care in how we deal with dynamic CPUID
> bits.  I think you'd agree that it's a bit haphazard.  For instance, I
> went looking for where we set X86_FEATURE_OSXSAVE after the
> 
>         cr4_set_bits(X86_CR4_OSXSAVE);
> 
> inside fpu__init_cpu_xstate() makes it appear.  I couldn't find one, not
> that we would notice since we suppress it from /proc/cpuinfo.
> 


I tripped over it. It's possible someone else has as well, but I haven't
heard from anyone else.

Thanks,
Jake
