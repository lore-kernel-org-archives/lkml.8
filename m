Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E9EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C7206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veMpOTUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgCLVYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:24:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33116 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:24:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id g15so7911482otr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yneQvF1hJ6usEuyq8GRX0R/tqhEUa2ADiPsauSWrEoo=;
        b=veMpOTUUSKk1W5Plq7w4iE7Xt1rV0F4lX3yPBIvfpYb2t5xTRND3xkNjF9g+0xvqcY
         udwQD0tPcclqNbSWSOTjEVNFTTvEsXqM/8WgqlQCzk2RARQoL90+mVV1LH42xfvFxY84
         BFwWsOAkzSPw+cjGCzq/VZZlWWtI9rTgmHp0AN/namW0Ydo3EjAiuomey/w574B4pIAY
         Dug3uROiEIhpw8xk4zNUVLs8qpWMlTIKEmbM9qJYx1qXxkUUsPIi2IATNuUUsZAJWnjy
         U8CvEYAF5deAy9pojvLdDL8kyOsfTQVREiMVJUlytE7e+r+Cv7oAKrehSDgIVcSEQuNr
         i8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yneQvF1hJ6usEuyq8GRX0R/tqhEUa2ADiPsauSWrEoo=;
        b=FXg7H1i7sziFA/0UwiycZCyTgQ2tovLimdU14PSPtcuW3g6wJmZAkCTbdbjwp66MR8
         Eyb8fBW5h9aaGi6WeI2ZsrqMsdybTrh+Kva2USPtaQWK8Y0KzRu4YjvTqEqrqX2Q0S0k
         B6iPLpJOCGIjbitishxAmSvFJsg3LrhSnyd1DGe8noMhg4Li4zfPAWqMAte8gGI+j7Kb
         +lGffylrFv8xEw5awwf9vzMPJ/eDq/s4TJnEDD6cDd7gM69KKi3094j+MZPeTdjMMN0t
         2351i2FUINu3KQYO/hMdRqss8e4dMFTEtRc9zJo38Y267qm7JQmUp6lA0Y/nyx58UI10
         Wz9g==
X-Gm-Message-State: ANhLgQ2srkZMDoSGxVStaMdiT+pkIa2o7l3D+dgroHLmlIEv7V2drPrl
        ASILdNqxwWljID57H+mOqfDe+3diJgu+JWukltOBEA==
X-Google-Smtp-Source: ADFU+vt1skaCzP8TliGQbHDYNhthb6VYqsycJG+E3FvK2DBWiWqsqVXuZ72fekv6VyZiDHN5wUM39ikwyWWuxTZiomA=
X-Received: by 2002:a9d:69c5:: with SMTP id v5mr2878249oto.228.1584048273870;
 Thu, 12 Mar 2020 14:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <cb9b03b2a391b064573c152696d99017f76e8603.1584033751.git.jpoimboe@redhat.com>
 <DECA668C-B7EA-4663-8ABB-5B9E0495F498@amacapital.net>
In-Reply-To: <DECA668C-B7EA-4663-8ABB-5B9E0495F498@amacapital.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Mar 2020 22:24:07 +0100
Message-ID: <CAG48ez3xfARut-t38p=+Vx6mogESL4OFjJdjp=1F7Vukg4+ijg@mail.gmail.com>
Subject: Re: [PATCH 03/14] x86/entry/64: Fix unwind hints in register clearing code
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 8:29 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > On Mar 12, 2020, at 10:31 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrot=
e:
> > =EF=BB=BFThe PUSH_AND_CLEAR_REGS macro zeroes each register immediately=
 after
> > pushing it.  If an NMI or exception hits after a register is cleared,
> > but before the UNWIND_HINT_REGS annotation, the ORC unwinder will
> > wrongly think the previous value of the register was zero.  This can
> > confuse the unwinding process and cause it to exit early.
> >
> > Because ORC is simpler than DWARF, there are a limited number of unwind
> > annotation states, so it's not possible to add an individual unwind hin=
t
> > after each push/clear combination.  Instead, the register clearing
> > instructions need to be consolidated and moved to after the
> > UNWIND_HINT_REGS annotation.
>
> I don=E2=80=99t suppose you know how bad t he performance hit is on a non=
-PTI machine?
[...]
> > +    xorl    %edx,  %edx    /* nospec dx  */
> > +    xorl    %ecx,  %ecx    /* nospec cx  */
> > +    xorl    %r8d,  %r8d    /* nospec r8  */
> > +    xorl    %r9d,  %r9d    /* nospec r9  */
> > +    xorl    %r10d, %r10d    /* nospec r10 */
> > +    xorl    %r11d, %r11d    /* nospec r11 */
> > +    xorl    %ebx,  %ebx    /* nospec rbx */
> > +    xorl    %ebp,  %ebp    /* nospec rbp */
> > +    xorl    %r12d, %r12d    /* nospec r12 */
> > +    xorl    %r13d, %r13d    /* nospec r13 */
> > +    xorl    %r14d, %r14d    /* nospec r14 */
> > +    xorl    %r15d, %r15d    /* nospec r15 */

I'm curious what the reason for a performance impact would be. Are you
worried about the performance of the instruction decoder or the
renamer? As long as those aren't slowed down, this will just end up
giving the store uops to the backend earlier, right? (Since the XOR
instructions shouldn't reach the backend at all AKAIU.)
