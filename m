Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D452C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7369520760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgFKKFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:05:24 -0400
Received: from 8bytes.org ([81.169.241.247]:47152 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKKFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:05:23 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3AD5C869; Thu, 11 Jun 2020 12:05:21 +0200 (CEST)
Date:   Thu, 11 Jun 2020 12:05:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v3 40/75] x86/sev-es: Compile early handler code into
 kernel image
Message-ID: <20200611100519.GB32093@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-41-joro@8bytes.org>
 <20200520091415.GC1457@zn.tnic>
 <20200604115413.GB30945@8bytes.org>
 <20200604151945.GB2246@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604151945.GB2246@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 05:19:53PM +0200, Borislav Petkov wrote:
> On Thu, Jun 04, 2020 at 01:54:13PM +0200, Joerg Roedel wrote:
> > It is not only the trace-point, this would also eliminate exception
> > handling in case the MSR access triggers a #GP. The "Unhandled MSR
> > read/write" messages would turn into a "General Protection Fault"
> > message.
> 
> But the early ones can trigger a #GP too. And there we can't handle
> those #GPs.
> 
> Why would the late ones need exception handling all of a sudden? And
> for the GHCB MSR, of all MSRs which the SEV-ES guest has used so far to
> bootstrap?!

For example when there is a bug in the code which triggers an SEV-ES-only
code-path at runtime on bare-metal or in a non-SEV-ES VM. When the MSR
is accessed accidentially in that code-path the exception handling will
be helpful.


	Joerg
