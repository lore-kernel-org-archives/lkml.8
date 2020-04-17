Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB5C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9919B20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgDQNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:40:05 -0400
Received: from 8bytes.org ([81.169.241.247]:36194 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbgDQNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:40:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 01A40342; Fri, 17 Apr 2020 15:40:02 +0200 (CEST)
Date:   Fri, 17 Apr 2020 15:39:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 05/70] x86/insn: Make inat-tables.c suitable for
 pre-decompression code
Message-ID: <20200417133959.GE21900@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-6-joro@8bytes.org>
 <20200325153945.GD27261@zn.tnic>
 <20200327120232.c8e455ca100dc0d96e4ddc43@kernel.org>
 <20200416152406.GB4290@8bytes.org>
 <20200417215000.47141001f80005f41153d22e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417215000.47141001f80005f41153d22e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:50:00PM +0900, Masami Hiramatsu wrote:
> On Thu, 16 Apr 2020 17:24:06 +0200
> Joerg Roedel <joro@8bytes.org> wrote:

> Ah, I got it. So you intended to port the instruction decoder to
> pre-decompression boot code, correct?

Right, it is needed there to decode instructions which cause #VC
exceptions when running as an SEV-ES guest.

> > The call-site is added with the patch that includes the
> > instruction decoder into the pre-decompression code. If possible I'd
> > like to keep those things separate, as both patches are already pretty
> > big by themselfes (and they do different things, in different parts of
> > the code).
> 
> OK, if you will send v2, please CC both to me.

Will do, I added you to the cc-list for future posts of this series.


Regards,

	Joerg
