Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F206206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GOHk7ZNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgFDPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:20:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgFDPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:20:00 -0400
Received: from zn.tnic (p200300ec2f112d0035262982e5edc845.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2d00:3526:2982:e5ed:c845])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CEA41EC0118;
        Thu,  4 Jun 2020 17:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591283999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v9mztibqlfJ/JLIFyImy9Q9qLirhr2kGLDWk5NuYc4Q=;
        b=GOHk7ZNT2JDKJZmzMCdd5ncsxdBtJ1WHI3JpBPGUDAkVXAd85NgVuWzqUzOfQmaZdUu940
        a7IhnG5aPPNkpl1OkaM3bTFrDqJDi9bC3qCWYfBupJVuZh/oWYxRKXYVZ/z8vWsDn0Y9ax
        RIzQH1SGrPjgRb2qcSl81uulBZZChEA=
Date:   Thu, 4 Jun 2020 17:19:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
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
Message-ID: <20200604151945.GB2246@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-41-joro@8bytes.org>
 <20200520091415.GC1457@zn.tnic>
 <20200604115413.GB30945@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200604115413.GB30945@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:54:13PM +0200, Joerg Roedel wrote:
> It is not only the trace-point, this would also eliminate exception
> handling in case the MSR access triggers a #GP. The "Unhandled MSR
> read/write" messages would turn into a "General Protection Fault"
> message.

But the early ones can trigger a #GP too. And there we can't handle
those #GPs.

Why would the late ones need exception handling all of a sudden? And
for the GHCB MSR, of all MSRs which the SEV-ES guest has used so far to
bootstrap?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
