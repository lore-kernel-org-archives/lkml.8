Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7BC206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahp/vhh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCMQIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:08:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgCMQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584115688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBLvGUzHFvIP3IVSZ/c85odnzZRogFcsQVQP2EXP6J4=;
        b=ahp/vhh9VJARD7R3oY4mkkMCgNdERVNc9ocjIdc/K/mtd6iFvXTWo2Qye/rhsd/xt2vCWw
        a11EzkFu9HmP9oOBdrzNi9RTheakjPZGNgxuL+ZjeTyjHd6eAhQdWbJ6vfJ+GIDkVInTaH
        r1u8EpUCJzJZreG/c6pPCfR1SmMPzKc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-R8YqYZH4PNWL515Mxk00TA-1; Fri, 13 Mar 2020 12:08:07 -0400
X-MC-Unique: R8YqYZH4PNWL515Mxk00TA-1
Received: by mail-il1-f198.google.com with SMTP id u9so1475654iln.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBLvGUzHFvIP3IVSZ/c85odnzZRogFcsQVQP2EXP6J4=;
        b=Gmnb8yVLhP/dynCTZlJXPL8F7wPW7Nchb20xA2vWWpEqTShYCTTCFF3n27PQouObuF
         fibedJW0bQjNlEVXt0+Qjdwt0cAPtr7N5+81BqjwHU+6WA9kMVNTS6yMLWaIvnUpsmnX
         avG+zIi6DKU5Kr9S4wVAWCJ6D1whR6bNfMDzRNLCjNaIliexNpaoLqQlXbjlMaJKBI/E
         lDut0NAFtbbYv6IqnNcwA7fIE/nKOc4KApY0NMSLU7zNHbYE+vocNO6LvAUuWVexAwfW
         nPQ5Wt2AwNjVF33Co1O2EeQXMgugQkm5FPQk8rxHU6ze6bLhhBWe46gAnEYbtijytcac
         +QIQ==
X-Gm-Message-State: ANhLgQ3L+5uXYdwE5p0X62BmC6m13G+Mxzu8CwjY01+w1OilcpMweJKD
        70XZxjEmy7f+Crq1vN0FAxFdg2BkHOiDjAUh84BC6uGPUiEIw/Z5fBnifH+GJIO4tfDDegKW2p8
        zN8trS0zSMmwlYE60mFMUqKYQLHRsgWinlUvqhqwr
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr14650327ils.86.1584115686327;
        Fri, 13 Mar 2020 09:08:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsRX7xXbdN9pKVmaa7xC0rKq8tThI8Bh2C5Erfi6nuMwFeJvnu5PGc/GZS27u6Ahub/3KQaFmtVV8xgkMODcg4=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr14650290ils.86.1584115685968;
 Fri, 13 Mar 2020 09:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepO2=KCzT+wdXWz2tUNvi6NyzNJ3KwvBMtH_P1TO8Yr_mQ@mail.gmail.com> <20200313005252.GA1292@linux.intel.com>
In-Reply-To: <20200313005252.GA1292@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Fri, 13 Mar 2020 12:07:55 -0400
Message-ID: <CAOASepMN1fmDaPjJJ-rpbLNPGUzE2LNB69s3X5mDBEhXziZ_UQ@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        cedric.xing@intel.com, Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 8:52 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Mar 11, 2020 at 03:30:44PM -0400, Nathaniel McCallum wrote:
> > On Tue, Mar 3, 2020 at 6:40 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > + * The exit handler's return value is interpreted as follows:
> > > + *  >0:                continue, restart __vdso_sgx_enter_enclave() with @ret as @leaf
> > > + *   0:                success, return @ret to the caller
> > > + *  <0:                error, return @ret to the caller
> > > + *
> > > + * The userspace exit handler is responsible for unwinding the stack, e.g. to
> > > + * pop @e, u_rsp and @tcs, prior to returning to __vdso_sgx_enter_enclave().
> >
> > Unless I misunderstand, this documentation...
>
> Hrm, that does appear wrong.  I'm guessing that was leftover from a previous
> incarnation of the code.  Or I botched the description, which is just as
> likely.

I figured out what happened on my end. This documentation error led me
to misread the code. More below.

> > > + * The exit handler may also transfer control, e.g. via longjmp() or a C++
> > > + * exception, without returning to __vdso_sgx_enter_enclave().
> > > + *
> > > + * Return:
> > > + *  0 on success,
> > > + *  -EINVAL if ENCLU leaf is not allowed,
> > > + *  -EFAULT if an exception occurs on ENCLU or within the enclave
> > > + *  -errno for all other negative values returned by the userspace exit handler
> > > + */
>
> ...
>
> > > +       /* Load the callback pointer to %rax and invoke it via retpoline. */
> > > +       mov     0x20(%rbp), %rax
> > > +       call    .Lretpoline
> > > +
> > > +       /* Restore %rsp to its post-exit value. */
> > > +       mov     %rbx, %rsp
> >
> > ... doesn't seem to match this code.
> >
> > If the handler pops from the stack and then we restore the stack here,
> > the handler had no effect.
> >
> > Also, one difference between this interface and a raw ENCLU[EENTER] is
> > that we can't pass arguments on the untrusted stack during EEXIT. If
> > we want to support that workflow, then we need to allow the ability
> > for the handler to pop "additional" values without restoring the stack
> > pointer to the exact value here.
>
> > Also, one difference between this interface and a raw ENCLU[EENTER] is
> > that we can't pass arguments on the untrusted stack during EEXIT. If
> > we want to support that workflow, then we need to allow the ability
> > for the handler to pop "additional" values without restoring the stack
> > pointer to the exact value here.
>
> The callback shenanigans exist precisely to allow passing arguments on the
> untrusted stack.  The vDSO is very careful to preserve the stack memory
> above RSP, and to snapshot RSP at the time of exit, e.g. the arguments in
> memory and their addresses relative to u_rsp live across EEXIT.  It's the
> same basic concept as regular function calls, e.g. the callee doesn't pop
> params off the stack, it just knows what addresses relative to RSP hold
> the data it wants.  The enclave, being the caller, is responsible for
> cleaning up u_rsp.
>
> FWIW, if the handler reaaaly wanted to pop off the stack, it could do so,
> fixup the stack, and then re-call __vdso_sgx_enter_enclave() instead of
> returning (to the original __vdso_sgx_enter_enclave()).

My understanding from the documentation issue above was that *if* you
wanted to push parameters back on the stack during enclave exit, you
would *have* to supply a handler so it could pop the parameters and
reset the stack. Which is why restoring %rsp from %rbx didn't make
sense to me.

Related to my other message in this thread, if
__vdso_sgx_enter_enclave() preserved %rbx and took @leaf as a stack
parameter, you could call __vdso_sgx_enter_enclave() from C so long as
the enclave didn't push return arguments on the stack. A workaround
for that case would be to fix up the stack in the handler. It would be
enough for the handler to simply set %rbx to the desired stack
location and return (though all of this unclean of course).

> > > +       /*
> > > +        * If the return from callback is zero or negative, return immediately,
> > > +        * else re-execute ENCLU with the postive return value interpreted as
> > > +        * the requested ENCLU leaf.
> > > +        */
> > > +       cmp     $0, %eax
> > > +       jle     .Lout
> > > +       jmp     .Lenter_enclave
> > > +
> > > +.Lretpoline:
> > > +       call    2f
> > > +1:     pause
> > > +       lfence
> > > +       jmp     1b
> > > +2:     mov     %rax, (%rsp)
> > > +       ret
> > > +       .cfi_endproc
> > > +
> > > +_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
>

