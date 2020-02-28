Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D81246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582916697;
	bh=UesoGr7t/2MKstHF09Zw/YmrCnhxnd6E/ryWREAGKVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1UDsV/k5EU7tdT2mAX0DnokQCHOzSbBIlymrxBg6MLq8+/dHbJ9YG2F0fYGKWsnbI
	 w2GUX7dKFpxrIGhNpyRgRSf9CuEqux7ScZ5q6+xV2I7NMvV54RJUhBthnJvbmdjvHb
	 cgxeCqyFwemGUW+PJEV2w0WGmrmYMvcgggTMIKcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB1TE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1TEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:04:55 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1273246A2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582916695;
        bh=UesoGr7t/2MKstHF09Zw/YmrCnhxnd6E/ryWREAGKVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fFJM2FCuy7QFdGXgSKrkP85wNsyoiCzc3v9IgqBr+GgCOg+zvEnQX1bggwEdzBF+X
         rQ2SrDsWqaUkeeWDZo4appgz1vd22jVoc9s3p7/sGsEZkH6a6K7Dxz/Sn1yA3VHSxW
         WJFpOmIWN7jucic+pi4Hl9lw1JZ0iTt47TTaFyY4=
Received: by mail-wr1-f46.google.com with SMTP id z15so4269685wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:04:54 -0800 (PST)
X-Gm-Message-State: APjAAAVMKrxVLdEi7DV/Gt6zTD2NTlqs4omoSlfufPOCf6xCcXsHHdzU
        D9imOBuYXSc3dl2sWm24jh7kG2qVTsJk5UBPqUjjOA==
X-Google-Smtp-Source: APXvYqz9C+Iv+4ybH2afVkhhwrf/0BdhKo9MdU1cz23vp2xqg8SYqWklTH5/w3c6agKrCvvZScsbAf0CMaFBSYCWX7A=
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr6026862wrm.70.1582916693251;
 Fri, 28 Feb 2020 11:04:53 -0800 (PST)
MIME-Version: 1.0
References: <6bf68d0facc36553324c38ec798b0feebf6742b7.1582915284.git.luto@kernel.org>
 <c80e3380-d484-1b01-a638-0ee130dea11a@redhat.com>
In-Reply-To: <c80e3380-d484-1b01-a638-0ee130dea11a@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 11:04:41 -0800
X-Gmail-Original-Message-ID: <CALCETrUG0B2QLYYp8h+5KiZ4LpVDZ00XEPsgh4DbbDX9Mx5-EQ@mail.gmail.com>
Message-ID: <CALCETrUG0B2QLYYp8h+5KiZ4LpVDZ00XEPsgh4DbbDX9Mx5-EQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm: Handle async page faults directly through do_page_fault()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/02/20 19:42, Andy Lutomirski wrote:
> > KVM overloads #PF to indicate two types of not-actually-page-fault
> > events.  Right now, the KVM guest code intercepts them by modifying
> > the IDT and hooking the #PF vector.  This makes the already fragile
> > fault code even harder to understand, and it also pollutes call
> > traces with async_page_fault and do_async_page_fault for normal page
> > faults.
> >
> > Clean it up by moving the logic into do_page_fault() using a static
> > branch.  This gets rid of the platform trap_init override mechanism
> > completely.
> >
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Just one thing:
>
> > @@ -1505,6 +1506,25 @@ do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
> >               unsigned long address)
> >  {
> >       prefetchw(&current->mm->mmap_sem);
> > +     /*
> > +      * KVM has two types of events that are, logically, interrupts, but
> > +      * are unfortunately delivered using the #PF vector.
>
> At least the not-present case isn't entirely an interrupt because it
> must be delivered precisely.  Regarding the page-ready case you're
> right, it could be an interrupt. However, generally speaking this is not
> a problem.  Using something in memory rather than overloading the error
> code was the mistake.



>
> > +      * These events are
> > +      * "you just accessed valid memory, but the host doesn't have it right
> > +      * not, so I'll put you to sleep if you continue" and "that memory
> > +      * you tried to access earlier is available now."
> > +      *
> > +      * We are relying on the interrupted context being sane (valid
> > +      * RSP, relevant locks not held, etc.), which is fine as long as
> > +      * the the interrupted context had IF=1.
>
> This is not about IF=0/IF=1; the KVM code is careful about taking
> spinlocks only with IRQs disabled, and async PF is not delivered if the
> interrupted context had IF=0.  The problem is that the memory location
> is not reentrant if an NMI is delivered in the wrong window, as you hint
> below.

If an async PF is delivered with IF=0, then, unless something else
clever happens to make it safe, we are toast.  The x86 entry code
cannot handle #PF (or most other entries) at arbitrary places.  I'll
improve the comment in v2.
