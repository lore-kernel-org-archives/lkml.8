Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E26C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1143206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgA2RH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:07:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:36373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgA2RH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:07:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 09:07:26 -0800
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="223890527"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 09:07:26 -0800
Date:   Wed, 29 Jan 2020 09:07:25 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129132618.GA30979@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 02:26:18PM +0100, Borislav Petkov wrote:
> On Tue, Jan 28, 2020 at 12:06:53PM -0800, Linus Torvalds wrote:
> > On Tue, Jan 28, 2020 at 11:51 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > >         ALTERNATIVE_2 \
> > >                 "cmp  $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
> > >                 "movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM, \
> > >                 "cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
> > 
> > Note the UNTESTED part.
> > 
> > In particular, I didn't check what the priority for the alternatives
> > is. Since FSRM being set always implies ERMS being set too, it may be
> > that the ERMS case is always picked with the above code.

So I wrote a tiny function to test (rather than wrestle with trying
to disassemble the post-alternative patched binary of the running system):

        .globl  feature
        .type   feature, @function
feature:
        .cfi_startproc
       ALTERNATIVE_2 \
               "movl    $1, %eax", \
               "movl    $2, %eax", X86_FEATURE_FSRM, \
               "movl    $3, %eax", X86_FEATURE_ERMS

        ret

This returns "3" ... not what we want. But swapping the ERMS/FSRM order
gets the correct version.

> And yes, your idea makes sense to use ALTERNATIVE_2 but as it is, it
> triple-faults my guest. I'll debug it more later to find out why, when I
> get a chance.

Triple fault is a surprise.  As long as you have ERMS, it shouldn't
hurt to take the FSRM code path.

Does the code that performs the patch use memmove() to copy the alternate
version into place? That could get ugly!

I'm not in the same city as my test machine, so I'm going to defer testing
Linus' patch (with FSRM/ERMS swapped) until I'm near enough to poke it
if it breaks.

-Tony
