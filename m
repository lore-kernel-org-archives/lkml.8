Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B3FC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87ACB2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgD0USN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:18:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:15351 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgD0USN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:18:13 -0400
IronPort-SDR: W1ND4r1lCU7phVlN6zEymSgV/dYY5UxKtaViPPUlIB+12abnwdMEshur9ax8foGuPULM7kTSRv
 9XglJ+GvmZcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 13:18:12 -0700
IronPort-SDR: 49XhrD2107mWQOJ8zWIhZV6uyNuG6sFLUOrEq2oeq8Ej1/NfRNLsyu7wwqC5yGsmnNVWwDjb9D
 vaoWJ5gm1VTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="404432935"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 13:18:12 -0700
Date:   Mon, 27 Apr 2020 13:17:16 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/7] x86/cpufeatures: Enumerate ENQCMD and ENQCMDS
 instructions
Message-ID: <20200427201716.GC242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-3-git-send-email-fenghua.yu@intel.com>
 <87y2qisdza.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2qisdza.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 01:06:33PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> > A user space application can execute ENQCMD instruction to submit work
> > to device. The kernel executes ENQCMDS instruction to submit work to
> > device.
> 
> So a user space application _can_ execute ENQCMD and the kernel
> executes ENQCMDS. And both submit work to device.
> 
> > There is a lot of other enabling needed for the instructions to actually
> > be usable in user space and the kernel, and that enabling is coming later
> > in the series and in device drivers.
> 
> That's important information to the enumeration of the instructions in
> which way?

I just want to notify people this enumeration is only part of enabling
ENQCMD. But seems this paragraph is not so useful to be here. Maybe I can
remove it.

Thanks.

-Fenghua
