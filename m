Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F93EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E39E20691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgFKNKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:10:49 -0400
Received: from 8bytes.org ([81.169.241.247]:47316 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgFKNKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:10:49 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5CFB3869; Thu, 11 Jun 2020 15:10:46 +0200 (CEST)
Date:   Thu, 11 Jun 2020 15:10:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
Subject: Re: [PATCH v3 59/75] x86/sev-es: Handle MONITOR/MONITORX Events
Message-ID: <20200611131045.GE11924@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-60-joro@8bytes.org>
 <20200520063845.GC17090@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520063845.GC17090@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:38:45PM -0700, Sean Christopherson wrote:
> On Tue, Apr 28, 2020 at 05:17:09PM +0200, Joerg Roedel wrote:
> > +static enum es_result vc_handle_monitor(struct ghcb *ghcb,
> > +					struct es_em_ctxt *ctxt)
> > +{
> > +	phys_addr_t monitor_pa;
> > +	pgd_t *pgd;
> > +
> > +	pgd = __va(read_cr3_pa());
> > +	monitor_pa = vc_slow_virt_to_phys(ghcb, ctxt->regs->ax);
> > +
> > +	ghcb_set_rax(ghcb, monitor_pa);
> > +	ghcb_set_rcx(ghcb, ctxt->regs->cx);
> > +	ghcb_set_rdx(ghcb, ctxt->regs->dx);
> > +
> > +	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MONITOR, 0, 0);
> 
> Why?  If SVM has the same behavior as VMX, the MONITOR will be disarmed on
> VM-Enter, i.e. the VMM can't do anything useful for MONITOR/MWAIT.  I
> assume that's the case given that KVM emulates MONITOR/MWAIT as NOPs on
> SVM.

Not sure if it is disarmed on VMRUN, but the MONITOR/MWAIT instructions
are part of the GHCB spec, so they are implemented here.


	Joerg
