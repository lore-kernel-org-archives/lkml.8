Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448542075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3SIw4Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgG2Urn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Urm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:47:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49339C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:47:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p16so9850517ile.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoJlKZaLXbUuLV4nosYhBKGNv2CAMoP0UIqUb30Ie3A=;
        b=Y3SIw4LskqRgpE5LgviYVSqSY/tsY3kr0cGoeYpoSrb/hJFhZYg+3dksqJxt5TnNVg
         +kd/B2h0bHIex0pJlfbkVupUVGjKPkcfXCQsBRd29pMsENwEr0RcO3nh6B/51Zsc+Aqw
         g196Yk+hPQGkHyI/Qrq6mbc/E5XFXIFTt0Wt8OExHcXRv6bArhgpMbzGTtWO1rbleXWf
         pHBpCDNR69Q9H8CL1mfd6ont/outxJCZSOCcju4df3bumqlpZj4K6a5JQ9BpFT/wIZO5
         i5ormwI5TjDN5YGwVrFbFlo1rrILQ6/pdlJEtsAX5t5uwu8R2LwZwYL92n/44xP2Tg5b
         8ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoJlKZaLXbUuLV4nosYhBKGNv2CAMoP0UIqUb30Ie3A=;
        b=ldvJdRM509sia2Fda5m//SUm4l6E3nAOLSf9inf+/Pgy6Zr3gbZD0Z4c5RaB0CzRMH
         hAvFSg+1c56eU8Lix86gSbmrRJsPhjYVCUsyabmZ7xFWqRtVNjSzbiuYcR0X6p79rRvF
         rvC74oLN6UfWdQn3sCrg7OdykdCL83lcRPHaCQ7RI7yHOj8Mb1b+MDZiciQdBI4DAQ7m
         A4rqdAOSjByOHO30G12Jhj8LomjAdr7ItWYyolz2rDm79a0C5Y31scGPbGlrP5uOfBlN
         /3F+4j2ivZPgkhywD8uVVy2ztcjOAmtwls1f5lWoL2GSIUnE/kf5fmBbU9thXmTK0dPf
         TqQA==
X-Gm-Message-State: AOAM532TeXVlBFOnnRBjpxy6eg3SKqjlGHicuZAbhEdK2tYz7I0roAQ7
        docOp9SuO5bnM4IReECroIw4QlRAnysC8nA0i/TfiA==
X-Google-Smtp-Source: ABdhPJxnn1nGoFy9ElsyLRQgWdscrHapUJ1Bb7Gtsqx96+CKmabOpGB+seMqVJ940AENql5HW66eqKFs2WUDC/shPiA=
X-Received: by 2002:a92:b60a:: with SMTP id s10mr28883334ili.119.1596055661499;
 Wed, 29 Jul 2020 13:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597949343.12744.9555364824745485311.stgit@bmoger-ubuntu>
In-Reply-To: <159597949343.12744.9555364824745485311.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 13:47:30 -0700
Message-ID: <CALMp9eTO-Det6u3Fa2Lrzkgw7SRj=Jbf2kJ1YuokZRmCEpj=EA@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] KVM: SVM: Modify intercept_exceptions to generic intercepts
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Modify intercept_exceptions to generic intercepts in vmcb_control_area.
> Use the generic __set_intercept, __clr_intercept and __is_intercept to
> set the intercept_exceptions bits.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

> @@ -52,6 +54,25 @@ enum {
>         INTERCEPT_DR5_WRITE,
>         INTERCEPT_DR6_WRITE,
>         INTERCEPT_DR7_WRITE,
> +       /* Byte offset 008h (Vector 2) */
> +       INTERCEPT_DE_VECTOR = 64 + DE_VECTOR,
> +       INTERCEPT_DB_VECTOR,
> +       INTERCEPT_BP_VECTOR = 64 + BP_VECTOR,
> +       INTERCEPT_OF_VECTOR,
> +       INTERCEPT_BR_VECTOR,
> +       INTERCEPT_UD_VECTOR,
> +       INTERCEPT_NM_VECTOR,
> +       INTERCEPT_DF_VECTOR,
> +       INTERCEPT_TS_VECTOR = 64 + TS_VECTOR,
> +       INTERCEPT_NP_VECTOR,
> +       INTERCEPT_SS_VECTOR,
> +       INTERCEPT_GP_VECTOR,
> +       INTERCEPT_PF_VECTOR,
> +       INTERCEPT_MF_VECTOR = 64 + MF_VECTOR,
> +       INTERCEPT_AC_VECTOR,
> +       INTERCEPT_MC_VECTOR,
> +       INTERCEPT_XM_VECTOR,
> +       INTERCEPT_VE_VECTOR,
>  };

I think it's demanding a lot of the reader to know where there are and
are not gaps in the allocated hardware exception vectors. Perhaps all
of the above enumeration definitions could have initializers? Either
way...

Reviewed-by: Jim Mattson <jmattson@google.com>
