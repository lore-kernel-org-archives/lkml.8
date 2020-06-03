Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9386320663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFCBRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:17:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:18951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFCBRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:17:18 -0400
IronPort-SDR: 8IozEOlfuRP/6pY3/sJVLJSwgpMS6p4XwnTHbeY0yG1TdMZFsPm5xEOL+HTCtaKNcpys4AU8LC
 CeeXA+sird5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 18:17:17 -0700
IronPort-SDR: zDre0G77XzM+C67sOFj6J42+uFmeaSWqNhAVekaxUPgl1KxdrplWfqaydk7MkVp8lw4DKuJ3MM
 HaEH27eBE3SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="347598112"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2020 18:17:17 -0700
Date:   Tue, 2 Jun 2020 18:17:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 08/14] x86/entry: Optimize local_db_save() for virt
Message-ID: <20200603011716.GC24169@linux.intel.com>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.187833200@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529213321.187833200@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:27:36PM +0200, Peter Zijlstra wrote:
> Because DRn access is 'difficult' with virt; but the DR7 read is
> cheaper than a cacheline miss on native, add a virt specific
> fast path to local_db_save(), such that when breakpoints are not in
> use we avoid touching DRn entirely.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/debugreg.h |    7 ++++++-
>  arch/x86/kernel/hw_breakpoint.c |   26 ++++++++++++++++++++++----
>  arch/x86/kvm/vmx/nested.c       |    2 +-
>  3 files changed, 29 insertions(+), 6 deletions(-)

...

> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3028,9 +3028,9 @@ static int nested_vmx_check_vmentry_hw(s
>  	/*
>  	 * VMExit clears RFLAGS.IF and DR7, even on a consistency check.
>  	 */
> -	local_irq_enable();
>  	if (hw_breakpoint_active())
>  		set_debugreg(__this_cpu_read(cpu_dr7), 7);
> +	local_irq_enable();
>  	preempt_enable();

This should be a separate patch, probably with:

  Cc: stable@vger.kernel.org
  Fixes: 52017608da33 ("KVM: nVMX: add option to perform early consistency checks via H/W")

