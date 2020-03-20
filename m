Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E7C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8DB20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCTTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:48:53 -0400
Received: from 8bytes.org ([81.169.241.247]:54648 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTTsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 15:48:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4F2324CA; Fri, 20 Mar 2020 20:48:51 +0100 (CET)
Date:   Fri, 20 Mar 2020 20:48:49 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 70/70] x86/sev-es: Add NMI state tracking
Message-ID: <20200320194849.GJ5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-71-joro@8bytes.org>
 <CALCETrUOQneBHjoZkP-7T5PDijb=WOyv7xF7TD0GLR2Aw77vyA@mail.gmail.com>
 <20200319160749.GC5122@8bytes.org>
 <CALCETrXY5M87C1Fc3QvTkc6MdbQ_3gAuOPUeWJktAzK4T60QNQ@mail.gmail.com>
 <20200319192654.GD611@suse.de>
 <CALCETrXzyUGjPYBR_NDSvTG8TqLuQP2Q+v_mwXPne4O0U-18NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXzyUGjPYBR_NDSvTG8TqLuQP2Q+v_mwXPne4O0U-18NA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 02:27:49PM -0700, Andy Lutomirski wrote:
> AIUI the shift-ist stuff is because we aren't very good about the way
> that we handle tracing right now, and that can cause a limited degree
> of recursion.  #DB uses IST for historical reasons that don't
> necessarily make sense.  Right now, we need it for only one reason:
> the MOV SS issue.  IIRC this isn't actually triggerable without
> debugging enabled -- MOV SS with no breakpoint but TF on doesn't seem
> to malfunction quite as badly.

I had a look at the shift_ist stuff today and it looks like a good
solution to the #VC nesting problem when it is turned into a #VC
handler. The devil is in the details, of course, as 3 or 4 stacks for
the #VC handler (per cpu) should only be allocated when actually running
in an SEV-ES guest. Let's see how this works out in practice.

Regards,

	Joerg
