Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9BFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFD721531
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593982557;
	bh=Er1cSupQus9TnIpV2t16NGTYwoMgLeV2WAfF/89/hpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uq7NeY/vE+XkX7qWZs1GCFCRFXtHn2aQYD/WZN31H8EQyzTMZ0Rbs524n/x0Pe/R5
	 iJmJyiuCyDVw6ber0pzWpSVyvzFSyVn3e7FgzQfVx9iUcrtEuhBS/KF4QSL4JRfhRo
	 3MKOuFYb2neo8fzxSpXYE9oQ0TQiFjJLtZJlYyzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGEUz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgGEUzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:55:55 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D984821919
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593982555;
        bh=Er1cSupQus9TnIpV2t16NGTYwoMgLeV2WAfF/89/hpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXjOt4fK68MU3jlvN3QsElD7RRwGxT7ogtTD+y3gmOyHQFztDUn3l7EVlSAM3c52j
         Npt+YkGIyndAVBE1xBjf4BQUOOXjXgZ+hV3Zob2ML66OTRH7nfFplsWphGjLOGOOpN
         4uF5bmejh4qSEf+0lmfzpEf0IBMG7wyAWo0ST/58=
Received: by mail-wm1-f54.google.com with SMTP id o8so37082718wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:55:54 -0700 (PDT)
X-Gm-Message-State: AOAM531ouUavOcT1xaysp0iitWfOOkl/oXFFCUW72/7DQYZOjOs4b80y
        l9PQli7mnPLObsUVsmiUuTfkmifh+uHcu5ChNp8Llg==
X-Google-Smtp-Source: ABdhPJwEhRKGcZrOM6YtAyEC4U3024d9j6rfeBXjMlWVMgaTuFbzng9N4g1JFrUcvOTgj4XIctOZQg6SDR2w1cjYssI=
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr45880509wmb.21.1593982553413;
 Sun, 05 Jul 2020 13:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200629214956.GA12962@linux.intel.com> <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-3-dpreed@deepplum.com> <CALCETrVZx4VA9rg-Hn7KdER866ZOtZtmTkR0MSacnj5jGO-Pag@mail.gmail.com>
 <1593978728.059424180@apps.rackspace.com>
In-Reply-To: <1593978728.059424180@apps.rackspace.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 5 Jul 2020 13:55:42 -0700
X-Gmail-Original-Message-ID: <CALCETrVCEP6bLrwTYg7h_Rx-XHEsOXT4QZ=BnwpReM-n8eco6g@mail.gmail.com>
Message-ID: <CALCETrVCEP6bLrwTYg7h_Rx-XHEsOXT4QZ=BnwpReM-n8eco6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu
 on crash or panic
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 12:52 PM David P. Reed <dpreed@deepplum.com> wrote:
>
> Thanks, will handle these. 2 questions below.
>
> On Sunday, July 5, 2020 2:22pm, "Andy Lutomirski" <luto@kernel.org> said:
>
> > On Sat, Jul 4, 2020 at 1:38 PM David P. Reed <dpreed@deepplum.com> wrote:
> >>
> >> Fix: Mask undefined operation fault during emergency VMXOFF that must be
> >> attempted to force cpu exit from VMX root operation.
> >> Explanation: When a cpu may be in VMX root operation (only possible when
> >> CR4.VMXE is set), crash or panic reboot tries to exit VMX root operation
> >> using VMXOFF. This is necessary, because any INIT will be masked while cpu
> >> is in VMX root operation, but that state cannot be reliably
> >> discerned by the state of the cpu.
> >> VMXOFF faults if the cpu is not actually in VMX root operation, signalling
> >> undefined operation.
> >> Discovered while debugging an out-of-tree x-visor with a race. Can happen
> >> due to certain kinds of bugs in KVM.
> >
> > Can you re-wrap lines to 68 characters?  Also, the Fix: and
>
> I used 'scripts/checkpatch.pl' and it had me wrap to 75 chars:
> "WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)"
>
> Should I submit a fix to checkpatch.pl to say 68?

75 is probably fine too, but something is odd about your wrapping.
You have long lines mostly alternating with short lines.  It's as if
you wrote 120-ish character lines and then wrapped to 75 without
reflowing.

>
> > Explanation: is probably unnecessary.  You could say:
> >
> > Ignore a potential #UD failut during emergency VMXOFF ...
> >
> > When a cpu may be in VMX ...
> >
> >>
> >> Fixes: 208067 <https://bugzilla.kernel.org/show_bug.cgi?id=208067>
> >> Reported-by: David P. Reed <dpreed@deepplum.com>
> >
> > It's not really necessary to say that you, the author, reported the
> > problem, but I guess it's harmless.
> >
> >> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> >> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Suggested-by: Andy Lutomirski <luto@kernel.org>
> >> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> >> ---
> >>  arch/x86/include/asm/virtext.h | 20 ++++++++++++++------
> >>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> >> index 0ede8d04535a..0e0900eacb9c 100644
> >> --- a/arch/x86/include/asm/virtext.h
> >> +++ b/arch/x86/include/asm/virtext.h
> >> @@ -30,11 +30,11 @@ static inline int cpu_has_vmx(void)
> >>  }
> >>
> >>
> >> -/* Disable VMX on the current CPU
> >> +/* Exit VMX root mode and isable VMX on the current CPU.
> >
> > s/isable/disable/
> >
> >
> >>  /* Disable VMX if it is supported and enabled on the current CPU
> >> --
> >> 2.26.2
> >>
> >
> > Other than that:
> >
> > Reviewed-by: Andy Lutomirski <luto@kernel.org>
>
> As a newbie, I have a process question - should I resend the patch with the 'Reviewed-by' line, as well as correcting the other wording? Thanks!

Probably.  Sometimes a maintainer will apply the patch and make these
types of cosmetic changes, but it's easier if you resubmit.  That
being said, for non-urgent patches, it's usually considered polite to
wait a day or two to give other people a chance to comment.

--Andy
