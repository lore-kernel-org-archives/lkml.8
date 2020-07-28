Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF7AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C259C20792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqBFbZ1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgG1RN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgG1RN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:13:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AACC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:13:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so9186560ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7RHcaI6/eTe56IzgJ5p2FT6CPrKQOVowAeyYJ5JZY8=;
        b=hqBFbZ1EIlbZWPYoCsixxDe1MAR9ZiNu7XW7VsFaOGKOrul7BN73reE5RP2wJUhIMi
         soM8CTX6M0sE6+8mXj356oFq7afSTEN3raZmVx7Iw6ZX1LBvJkmNf8BeFWhXyWgTt5QO
         sX/uSn8oNMCt4QDEShDFJ7/oldS98rYaGFuedhtSNN+eDif4oEixlTqZPeAbfbXRDt/U
         cFfLAi/d75TyOrcppGsnsrwsy1s6s4M/K5qeJH4Qg2x2NnVDLWg00bUa+RswtIAz0yV8
         uZjiyPSCrman08np7drF5ovs+s0yYro3RLrjtBQtnu85Srj/Kdbt8DZ3cLk/3fN4nkny
         9iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7RHcaI6/eTe56IzgJ5p2FT6CPrKQOVowAeyYJ5JZY8=;
        b=mfv7W5KeIHQttUDkbuJoru19nFXy1ewUReTuFRJDy6no/tavlksBdTALR0Nmw1JGwS
         Xv2S5Nph+9Zwq8Ut/gDVzS68C2WLVgNMOfucubqAG3wQvBALaFLxuq5/2S1rzYDGvALO
         ttDfKYAqSbSCk9rJ37EqBvNekFHUe3uJKLDHd/SlVOb1ng7UfBRZ7WB05GPZ7ZDdaAIU
         c9LsP5IU6irENA2DaOcYgA0+9uusNgxHRV0IyBb/YLVz0j3kFbD7XEPlVM1sZNVp3hcB
         6pqp93pD5e4kaK3bgSTJsAjXCCj6ZA4oS+KetARdpx2V3qrolAfIHh/AUprNiATx3Nto
         RIgg==
X-Gm-Message-State: AOAM531pq/CxpU1NOWxgE2THxGEtSxxy6MoM4fq9KuyIFjR7de67KSO4
        uxg4oCBBYk4MLtf3XOKvCpbIp4K3LexnBF/pwV0LfA==
X-Google-Smtp-Source: ABdhPJzma4OqnK14EV4esOOkgwzNHy5xbaUVnJne8BaCRpJN0GzCX3/MLC6Rh5rtpUGBJ1dGDwx7gOeDEISxL4P9YPA=
X-Received: by 2002:a05:6638:164e:: with SMTP id a14mr9658222jat.18.1595956404815;
 Tue, 28 Jul 2020 10:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200728004446.932-1-graf@amazon.com> <87d04gm4ws.fsf@vitty.brq.redhat.com>
 <a1f30fc8-09f5-fe2f-39e2-136b881ed15a@amazon.com>
In-Reply-To: <a1f30fc8-09f5-fe2f-39e2-136b881ed15a@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 10:13:13 -0700
Message-ID: <CALMp9eQ3OxhQZYiHPiebX=KyvjWQgxQEO-owjSoxgPKsOMRvjw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Deflect unknown MSR accesses to user space
To:     Alexander Graf <graf@amazon.com>,
        Aaron Lewis <aaronlewis@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 5:41 AM Alexander Graf <graf@amazon.com> wrote:
>
>
>
> On 28.07.20 10:15, Vitaly Kuznetsov wrote:
> >
> > Alexander Graf <graf@amazon.com> writes:
> >
> >> MSRs are weird. Some of them are normal control registers, such as EFER.
> >> Some however are registers that really are model specific, not very
> >> interesting to virtualization workloads, and not performance critical.
> >> Others again are really just windows into package configuration.
> >>
> >> Out of these MSRs, only the first category is necessary to implement in
> >> kernel space. Rarely accessed MSRs, MSRs that should be fine tunes against
> >> certain CPU models and MSRs that contain information on the package level
> >> are much better suited for user space to process. However, over time we have
> >> accumulated a lot of MSRs that are not the first category, but still handled
> >> by in-kernel KVM code.
> >>
> >> This patch adds a generic interface to handle WRMSR and RDMSR from user
> >> space. With this, any future MSR that is part of the latter categories can
> >> be handled in user space.

This sounds similar to Peter Hornyack's RFC from 5 years ago:
https://www.mail-archive.com/kvm@vger.kernel.org/msg124448.html.

> >> Furthermore, it allows us to replace the existing "ignore_msrs" logic with
> >> something that applies per-VM rather than on the full system. That way you
> >> can run productive VMs in parallel to experimental ones where you don't care
> >> about proper MSR handling.
> >>
> >
> > In theory, we can go further: userspace will give KVM the list of MSRs
> > it is interested in. This list may even contain MSRs which are normally
> > handled by KVM, in this case userspace gets an option to mangle KVM's
> > reply (RDMSR) or do something extra (WRMSR). I'm not sure if there is a
> > real need behind this, just an idea.
> >
> > The problem with this approach is: if currently some MSR is not
> > implemented in KVM you will get an exit. When later someone comes with a
> > patch to implement this MSR your userspace handling will immediately get
> > broken so the list of not implemented MSRs effectively becomes an API :-)

Indeed. This is a legitimate concern. At Google, we have experienced
this problem already, using Peter Hornyack's approach. We ended up
commenting out some MSRs from kvm, which is less than ideal.

> Yeah, I'm not quite sure how to do this without bloating the kernel's
> memory footprint too much though.
>
> One option would be to create a shared bitmap with user space. But that
> would need to be sparse and quite big to be able to address all of
> today's possible MSR indexes. From a quick glimpse at Linux's MSR
> defines, there are:
>
>    0x00000000 - 0x00001000 (Intel)
>    0x00001000 - 0x00002000 (VIA)
>    0x40000000 - 0x50000000 (PV)
>    0xc0000000 - 0xc0003000 (AMD)
>    0xc0010000 - 0xc0012000 (AMD)
>    0x80860000 - 0x80870000 (Transmeta)
>
> Another idea would be to turn the logic around and implement an
> allowlist in KVM with all of the MSRs that KVM should handle. In that
> API we could ask for an array of KVM supported MSRs into user space.
> User space could then bounce that array back to KVM to have all in-KVM
> supported MSRs handled. Or it could remove entries that it wants to
> handle on its own.
>
> KVM internally could then save the list as a dense bitmap, translating
> every list entry into its corresponding bit.
>
> While it does feel a bit overengineered, it would solve the problem that
> we're turning in-KVM handled MSRs into an ABI.

It seems unlikely that userspace is going to know what to do with a
large number of MSRs. I suspect that a small enumerated list will
suffice. In fact, +Aaron Lewis is working on upstreaming a local
Google patch set that does just that.
