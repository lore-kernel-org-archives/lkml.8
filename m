Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7012E20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG1AdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:33:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:58006 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgG1AdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:33:15 -0400
IronPort-SDR: HMwRvlVZ69u7V5UsQfGaXJ+qq2cD/AUx5fN1SK/XIfrtRFxmDu4r7Hg8G/nNX0mEPyFMhoKTKp
 uQpwlDeYwFfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="212654714"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="212654714"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 17:33:15 -0700
IronPort-SDR: xL3/aL/R3FYyBN63HbxCVwv5DoeHBiX7Na/AE52zScDgw6BPlKsCOJ9XwivuQkTlEW0pQlLxSI
 teq4Z/0tP87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="303655467"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2020 17:33:14 -0700
Date:   Mon, 27 Jul 2020 17:32:57 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 0/4] x86/cpu: Use SERIALIZE in sync_core()
Message-ID: <20200728003257.GA23421@ranerica-svr.sc.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727110708.GA3174@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727110708.GA3174@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 01:07:08PM +0200, Ingo Molnar wrote:
> 
> * Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > A recent submission to LKML introduced a CPU feature flag for a new
> > Intel architecture Serializing Instruction, SERIALIZE [1]. Unlike the
> > existing Serializing Instructions, this new instruction does not have
> > side effects such as clobbering registers or exiting to a hypervisor.
> > 
> > As stated in the Intel "extensions" (ISE) manual [2], this instruction
> > will appear first in Sapphire Rapids and Alder Lake.
> > 
> > Andy Lutomirski suggested to use this instruction in sync_core() as it
> > serves the very purpose of this function [3].
> > 
> > For completeness, I picked patch #3 from Cathy's series (and has become
> > patch #1 here) [1]. Her series depends on such patch to build correctly.
> > Maybe it can be merged independently while the discussion continues?
> > 
> > Thanks and BR,
> > Ricardo
> > 
> > [1]. https://lore.kernel.org/kvm/1594088183-7187-1-git-send-email-cathy.zhang@intel.com/
> > [2]. https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> > [3]. https://lore.kernel.org/kvm/CALCETrWudiF8G8r57r5i4JefuP5biG1kHg==0O8YXb-bYS-0BA@mail.gmail.com/
> > 
> > Ricardo Neri (4):
> >   x86/cpufeatures: Add enumeration for SERIALIZE instruction
> >   x86/cpu: Relocate sync_core() to sync_core.h
> >   x86/cpu: Refactor sync_core() for readability
> >   x86/cpu: Use SERIALIZE in sync_core() when available
> 
> I've picked up the first 3 preparatory patches into tip:x86/cpu, as 
> they are valid improvements even without the 4th patch. The actual 
> functionality in the 4th patch still needs work.

Thank you Ingo! I'll work on the fourth patch.

BR,
Ricardo
