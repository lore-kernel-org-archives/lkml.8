Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0E620661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9MjwsR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBXGZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:25:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgBXGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582525550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dckTTjxyBibi0/eHSJpegNMnKv/ZFpoC0SMhoS98gYQ=;
        b=J9MjwsR9yWxHoBpvY6osQMej9F2RPXRVh0ZcTzMqRTgtr4fkOgBbb3YlfrVhOCdRHq2xXC
        jKxCot0ZRzTBBmr8If6HTmRqCBvUgXS739ET/A9q2TP1/TzJMfYR1IqojBrhPryvbOG2S9
        8RiEFUprSXMkp93Ce+R69pUmKTVIAak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-R58UNRq-MPqAMN2K99bKdw-1; Mon, 24 Feb 2020 01:25:49 -0500
X-MC-Unique: R58UNRq-MPqAMN2K99bKdw-1
Received: by mail-wr1-f72.google.com with SMTP id o9so5110138wrw.14
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 22:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dckTTjxyBibi0/eHSJpegNMnKv/ZFpoC0SMhoS98gYQ=;
        b=C6hqNSE15KOi7VkLgZMa8ldULOvEGdgCJW1RH/1FYVozBGccMX21v/OAP7E1CZ/UsB
         ol6FPdjqgXpta0EcYwM1G01EGAU7mOSyVB8KIelSL7UhEC7QXcFjeO1W2AJ8V0RYCayZ
         l1xQ/CkKrosAH+ArnfiJBbhogN8jf6KH44B873WAFbXygg9o9nsg53mxJ4o+Kw3Vds/8
         xNagFPIPb4LZV4twSIU6ja7NYiDDE3+pu7fo50pRFHJaoyt5cu6h3ANC58/5CgkIRLkh
         1kzBlRKwATnFbFTeWiSflg1uEjmSrPY7i69VNFMe1WwNFAmN2ljzAtzH/LLnwoByESvS
         uBYA==
X-Gm-Message-State: APjAAAWxY1t4gsrItJJdZu6wAbLJfkbq9+mt64xIko7kaWdYMgnk4nKD
        N10pA60+7WQrqAlRsJ2cxF9GznzFrW4t52m+ydzNYZdYE5vRVAPfAolkDESMVkvZBmCQCpImOpx
        10vXSAAx9cK7hR4gVto/NEeIoZ1NAiUmpScoiwNgL
X-Received: by 2002:a1c:6755:: with SMTP id b82mr20610993wmc.126.1582525547966;
        Sun, 23 Feb 2020 22:25:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxA5kdvYr5b57CvBHEyg7SYwjy39EA3KJkD+2t/YLueVtODgOYqrVfSMUaLHTeag8+AJUU1fdINXjmJPOfgzU=
X-Received: by 2002:a1c:6755:: with SMTP id b82mr20610946wmc.126.1582525547617;
 Sun, 23 Feb 2020 22:25:47 -0800 (PST)
MIME-Version: 1.0
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com> <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
 <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com> <f791e777-781c-86ce-7619-1de3fe3e7b90@arm.com>
 <351975548.1986001.1578682810951.JavaMail.zimbra@redhat.com>
 <04287d60-e99e-631b-c134-d6dc39e6a193@redhat.com> <974f3601-25f8-f4e6-43a8-ff4275e9c174@arm.com>
