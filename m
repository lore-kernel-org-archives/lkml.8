Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24A0206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbgYazza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgGQFpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:45:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA385C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:45:23 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so6027325oty.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHkdyRAcZkv1Vdi/CSUR9aW83f/Brxcwc8MUQ7kmTKI=;
        b=pbgYazzaArA2nnQJoKycAuv1HgDXSO+TAsN+cjtFYjPGNKFEbzIACwyHf+sPwauUCX
         vBMGHv7/ccm4+VDg5tof8NYSFES173qlMMod1wFvM3L38Gyv5PjDjYgkSCj+e7kJdkG8
         eGnTzy2+7dzif4l85l+AFxBkzhyZZW+oL6Ss3Z/McHcZ27aEnyAKBPJ94QEeRRFll7xT
         +IqwXpXL+Q0H6cXnE0wdTvd3RhPjWkIFR/4lYdZI+QMPOwXgiP9oKoKucoJAsCcO9k8c
         EeOTHFmcdRr5WAouYtWnMDFN121P5F/dnD9FrAVV0TFUh9JE8eBdSo1TnjPH0jKCFFV/
         YSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHkdyRAcZkv1Vdi/CSUR9aW83f/Brxcwc8MUQ7kmTKI=;
        b=SlZSlTPF0fYJ9f9OF0ojf/Duk5Os5+OGcB93OGmiu/IOG0UiDqSH5s9Ue27i4X/Jrl
         tufRAs75UAag3D3Hqxn+Y6KrPt4QjzQ5LIC7YZXiwhG9qxNmVemOaec1WLafGL0Lqsa9
         4pjK2G6YYEbp6hIZNop7K5h1aqQ+TUNDIjCzD23oHwfj3za9mfM1ENae8XZH532QFpYY
         4EDxWScOH7WCrLao2hi5VNUCPkgMpikf/QyzX0Lw4a9KpFBEwhNKW7+pCJg64gPGwwdb
         PJhOsUYK5+5r2sGBbiGKQEcPwaLk3abaF03AEOs+BOGPILEQF1wrU+29jVWZtbogBmOd
         b5Jw==
X-Gm-Message-State: AOAM532o1OzD9IPPQx5yWgAaHBMAOw7qKTpvS/HZJ/lMMMIfjlNdqDo3
        jPHOA1U8E1CLtb+rCZNPH75Q55OrK8tdrYN9bG4=
X-Google-Smtp-Source: ABdhPJxiyKw7Csu4IqifiSBr4IftmnIMA8UrFJtjTi0CrfVhwfFFjAU7z8vnrsqzKV4EY24AKbZRPrqme1N9Oys2gd8=
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr7355306otq.51.1594964722770;
 Thu, 16 Jul 2020 22:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-6-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-6-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Fri, 17 Jul 2020 15:44:13 +1000
Message-ID: <CACzsE9oE+OMnWEXvbZZbq35YzpSzCbBHWEJcjtCgkcq-YrABng@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] powerpc/dt_cpu_ftrs: Add feature for 2nd DAWR
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:10 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Add new device-tree feature for 2nd DAWR. If this feature is present,
> 2nd DAWR is supported, otherwise not.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/cputable.h | 7 +++++--
>  arch/powerpc/kernel/dt_cpu_ftrs.c   | 7 +++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index e506d429b1af..3445c86e1f6f 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -214,6 +214,7 @@ static inline void cpu_feature_keys_init(void) { }
>  #define CPU_FTR_P9_TLBIE_ERAT_BUG      LONG_ASM_CONST(0x0001000000000000)
>  #define CPU_FTR_P9_RADIX_PREFETCH_BUG  LONG_ASM_CONST(0x0002000000000000)
>  #define CPU_FTR_ARCH_31                        LONG_ASM_CONST(0x0004000000000000)
> +#define CPU_FTR_DAWR1                  LONG_ASM_CONST(0x0008000000000000)
>
>  #ifndef __ASSEMBLY__
>
> @@ -497,14 +498,16 @@ static inline void cpu_feature_keys_init(void) { }
>  #define CPU_FTRS_POSSIBLE      \
>             (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
>              CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | CPU_FTRS_POWER9 | \
> -            CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10)
> +            CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10 | \
> +            CPU_FTR_DAWR1)
>  #else
>  #define CPU_FTRS_POSSIBLE      \
>             (CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
>              CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
>              CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | \
>              CPU_FTR_VSX_COMP | CPU_FTR_ALTIVEC_COMP | CPU_FTRS_POWER9 | \
> -            CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10)
> +            CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10 | \
> +            CPU_FTR_DAWR1)
Instead of putting CPU_FTR_DAWR1 into CPU_FTRS_POSSIBLE should it go
into CPU_FTRS_POWER10?
Then it will be picked up by CPU_FTRS_POSSIBLE.
>  #endif /* CONFIG_CPU_LITTLE_ENDIAN */
>  #endif
>  #else
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index ac650c233cd9..c78cd3596ec4 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -574,6 +574,12 @@ static int __init feat_enable_mma(struct dt_cpu_feature *f)
>         return 1;
>  }
>
> +static int __init feat_enable_debug_facilities_v31(struct dt_cpu_feature *f)
> +{
> +       cur_cpu_spec->cpu_features |= CPU_FTR_DAWR1;
> +       return 1;
> +}
> +
>  struct dt_cpu_feature_match {
>         const char *name;
>         int (*enable)(struct dt_cpu_feature *f);
> @@ -649,6 +655,7 @@ static struct dt_cpu_feature_match __initdata
>         {"wait-v3", feat_enable, 0},
>         {"prefix-instructions", feat_enable, 0},
>         {"matrix-multiply-assist", feat_enable_mma, 0},
> +       {"debug-facilities-v31", feat_enable_debug_facilities_v31, 0},
Since all feat_enable_debug_facilities_v31() does is set
CPU_FTR_DAWR1, if you just have:
{"debug-facilities-v31", feat_enable, CPU_FTR_DAWR1},
I think cpufeatures_process_feature() should set it in for you at this point:
            if (m->enable(f)) {
                cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
                break;
            }

>  };
>
>  static bool __initdata using_dt_cpu_ftrs;
> --
> 2.26.2
>
