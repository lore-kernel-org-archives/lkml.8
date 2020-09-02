Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9491020829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rReJtTJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgIBP6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIBP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:58:21 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D769C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:58:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h11so5419259ilj.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JoguK0t2hKxuhREswBqHNa7tuob+XzJi0Xu9ksbpOc=;
        b=rReJtTJH7H7q/P1Yom+QXMk15rqMDzxkVaPh9Td1/uWRnk1F/A6Mjslb9LwaU2jC9e
         svrwJysDQmoM/d3Ha1BLlLynPAZLKUQNR+3la866X/Q/fW6sKVulL4gO61GrbaolHJsG
         JDF1ZA0PL7HhngVmRq93O0S+ZWIubzUjI7Pl4arNEW65+Rv9+Bfls0dxqu4yxj/pzb1V
         IsKaaZDHDki/DLcRiFxHxIUhIB9FlpbZrpXfs9UwfqT/CunIbpE7hQZ+8TklydKPVxTX
         1/KL2VWYw5TuY0qKW7iTNq80KjnyMGn/MrMnRKSv4SZk6+DfCl5idO6dn4SoM7MdHvDO
         d66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JoguK0t2hKxuhREswBqHNa7tuob+XzJi0Xu9ksbpOc=;
        b=H9XtX/Oj4/P3ed6WLm+Q4gSwDl77qO8xZM8rSxC4ImyhwJY1WfMSVdzqX+YeQj08K+
         gPkJsd8F0TUd47ydb98hO3V+Uvy57BRqLwErVvQbith5DstDdf6hKlKyzCdUdtl5jd1u
         r+F/pi2G6L8yD6k2jNZ5IkAgQ6PT4YevNhN6Pyi3T+n+Uz0pY6nENkULUnHmiIuSLsBK
         +xM5IP2HoPbX57+1nqdvotwutMTVqwP2DwAwPjfobG0m5mhcS1GHvdJNLunCuoBnfpEj
         WI4pXClcxq6xR15YOFNoNNQT5YrsTuU65ErOeSbJOHqk5/DH68zetSNtMK0rNqRnWvXn
         228g==
X-Gm-Message-State: AOAM531oYxW1mG1MglucysJ4YzdxLfbKIanUDmMzX5A18z7f6BUFhzDc
        5hsAlFA8ouTdzHK46PlouWaKgBukbaIX5O37BQ==
X-Google-Smtp-Source: ABdhPJx7OGYCbTTGFirwkI5W8AOrEw1KauBHPGTziemzRiz/BSi4dc2BM9Ekq36kspFM3/Ifz4/8UjLK8ou5f5+izaM=
X-Received: by 2002:a92:6a09:: with SMTP id f9mr4251600ilc.273.1599062300407;
 Wed, 02 Sep 2020 08:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200902132549.496605622@infradead.org> <20200902133200.666781610@infradead.org>
In-Reply-To: <20200902133200.666781610@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 2 Sep 2020 11:58:09 -0400
Message-ID: <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] x86/entry: Fix AC assertion
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
> improve user entry sanity checks") unconditionally triggers on my IVB
> machine because it does not support SMAP.
>
> For !SMAP hardware we patch out CLAC/STAC instructions and thus if
> userspace sets AC, we'll still have it set after entry.
>
> Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/entry-common.h |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -18,8 +18,16 @@ static __always_inline void arch_check_u
>                  * state, not the interrupt state as imagined by Xen.
>                  */
>                 unsigned long flags = native_save_fl();
> -               WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> -                                     X86_EFLAGS_NT));
> +               unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
> +
> +               /*
> +                * For !SMAP hardware we patch out CLAC on entry.
> +                */
> +               if (boot_cpu_has(X86_FEATURE_SMAP) ||
> +                   (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
> +                       mask |= X86_EFLAGS_AC;

Is the explicit Xen check necessary?  IIRC the Xen hypervisor will
filter out the SMAP bit in the cpuid pvop.

--
Brian Gerst
