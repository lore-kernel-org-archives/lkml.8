Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C45E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgCSQMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:12:49 -0400
Received: from 8bytes.org ([81.169.241.247]:53926 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCSQMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:12:48 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 885FC217; Thu, 19 Mar 2020 17:12:47 +0100 (CET)
Date:   Thu, 19 Mar 2020 17:12:46 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 42/70] x86/sev-es: Support nested #VC exceptions
Message-ID: <20200319161245.GD5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-43-joro@8bytes.org>
 <CALCETrXiWjALMTcG=92DmMn_H=yR88e0-3cj8CjTAjtjTvBR8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXiWjALMTcG=92DmMn_H=yR88e0-3cj8CjTAjtjTvBR8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:46:36AM -0700, Andy Lutomirski wrote:
> This can't possibly end well.  Maybe have a little percpu list of
> GHCBs and make sure there are enough for any possible nesting?

Yeah, it is not entirely robust yet. Without NMI nesting the number of
possible #VC nesting levels should be limited. At least one backup GHCB
pre-allocated is probably a good idea.

> Also, I admit confusion.  Isn't the GHCB required to be unencrypted?
> How does that work with kzalloc()?

Yes, but the kzalloc'ed ghcb is just the backup space for the real GHCB,
which is mapped unencrypted. The contents of the unencrypted GHCB is
copied to the backup and restored on return, so that the interrupted #VC
handler finds the GHCB unmodified.

Regards,

	Joerg
