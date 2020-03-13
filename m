Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E66C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9800D20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB7qv3MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgCMPtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:49:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgCMPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584114548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8bUXgYRPclKxqAi1i8ua31qOg4xoF1OaWr/dXz7BtFg=;
        b=PB7qv3MGJ5OKDQlIBN1IlreYQPPYBFdN7c6jVxOOFSd7eApk8/pp1g0IWtlWWd24R81jEu
        20K8g8HA+Mh+gSQ8eF2mN+WP6eRLdIcDatbRykGdXkWCOksFT/Pa3OcWj0yzhRGlf+LHCk
        VKQCGNfv2s0OfQAP2Ep0QvysK4s3OoA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-rHnS7_p1NOW4Frx6D6UBhA-1; Fri, 13 Mar 2020 11:49:07 -0400
X-MC-Unique: rHnS7_p1NOW4Frx6D6UBhA-1
Received: by mail-io1-f70.google.com with SMTP id d13so6622375ioo.23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bUXgYRPclKxqAi1i8ua31qOg4xoF1OaWr/dXz7BtFg=;
        b=Wn5xg5S2932xM4mq89F+Fsj2L1cc2fsz/BpvMf7yJzsAa6bNKcHu0O+uPE61/yyNt5
         NeEKnGnBdiMIJrlAb2BGxIzHn6z5AQGQPaFtaqSKWrWPfpHBSGzCZIwASACttnQ1f19G
         Q8bZwvjhgBs2MqfSwpkNQP/w6wWq/RR2fHNYtwIWABKJzhD+FhCxERCiEmBpveyB+Ilw
         UYa3lw8422PvpqNO8LHL/sQ/ER68lEY0sfFbMYj5Eshbc5h/ZRaw4wZvokdqBU0sxNA2
         hu46EGKyfVfznjUIO1JVyhKlzKL7l28iTz+9q3qYehUxsoywbqLFn1I2vPd0z4vPKXW7
         lOuA==
X-Gm-Message-State: ANhLgQ0aIn+TmeCDryDQ1wFd7ld4rj7iClKch3Z3dWDoPUumx3h4WMYD
        T+7XXno+tDrnVNhXjsdSNjL7Mr7PIHLRlGAVavESndRkgxmwh7v9rprsE1+VoxfkIb9yV8EhnCo
        qFnSVqxMqLsCnqnRUsCF4WE6kRGmXwauAae+JBH3q
X-Received: by 2002:a6b:7e45:: with SMTP id k5mr8766341ioq.95.1584114546120;
        Fri, 13 Mar 2020 08:49:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuYcyP+1YgLDSvOwFVTwDXNeGAhQtzs36/oQAkHkt29OyCkLN7DT8mStsJSdhKPxb4+Es3hZFAGHreqpfLaNY4=
X-Received: by 2002:a6b:7e45:: with SMTP id k5mr8766298ioq.95.1584114545654;
 Fri, 13 Mar 2020 08:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com> <254f1e35-4302-e55f-c00d-0f91d9503498@fortanix.com>
