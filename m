Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D447C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417E520706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDVAmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:42:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:2830 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:42:14 -0400
IronPort-SDR: +Twdksnq26JzTYJDmHUisDqyVktSVfsisxAnB3NUiMOPTIkRm6yXgrdB0BnyUECdNe8qr22isH
 lZ8thfOuKfdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 17:42:13 -0700
IronPort-SDR: SiSuhn44bcVmf+oXXggLxCXgVmew1IaBu6Dm3ZQp34xgCpHFLtjWqwxG5u5Xus/DDQtAE1glEx
 fCSYhjuUrshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="402363527"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2020 17:42:13 -0700
Date:   Tue, 21 Apr 2020 17:42:13 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
Message-ID: <20200422004213.GC17836@linux.intel.com>
References: <20200419203137.214111265@linutronix.de>
 <20200420092045.GC24518@infradead.org>
 <87sggyax05.fsf@nanos.tec.linutronix.de>
 <20200421080905.GF11134@linux.intel.com>
 <87tv1durws.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv1durws.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:09:07AM +0200, Thomas Gleixner wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> 
> > On Mon, Apr 20, 2020 at 07:27:06PM +0200, Thomas Gleixner wrote:
> >> Christoph Hellwig <hch@infradead.org> writes:
> >> > Just looking over some exports at the end of the series (and thus
> >> > ignoring bisection issues):
> >> >
> >> >  - Is there any good reason to keep __flush_tlb_all inline vs moving it
> >> >    out of line and kill the flush_tlb_local and flush_tlb_global exports.
> >> >    Also there is just a single modular users in SVM, I wonder if there is
> >> >    any way to get rid of that one as well.
> >> 
> >> I'll have a look again.
> >
> > Regarding the SVM case, the only usage is for a TLB errata.  At a glance,
> > svm_init_erratum_383() and is_erratum_383() don't use any KVM hooks, i.e. I
> > don't see anything that would prevent moving those to .../kernel/cpu/amd.c.
> 
> Right, but that would trade one export vs. two SVM errata specific
> exports. Not really a win.

True.  I was thinking the svm_init_erratum_383() call could be moved to
init_amd(), assuming the MSR's magic bit 47 is "safe" outside of SVM
enabled, but that's probably not worth risking the potential for breakage
unless you really want to hide __flush_tlb_all().
