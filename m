Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A31C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9B92072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bhp9rRG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCTPyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:54:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44831 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbgCTPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584719639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZ5I0foREHEHB1ZAJPQnE/2EJVF50ZVraTnkaTMvS4U=;
        b=Bhp9rRG3JdVrYEFwp6TsjxQx0sHitFO1LZRUuJCXHs1PA7aeXQ2Yqpoqic+2+hLe6kaE//
        E9I5ES3wylEKOQvKUuIwfPi6IDdFXD5jjCgWyvjKmj/esdoT8tCTcuCwYUyUy04IhtsG11
        jKCn30hnM/e6/KN+hOPWaC8L5l3fwWY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-H88e7rz5PFeRcU5xpsqKgA-1; Fri, 20 Mar 2020 11:53:58 -0400
X-MC-Unique: H88e7rz5PFeRcU5xpsqKgA-1
Received: by mail-io1-f69.google.com with SMTP id n4so4963795ion.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZ5I0foREHEHB1ZAJPQnE/2EJVF50ZVraTnkaTMvS4U=;
        b=eHC0tKdM77Mfe1cWgiq1PdgvwBfzNzpgPq3s0rGKuHnPK0d8EaUYWZRVJMyf6FfEZz
         d9UbzxiMPdr0XQbkD1Aolv/WBrNYyjcG0gib0p2eHjTYnrLkPhx4m32pWjc9T9U5KmoG
         /rh01vFGBvE4lfiX4XANeZhUS0qzHP4lzRb5Uzc0Ca2LQko0aAiUVBsxHP8x9BURjDEQ
         P+j3HUocEc64l2X67of1MJlLsLlI89WTHvYZ/P9ysgFttWDDCrKMXQ3+VybOlC/+Nlz8
         G6wH+A066G2Rc95WZwv/PMf7o3w3X70n9plaCTHE+APNHuUPA3bpQ/20NYTEW78xyq2w
         +70g==
X-Gm-Message-State: ANhLgQ2GjtiYt7b/msp7h7UKl1t0b2UWCP5j2O+Ne1aFVkp+m6cwpRo6
        bX8E1PlF0ASpQs2OYalt+TegUxOyNZQ3RnF0r4szgadUrh/LxZYuBODFumL8thAJWDaI//60yCW
        rT3FNSSsDGaNE+IbDb98gqyDHAcOwbfmBFhUIFqIN
X-Received: by 2002:a92:c841:: with SMTP id b1mr8761747ilq.116.1584719637314;
        Fri, 20 Mar 2020 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuhq2+QdG1YvC8jNt4cSCZ3mGp1wrDWBwwLCmgYsoKFVe1Jx44eGDViyPog8JQBx657uLFE925fL+SkZEo6++A=
X-Received: by 2002:a92:c841:: with SMTP id b1mr8761711ilq.116.1584719636871;
 Fri, 20 Mar 2020 08:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <20200315012523.GC208715@linux.intel.com> <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
 <94ce05323c4de721c4a6347223885f2ad9f541af.camel@linux.intel.com>
 <CAOASepM1pp1emPwSdFcaRkZfFm6sNmwPCJH+iFMiaJpFjU0VxQ@mail.gmail.com>
 <5dc2ec4bc9433f9beae824759f411c32b45d4b74.camel@linux.intel.com>
 <20200316225322.GJ24267@linux.intel.com> <fa773504-4cc1-5cbd-c018-890f7a5d3152@intel.com>
 <20200316235934.GM24267@linux.intel.com> <ca2c9ac0-b717-ee96-c7df-4e39f03a9193@intel.com>
 <CAOASepN7n1XUGPQHwk2Vcu-dyyBJ7dwhM_mF_RcJa71PcNiLmA@mail.gmail.com>
 <a447fb5c-b3bd-ef82-ee5f-33be69796a27@intel.com> <CAOASepPZ727dKLNaus2wGY3CLNE1SNi-5QyvS5OMxcCYbN5Rdw@mail.gmail.com>
