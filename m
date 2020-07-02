Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F74C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BE9207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoLWrgpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGBSnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:43:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgGBSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593715429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBs9fJWNeYySdMcu8KtkWgGYnn/ATIhNzdp6AqWn/po=;
        b=HoLWrgpwPQf4+ccF4lEaRRRpUeRyBcqOIlKnAQeqUnqjGLdgzpa5nKH2EqaWI1wwYMUgzt
        Vwg/NvFiIMOirJQRTgojI8zhdfuxQo2rXLE3bdbUjVnN5u2t9PwjBuSDEgoDyqKWkIF3WJ
        dnuCRsSoYYMJywTwZD7j1IN7TrdDwM8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-T3xz0Eh1O4-MwMYOt4gM5Q-1; Thu, 02 Jul 2020 14:43:43 -0400
X-MC-Unique: T3xz0Eh1O4-MwMYOt4gM5Q-1
Received: by mail-qk1-f198.google.com with SMTP id h4so19263237qkl.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBs9fJWNeYySdMcu8KtkWgGYnn/ATIhNzdp6AqWn/po=;
        b=J5B7iauezL09FXvv5/2PysmF6PA4/k7k6jJc3B8W96OgicilZ3hFdjPHMDei0BFmh3
         Rsep9DxHg+QwDLiD1ccw5GqDrIjXdPRlCYQ7+PjuU9ykUDEQ0NUG2k1BZEAlDwm99kgG
         4slRYFjbsTnVL8TJQGJlvyONZiusNybrK6dUh+s4vAE1Gpu+3lGMIh+c2vjHB8IRshVK
         bGiNqzzAhUjqzyVBKe8IANaAS34j+OFVczofm8IkbFXEsgL6OcJcEobGIbjxN2nekSm7
         5NvaEdZACPOikTWNq7Qkl+t1w49vEnY73XOSSGLI4FMwuQMWU7f3G/s4T8l9you42nBr
         TbBA==
X-Gm-Message-State: AOAM532Bqb2nNEZ02/NdJQfDQ0wRkcvyxxnHtoEXQbq45AthC/8gbARH
        UJXlwJ6B5/HFkFkg/9nGXgpi4mGuU+CNBxLKiWNUp99ZdjeyrA7Fi/XGU5UJcw4azEwbjX2ZnlR
        Yf4UOMeTkS8z3cW4u6q2wlv20VKUKJP9CHXnpKfm1
X-Received: by 2002:ac8:429b:: with SMTP id o27mr21484405qtl.124.1593715423286;
        Thu, 02 Jul 2020 11:43:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeunlLTSmJ7ldLPyyGx2hly92ochyhDWedphYsrnNnrZbxzUOcSEgJ30myWyCcqcZPawXx+2/U/YGBr1VRid4=
X-Received: by 2002:ac8:429b:: with SMTP id o27mr21484372qtl.124.1593715422996;
 Thu, 02 Jul 2020 11:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com> <159370984726.27923.4874334372278158979.b4-ty@arm.com>
In-Reply-To: <159370984726.27923.4874334372278158979.b4-ty@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 3 Jul 2020 00:13:31 +0530
Message-ID: <CACi5LpNUDmoMkEuHvw0Asg=OHJCB3SfZR7XmuyzpFdSkdb5vjw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     x86@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Boris Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 10:45 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, 14 May 2020 00:22:35 +0530, Bhupesh Sharma wrote:
> > Apologies for the delayed update. Its been quite some time since I
> > posted the last version (v5), but I have been really caught up in some
> > other critical issues.
> >
> > Changes since v5:
> > ----------------
> > - v5 can be viewed here:
> >   http://lists.infradead.org/pipermail/kexec/2019-November/024055.html
> > - Addressed review comments from James Morse and Boris.
> > - Added Tested-by received from John on v5 patchset.
> > - Rebased against arm64 (for-next/ptr-auth) branch which has Amit's
> >   patchset for ARMv8.3-A Pointer Authentication feature vmcoreinfo
> >   applied.
> >
> > [...]
>
> Applied to arm64 (for-next/vmcoreinfo), thanks!
>
> [1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>       https://git.kernel.org/arm64/c/1d50e5d0c505
> [2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
>       https://git.kernel.org/arm64/c/bbdbc11804ff

Thanks Catalin for pulling in the changes.

Dave and James, many thanks for reviewing the same as well.

Regards,
Bhupesh

