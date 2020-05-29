Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BEDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DF1207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5ksG3vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2GU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2GUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:20:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B2C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:20:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g18so1058013qtu.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaCv60IMH52sUYhN54rT0QVhCZ6BwcvDQ3ZQJ0otRwE=;
        b=t5ksG3vBG8mzwriDRQrhjAiehLlzbA6q5Td4aMNrrByTsP4SRy78jcfyqAMEj3Xc3H
         g2HwyefnUitQtySfNIc3ObQ6W+sMM4UUn7Eg+8lcHS9GlhvPq5P4+s9M9gTYxP5AhJQV
         8q7uDAHdOZrE8UKueNfK+VXVFl1ng35kopi/Yc0mEYCij77qIss2RyjotbZ7beZ44I79
         8dQy8Rl2KeLpQwwL6otZgJu9M14azOgMx/NEz2l33/wOtbMHRh9NJ/yFraEX9oAXwE/x
         VjNkItxQIy7dUpL3QkAYJJ85m6YECPzR15Y5XMZUCP/qf4MmYRT7xr/SW1sPyBQHBi3K
         W7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaCv60IMH52sUYhN54rT0QVhCZ6BwcvDQ3ZQJ0otRwE=;
        b=WwDjIIsSvBpT4XDCdVBMIbre1k22xHZuQqs2zdarE3x7OhoLxnfUzKSnd3T8KgZ5Gu
         hg+GtCuF8zWTAWLPqImY/h7nVOmw7f6YGQpsEqFbgm9Em7pJUI9h/M+PVEI9gzfetuzw
         o/BbdfFIcKKVsynO+ehtkZf22bGpFeYLPTYAQgvWhlP+i24zyiP3vkucpxP6ltDF+FBc
         bPMDfMqQCf4ehSBDMhGSvAbgRPIHjbRlNlp+6iycBsmi9g+8EUBRa7LWx5ZFZ34tZNAZ
         G/rsnTW3nDZ+M6WBPDNAVK/JohEJlIt/BcCMUiuodJerziqxpz9CiooMhH+5HDm/U+aR
         Bydw==
X-Gm-Message-State: AOAM530zdE2rP7zoGTeel0ceNwQYCmGCx9S+G/6Bpu2d2eWERVkOh7Cp
        LZHQxfxeDmexvJTkI5+60re0fAeGqLtOZbpmFk1YNg==
X-Google-Smtp-Source: ABdhPJyIvJmxz2v0s7V5YP/64F/YebBn88XYFdU95gvRmcex/D+LC4NZ+tX/rrr/SoYZjD4LX2kGnptt+1aLjBK7ADQ=
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr6695716qtc.257.1590733223244;
 Thu, 28 May 2020 23:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000840d4d05a6850c73@google.com> <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
 <20200528161143.GF2869@paulmck-ThinkPad-P72> <878shbols9.fsf@nanos.tec.linutronix.de>
 <20200528204839.GR2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200528204839.GR2869@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 May 2020 08:20:12 +0200
Message-ID: <CACT4Y+bVPSZVkWJquu5gk11ymhirsFvVFYHkexjqgBkgga379w@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, May 28, 2020 at 10:19:02PM +0200, Thomas Gleixner wrote:
> > Paul,
> >
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > On Thu, May 28, 2020 at 03:33:44PM +0200, Thomas Gleixner wrote:
> > >> syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com> writes:
> > >> Weird. I have no idea how that thing is an EQS here.
> > >
> > > No argument on the "Weird" part!  ;-)
> > >
> > > Is this a NO_HZ_FULL=y kernel?
> >
> > No, it has only NO_HZ_IDLE.
> >
> >   https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
>
> OK, from the .config, another suggestion is to build the kernel
> with CONFIG_RCU_EQS_DEBUG=y.  This still requires that this issue be
> reproduced, but it might catch the problem earlier.

How much does it slow down execution? If we enable it on syzbot, it
will affect all fuzzing done by syzbot always.
It can tolerate significant slowdown and it's far from a production
kernel (it enables KASAN, KCOV, LOCKDEP and more). But I am still
asking because some debugging features are built without performance
in mind at all (like let's just drop a global lock in every
kmalloc/free, which may be too much even for a standard debug build).


> > > If so, one possibility is that the call
> > > to rcu_user_exit() went missing somehow.  If not, then RCU should have
> > > been watching userspace execution.
> > >
> > > Again, the only thing I can think of (should this prove to be
> > > reproducible) is the rcu_dyntick trace event.
> >
> > :)
> >
> > Thanks,
> >
> >         tglx
>
>                                                         Thanx, Paul
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200528204839.GR2869%40paulmck-ThinkPad-P72.
