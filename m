Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D785AC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74B020409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgCJNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730578AbgCJNDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D0CEAECA;
        Tue, 10 Mar 2020 13:03:23 +0000 (UTC)
Date:   Tue, 10 Mar 2020 14:03:21 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200310130321.GH7028@suse.de>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
 <20200310124003.GE29372@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310124003.GE29372@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 01:40:03PM +0100, Borislav Petkov wrote:
> On Tue, Feb 25, 2020 at 09:42:07AM -0600, Tom Lendacky wrote:
> > @@ -135,6 +135,13 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
> >  	memset(desc, 0, sizeof(struct ioremap_desc));
> >  
> >  	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
> > +
> > +	/*
> > +	 * The EFI runtime services data area is not covered by walk_mem_res(),
> > +	 * but must be mapped encrypted when SEV is active.
> > +	 */
> > +	if (sev_active() && efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
> > +		desc->flags |= IORES_MAP_ENCRYPTED;
> >  }
> 
> Why isn't this done in __ioremap_check_encrypted() which is exactly for
> SEV stuff like that?

See the comment added in the patch, walk_mem_res() does not iterate over
the resource which contains EFI_RUNTIME_SERVICES_DATA, so
__ioremap_check_encrypted() will not be called on that resource.

walk_system_ram_range() might do the job, but calling it only for
EFI_RUNTIME_SERVICES_DATA has some overhead.

Regards,

	Joerg
