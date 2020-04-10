Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E51C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA862078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr88S+VC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJJrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:47:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35471 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:47:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id b10so1007293oic.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tzg1tHziELvZQ3o5qR7exMV835Cs9K0+FEoadxQ1B5o=;
        b=Dr88S+VCT4svySlUrD2xr3WlASw5FYW271Zc+V8NWdDjPDbNtELUcibffqW7AJZPsV
         D9QcU86PUYZrKepDD8qwREMkh0lfTO9V1glabOCkJ4gHM8rZabTRneDHzozmakayjeIq
         s/kuOZWK9Qf4Yfhtp8jUirvJXpqk+Lhf+pBeqLfD21z0tV229EY+t//oYXx6GFyBCw6q
         RKzJ512PSGdX8pdxiRxT5P9HOEN5Ytl/z0sWzx0/TFPEAeki6O0gzgGwhbEDHfLgq12V
         vkI9o30irYVW0YiFPATG9o3mZBKQjB4sD2jiMAg5jgkzx9+9KB6iYORuAer2ZRq+eJWR
         R1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzg1tHziELvZQ3o5qR7exMV835Cs9K0+FEoadxQ1B5o=;
        b=RWsiobUeiGCq4iGMY7lAZvDVgQN4so5Bi7rORgTSu/9pX4hnmJFS0vgYXCLFWqU6by
         uWFQDiPOJDxcrltNs6L4BBdsjgyaGFE8zw0uFLLJDH6QR8Gk9a/ycV9xjPN4Hi136V6H
         1h8uHvtLhBded/EKTUDhOzxS1K0+JMOGpyCOi72BblCkATuJdCU2nrLKMZCPsTUNZeDJ
         1m3xNBEfIPKnB2OBrT8kYgoj4UHI4AlKJN9/pBvKM0EgArEdyQjQ6RL7WDiNg+5fjDiD
         oYfyGGWP5IvoClKilQYDBK4pL5WBDiOOumCngZC1NzvAZhnidEY2wpgc5lUEjJddNpOU
         wP2A==
X-Gm-Message-State: AGi0PuakUnqrSslm6IrB73bFsVHdhj1PyVlRXEHjinqAwxt4eIB9AFMg
        hyA22c1jziV3F8ZXoVEcJ6yJFcRF6vyDa18R8YngTw==
X-Google-Smtp-Source: APiQypLbrI/BG5gn1gvEeXgPVufwP/l9HFf5GU/vBOyLLwt/UnWl0iuMUMgMJbixyKmMHJDBfVR1IVVsr0GDq6YtJfs=
X-Received: by 2002:a54:481a:: with SMTP id j26mr2758242oij.172.1586512054759;
 Fri, 10 Apr 2020 02:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw> <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
 <017E692B-4791-46AD-B9ED-25B887ECB56B@lca.pw> <CANpmjNMiHNVh3BVxZUqNo4jW3DPjoQPrn-KEmAJRtSYORuryEA@mail.gmail.com>
 <B7F7F73E-EE27-48F4-A5D0-EBB29292913E@lca.pw> <CANpmjNMEgc=+bLU472jy37hYPYo5_c+Kbyti8-mubPsEGBrm3A@mail.gmail.com>
 <2730C0CC-B8B5-4A65-A4ED-9DFAAE158AA6@lca.pw> <CANpmjNNUn9_Q30CSeqbU_TNvaYrMqwXkKCA23xO4ZLr2zO0w9Q@mail.gmail.com>
 <B5F0F530-911E-4B75-886A-9D8C54FF49C8@lca.pw> <DF45D739-59F3-407C-BE8C-2B1E164B493B@lca.pw>
In-Reply-To: <DF45D739-59F3-407C-BE8C-2B1E164B493B@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Apr 2020 11:47:23 +0200
Message-ID: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
Subject: Re: KCSAN + KVM = host reset
To:     Qian Cai <cai@lca.pw>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 01:00, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Apr 9, 2020, at 5:28 PM, Qian Cai <cai@lca.pw> wrote:
> >
> >
> >
> >> On Apr 9, 2020, at 12:03 PM, Marco Elver <elver@google.com> wrote:
> >>
> >> On Thu, 9 Apr 2020 at 17:30, Qian Cai <cai@lca.pw> wrote:
> >>>
> >>>
> >>>
> >>>> On Apr 9, 2020, at 11:22 AM, Marco Elver <elver@google.com> wrote:
> >>>>
> >>>> On Thu, 9 Apr 2020 at 17:10, Qian Cai <cai@lca.pw> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>> On Apr 9, 2020, at 3:03 AM, Marco Elver <elver@google.com> wrote:
> >>>>>>
> >>>>>> On Wed, 8 Apr 2020 at 23:29, Qian Cai <cai@lca.pw> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>> On Apr 8, 2020, at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> >>>>>>>>
> >>>>>>>> On 08/04/20 22:59, Qian Cai wrote:
> >>>>>>>>> Running a simple thing on this AMD host would trigger a reset r=
ight away.
> >>>>>>>>> Unselect KCSAN kconfig makes everything work fine (the host wou=
ld also
> >>>>>>>>> reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D befo=
re running qemu-kvm).
> >>>>>>>>
> >>>>>>>> Is this a regression or something you've just started to play wi=
th?  (If
> >>>>>>>> anything, the assembly language conversion of the AMD world swit=
ch that
> >>>>>>>> is in linux-next could have reduced the likelihood of such a fai=
lure,
> >>>>>>>> not increased it).
> >>>>>>>
> >>>>>>> I don=E2=80=99t remember I had tried this combination before, so =
don=E2=80=99t know if it is a
> >>>>>>> regression or not.
> >>>>>>
> >>>>>> What happens with KASAN? My guess is that, since it also happens w=
ith
> >>>>>> "off", something that should not be instrumented is being
> >>>>>> instrumented.
> >>>>>
> >>>>> No, KASAN + KVM works fine.
> >>>>>
> >>>>>>
> >>>>>> What happens if you put a 'KCSAN_SANITIZE :=3D n' into
> >>>>>> arch/x86/kvm/Makefile? Since it's hard for me to reproduce on this
> >>>>>
> >>>>> Yes, that works, but this below alone does not work,
> >>>>>
> >>>>> KCSAN_SANITIZE_kvm-amd.o :=3D n
> >>>>
> >>>> There are some other files as well, that you could try until you hit
> >>>> the right one.
> >>>>
> >>>> But since this is in arch, 'KCSAN_SANITIZE :=3D n' wouldn't be too b=
ad
> >>>> for now. If you can't narrow it down further, do you want to send a
> >>>> patch?
> >>>
> >>> No, that would be pretty bad because it will disable KCSAN for Intel
> >>> KVM as well which is working perfectly fine right now. It is only AMD
> >>> is broken.
> >>
> >> Interesting. Unfortunately I don't have access to an AMD machine right=
 now.
> >>
> >> Actually I think it should be:
> >>
> >> KCSAN_SANITIZE_svm.o :=3D n
> >> KCSAN_SANITIZE_pmu_amd.o :=3D n
> >>
> >> If you want to disable KCSAN for kvm-amd.
> >
> > KCSAN_SANITIZE_svm.o :=3D n
> >
> > That alone works fine. I am wondering which functions there could trigg=
er
> > perhaps some kind of recursing with KCSAN?
>
> Another data point is set CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn alone
> also fixed the issue. I saw quite a few interrupt related function in svm=
.c, so
> some interrupt-related recursion going on?

That would contradict what you said about it working if KCSAN is
"off". What kernel are you attempting to use in the VM?

Thanks,
-- Marco
