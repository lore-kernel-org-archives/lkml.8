Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF16EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9623F2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr7Xzz4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGTBx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgGTBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:53:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93BC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:53:25 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t18so10988052otq.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOIR1xA5sY1eNWHjg5kE4RiFG7INhNHarb087xmB/Qw=;
        b=Vr7Xzz4lZf2QNsKHilp6aPXNyBihOJyQ57UBJMekVYFPGCH18uwWDtRpjBsQ3doXWk
         R4Is5gEIStBMRJLjmn4egcdpJevEcaVfTh7zPGXCl3dQJDQJKYGDuUGo0b1hjcFxD64w
         zVXTvUDPsduB6IHBS3EWobUl6DIA1XxWLuQoeJ16GR2qcsdq+PmHMWlnoduCNhKpUOEW
         i8kGCgrV0+RtGUWRyVzcRwaYgDRsIT4HOtZsQsmmaoZM7EHFqjsemvS7RQI5Bs92vD54
         j+QxWdYibN1TFDDmelzQpQloxLKTREuxYv+IIepOHdbnmLuDV95VvwPv94JW264ZZ+NF
         Q9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOIR1xA5sY1eNWHjg5kE4RiFG7INhNHarb087xmB/Qw=;
        b=a0CzFVs5JhUg5yVH3ZdptMu/AsZL5FsoMKGqEEHbGCWvYyd15MA7TZzS0Jda3GWLtx
         5fTwg6HEjqGkgQWgg0O+Qx9zWcqPoSotmAyqII88kSguKUBkABSmLCegY+gjJRoXpju/
         nDfVfEBafbLUQNoVknG1tJSrBc/wq97PnpnX2s+eCuH+RDgnu+qIktj5kKW3GoS5wM7C
         KU54rSmaxWXVIYcPjQDYkG4fGMpCvVQVt9b5NvVL/y9mwWSqJ3O4nlcT0W2ekOiLIFGZ
         Mfj9FjMATHEtTVUnYemGDqth/A45Gu1txw+cbaWSvcqhBE6vaxh/yPvfWbr66140fBoi
         Ybsg==
X-Gm-Message-State: AOAM5329mNXi5qsFPP8/Kyf/nBZS65uwxXgyq51saQOeT17Wl3mUraJ0
        0+Z2Kgpzq5VaVDVfsiQ4esPPKR0LCDuQ54/Zapc=
X-Google-Smtp-Source: ABdhPJwga60s4e0u6T7eKY/7B9Nxa7rDHN5XoJyiBMHq1oZKKPKs1R2I4rw4wnPeMaFvwI4glA2SNyW7iuqz5MNcVaw=
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr17641938otq.51.1595210005246;
 Sun, 19 Jul 2020 18:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-8-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-8-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Mon, 20 Jul 2020 11:50:07 +1000
Message-ID: <CACzsE9pipmQAYvYBtf13D+ZkM2jp2=os=ugi-28mjpwouM3Ahg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] powerpc/watchpoint: Rename current H_SET_MODE
 DAWR macro
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

On Fri, Jul 17, 2020 at 2:11 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Current H_SET_MODE hcall macro name for setting/resetting DAWR0 is
> H_SET_MODE_RESOURCE_SET_DAWR. Add suffix 0 to macro name as well.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/include/asm/hvcall.h         | 2 +-
>  arch/powerpc/include/asm/plpar_wrappers.h | 2 +-
>  arch/powerpc/kvm/book3s_hv.c              | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index 43486e773bd6..b785e9f0071c 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -355,7 +355,7 @@
>
>  /* Values for 2nd argument to H_SET_MODE */
>  #define H_SET_MODE_RESOURCE_SET_CIABR          1
> -#define H_SET_MODE_RESOURCE_SET_DAWR           2
> +#define H_SET_MODE_RESOURCE_SET_DAWR0          2
>  #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE    3
>  #define H_SET_MODE_RESOURCE_LE                 4
>
> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
> index 4293c5d2ddf4..d12c3680d946 100644
> --- a/arch/powerpc/include/asm/plpar_wrappers.h
> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
> @@ -312,7 +312,7 @@ static inline long plpar_set_ciabr(unsigned long ciabr)
>
>  static inline long plpar_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
>  {
> -       return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
> +       return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR0, dawr0, dawrx0);
>  }
>
>  static inline long plpar_signal_sys_reset(long cpu)
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 6bf66649ab92..7ad692c2d7c7 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -764,7 +764,7 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
>                         return H_P3;
>                 vcpu->arch.ciabr  = value1;
>                 return H_SUCCESS;
> -       case H_SET_MODE_RESOURCE_SET_DAWR:
> +       case H_SET_MODE_RESOURCE_SET_DAWR0:
>                 if (!kvmppc_power8_compatible(vcpu))
>                         return H_P2;
>                 if (!ppc_breakpoint_available())
> --
> 2.26.2
>
