Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11119C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14552084D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596654700;
	bh=+orqcmMUx4wxaMB9/tQ3uZegiQO+qPJJ8gk9VLAh5zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DLfkbOQ9LdtCk0unW7dLcXds4K3AjrCK3oteTTbqCU8wpB+xUXPPgZQGMDbJSltWO
	 D1GZ+VB/we/lWxu0w5v15EKI+RM4OHZJogwWEzbloeMM30jlL3otEZmIi8pTZwn1FM
	 Zqp3qMIf3FKHQvQaJB/wGqsWyDcje28Yb/FDLSK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgHETL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgHESaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:30:20 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABB22310D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596652126;
        bh=+orqcmMUx4wxaMB9/tQ3uZegiQO+qPJJ8gk9VLAh5zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VWPAwtdomtPlOEYpApBm0RJG0+rh5r5Fx6XZ7HhNy56z9KhVhQ9Q4O9yNsyuWKfM3
         biIAcbAYb9keWj8iPDEVluOBvymJypjy5yMPc/tXmThUkWpgMrjfKPNsIEcmvNz30e
         HKF/N21EFPS49yM7wvprq2QV5B7AXUzGdVKaFIa4=
Received: by mail-wr1-f41.google.com with SMTP id a14so41653413wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:28:45 -0700 (PDT)
X-Gm-Message-State: AOAM532jIxThxBCv5u49u+nWP2w3HayZjdOakg+s/d5r08bkfCtSavEN
        48OdR693fTeYBjwjGC3Vaj5bR8EdLPkKdQVp9eo8NA==
X-Google-Smtp-Source: ABdhPJw0T73JhpPablAM0weF5CdOo7RMDuTXYhROjwPq7A2D3w0EFQfTjsbQ7zXQqefzQ2gXJGI+6d2aG6nYRsojZ3E=
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr3831077wrw.70.1596652124048;
 Wed, 05 Aug 2020 11:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
 <20200805044840.GA9127@nazgul.tnic> <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com>
 <20200805050808.GC9127@nazgul.tnic> <20200805170717.GB26661@ranerica-svr.sc.intel.com>
In-Reply-To: <20200805170717.GB26661@ranerica-svr.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Aug 2020 11:28:31 -0700
X-Gmail-Original-Message-ID: <CALCETrWByBugaunKPz52sdOGJpEdNNMK2kcp-wXgjFpFZuoOmQ@mail.gmail.com>
Message-ID: <CALCETrWByBugaunKPz52sdOGJpEdNNMK2kcp-wXgjFpFZuoOmQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:07 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Aug 05, 2020 at 07:08:08AM +0200, Borislav Petkov wrote:
> > On Tue, Aug 04, 2020 at 09:58:25PM -0700, hpa@zytor.com wrote:
> > > Because why use an alternative to jump over one instruction?
> > >
> > > I personally would prefer to have the IRET put out of line
> >
> > Can't yet - SERIALIZE CPUs are a minority at the moment.
> >
> > > and have the call/jmp replaced by SERIALIZE inline.
> >
> > Well, we could do:
> >
> >       alternative_io("... IRET bunch", __ASM_SERIALIZE, X86_FEATURE_SERIALIZE, ...);
> >
> > and avoid all kinds of jumping. Alternatives get padded so there
> > would be a couple of NOPs following when SERIALIZE gets patched in
> > but it shouldn't be a problem. I guess one needs to look at what gcc
> > generates...
>
> But the IRET-TO-SELF code has instruction which modify the stack. This
> would violate stack invariance in alternatives as enforced in commit
> 7117f16bf460 ("objtool: Fix ORC vs alternatives"). As a result, objtool
> gives warnings as follows:
>
> arch/x86/kernel/alternative.o: warning: objtool: do_sync_core()+0xe:
> alternative modifies stack
>
> Perhaps in this specific case it does not matter as the changes in the
> stack will be undone by IRET. However, using alternative_io would require
> adding the macro STACK_FRAME_NON_STANDARD to functions using sync_core().
> IMHO, it wouldn't look good.
>
> So maybe the best approach is to implement as you suggested using
> static_cpu_has()?

I agree.  Let's keep it simple.

Honestly, I think the right solution is to have iret_to_self() in
actual asm and invoke it from C as needed.  IRET is *slow* -- trying
to optimize it at all is silly.  The big optimization was switching
from CPUID to IRET, since CPUID is slooooooooooooooooooow in virtual
environments, whereas IRET is merely sloooooooow and SERIALIZE is
probably just sloooow.

(I once benchmarked it.  IIRC the winning version on my laptop is MOV
to CR2 on bare metal and IRET in a Xen PV guest.  This optimization
was not obviously worthwhile.)

>
> Thanks and BR,
> Ricardo