In-Reply-To: <CAOASepPZ727dKLNaus2wGY3CLNE1SNi-5QyvS5OMxcCYbN5Rdw@mail.gmail.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Fri, 20 Mar 2020 11:53:45 -0400
Message-ID: <CAOASepM4uWH=shAj17j9E=Q55GcWQg3T6p9b88XZSn2tzx2Tmw@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:01 AM Nathaniel McCallum
<npmccallum@redhat.com> wrote:
>
> On Tue, Mar 17, 2020 at 6:23 PM Xing, Cedric <cedric.xing@intel.com> wrote:
> >
> > On 3/17/2020 9:50 AM, Nathaniel McCallum wrote:
> > > On Mon, Mar 16, 2020 at 8:18 PM Xing, Cedric <cedric.xing@intel.com> wrote:
> > >>
> > >> On 3/16/2020 4:59 PM, Sean Christopherson wrote:
> > >>> On Mon, Mar 16, 2020 at 04:50:26PM -0700, Xing, Cedric wrote:
> > >>>> On 3/16/2020 3:53 PM, Sean Christopherson wrote:
> > >>>>> On Mon, Mar 16, 2020 at 11:38:24PM +0200, Jarkko Sakkinen wrote:
> > >>>>>>> My suggestions explicitly maintained robustness, and in fact increased
> > >>>>>>> it. If you think we've lost capability, please speak with specificity
> > >>>>>>> rather than in vague generalities. Under my suggestions we can:
> > >>>>>>> 1. call the vDSO from C
> > >>>>>>> 2. pass context to the handler
> > >>>>>>> 3. have additional stack manipulation options in the handler
> > >>>>>>>
> > >>>>>>> The cost for this is a net 2 additional instructions. No existing
> > >>>>>>> capability is lost.
> > >>>>>>
> > >>>>>> My vague generality in this case is just that the whole design
> > >>>>>> approach so far has been to minimize the amount of wrapping to
> > >>>>>> EENTER.
> > >>>>>
> > >>>>> Yes and no.   If we wanted to minimize the amount of wrapping around the
> > >>>>> vDSO's ENCLU then we wouldn't have the exit handler shenanigans in the
> > >>>>> first place.  The whole process has been about balancing the wants of each
> > >>>>> use case against the overall quality of the API and code.
> > >>>>>
> > >>>> The design of this vDSO API was NOT to minimize wrapping, but to allow
> > >>>> maximal flexibility. More specifically, we strove not to restrict how info
> > >>>> was exchanged between the enclave and its host process. After all, calling
> > >>>> convention is compiler specific - i.e. the enclave could be built by a
> > >>>> different compiler (e.g. MSVC) that doesn't share the same list of CSRs as
> > >>>> the host process. Therefore, the API has been implemented to pass through
> > >>>> virtually all registers except those used by EENTER itself. Similarly, all
> > >>>> registers are passed back from enclave to the caller (or the exit handler)
> > >>>> except those used by EEXIT. %rbp is an exception because the vDSO API has to
> > >>>> anchor the stack, using either %rsp or %rbp. We picked %rbp to allow the
> > >>>> enclave to allocate space on the stack.
> > >>>
> > >>> And unless I'm missing something, using %rcx to pass @leaf would still
> > >>> satisfy the above, correct?  Ditto for saving/restoring %rbx.
> > >>>
> > >>> I.e. a runtime that's designed to work with enclave's using a different
> > >>> calling convention wouldn't be able to take advantage of being able to call
> > >>> the vDSO from C, but neither would it take on any meaningful burden.
> > >>>
> > >> Not exactly.
> > >>
> > >> If called directly from C code, the caller would expect CSRs to be
> > >> preserved.
> > >
> > > Correct. This requires collaboration between the caller of the vDSO
> > > and the enclave.
> > >
> > >> Then who should preserve CSRs?
> > >
> > > The enclave.
> > >
> > >> It can't be the enclave
> > >> because it may not follow the same calling convention.
> > >
> > > This is incorrect. You are presuming there is not tight integration
> > > between the caller of the vDSO and the enclave. In my case, the
> > > integration is total and complete. We have working code today that
> > > does this.
> > >
> > >> Moreover, the
> > >> enclave may run into an exception, in which case it doesn't have the
> > >> ability to restore CSRs.
> > >
> > > There are two solutions to this:
> > > 1. Write the handler in assembly and don't return to C on AEX.
> > > 2. The caller can simply preserve the registers. Nothing stops that.
> > >
> > > We have implemented #1.
> > >
> > What if the enclave cannot proceed due to an unhandled exception so the
> > execution has to get back to the C caller of the vDSO API?
>
> mov $60, %rax
> mov $1, %rdi
> syscall
>
> We exit in all such cases.

Another solution is for the enclave to push the non-volatile registers
to the non-enclave stack upon entry and let the handler restore them.
That works for both EEXIT and AEX and you can return to C code then.

> > It seems to me the caller has to preserve CSRs by itself, otherwise it
> > cannot continue execution after any enclave exception. Passing @leaf in
> > %ecx will allow saving/restoring CSRs in C by setjmp()/longjmp(), with
> > the help of an exit handler. But if the C caller has already preserved
> > CSRs, why preserve CSRs again inside the enclave? It looks to me things
> > can be simplified only if the host process handles no enclave exceptions
> > (or exceptions inside the enclave will crash the calling thread). Thus
> > the only case of enclave EEXIT'ing back to its caller is considered
> > valid, hence the enclave will always be able to restore CSRs, so that
> > neither vDSO nor its caller has to preserve CSRs.
> >
> > Is my understanding correct?
> >