In-Reply-To: <254f1e35-4302-e55f-c00d-0f91d9503498@fortanix.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Fri, 13 Mar 2020 11:48:54 -0400
Message-ID: <CAOASepOm8-2UCdEnVMopEprMGWjkYUbUTX++dHaqCafi2ju8mA@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        cedric.xing@intel.com, Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 1:38 PM Jethro Beekman <jethro@fortanix.com> wrote:
>
> On 2020-03-11 18:30, Nathaniel McCallum wrote:
> > On Tue, Mar 3, 2020 at 6:40 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> >>
> >> From: Sean Christopherson <sean.j.christopherson@intel.com>
> >>
> >> An SGX runtime must be aware of the exceptions, which happen inside an
> >> enclave. Introduce a vDSO call that wraps EENTER/ERESUME cycle and returns
> >> the CPU exception back to the caller exactly when it happens.
> >>
> >> Kernel fixups the exception information to RDI, RSI and RDX. The SGX call
> >> vDSO handler fills this information to the user provided buffer or
> >> alternatively trigger user provided callback at the time of the exception.
> >>
> >> The calling convention is custom and does not follow System V x86-64 ABI.
> >>
> >> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Co-developed-by: Cedric Xing <cedric.xing@intel.com>
> >> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> >> Tested-by: Jethro Beekman <jethro@fortanix.com>
> >> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> ---
> >>  arch/x86/entry/vdso/Makefile             |   2 +
> >>  arch/x86/entry/vdso/vdso.lds.S           |   1 +
> >>  arch/x86/entry/vdso/vsgx_enter_enclave.S | 187 +++++++++++++++++++++++
> >>  arch/x86/include/uapi/asm/sgx.h          |  37 +++++
> >>  4 files changed, 227 insertions(+)
> >>  create mode 100644 arch/x86/entry/vdso/vsgx_enter_enclave.S
> >>
> >> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> >> index 657e01d34d02..fa50c76a17a8 100644
> >> --- a/arch/x86/entry/vdso/Makefile
> >> +++ b/arch/x86/entry/vdso/Makefile
> >> @@ -24,6 +24,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)       := y
> >>
> >>  # files to link into the vdso
> >>  vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
> >> +vobjs-$(VDSO64-y)              += vsgx_enter_enclave.o
> >>
> >>  # files to link into kernel
> >>  obj-y                          += vma.o extable.o
> >> @@ -90,6 +91,7 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS
> >>  CFLAGS_REMOVE_vclock_gettime.o = -pg
> >>  CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
> >>  CFLAGS_REMOVE_vgetcpu.o = -pg
> >> +CFLAGS_REMOVE_vsgx_enter_enclave.o = -pg
> >>
> >>  #
> >>  # X32 processes use x32 vDSO to access 64bit kernel data.
> >> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> >> index 36b644e16272..4bf48462fca7 100644
> >> --- a/arch/x86/entry/vdso/vdso.lds.S
> >> +++ b/arch/x86/entry/vdso/vdso.lds.S
> >> @@ -27,6 +27,7 @@ VERSION {
> >>                 __vdso_time;
> >>                 clock_getres;
> >>                 __vdso_clock_getres;
> >> +               __vdso_sgx_enter_enclave;
> >>         local: *;
> >>         };
> >>  }
> >> diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >> new file mode 100644
> >> index 000000000000..94a8e5f99961
> >> --- /dev/null
> >> +++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >> @@ -0,0 +1,187 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +#include <linux/linkage.h>
> >> +#include <asm/export.h>
> >> +#include <asm/errno.h>
> >> +
> >> +#include "extable.h"
> >> +
> >> +#define EX_LEAF                0*8
> >> +#define EX_TRAPNR      0*8+4
> >> +#define EX_ERROR_CODE  0*8+6
> >> +#define EX_ADDRESS     1*8
> >> +
> >> +.code64
> >> +.section .text, "ax"
> >> +
> >> +/**
> >> + * __vdso_sgx_enter_enclave() - Enter an SGX enclave
> >> + * @leaf:      ENCLU leaf, must be EENTER or ERESUME
> >> + * @tcs:       TCS, must be non-NULL
> >> + * @e:         Optional struct sgx_enclave_exception instance
> >> + * @handler:   Optional enclave exit handler
> >> + *
> >> + * **Important!**  __vdso_sgx_enter_enclave() is **NOT** compliant with the
> >> + * x86-64 ABI, i.e. cannot be called from standard C code.
> >> + *
> >> + * Input ABI:
> >> + *  @leaf      %eax
> >> + *  @tcs       8(%rsp)
> >> + *  @e                 0x10(%rsp)
> >> + *  @handler   0x18(%rsp)
> >> + *
> >> + * Output ABI:
> >> + *  @ret       %eax
> >> + *
> >> + * All general purpose registers except RAX, RBX and RCX are passed as-is to
> >> + * the enclave. RAX, RBX and RCX are consumed by EENTER and ERESUME and are
> >> + * loaded with @leaf, asynchronous exit pointer, and @tcs respectively.
> >> + *
> >> + * RBP and the stack are used to anchor __vdso_sgx_enter_enclave() to the
> >> + * pre-enclave state, e.g. to retrieve @e and @handler after an enclave exit.
> >> + * All other registers are available for use by the enclave and its runtime,
> >> + * e.g. an enclave can push additional data onto the stack (and modify RSP) to
> >> + * pass information to the optional exit handler (see below).
> >> + *
> >> + * Most exceptions reported on ENCLU, including those that occur within the
> >> + * enclave, are fixed up and reported synchronously instead of being delivered
> >> + * via a standard signal. Debug Exceptions (#DB) and Breakpoints (#BP) are
> >> + * never fixed up and are always delivered via standard signals. On synchrously
> >> + * reported exceptions, -EFAULT is returned and details about the exception are
> >> + * recorded in @e, the optional sgx_enclave_exception struct.
> >> +
> >> + * If an exit handler is provided, the handler will be invoked on synchronous
> >> + * exits from the enclave and for all synchronously reported exceptions. In
> >> + * latter case, @e is filled prior to invoking the handler.
> >> + *
> >> + * The exit handler's return value is interpreted as follows:
> >> + *  >0:                continue, restart __vdso_sgx_enter_enclave() with @ret as @leaf
> >> + *   0:                success, return @ret to the caller
> >> + *  <0:                error, return @ret to the caller
> >> + *
> >> + * The userspace exit handler is responsible for unwinding the stack, e.g. to
> >> + * pop @e, u_rsp and @tcs, prior to returning to __vdso_sgx_enter_enclave().
> >> + * The exit handler may also transfer control, e.g. via longjmp() or a C++
> >> + * exception, without returning to __vdso_sgx_enter_enclave().
> >> + *
> >> + * Return:
> >> + *  0 on success,
> >> + *  -EINVAL if ENCLU leaf is not allowed,
> >> + *  -EFAULT if an exception occurs on ENCLU or within the enclave
> >> + *  -errno for all other negative values returned by the userspace exit handler
> >> + */
> >> +#ifdef SGX_KERNEL_DOC
> >> +/* C-style function prototype to coerce kernel-doc into parsing the comment. */
> >> +int __vdso_sgx_enter_enclave(int leaf, void *tcs,
> >> +                            struct sgx_enclave_exception *e,
> >> +                            sgx_enclave_exit_handler_t handler);
> >> +#endif
> >> +SYM_FUNC_START(__vdso_sgx_enter_enclave)
> >
> > Currently, the selftest has a wrapper around
> > __vdso_sgx_enter_enclave() which preserves all x86-64 ABI callee-saved
> > registers (CSRs), though it uses none of them. Then it calls this
> > function which uses %rbx but preserves none of the CSRs. Then it jumps
> > into an enclave which zeroes all these registers before returning.
> > Thus:
> >
> >   1. wrapper saves all CSRs
> >   2. wrapper repositions stack arguments
> >   3. __vdso_sgx_enter_enclave() modifies, but does not save %rbx
> >   4. selftest zeros all CSRs
> >   5. wrapper loads all CSRs
> >
> > I'd like to propose instead that the enclave be responsible for saving
> > and restoring CSRs. So instead of the above we have:
> >   1. __vdso_sgx_enter_enclave() saves %rbx
> >   2. enclave saves CSRs
> >   3. enclave loads CSRs
> >   4. __vdso_sgx_enter_enclave() loads %rbx
> >
> > I know that lots of other stuff happens during enclave transitions,
> > but at the very least we could reduce the number of instructions
> > through this critical path.
>()
> The current calling convention for __vdso_sgx_enter_enclave has been carefully designed to mimic just calling ENCLU[EENTER] as closely as possible.
>
> I'm not sure why you're referring to the selftest wrapper here, that doesn't seem relevant to me.

