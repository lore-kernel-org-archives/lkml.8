Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13696C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFF72253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+Sjm1R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAWSWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:22:36 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36309 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAWSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:22:36 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so2810023iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8clo8dXG42zIL/L9nZL9Dx9XAGs9mrDLfnthhdfY8Y=;
        b=V+Sjm1R1nhL0npwIMsw08M2uOWP2QfGRS14RPBDTz1HEgswva+ntVT2eXOtui8fRNy
         NCFOqtf0cvErUsF7f97XV69guOe8TT24ZNf6Zi/1gX4Bqbi8+tmnD0/GsH0/fjJeYenJ
         besrC7mHrghalQX8hPFwTkWSeSAc2LZZa/mZJokhx6TEbgMFLVqGzCc+FxpGqTaD86aa
         G8FMlPcuJqDDfB7PC2NQrqQHqH4dou8KisqYDKqmCbq9uDiTAJ7PPpmZhHvTNPBIknGB
         /Fk/rwD3x/Ao8Az2ws4HSX6N++/TXTOqwRGAF5b1wBSrVHaRqcZObNq24D3rHg24D3Xu
         p5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8clo8dXG42zIL/L9nZL9Dx9XAGs9mrDLfnthhdfY8Y=;
        b=MPF0RkP+FWyW/FxiwvTIWSBk2QGPn1ffEKZyBopRx6ZF9T/pYdtDrjpev4TFvvJNfn
         oQ/bgRm0G+lwXxBHJoEGWebwifwVZ6xXFCNr1POpEMJTZ3pXrKyzYGzpyWnUs6gW78xp
         jrP0QfG3okwMqHGS2eHN1J/9dgGxNdTVeeG9BMxqky+040K7GnqJyUtjgq3T0Xdax71w
         9+2Bf8PobYv56LSIVizUwwZwHNXUged4Ml/RrfHJihPEzDrIsxWBRIQHce0dZlomZc0e
         mrl4nCPlLd1ACeHeq35Ugj85ZbCKHtxjz8PfiJTcSCLSlEMBHyKv5Gs5JrWrryHFKuvY
         ewwQ==
X-Gm-Message-State: APjAAAX6xCWqWagXIBWY1puh2GDWw7m2Ujww3nPp/vXxRLkr3P5sFvFH
        lINYuwB4nqGH2amyBixJxZ96nNqZ/UF/GP5PFgmiig==
X-Google-Smtp-Source: APXvYqzt9yyKrwX6qDon/KVWTbyRb5RYOyonsWZO6Z1k1vq4AHaWPOnc83kRw1cSE+bKh4+oY69Ric6NljkOVgt3JtE=
X-Received: by 2002:a92:8458:: with SMTP id l85mr13969531ild.296.1579803755413;
 Thu, 23 Jan 2020 10:22:35 -0800 (PST)
MIME-Version: 1.0
References: <1579749241-712-1-git-send-email-linmiaohe@huawei.com>
 <8736c6sga7.fsf@vitty.brq.redhat.com> <1a083ac8-3b01-fd2d-d867-2b3956cdef6d@redhat.com>
 <87wo9iqzfa.fsf@vitty.brq.redhat.com> <ee7d815f-750f-3d0e-2def-1631be66a483@redhat.com>
In-Reply-To: <ee7d815f-750f-3d0e-2def-1631be66a483@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 23 Jan 2020 10:22:24 -0800
Message-ID: <CALMp9eRRUY6a_QzbG-rHoZi5zc1YWHLk243=V2VBSQa=HL-Dpw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in
 handle_invvpid() default case
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 1:54 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/01/20 10:45, Vitaly Kuznetsov wrote:
> >>> SDM says that "If an
> >>> unsupported INVVPID type is specified, the instruction fails." and this
> >>> is similar to INVEPT and I decided to check what handle_invept()
> >>> does. Well, it does BUG_ON().
> >>>
> >>> Are we doing the right thing in any of these cases?
> >>
> >> Yes, both INVEPT and INVVPID catch this earlier.
> >>
> >> So I'm leaning towards not applying Miaohe's patch.
> >
> > Well, we may at least want to converge on BUG_ON() for both
> > handle_invvpid()/handle_invept(), there's no need for them to differ.
>
> WARN_ON_ONCE + nested_vmx_failValid would probably be better, if we
> really want to change this.
>
> Paolo

In both cases, something is seriously wrong. The only plausible
explanations are compiler error or hardware failure. It would be nice
to handle *all* such failures with a KVM_INTERNAL_ERROR exit to
userspace. (I'm also thinking of situations like getting a VM-exit for
INIT.)