In-Reply-To: <974f3601-25f8-f4e6-43a8-ff4275e9c174@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Mon, 24 Feb 2020 11:55:35 +0530
Message-ID: <CACi5LpOK6Q3ud3M3zakexLJNOtHy9TODHyYSHVwE3JHVakKzqA@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
To:     Amit Kachhap <amit.kachhap@arm.com>
Cc:     Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        bhupesh linux <bhupesh.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Fri, Feb 21, 2020 at 2:36 PM Amit Kachhap <amit.kachhap@arm.com> wrote:
>
> Hi Bhupesh,
>
> On 1/13/20 5:44 PM, Bhupesh Sharma wrote:
> > Hi James,
> >
> > On 01/11/2020 12:30 AM, Dave Anderson wrote:
> >>
> >> ----- Original Message -----
> >>> Hi Bhupesh,
> >>>
> >>> On 25/12/2019 19:01, Bhupesh Sharma wrote:
> >>>> On 12/12/2019 04:02 PM, James Morse wrote:
> >>>>> On 29/11/2019 19:59, Bhupesh Sharma wrote:
> >>>>>> vabits_actual variable on arm64 indicates the actual VA space size,
> >>>>>> and allows a single binary to support both 48-bit and 52-bit VA
> >>>>>> spaces.
> >>>>>>
> >>>>>> If the ARMv8.2-LVA optional feature is present, and we are running
> >>>>>> with a 64KB page size; then it is possible to use 52-bits of address
> >>>>>> space for both userspace and kernel addresses. However, any kernel
> >>>>>> binary that supports 52-bit must also be able to fall back to 48-bit
> >>>>>> at early boot time if the hardware feature is not present.
> >>>>>>
> >>>>>> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> >>>>>> addressed by TTBR1_EL1 (and hence can be used for determining the
> >>>>>> vabits_actual value) it makes more sense to export the same in
> >>>>>> vmcoreinfo rather than vabits_actual variable, as the name of the
> >>>>>> variable can change in future kernel versions, but the architectural
> >>>>>> constructs like TCR_EL1.T1SZ can be used better to indicate intended
> >>>>>> specific fields to user-space.
> >>>>>>
> >>>>>> User-space utilities like makedumpfile and crash-utility, need to
> >>>>>> read/write this value from/to vmcoreinfo
> >>>>>
> >>>>> (write?)
> >>>>
> >>>> Yes, also write so that the vmcoreinfo from an (crashing) arm64
> >>>> system can
> >>>> be used for
> >>>> analysis of the root-cause of panic/crash on say an x86_64 host using
> >>>> utilities like
> >>>> crash-utility/gdb.
> >>>
> >>> I read this as as "User-space [...] needs to write to vmcoreinfo".
> >
> > That's correct. But for writing to vmcore dump in the kdump kernel, we
> > need to read the symbols from the vmcoreinfo in the primary kernel.
> >
> >>>>>> for determining if a virtual address lies in the linear map range.
> >>>>>
> >>>>> I think this is a fragile example. The debugger shouldn't need to know
> >>>>> this.
> >>>>
> >>>> Well that the current user-space utility design, so I am not sure we
> >>>> can
> >>>> tweak that too much.
> >>>>
> >>>>>> The user-space computation for determining whether an address lies in
> >>>>>> the linear map range is the same as we have in kernel-space:
> >>>>>>
> >>>>>>     #define __is_lm_address(addr)    (!(((u64)addr) &
> >>>>>> BIT(vabits_actual -
> >>>>>>     1)))
> >>>>>
> >>>>> This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA
> >>>>> space"). If
> >>>>> user-space
> >>>>> tools rely on 'knowing' the kernel memory layout, they must have to
> >>>>> constantly be fixed
> >>>>> and updated. This is a poor argument for adding this to something that
> >>>>> ends up as ABI.
> >>>>
> >>>> See above. The user-space has to rely on some ABI/guaranteed
> >>>> hardware-symbols which can be
> >>>> used for 'determining' the kernel memory layout.
> >>>
> >>> I disagree. Everything and anything in the kernel will change. The
> >>> ABI rules apply to
> >>> stuff exposed via syscalls and kernel filesystems. It does not apply
> >>> to kernel internals,
> >>> like the memory layout we used yesterday. 14c127c957c1 is a case in
> >>> point.
> >>>
> >>> A debugger trying to rely on this sort of thing would have to play
> >>> catchup whenever it
> >>> changes.
> >>
> >> Exactly.  That's the whole point.
> >>
> >> The crash utility and makedumpfile are not in the same league as other
> >> user-space tools.
> >> They have always had to "play catchup" precisely because they depend
> >> upon kernel internals,
> >> which constantly change.
> >
> > I agree with you and DaveA here. Software user-space debuggers are
> > dependent on kernel internals (which can change from time-to-time) and
> > will have to play catch-up (which has been the case since the very start).
> >
> > Unfortunately we don't have any clear ABI for software debugging tools -
> > may be something to look for in future.
> >
> > A case in point is gdb/kgdb, which still needs to run with KASLR
> > turned-off (nokaslr) for debugging, as it confuses gdb which resolve
> > kernel symbol address from symbol table of vmlinux. But we can
> > work-around the same in makedumpfile/crash by reading the 'kaslr_offset'
> > value. And I have several users telling me now they cannot use gdb on
> > KASLR enabled kernel to debug panics, but can makedumpfile + crash
> > combination to achieve the same.
> >
> > So, we should be looking to fix these utilities which are broken since
> > the 52-bit changes for arm64. Accordingly, I will try to send the v6
> > soon while incorporating the comments posted on the v5.
>
> Any update on the next v6 version. Since this patch series is fixing the
> current broken kdump so need this series to add some more fields in
> vmcoreinfo for Pointer Authentication work.

Sorry for the delay. I was caught up in some other urgent arm64
user-space issues.
I am preparing the v6 now and hopefully will be able to post it out
for review later today.

Thanks,
Bhupesh

