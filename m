Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10903C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23C920720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpFuK9OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgGUQtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGUQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:49:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B21C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so24894514lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Od+zTycOXgLO8KxOLxcSpm14nyLCP4jZwV8jGWRnKLg=;
        b=lpFuK9OAa+wE2Ulyz7amAwN9pME8grhLmFBJmxuxYbgbyPwDqYiXKVlZRutm696IoP
         CucdkfpNKHu1dC6W5osl2PoysYrfTz7tKtBYUJCzu/VlEh9Xe5pnjhL6A8Cwyk99gIy7
         /fnpKlTDy7dEKz6P6+g8l78OCPsXrP6qVBwQWim0bZpWZ87T1RLAAGbdcvZAgGOdCF/e
         ky3e+cJQeznHXmg0f781bisBn+BB/dgYXYmeLaQp/82EeSVX6mt9LJW/Ss77Xm4nEnwa
         PZNKC7fb+OnbHqgP5oKOtxA45slZ5xFazzEC5V/m4kiZiIMelPi1u1zWTbpxfr2o5W9Q
         JaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Od+zTycOXgLO8KxOLxcSpm14nyLCP4jZwV8jGWRnKLg=;
        b=nTBhanwO572bkio7IKgLawvFmiOWBJsjLKwGQiRh/M2mzntcXzZBCz7rWnE+oCL0Jl
         +/8NXbEfT2cYALwd8KjyLfJztojVNFRwljVsX1LzbfEDkzMFdyrCf+tpYChvDi9azTFd
         nYg2+QVY6HS2v0ZbhtT/M667AT5sE1eXGVWXt3ep72uUB991nEb2o2fX3IKh7BSe8Ux3
         eY9R6j178iZQWt4kZ9wMWCoTvEJOKjx3J+fslHcJheCObqrePiVCWzHnKz0wBR1TGPSY
         Yr/feyHJz2qpLx+No4fYFyJ8UJWpA5fJnKRsGCMJR48Ht8GuByHDavJydcCLHOP+uPXk
         nepA==
X-Gm-Message-State: AOAM530ieggHx4a8cudg84yrTP0H5FE3aRr4P/lwYjdmDkDokapds3tX
        U+sWXaYxg/2JQ3QhaSzkhv2RUFonoaCHwCUZ6z+wqQ==
X-Google-Smtp-Source: ABdhPJwYDlDFxMbND8/mrk/EvLJEg1yVZ7yDt8/GKj1m85S0l/2vvZs0Ab4E7ekx1j+8SWGe5O2g2dCiYC100eQoheU=
X-Received: by 2002:a2e:8851:: with SMTP id z17mr13816631ljj.225.1595350143051;
 Tue, 21 Jul 2020 09:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200714120917.11253-1-joro@8bytes.org> <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de> <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de> <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
 <20200721124957.GD6132@suse.de>
In-Reply-To: <20200721124957.GD6132@suse.de>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Tue, 21 Jul 2020 09:48:51 -0700
Message-ID: <CAAYXXYwVV_g8pGL52W9vxkgdNxg1dNKq_OBsXKZ_QizdXiTx2g@mail.gmail.com>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I am using OVMF with SEV-ES (sev-es-v12 patches applied). I am
running Ubuntu 18.04 distro. My grub target is x86_64-efi. I also
tried installing the grub-efi-amd64 package. In all cases, the grub is
running in 64bit but enters the startup_32 in 32 bit mode. I think
there should be a 32bit #VC handler just something very similar in the
OVMF patches to handle the cpuid when the CPU is still in 32bit mode.
As it is now, it will be a huge problem to support different distro images.
I wonder if I am the only one having this problem.

-Erdem

On Tue, Jul 21, 2020 at 5:50 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi,
>
> On Mon, Jul 20, 2020 at 06:09:19PM -0700, Erdem Aktas wrote:
> > It looks like there is an expectation that the bootloader will start
> > from the 64bit entry point in header_64.S. With the current patch
> > series, it will not boot up if the bootloader jumps to the startup_32
> > entry, which might break some default distro images.
> > What are supported bootloaders and configurations?
> > I am using grub ( 2.02-2ubuntu8.15) and it fails to boot because of
> > this reason. I am not a grub expert, so I would appreciate any
> > pointers on this.
>
> This is right, the only supported boot path is via the 64bit EFI entry
> point. The reason is that SEV-ES requires support in the firmware too,
> and currently only OVMF is supported in that regard. The firmware needs
> to setup the AP jump-table, for example.
>
> Other boot-paths have not been implemented. Booting via startup_32 would
> require exception handling in the 32bit-part of the boot-strap code,
> because verify_cpu is called there. Also an AMD specific MSR can't be
> accessed there because this would #GP on non-AMD/SEV-ES machines and,
> as I said, there is no way yet to handle them.
>
> How did you get into the startup_32 entry-point, do you have an SEV-ES
> BIOS supporting this? If it is really needed it could be implemented at
> a later point.
>
> Regards,
>
>         Joerg
>
