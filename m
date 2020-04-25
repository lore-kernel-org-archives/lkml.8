Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF4C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6794D206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDYUXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:23:19 -0400
Received: from 8bytes.org ([81.169.241.247]:37050 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgDYUXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:23:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D1C8E433; Sat, 25 Apr 2020 22:23:17 +0200 (CEST)
Date:   Sat, 25 Apr 2020 22:23:16 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Mike Stunes <mstunes@vmware.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>,
        Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Message-ID: <20200425202316.GL21900@8bytes.org>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:47:31PM -0700, Andy Lutomirski wrote:
> I assume the race you mean is:
> 
> #VC
> Immediate NMI before IST gets shifted
> #VC
> 
> Kaboom.
> 
> How are you dealing with this?  Ultimately, I think that NMI will need
> to turn off IST before engaging in any funny business. Let me ponder
> this a bit.

Right, I dealt with that by unconditionally shifting/unshifting the #VC IST entry
in do_nmi() (thanks to Davin Kaplan for the idea). It might cause
one of the IST stacks to be unused during nesting, but that is fine. The
stack memory for #VC is only allocated when SEV-ES is active (in an
SEV-ES VM).

Regards,

	Joerg
