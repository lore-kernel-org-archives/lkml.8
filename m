Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BCFC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35715206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM6jBlbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgD0Raf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0Rae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:30:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A9C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:30:34 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id u189so17498605ilc.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WAmnZAQqsfdyDzhsu6wAOJW6mDvNQHToHiDwv+tvXL0=;
        b=rM6jBlbJF1p0rjqRj7enKn0xq7UtAq83W7/SMdsqwx7j8hmwJeU36VtGxm8+GhlYgi
         Ve6dpPf9g/k7UAXG5Kz3hp4z6YzgMyETLRyzSpcdDp9PkOJjRsWZGuyxr1Guxa1Qgx5h
         9HsDiljnE8iqsOYg9kr3Nl0Y+4k6JN3ZLOUNhj4aKH1LQtSMaK9Zmf8fLI2E78lgUGHz
         Rd/Gk7s4nR2oYB/JsvK/t2tZ4Pk9T0UC45bJ22686Gnmk1YPYfR5ss4L+L95lXOsU5ev
         WlZvRr3Z3PaNGYEQoz8EazMzdRqDlGQ/y/xmK9Z8BLvfiiLjQv1f3l6cJNPklESdAKt9
         c2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WAmnZAQqsfdyDzhsu6wAOJW6mDvNQHToHiDwv+tvXL0=;
        b=fQhfXwV5KMI/Q6I8bhySUOWIyJW4VmkvEm3ii8SYKUQJrRXOgUUeVK/2XvETahDhOD
         csddwWGkKiEzoGHknIW4WctttXajZnrXje2i4pPpGDEY3Fkr3ijnJMoKICCjQpqgYux7
         OdHGnIVOmvobCEGM0JAZ1FwGTDBILKT+8kNwT0j2iXf70ird0JexvwnOkpK6z5InIs61
         Ld2JsFHB/5E2RXCS17yMTZbLv9w2K2BmG7nTwALTwqf+ji8X6q+PbImC5OLcTQZuIqJK
         lxm6K4f71VzCyBgBHhub7o56FHMfoU6Zod66hKjzMpWg3oYSOnT5SOOSzmgPN0depS4l
         qQTA==
X-Gm-Message-State: AGi0PuYaC3xwgunUW020Yv+Os+IuZHo/wrZcJzkO3kG2NPQclUXFAjZ7
        I5MA/Hm0kuv9NfofHPsm6nAet/iGk51PnwuyrMgt0fwp
X-Google-Smtp-Source: APiQypLYGcoWKQQgcyvEo8F50ZL+lo84Kee1KKs7UcdGmTDiIyOyUYlVajqWTGznlrcpj+c81fTJlOxSHfqZrkYwiqE=
X-Received: by 2002:a92:da4e:: with SMTP id p14mr22191527ilq.296.1588008633445;
 Mon, 27 Apr 2020 10:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <1587704935-30960-1-git-send-email-lirongqing@baidu.com>
 <20200424100143.GZ20730@hirez.programming.kicks-ass.net> <20200424144625.GB30013@linux.intel.com>
 <CALMp9eQtSrZMRQtxa_Z5WmjayWzJYhSrpNkQbqK5b7Ufxg-cMA@mail.gmail.com>
 <ce51d5f9-aa7b-233b-883d-802d9b00e090@redhat.com> <fd2a8092edf54a85979e5781dc354690@baidu.com>
In-Reply-To: <fd2a8092edf54a85979e5781dc354690@baidu.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 27 Apr 2020 10:30:22 -0700
Message-ID: <CALMp9eQrGuqzy_ZRu+qU3A7PRkoi8JHWFRpm---cMhp9+J4j8A@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kvm: x86: emulate APERF/MPERF registers
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 8:24 PM Li,Rongqing <lirongqing@baidu.com> wrote:
>
>
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B44=E6=9C=8825=E6=97=
=A5 0:30
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Jim Mattson <jmattson@google.com>; Sean Ch=
ristopherson
> > <sean.j.christopherson@intel.com>
> > =E6=8A=84=E9=80=81: Peter Zijlstra <peterz@infradead.org>; Li,Rongqing
> > <lirongqing@baidu.com>; LKML <linux-kernel@vger.kernel.org>; kvm list
> > <kvm@vger.kernel.org>; the arch/x86 maintainers <x86@kernel.org>; H .
> > Peter Anvin <hpa@zytor.com>; Borislav Petkov <bp@alien8.de>; Ingo Molna=
r
> > <mingo@redhat.com>; Thomas Gleixner <tglx@linutronix.de>; Joerg Roedel
> > <joro@8bytes.org>; Wanpeng Li <wanpengli@tencent.com>; Vitaly Kuznetsov
> > <vkuznets@redhat.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] [RFC] kvm: x86: emulate APERF/MPERF reg=
isters
> >
> > On 24/04/20 18:25, Jim Mattson wrote:
> > >> Assuming we're going forward with this, at an absolute minimum the
> > >> RDMSRs need to be wrapped with checks on host _and_ guest support fo=
r
> > >> the emulated behavior.  Given the significant overhead, this might
> > >> even be something that should require an extra opt-in from userspace=
 to
> > enable.
> > >
> > > I would like to see performance data before enabling this uncondition=
ally.
> >
> > I wouldn't want this to be enabled unconditionally anyway, because you =
need to
> > take into account live migration to and from processors that do not hav=
e
> > APERF/MPERF support.
> >
> > Paolo
>
> I will add a kvm parameter to consider whether enable MPERF/APERF emulati=
ons, and make default value to false

Wouldn't it be better to add a per-VM capability to enable this feature?