Thinking about this more carefully, I still think that at least part
of my critique still stands.

__vdso_sgx_enter_enclave() doesn't use the x86-64 ABI. This means that
there will always be an assembly wrapper for
__vdso_sgx_enter_enclave(). But because __vdso_sgx_enter_enclave()
doesn't save %rbx, the wrapper is forced to in order to be called from
C.

A common pattern for the wrapper will be to do something like this:

# void enter_enclave(rdi, rsi, rdx, unused, r8, r9, @tcs, @e,
@handler, @leaf, @vdso)
enter_enclave:
    push %rbx
    push $0 /* align */
    push 0x48(%rsp)
    push 0x48(%rsp)
    push 0x48(%rsp)

    mov 0x70(%rsp), %eax
    call *0x68(%rsp)

    add $0x20, %rsp
    pop %rbx
    ret

Because __vdso_sgx_enter_enclave() doesn't preserve %rbx, the wrapper
is forced to reposition stack parameters in a performance-critical
path. On the other hand, if __vdso_sgx_enter_enclave() preserved %rbx,
you could implement the above as:

# void enter_enclave(rdi, rsi, rdx, unused, r8, r9, @tcs, @e,
@handler, @leaf, @vdso)
enter_enclave:
    mov 0x20(%rsp), %eax
    jmp *0x28(%rsp)

This also implies that if __vdso_sgx_enter_enclave() took @leaf as a
stack parameter and preserved %rbx, it would be x86-64 ABI compliant
enough to call from C if the enclave preserves all callee-saved
registers besides %rbx (Enarx does).

What are the downsides of this approach? It also doesn't harm the more
extended case when you need to use an assembly wrapper to setup
additional registers. This can still be done. It does imply an extra
push and mov instruction. But because there are currently an odd
number of stack function parameters, the push also removes an
alignment instruction where the stack is aligned before the call to
__vdso_sgx_enter_enclave() (likely). Further, the push and mov are
going to be performed by *someone* in order to call
__vdso_sgx_enter_enclave() from C.

Therefore, I'd like to propose that __vdso_sgx_enter_enclave():
  * Preserve %rbx.
  * Take the leaf as an additional stack parameter instead of passing
it in %rax.

Then C can call it without additional overhead. And people who need to
"extend" the C ABI can still do so.

