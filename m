Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957DAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1DA20768
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTXModHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDIQDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:03:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37444 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgDIQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:03:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id u20so311002oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tjHIQBCBSrHwNHPc99hMBF0pIDG2KesjmgOXuqoKDMM=;
        b=hTXModHkfdlX4RpWCP0A8PlGie48zk3lgc/GhvV68BZ/2aFTULVRTRqzfiLrEzbp0c
         ZKAIlsAUDMHBfH+Tm+tEkVwivavdnnnUlzWGkKC0h8JWKx2uSLpFCRwppcZoCtGZa/HD
         u2R43yOje8QjZT6SEJmT7a2S8n+s65ArUAGaee5e4pAjrqJwPswZWhJPtmiOYFl8b/TM
         /rzlesPZIDJRpWedg4VX6ouyELcid/NqcHPreWZWu6uj6TAg5nCUYfwqVRXU+zx+sIq2
         gT8LaiWk7S2hJJD3820Bmji/zmlOnTznAOc14FpxaXSXfraYIEA9ZrEmwkkYmGLA9R2c
         u1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tjHIQBCBSrHwNHPc99hMBF0pIDG2KesjmgOXuqoKDMM=;
        b=c6EgQsAN/GqovCxOnZeg+dClz9ODJhN60BYyhgnTKJXI0QTtH5abZMAbg/L+MGafRW
         zGnP7mHK8VaIVV2l/L1ktzIzsymULizITMWp3hd9J+Zf7vhuO0OAsfUnY93S+uOnI+VH
         MwhwilHla4jLovx7Q9my5Vqyq+Bw5HR5ZsKlKu3cRgvCMqeOdkFtrmH1PY9JuRAuF4mk
         EZef+D7iti5SC8MjPvmpGlKSZ8kLGLZ+CpZxxi2q8vjH689EaQ+sJnC53I30xBwsFVDK
         Os3SEV8MAqyIDF3VG7oT/CbVWKsTnNkZ7SuSHnQKyxl1hlxecwye0nH2NYmCEzFllqR1
         tn3w==
X-Gm-Message-State: AGi0PubKF8fDOYgLOTPl1XFVgJswEYcaxfNhGfjTfV8MatNST7R0SQ+4
        NOs+dYLlbScFtjejxDYZwz6Ep0m+IoBlTT808F/dmQ==
X-Google-Smtp-Source: APiQypKFcY0QZIxSnMvqOumGL+bCUZQWyP22MGaxw3k465l/nIpOkbNXdj9LwkwU0lNfgWhrUjuExNoRAwBspu6AUvw=
X-Received: by 2002:aca:620a:: with SMTP id w10mr1792454oib.121.1586448202131;
 Thu, 09 Apr 2020 09:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw> <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
 <017E692B-4791-46AD-B9ED-25B887ECB56B@lca.pw> <CANpmjNMiHNVh3BVxZUqNo4jW3DPjoQPrn-KEmAJRtSYORuryEA@mail.gmail.com>
 <B7F7F73E-EE27-48F4-A5D0-EBB29292913E@lca.pw> <CANpmjNMEgc=+bLU472jy37hYPYo5_c+Kbyti8-mubPsEGBrm3A@mail.gmail.com>
 <2730C0CC-B8B5-4A65-A4ED-9DFAAE158AA6@lca.pw>
In-Reply-To: <2730C0CC-B8B5-4A65-A4ED-9DFAAE158AA6@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Apr 2020 18:03:10 +0200
Message-ID: <CANpmjNNUn9_Q30CSeqbU_TNvaYrMqwXkKCA23xO4ZLr2zO0w9Q@mail.gmail.com>
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

On Thu, 9 Apr 2020 at 17:30, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Apr 9, 2020, at 11:22 AM, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 9 Apr 2020 at 17:10, Qian Cai <cai@lca.pw> wrote:
> >>
> >>
> >>
> >>> On Apr 9, 2020, at 3:03 AM, Marco Elver <elver@google.com> wrote:
> >>>
> >>> On Wed, 8 Apr 2020 at 23:29, Qian Cai <cai@lca.pw> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Apr 8, 2020, at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> >>>>>
> >>>>> On 08/04/20 22:59, Qian Cai wrote:
> >>>>>> Running a simple thing on this AMD host would trigger a reset righ=
t away.
> >>>>>> Unselect KCSAN kconfig makes everything work fine (the host would =
also
> >>>>>> reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D before =
running qemu-kvm).
> >>>>>
> >>>>> Is this a regression or something you've just started to play with?=
  (If
> >>>>> anything, the assembly language conversion of the AMD world switch =
that
> >>>>> is in linux-next could have reduced the likelihood of such a failur=
e,
> >>>>> not increased it).
> >>>>
> >>>> I don=E2=80=99t remember I had tried this combination before, so don=
=E2=80=99t know if it is a
> >>>> regression or not.
> >>>
> >>> What happens with KASAN? My guess is that, since it also happens with
> >>> "off", something that should not be instrumented is being
> >>> instrumented.
> >>
> >> No, KASAN + KVM works fine.
> >>
> >>>
> >>> What happens if you put a 'KCSAN_SANITIZE :=3D n' into
> >>> arch/x86/kvm/Makefile? Since it's hard for me to reproduce on this
> >>
> >> Yes, that works, but this below alone does not work,
> >>
> >> KCSAN_SANITIZE_kvm-amd.o :=3D n
> >
> > There are some other files as well, that you could try until you hit
> > the right one.
> >
> > But since this is in arch, 'KCSAN_SANITIZE :=3D n' wouldn't be too bad
> > for now. If you can't narrow it down further, do you want to send a
> > patch?
>
> No, that would be pretty bad because it will disable KCSAN for Intel
> KVM as well which is working perfectly fine right now. It is only AMD
> is broken.

Interesting. Unfortunately I don't have access to an AMD machine right now.

Actually I think it should be:

  KCSAN_SANITIZE_svm.o :=3D n
  KCSAN_SANITIZE_pmu_amd.o :=3D n

If you want to disable KCSAN for kvm-amd.

Thanks,
-- Marco
