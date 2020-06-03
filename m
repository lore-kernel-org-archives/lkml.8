Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8300C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CEC20829
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFCXHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:07:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:57581 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgFCXHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:07:17 -0400
IronPort-SDR: 7wrL/6neXPBUwswJEbQByCUAE6LfZEdks5kpP3/ut0OinZH2O1EtzUe9INiev1CWhbFsBQWe60
 U6sjKjx5rgmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 16:07:16 -0700
IronPort-SDR: 9vgjozx/oRvfwuPeSTLMZum356iRJhNe/DrZ/MBqnUU3vFsurtA0Q5wtboYcgXlyglaP+MZ8SD
 SBq1OTh5oacw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="445286783"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 16:07:16 -0700
Date:   Wed, 3 Jun 2020 16:07:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 25/75] x86/sev-es: Add support for handling IOIO
 exceptions
Message-ID: <20200603230716.GD25606@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-26-joro@8bytes.org>
 <20200520062055.GA17090@linux.intel.com>
 <20200603142325.GB23071@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603142325.GB23071@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:23:25PM +0200, Joerg Roedel wrote:
> > > +		 */
> > > +		io_bytes   = (exit_info_1 >> 4) & 0x7;
> > > +		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
> > > +
> > > +		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
> > > +		exit_info_2 = min(op_count, ghcb_count);
> > > +		exit_bytes  = exit_info_2 * io_bytes;
> > > +
> > > +		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
> > > +
> > > +		if (!(exit_info_1 & IOIO_TYPE_IN)) {
> > > +			ret = vc_insn_string_read(ctxt,
> > > +					       (void *)(es_base + regs->si),
> > 
> > SEV(-ES) is 64-bit only, why bother with the es_base charade?
> 
> User-space can also cause IOIO #VC exceptions, and user-space can be
> 32-bit legacy code with segments, so es_base has to be taken into
> account.

Is there actually a use case for this?  Exposing port IO to userspace
doesn't exactly improve security.

Given that i386 ABI requires EFLAGS.DF=0 upon function entry/exit, i.e. is
the de facto default, the DF bug implies this hasn't been tested.  And I
don't see how this could possibly have worked for SEV given that the kernel
unrolls string I/O because the VMM can't emulate string I/O.  Presumably
someone would have complained if they "needed" to run legacy crud.  The
host and guest obviously need major updates, so supporting e.g. DPDK with
legacy virtio seems rather silly.

> > > +					       ghcb->shared_buffer, io_bytes,
> > > +					       exit_info_2, df);
> > 
> > df handling is busted, it's aways non-zero.  Same goes for the SI/DI
> > adjustments below.
> 
> Right, this is fixed now.
> 
> > Batching the memory accesses and I/O accesses separately is technically
> > wrong, e.g. a #DB on a memory access will result in bogus data being shown
> > in the debugger.  In practice it seems unlikely to matter, but I'm curious
> > as to why string I/O is supported in the first place.  I didn't think there
> > was that much string I/O in the kernel?
> 
> True, #DBs won't be correct anymore. Currently debugging is not
> supported in SEV-ES guests anyway, but if it is supported the #DB
> exception would happen in the #VC handler and not on the original
> instruction.

As in, the guest can't debug itself?  Or the host can't debug the guest?
