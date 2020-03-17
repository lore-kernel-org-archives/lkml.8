Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA0C5ACBF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF6620724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYu1cTfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCQQu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:50:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49438 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgCQQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584463823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BnQjMX3riXTqLuP61/bkfPEBMDRDn7tr+gKn5UnCig0=;
        b=VYu1cTfXocT6UKsJHOh6GtkuCRkmVQ9hfGIGYdtOXoVZ5r911DtmMFFLRVQ0WYcF1ERFMj
        vPKZ+YCvHL99jJOx5pwLDR/usGgj7UE4Cqe32v+BwDy3I4v2PJ9yvLvHskyfefKl2ZCgjm
        fLbNleuHQRmcN8ggpXGGddV7OjAlL+s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-ggyRTRbWM_6oAUAmNv5SAw-1; Tue, 17 Mar 2020 12:50:21 -0400
X-MC-Unique: ggyRTRbWM_6oAUAmNv5SAw-1
Received: by mail-io1-f72.google.com with SMTP id q22so6254594ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnQjMX3riXTqLuP61/bkfPEBMDRDn7tr+gKn5UnCig0=;
        b=GFFS/1v2owraJwJyxo00DHMZbdHioumh4VnvX/MtFI9Bw5n0Is4XdWPJFf+DjZm15h
         4/HAuwfcq2bPuok5L+Z63F/N905kdDArnIpf1TyfqxDO2W0oFaqReF6vq6FE1gAcjgUW
         0VRh957PKIPN/qFZs8u9+V25fPkUSVIwo6kr7MZ2zkq/gbYLQoVb3U385U+dsX4eXDEA
         TcnMsUBFj8od4kBlI20oSK/XgBEKN5Egsidcjvu030Fd2fPKbqQIGYXY3HyMNeE242cr
         M3iT1MK7LE9Pum4CS8uHQM8SHdh/irnKmbAzlWI8D/LcRcxFY103ZeHj3bZcghp4bVUm
         Wwjg==
X-Gm-Message-State: ANhLgQ3SvTM/B/y1xLDFenAakWo1YCMZbeVR5KSqxliPLaj6m7y0IUZn
        WOa8G7wtRj4VSqik4cD/RG7fCMvkHxRBu2OWGLvtzXx9gI68RwKvW/ewogNrzyhUWOuIhPvmZTD
        VR1nsYdkeGNrOjB2aLIfoMFzXwMDw3RoHpR1yLTcj
X-Received: by 2002:a92:c841:: with SMTP id b1mr2523700ilq.116.1584463820735;
        Tue, 17 Mar 2020 09:50:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUGpVkJwtMHPGqE1iBtLPCrgEboZp3yvc7d4nU4uFAWhb4ybA3lVwDdeIK2rTgOxNdiYyT9yhdB527oV9KI1Y=
X-Received: by 2002:a92:c841:: with SMTP id b1mr2523652ilq.116.1584463820374;
 Tue, 17 Mar 2020 09:50:20 -0700 (PDT)
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
In-Reply-To: <ca2c9ac0-b717-ee96-c7df-4e39f03a9193@intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Tue, 17 Mar 2020 12:50:09 -0400
Message-ID: <CAOASepN7n1XUGPQHwk2Vcu-dyyBJ7dwhM_mF_RcJa71PcNiLmA@mail.gmail.com>
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

On Mon, Mar 16, 2020 at 8:18 PM Xing, Cedric <cedric.xing@intel.com> wrote:
>
> On 3/16/2020 4:59 PM, Sean Christopherson wrote:
> > On Mon, Mar 16, 2020 at 04:50:26PM -0700, Xing, Cedric wrote:
> >> On 3/16/2020 3:53 PM, Sean Christopherson wrote:
> >>> On Mon, Mar 16, 2020 at 11:38:24PM +0200, Jarkko Sakkinen wrote:
> >>>>> My suggestions explicitly maintained robustness, and in fact increased
> >>>>> it. If you think we've lost capability, please speak with specificity
> >>>>> rather than in vague generalities. Under my suggestions we can:
> >>>>> 1. call the vDSO from C
> >>>>> 2. pass context to the handler
> >>>>> 3. have additional stack manipulation options in the handler
> >>>>>
> >>>>> The cost for this is a net 2 additional instructions. No existing
> >>>>> capability is lost.
> >>>>
> >>>> My vague generality in this case is just that the whole design
> >>>> approach so far has been to minimize the amount of wrapping to
> >>>> EENTER.
> >>>
> >>> Yes and no.   If we wanted to minimize the amount of wrapping around the
> >>> vDSO's ENCLU then we wouldn't have the exit handler shenanigans in the
> >>> first place.  The whole process has been about balancing the wants of each
> >>> use case against the overall quality of the API and code.
> >>>
> >> The design of this vDSO API was NOT to minimize wrapping, but to allow
> >> maximal flexibility. More specifically, we strove not to restrict how info
> >> was exchanged between the enclave and its host process. After all, calling
> >> convention is compiler specific - i.e. the enclave could be built by a
> >> different compiler (e.g. MSVC) that doesn't share the same list of CSRs as
> >> the host process. Therefore, the API has been implemented to pass through
> >> virtually all registers except those used by EENTER itself. Similarly, all
> >> registers are passed back from enclave to the caller (or the exit handler)
> >> except those used by EEXIT. %rbp is an exception because the vDSO API has to
> >> anchor the stack, using either %rsp or %rbp. We picked %rbp to allow the
> >> enclave to allocate space on the stack.
> >
> > And unless I'm missing something, using %rcx to pass @leaf would still
> > satisfy the above, correct?  Ditto for saving/restoring %rbx.
> >
> > I.e. a runtime that's designed to work with enclave's using a different
> > calling convention wouldn't be able to take advantage of being able to call
> > the vDSO from C, but neither would it take on any meaningful burden.
> >
> Not exactly.
>
> If called directly from C code, the caller would expect CSRs to be
> preserved.

Correct. This requires collaboration between the caller of the vDSO
and the enclave.

> Then who should preserve CSRs?

The enclave.

> It can't be the enclave
> because it may not follow the same calling convention.

This is incorrect. You are presuming there is not tight integration
between the caller of the vDSO and the enclave. In my case, the
integration is total and complete. We have working code today that
does this.

> Moreover, the
> enclave may run into an exception, in which case it doesn't have the
> ability to restore CSRs.

There are two solutions to this:
1. Write the handler in assembly and don't return to C on AEX.
2. The caller can simply preserve the registers. Nothing stops that.

We have implemented #1.

> So it has to be done by the vDSO API.

Nope. See above.

> That
> means CSRs will be overwritten upon enclave exits, which violates the
> goal of "passing all registers back to the caller except those used by
> EEXIT".

All registers get passed to the handler in this scenario, not the caller.

The approach is as follows: the vDSO is callable by C so long as the
enclave respects the ABI *OR* the handler patches up any enclave
deviation from the ABI.

