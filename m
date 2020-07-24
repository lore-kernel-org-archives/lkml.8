Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E921C4346E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BE12065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK/ytXOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGXSph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgGXSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:45:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A9C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u12so5718036lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGu1CrNLcjpxClPLAqdnVovo4TK7xD0xrtAptpWw6Lk=;
        b=SK/ytXOMocB9aJozL93rk+NQ7m8Yf/k+QUen1vyYSLRVEKGW6TMAg589Teys7WB5pk
         FmAIbj0u5zI4kLgXFTT3jHcFCYAFW7eIFgBiUAJ0L0iIE61UEXkz3LGvSG8T1zq2GugZ
         knONSNr1ZNOOlW219wHotffUWcofkFXaLPJrX2duYRzT0Xo5GPclA2jfttYD9HG4bMU1
         qg7FlRnuvmsOogX42BqVf/wbFC6+L9rdIHJK5gezgn7GTyJDFj4a8VXvPEoLhriU0fT9
         lC0eE9fayPS0j9w+/LAbX/GF8ah44wzagdS3shIla8DYjxBpLJXSzOsCmQv1wQE9dc9D
         Urtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGu1CrNLcjpxClPLAqdnVovo4TK7xD0xrtAptpWw6Lk=;
        b=Y4VwEAwAYEtAK4ONWevxTKVYK7IASKMzFVaQNiEjhyJhYGoRudr7QLKtmteDmqs3VQ
         +zUyXZQtpte0uzYtU7xFEvFPOW0P9XdqU56jhXCIWCxbGn9t+iozT4eKh1c1TpcyL3z4
         upIL3kwRG8MAIs0NbQdT8Kj8zNPCniWSjPGscoRcWBEf8BM8mURi6gNFWt0LEoiYgNvo
         j5f5E6JxCOrxQUN8d0gckpOBkQZJZke/BE9GkOiAF1J3I8vGgNuza1LMu1N11OT2BHKU
         QOsWkId/t8+J9leC11nmdB1uF5o1A3a9XzCrG2uDsokePlz9VGOOBSCiwow6CG03vZ4H
         y9/Q==
X-Gm-Message-State: AOAM530dfEYPOuFYcMP4Ev85Q3jUJ7/Hq+5d90NrGgiJ8S9xHxDE5Pqu
        rAAD2cDj9OJDgTrO+DrrllEIQkmIKWe/YGu1bWNaRcDE
X-Google-Smtp-Source: ABdhPJwBtGU3bv0TC7eb+N08jPZAJVhhFnr67vs3+yGBQvKJTuU71zMBC5a55nb5rKJ7WvUUobxSFbnUCLILhSi7fRY=
X-Received: by 2002:a19:7710:: with SMTP id s16mr5626302lfc.162.1595616334246;
 Fri, 24 Jul 2020 11:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724173536.789982-1-oupton@google.com>
In-Reply-To: <20200724173536.789982-1-oupton@google.com>
From:   Oliver Upton <oupton@google.com>
Date:   Fri, 24 Jul 2020 11:45:23 -0700
Message-ID: <CAOQ_Qsh2aXWgNrSixcV4vEOr0NtPTDtZY1h8EWUQr0vba61BxQ@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: fix reversed timespec values in PV wall clock
To:     kvm list <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:35 AM Oliver Upton <oupton@google.com> wrote:
>
> commit 8171cd68806b ("KVM: x86: use raw clock values consistently")
> causes KVM to accidentally write seconds to the nanoseconds field (and
> vice versa) in the KVM wall clock. Fix it by reversing this accidental
> switch. Modulo the written nanoseconds value by NSEC_PER_SEC to correct
> for the amount of time represented as seconds.
>
> Fixes: 8171cd68806b ("KVM: x86: use raw clock values consistently")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Peter Shier <pshier@google.com>
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  Parent commit: c34b26b98cac ("KVM: MIPS: clean up redundant 'kvm_run' parameters")
>
>  arch/x86/kvm/x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e27d3db7e43f..86228cc6b29e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1809,8 +1809,9 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
>          */
>         wall_nsec = ktime_get_real_ns() - get_kvmclock_ns(kvm);
>
> -       wc.nsec = do_div(wall_nsec, 1000000000);
> -       wc.sec = (u32)wall_nsec; /* overflow in 2106 guest time */
> +       /* overflow in 2106 guest time */
> +       wc.sec = (u32)do_div(wall_nsec, NSEC_PER_SEC);
> +       wc.nsec = wall_nsec % NSEC_PER_SEC;
>         wc.version = version;
>
>         kvm_write_guest(kvm, wall_clock, &wc, sizeof(wc));
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>

Disregard, I crossed wires in my reading of do_div().
