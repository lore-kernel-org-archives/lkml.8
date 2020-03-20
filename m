Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D0C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19BA20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCTWVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:21:05 -0400
Received: from 8bytes.org ([81.169.241.247]:54746 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgCTWVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:21:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 923B24CA; Fri, 20 Mar 2020 23:21:03 +0100 (CET)
Date:   Fri, 20 Mar 2020 23:21:02 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     David Rientjes <rientjes@google.com>
Cc:     erdemaktas@google.com, x86@kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 62/70] x86/kvm: Add KVM specific VMMCALL handling under
 SEV-ES
Message-ID: <20200320222102.GM5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-63-joro@8bytes.org>
 <alpine.DEB.2.21.2003201423230.205664@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003201423230.205664@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 02:23:58PM -0700, David Rientjes wrote:
> On Thu, 19 Mar 2020, Joerg Roedel wrote:
> > +#if defined(CONFIG_AMD_MEM_ENCRYPT)
> > +static void kvm_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
> > +{
> > +	/* RAX and CPL are already in the GHCB */
> > +	ghcb_set_rbx(ghcb, regs->bx);
> > +	ghcb_set_rcx(ghcb, regs->cx);
> > +	ghcb_set_rdx(ghcb, regs->dx);
> > +	ghcb_set_rsi(ghcb, regs->si);
> 
> Is it possible to check the hypercall from RAX and only copy the needed 
> regs or is there a requirement that they must all be copied 
> unconditionally?

No, there is no such requirement. This could be optimized with hypercall
specific knowledge as it is in the KVM code anyway.

Regards,

	Joerg

