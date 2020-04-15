Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBC4C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8433020771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441763AbgDOTPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:15:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:7249 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgDOTGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:06:41 -0400
IronPort-SDR: xt3XW0fWep1rD6mjqPO/2YD4Ovi/Y/ROI4zFaxJiswPpA0ovkCwOKxV6XnqL5R71aRst+P2xJ5
 S2ROecCjVpSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:06:39 -0700
IronPort-SDR: d+T2qO8aKraJTjw39BMYEhZJYVjCzf/wZeAyxgSrlcd44nehQH7Esi0Qt6S1z0gemxAvc5Uf4Q
 jOGPpcXvEjVg==
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245764600"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.108.43]) ([10.254.108.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:06:37 -0700
Subject: Re: [RFC PATCH v2 0/2] x86/resctrl: Start abstraction for a second
 arch
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com>
 <e3e4b142-d6e2-4fa8-be57-e829fc6e48f7@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e4d770b6-edea-868c-75df-3074d40c3dbb@intel.com>
Date:   Wed, 15 Apr 2020 12:06:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e3e4b142-d6e2-4fa8-be57-e829fc6e48f7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you very much for your thorough response. I do have a lot to
digest from it but would like to at least respond promptly to a question
you included ...

On 4/15/2020 5:59 AM, James Morse wrote:
> On 14/04/2020 19:56, Reinette Chatre wrote:
>> On 12/31/1969 4:00 PM, James Morse wrote:

...

>> * Apart from actual interface changes, highlighting planned behavior
>> changes and motivation for them would also be helpful … for example
>> force enabling of CDP on all cache levels is a red flag to me.
> 
> Interesting. This is the change that makes the CDP on/off global, instead of per cache.

This is the one I referred to and a significant change.

> Its still controlled by user-space. (so nothing is forced).

Right, controlled with the mount option but the behavior is being
changed to apply to both L2 and L3, even if user requests just one of
the two.

Please note that in the documentation it is currently explicitly stated
that: "L2 and L3 CDP are controlled separately"

> Do you have systems that support CAT at L3 and L2, but only CDP at L3, not L2?
> (I was under the impression the L2 stuff was all Atom, and the L3+MBM was all Xeon).

Things are not as clear cut unfortunately. There is a new Atom system
that has a server uncore, thus inheriting some RDT features that have
previously only been seen on servers. L2 CAT/CDP is also moving to
servers in future server products.

You can find more details about RDT features in upcoming systems in
Chapter 9 of
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

> 
> MPAM's equivalent to CDP is just part of the CPU interface. Its always on.
> To support 'CDP on L2 but not L3', (neither of which exist), we'd need to have extra code:
> "was I asked to pretend CDP is enabled on this cache".
> 
> As CDP affects the way you allocate closid, (that odd/even thing), which is global, it

The odd/even is just for the CDP enabled resource, not global. It is
thus possible for, for example, the L3, L2CODE, and L2DATA resources to
be enabled. The odd/even is configured by the multiplier cbm_idx_mult
set in the resource configuration and used in cbm_idx(). Perhaps you
mean the CLOSID is global? By enabling these together it would reduce
the number of CLOSIDs that could be used by L3 in this example.

> makes sense that this is either on or off. (doing this let me support CDP without the arch
> code doing anything special!)
> 
> Existence of hardware that does this would obviously change this.
> 

Yes, there are systems that support L2 CAT/CDP and L3 CAT/CDP. CDP is
controlled separately on the different cache levels.

>> It seems to me that MPAM may need more than what is currently available
>> from resctrl
> 
> Ultimately yes, but the aim here isn't to support all of MPAM.
> Its just to support what maps nicely. We can then discuss what to do next.

Thank you for stating this. This is significant and was not clear to me
initially.

Reinette
