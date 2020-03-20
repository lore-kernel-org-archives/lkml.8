Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2417C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF172072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCTWT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:19:26 -0400
Received: from 8bytes.org ([81.169.241.247]:54714 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTWT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:19:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 87BB24CA; Fri, 20 Mar 2020 23:19:24 +0100 (CET)
Date:   Fri, 20 Mar 2020 23:19:23 +0100
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
Subject: Re: [PATCH 18/70] x86/boot/compressed/64: Add stage1 #VC handler
Message-ID: <20200320221923.GL5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-19-joro@8bytes.org>
 <alpine.DEB.2.21.2003201413010.205664@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003201413010.205664@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 02:16:39PM -0700, David Rientjes wrote:
> On Thu, 19 Mar 2020, Joerg Roedel wrote:
> > +#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
> > +#define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
> 
> Since preemption and irqs should be disabled before updating the GHCB and 
> its MSR and until the contents have been accessed following VMGEXIT, 
> should there be checks in place to ensure that's always the case?

Good point, some checking is certainly helpful. Currently it is the
case, because the GHCB is accessed and used only:

	1) At boot when only the boot CPU is running

	2) In the #VC handler, which does not enable interrupts

	3) In the NMI handler, which is also not preemptible

I can also add code to sev_es_get/put_ghcb to make sure these conditions
are met. All this does not prevent the preemption by NMIs, which could
cause another nested #VC exception, but that is handled separatly.


Regards,

	Joerg
