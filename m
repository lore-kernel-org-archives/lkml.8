Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4D220644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDGBfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:35:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:11238 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgDGBfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:35:36 -0400
IronPort-SDR: HHThN/dxP8rTpoUETPZk0Lieszk4koh5siB47YeuZjlPYeQ305vHuWAo+RcQ/PZi2D6+MWEKfL
 TkzgLjq7MeNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 18:35:35 -0700
IronPort-SDR: 8+uT1ibjrBgOdYkVqjDeyKzlUbt30QK4kLwPGyznPOeSc+gtzQcqfSdPoMgwFKfe+3BQcIZmV1
 7jYgZnnTr0xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; 
   d="scan'208";a="424570349"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2020 18:35:35 -0700
Date:   Mon, 6 Apr 2020 18:36:25 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Add enumeration for serialize
 instruction
Message-ID: <20200407013625.GA5587@ranerica-svr.sc.intel.com>
References: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
 <20200403081217.GA20218@zn.tnic>
 <20200404052039.GA14886@ranerica-svr.sc.intel.com>
 <20200404082809.GA7356@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404082809.GA7356@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 10:28:09AM +0200, Borislav Petkov wrote:
> On Fri, Apr 03, 2020 at 10:20:39PM -0700, Ricardo Neri wrote:
> > Do you mean code in the kernel using this instructions. Thus far, I
> > don't have any kernel use cases for this instruction.
> 
> I'm sure you can find at least a couple of places in the kernel
> which use CPUID to serialize and could switch to this new insn with
> alternatives, for example. Or all those memory barrier uses. Would it be
> better to switch to SERIALIZE there? Dunno, but would be good to know.
> And so on.

Yes, I lookede for uses of CPUID for serialization but I didn't find
any. I will look again. I will also look at the memory barrier cases.

Thanks and BR,
Ricardo

> 
> > My intention is to expose this instruction to user space via
> > /proc/cpuinfo. Is that not acceptable?
> 
> I know what your intention is. What good is the string "serialize" in
> /proc/cpuinfo if nothing uses it?

Wouldn't it be useful for userspace tools to see? Admittedly, the would
be looking at CPUID directly, I think.

Thanks and BR,
Ricardo
