Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F05C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D0E20775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLHHvMca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGISlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGISlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:41:05 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A5C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:41:05 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o3so2870601ilo.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJQldr4+VKrEQsjFpeywG2H0CUaXEr03YCsdEkG+QHU=;
        b=sLHHvMcaaw8F8Vc2qUuZTPf0IOPqoaIrg15SnfkoSsQmKU1+z+Xx3tk6XwpKmXSnaj
         W1BEXXfegRmyrI7K/2oTAPrzFILjPz3KB7Tqr54DRPZxyGQs3JbShF2FYSxh30PJVIqm
         Ty8WWF6+Ucg9fMASWJszsePs+ghbxuknkGkVkfITDrRs4rNfHofSslmeUjTT4XFeZFDZ
         dbkU/YKhBu1a3I+POGNOjJPmTJaA4gbyV3+QANd1agBsHBPmp+VJ2D3TDedQgfSWnx1M
         wm3y9hAHi3kKcadop2Dy/D9nbKdtz+KS3woGn9ItvMWJRZl9zaj9oObwlRII/3MjIWwG
         w5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJQldr4+VKrEQsjFpeywG2H0CUaXEr03YCsdEkG+QHU=;
        b=HCun716S6h3KrdO8iFpTqzS7wEb9t/GtMvs5//uMqpXfYMqCG7zjj4/mai3cO5fWZP
         PSRX4ZT4RUVMgztJRlnMI4JmCK8eSk14yN+ltGX0m+R/VW2WJNPSd3ZHcOCs+Dy6Pws5
         iAlCc9FYGGZ3KDF6twlY4sdrMf14aLZxxDDsz+b7cY0Pt48w2shE+CwQlBlE92nAeSE4
         VTWLQsF4PmwrAWBYxU91nnBAcCHV8Gn461m/3g6JCpWa1skvepyfinlpewKaGFtEa157
         HwM6GDPTlj9hZxGxsb4l5yen2URqA248ZIezYFNH2+2nhvu/LO0NX3zwbbZwHYXUkQWG
         6J2Q==
X-Gm-Message-State: AOAM532tMOd4oFMA3eWyCDZHV31QUXoUxcZL8S3oQU7WbsCKDpB4mSdV
        xnJJQ8ytLhuKEAkBKGjdbsb7PUnQdadFrTMejI/8jg==
X-Google-Smtp-Source: ABdhPJxUhfmTOSdMHniBtR0MgiiEHBwdV0hZSBl2vpyCS+aoz3HFiQw7kcr/bpfFq9jTLI/nJrrymrJQSdKsbrYwHxw=
X-Received: by 2002:a05:6e02:de6:: with SMTP id m6mr47488213ilj.296.1594320064774;
 Thu, 09 Jul 2020 11:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200709095525.907771-1-pbonzini@redhat.com> <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
 <782fdf92-38f8-c081-9796-5344ab3050d5@redhat.com> <CALMp9eRSvdx+UHggLbvFPms3Li2KY-RjZhjGjcQ3=GbSB1YyyA@mail.gmail.com>
 <717a1b5d-1bf3-5f72-147a-faccd4611b87@redhat.com>
In-Reply-To: <717a1b5d-1bf3-5f72-147a-faccd4611b87@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Jul 2020 11:40:53 -0700
Message-ID: <CALMp9eThSjLY92-WURobbJBHRKLxGuYPLBWMnq+=FxxYHquTiw@mail.gmail.com>
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

On Thu, Jul 9, 2020 at 11:31 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/07/20 20:28, Jim Mattson wrote:
> >> That said, the VMCB here is guest memory and it can change under our
> >> feet between nested_vmcb_checks and nested_prepare_vmcb_save.  Copying
> >> the whole save area is overkill, but we probably should copy at least
> >> EFER/CR0/CR3/CR4 in a struct at the beginning of nested_svm_vmrun; this
> >> way there'd be no TOC/TOU issues between nested_vmcb_checks and
> >> nested_svm_vmrun.  This would also make it easier to reuse the checks in
> >> svm_set_nested_state.  Maybe Maxim can look at it while I'm on vacation,
> >> as he's eager to do more nSVM stuff. :D
> >
> > I fear that nested SVM is rife with TOCTTOU issues.
>
> I am pretty sure about that, actually. :)
>
> Another possibility to stomp them in a more efficient manner could be to
> rely on the dirty flags, and use them to set up an in-memory copy of the
> VMCB.

That sounds like a great idea! Is Maxim going to look into that?
