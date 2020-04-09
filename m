Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20286C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0382074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSr6492W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgDIPXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:23:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45124 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:23:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id 60so7945103otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vgEQvvnJoquOGzGtJREDN5USMlXV+4P/x5EsAI2d6zc=;
        b=CSr6492WZ0/6vPLAPxMxzzM42U3DllbebcNqQ2ZLUGYDbje3VkNh4OEX3PKcco5B1F
         aI5WZ1HGy0kwZiRNxRMKr37ICaRvMivASl1MFsOYI14Qf40WnLlZweFp9W48x2aY/xrC
         yDPoLUnRJbZ6z2Yomz6ryfKpgh4tfDtNMBIGNK87M6eKxZguH5o35TjaH+OY4XoyTXF6
         sBhzDw2qyzpKTyA6MPpGPJrIOS550tOA88yblwbGi4ocFCLFYhJHvMyttn6ejkiwOtJ0
         gVOvke+jeOVJk8pYuWmUx1Hhrc7d5VLtkcsOTehiL1El13AoS5GxnPkMaCmQjAosKxUK
         5N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vgEQvvnJoquOGzGtJREDN5USMlXV+4P/x5EsAI2d6zc=;
        b=D8Y8/7jc4R+3A9QWW1hIPelQMZd+d2qYN8zah8WYTl8LYh1x5b6P30q87HjsHv7PAi
         AH9r3xqjG//ujpLfLcVfaZsCXWqAgT1udKUgC2JNRfy2UeqgokFjfpHT027IXWJbPolB
         0EwgoNQZcaa3rg9JlqkvUXZByH0QjB3QZybYuyJ3ObvFdkg0C3xPVmS++FR7QW1IxF4q
         iTCLWj97iiU62Ntk/6rqvWtHVCJyYt2bfpRpemNsT6lARCpj5uyzsu+RSJzUON2Pozwq
         cnvRo86BPDcOxPRIQLjSt8ED8AloElOwd+9lHDn/vPu4sY6ANLhmYAZ4e9brbuxSRiM4
         fagw==
X-Gm-Message-State: AGi0PubagsMgM1AREgwspa7Yi+ikQEbZXOHtaUIjJKM3mAbCUxgSyiLl
        zsOiEVq/ZrWlgqbz/SzB2beZxp2mB0rRokYurxh+UQ==
X-Google-Smtp-Source: APiQypJRkHrtZ8xwgQFQh9fHwNPp224Z1VyW2q4b6zJ+iuZEnRKzEYEnYhRknJcPEh3e5cefJZ0fSxfOHXfJZc8R124=
X-Received: by 2002:a4a:d516:: with SMTP id m22mr355695oos.72.1586445779925;
 Thu, 09 Apr 2020 08:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw> <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
 <017E692B-4791-46AD-B9ED-25B887ECB56B@lca.pw> <CANpmjNMiHNVh3BVxZUqNo4jW3DPjoQPrn-KEmAJRtSYORuryEA@mail.gmail.com>
 <B7F7F73E-EE27-48F4-A5D0-EBB29292913E@lca.pw>
In-Reply-To: <B7F7F73E-EE27-48F4-A5D0-EBB29292913E@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Apr 2020 17:22:48 +0200
Message-ID: <CANpmjNMEgc=+bLU472jy37hYPYo5_c+Kbyti8-mubPsEGBrm3A@mail.gmail.com>
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

On Thu, 9 Apr 2020 at 17:10, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Apr 9, 2020, at 3:03 AM, Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 8 Apr 2020 at 23:29, Qian Cai <cai@lca.pw> wrote:
> >>
> >>
> >>
> >>> On Apr 8, 2020, at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >>>
> >>> On 08/04/20 22:59, Qian Cai wrote:
> >>>> Running a simple thing on this AMD host would trigger a reset right =
away.
> >>>> Unselect KCSAN kconfig makes everything work fine (the host would al=
so
> >>>> reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D before ru=
nning qemu-kvm).
> >>>
> >>> Is this a regression or something you've just started to play with?  =
(If
> >>> anything, the assembly language conversion of the AMD world switch th=
at
> >>> is in linux-next could have reduced the likelihood of such a failure,
> >>> not increased it).
> >>
> >> I don=E2=80=99t remember I had tried this combination before, so don=
=E2=80=99t know if it is a
> >> regression or not.
> >
> > What happens with KASAN? My guess is that, since it also happens with
> > "off", something that should not be instrumented is being
> > instrumented.
>
> No, KASAN + KVM works fine.
>
> >
> > What happens if you put a 'KCSAN_SANITIZE :=3D n' into
> > arch/x86/kvm/Makefile? Since it's hard for me to reproduce on this
>
> Yes, that works, but this below alone does not work,
>
> KCSAN_SANITIZE_kvm-amd.o :=3D n

There are some other files as well, that you could try until you hit
the right one.

But since this is in arch, 'KCSAN_SANITIZE :=3D n' wouldn't be too bad
for now. If you can't narrow it down further, do you want to send a
patch?

Thanks,
-- Marco

> I have been able to reproduce this on a few AMD hosts.
>
> > exact system, I'd ask you to narrow it down by placing 'KCSAN_SANITIZE
> > :=3D n' into suspect subsystems' Makefiles. Once you get it to work wit=
h
> > that, we can refine the solution.
> >
> > Thanks,
> > -- Marco
>
