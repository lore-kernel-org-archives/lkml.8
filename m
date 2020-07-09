Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA202078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwaWKxJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGIS2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGIS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:28:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E4C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:28:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q74so3396963iod.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zjs+rIBBj6MrxntmJxcLKegx38dFb1Uyu8eE1it5wg=;
        b=gwaWKxJvSK5tHnvv6KDqfs/WIspheIA1bzQ3YgabM9QKy2rzT4HNP1lPPS/H1qS4xt
         FNYPUI0Fd6nh2BOqEDkNIRjhg68UOxU6LLjqet3IruG8ax/fcivVw+UOiE0A8M43gHpZ
         Ey+aea76o+UfwUlN/OyVdWgxT4oqcJAyXiEFBdV3P57YO3kEpJ/RS4/OSlaVcI1iir2o
         wcaMut+gck89mop3SCn1LvFENY/PTVZhsCdFUiIUSuqhKskucMCYeqU4LFI4tY9HlUC3
         Kh/ZQiXHJvffMoMC1zYo+N31cqd7MhypUazR4kBwZOBGW2CuX0AN2Q9FABALvRAKFd64
         y7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zjs+rIBBj6MrxntmJxcLKegx38dFb1Uyu8eE1it5wg=;
        b=hhG2jrObKYafdGLYCcJf+kBnFji0wRJ/dGkJLXXwdT8ugNZ3jELDhw3EFw6KYmb14e
         389pI7YvESnEBtrpeppP1qcB0y1sLZikiHHqO/TqYzvJrFwXVLJQjg/OsgjX8gX8EjjJ
         lbNJqEOpQf3UI5D9PfA60Jmqlm6SEmwbdEURRmfmX9WArtV296Qt4EiWVNG4X62tFwzc
         q0/T1F4tyPOF+KaPzi0op2Ae3p45g/cnpLSr8zdUSJulcL852n2AIKJRjFv8t877FsIQ
         3ujF+dyPEiEnv0kp64ybPHdqp9MJq0CLDeGyAfM68ZyGyp0iAhR/tUkorTpuFkY3GVRr
         TDSg==
X-Gm-Message-State: AOAM530MaqupdgF7ANdqq48kdBR/7uBE83a8MlIJ969cs852kgNXKeHZ
        NQOcPaEI9MCDTK4LQCxCl846UGqNVKeMZ6Dr0QkoWQ==
X-Google-Smtp-Source: ABdhPJyR8OKtUqECdG1gGuhcnIRkURaY1y6wimMMYrouaPEN+AintJIUGjyWo4+P2h/irUAQmQb2QC2/MfGpAbcghys=
X-Received: by 2002:a5e:c311:: with SMTP id a17mr14217665iok.12.1594319316616;
 Thu, 09 Jul 2020 11:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200709095525.907771-1-pbonzini@redhat.com> <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
 <782fdf92-38f8-c081-9796-5344ab3050d5@redhat.com>
In-Reply-To: <782fdf92-38f8-c081-9796-5344ab3050d5@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Jul 2020 11:28:25 -0700
Message-ID: <CALMp9eRSvdx+UHggLbvFPms3Li2KY-RjZhjGjcQ3=GbSB1YyyA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: vmentry ignores EFER.LMA and possibly RFLAGS.VM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 10:25 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/07/20 19:12, Jim Mattson wrote:
> >> +
> >> +       /* The processor ignores EFER.LMA, but svm_set_efer needs it.  */
> >> +       efer &= ~EFER_LMA;
> >> +       if ((nested_vmcb->save.cr0 & X86_CR0_PG)
> >> +           && (nested_vmcb->save.cr4 & X86_CR4_PAE)
> >> +           && (efer & EFER_LME))
> >> +               efer |= EFER_LMA;
> > The CR4.PAE check is unnecessary, isn't it? The combination CR0.PG=1,
> > EFER.LMA=1, and CR4.PAE=0 is not a legal processor state.

Oops, I meant EFER.LME above.

Krish pointed out that I was quoting from Intel's documentation. The
same constraints are covered in Table 14-5 of AMD's APM, volume 2.

> Yeah, I was being a bit cautious because this is the nested VMCB and it
> can be filled in with invalid state, but indeed that condition was added
> just yesterday by myself in nested_vmcb_checks (while reviewing Krish's
> CR0/CR3/CR4 reserved bit check series).

From Canonicalization and Consistency Checks of section 15.5 in AMD's
APM, volume 2:

The following conditions are considered illegal state combinations:
...
EFER.LME and CR0.PG are both set and CR4.PAE is zero.

This VMCB state should result in an immediate #VMEXIT with exit code -1.

> That said, the VMCB here is guest memory and it can change under our
> feet between nested_vmcb_checks and nested_prepare_vmcb_save.  Copying
> the whole save area is overkill, but we probably should copy at least
> EFER/CR0/CR3/CR4 in a struct at the beginning of nested_svm_vmrun; this
> way there'd be no TOC/TOU issues between nested_vmcb_checks and
> nested_svm_vmrun.  This would also make it easier to reuse the checks in
> svm_set_nested_state.  Maybe Maxim can look at it while I'm on vacation,
> as he's eager to do more nSVM stuff. :D

I fear that nested SVM is rife with TOCTTOU issues.
