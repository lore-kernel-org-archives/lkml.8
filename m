Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D330C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A2320739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593973384;
	bh=Tv+vnChtxZf8reTGqSpw/7WA9YmfLwCc4rTCJANU6pQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rNygcgLmayCNIfAaGXm2kjaLUm+GuwtBbxhOukqafb93bhHDJyBv/UX5WqUQeNvDW
	 VmwzfWNWXBhw0uBhgbPou3PbxMM3m1I0X7Yv+3nqMd9s+ZTCDE9Mss5BUPxw7YFbt3
	 5tPjL9lYuJU6yMXOHOIzss9nmboOa3Bcb12ns5Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGESW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgGESW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:22:56 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C5A20936
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593973375;
        bh=Tv+vnChtxZf8reTGqSpw/7WA9YmfLwCc4rTCJANU6pQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=howxMOBXFc79K1vp1YDY37NP5WQUQEgo/R3TbpOoN1nSaDjx1Y3u8wd8e6sJEb1QN
         96YzXaBlM7AjqYFi+1bxAVxA2Bt3nNW20U5XAwRkRg/rW5DkoF6j09K+Yp3HCvakMd
         utnQIFJ1ELlV+eUhfQDrMljUbLHhSgqgtZ8NtORk=
Received: by mail-wm1-f46.google.com with SMTP id l17so36816698wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 11:22:55 -0700 (PDT)
X-Gm-Message-State: AOAM530b9Z2rgI72VZvEqSXrsC/axLx+bIX5qQvit1aUN8h6cxT3PrTo
        O1YRLKAkxLp0eMpGoX9Z/HXdioNyJxVSKtLLwjGxdA==
X-Google-Smtp-Source: ABdhPJzKPBwwErrCHUSfauqSSipzcMqZuSVgGLPebcQQRad4JzD9Q2Cbm4PyO1SfUsx4g+DVXop6rjaoOuJJDWk75eE=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr45904253wmk.138.1593973373941;
 Sun, 05 Jul 2020 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200629214956.GA12962@linux.intel.com> <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-3-dpreed@deepplum.com>
In-Reply-To: <20200704203809.76391-3-dpreed@deepplum.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 5 Jul 2020 11:22:42 -0700
X-Gmail-Original-Message-ID: <CALCETrVZx4VA9rg-Hn7KdER866ZOtZtmTkR0MSacnj5jGO-Pag@mail.gmail.com>
Message-ID: <CALCETrVZx4VA9rg-Hn7KdER866ZOtZtmTkR0MSacnj5jGO-Pag@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu
 on crash or panic
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 1:38 PM David P. Reed <dpreed@deepplum.com> wrote:
>
> Fix: Mask undefined operation fault during emergency VMXOFF that must be
> attempted to force cpu exit from VMX root operation.
> Explanation: When a cpu may be in VMX root operation (only possible when
> CR4.VMXE is set), crash or panic reboot tries to exit VMX root operation
> using VMXOFF. This is necessary, because any INIT will be masked while cpu
> is in VMX root operation, but that state cannot be reliably
> discerned by the state of the cpu.
> VMXOFF faults if the cpu is not actually in VMX root operation, signalling
> undefined operation.
> Discovered while debugging an out-of-tree x-visor with a race. Can happen
> due to certain kinds of bugs in KVM.

Can you re-wrap lines to 68 characters?  Also, the Fix: and
Explanation: is probably unnecessary.  You could say:

Ignore a potential #UD failut during emergency VMXOFF ...

When a cpu may be in VMX ...

>
> Fixes: 208067 <https://bugzilla.kernel.org/show_bug.cgi?id=208067>
> Reported-by: David P. Reed <dpreed@deepplum.com>

It's not really necessary to say that you, the author, reported the
problem, but I guess it's harmless.

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
>  arch/x86/include/asm/virtext.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> index 0ede8d04535a..0e0900eacb9c 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -30,11 +30,11 @@ static inline int cpu_has_vmx(void)
>  }
>
>
> -/* Disable VMX on the current CPU
> +/* Exit VMX root mode and isable VMX on the current CPU.

s/isable/disable/


>  /* Disable VMX if it is supported and enabled on the current CPU
> --
> 2.26.2
>

Other than that:

Reviewed-by: Andy Lutomirski <luto@kernel.org>

--Andy
