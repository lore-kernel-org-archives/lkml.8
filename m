Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228C72070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Zx4MgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgGTDqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGTDqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:46:02 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3951EC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:46:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t18so11112046otq.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUo91yORQpmQrJaOYjYlutMzILGTSt8GTjjWtCRYY+Y=;
        b=J4Zx4MgOZIL/gGkGJMyP+FNGO8dyF8LKnVLl3pQaMc7wo0FnO7t3tO+pQhTVc6fZmJ
         TAGQGJ1yacVYHJh7J5w5HKFaHv3Fz/b+rc5Wu2Qk/k7vKjAIIKe3Ua9NXby6Rh0QXbmn
         COtWCMuoyBZjkUJYblsgKyOS4+VfBTE6AO9n/6NHvnfjzhLB2Oz56OXdEdKf3me6ISkj
         CMiTHZ6niEY7TyizY6v9cHPrvvPX9JRNRT4+BzAqqMxXtdZpZ/CsnVTTBhPFVlYw/6hj
         Gkv80XPRO0Mzx8ybt5DNeOm9pUTjejxdN23+z9d+pRqF7SpNrH0Bf+PnIn4k628Vql5o
         EfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUo91yORQpmQrJaOYjYlutMzILGTSt8GTjjWtCRYY+Y=;
        b=KFU+jAB+QTzddtaMka+FWJV/DEc32wNPr3Sc3aClb0FebpNc31xqATgjkh5nTj5eEg
         WZC8OFvI3/ccegD32zW4vRMqUahX3yibhU/uYRWLnPCUcjNcm6n4cQKqhhbm2G3Rmn0k
         45M63Lvtt+quzapDcmSX3NwNRUanW2VM7NFTppwPScFMeOPNanl9kZgnRdSDyuibF1dx
         FzY+A50l+0niijD5nm0c9WlNYsSuT8H/0M9n4Dbo2XxnbJBWlcPN+SlF0UKyO3MPE+pz
         sOiLhlobGDrFFaNc2CMammtTo6yz4l+YXgBSAi1XBWOHmKwnpjReZH+aKHl9rEWs+VgH
         IrIg==
X-Gm-Message-State: AOAM530rh+Co2XmzV9Yb4dymubQ+Ij7Sww/Tg4kwUahjX4C1poF2XZ0i
        C5ApHcaoRbwCJQcrB0DrzAZbxugP0Tje/nFtKJU=
X-Google-Smtp-Source: ABdhPJw9jkRfB/fLMAKvjcGMQ0RpmsQS2Kcfu7xbtbkIOAM7bX0lwvqv7pPKnqhfETHAI3VawfiCv2I1KfiLMyZiQfs=
X-Received: by 2002:a9d:6a12:: with SMTP id g18mr19560641otn.155.1595216761606;
 Sun, 19 Jul 2020 20:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-10-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-10-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Mon, 20 Jul 2020 13:42:42 +1000
Message-ID: <CACzsE9r0acLUkV35mVxy1AEK_xObs0yz+fD6UdbNdc6uz=Buqw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] powerpc/watchpoint: Return available watchpoints dynamically
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
> So far Book3S Powerpc supported only one watchpoint. Power10 is
> introducing 2nd DAWR. Enable 2nd DAWR support for Power10.
> Availability of 2nd DAWR will depend on CPU_FTR_DAWR1.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/cputable.h      | 4 +++-
>  arch/powerpc/include/asm/hw_breakpoint.h | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 3445c86e1f6f..36a0851a7a9b 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -633,7 +633,9 @@ enum {
>   * Maximum number of hw breakpoint supported on powerpc. Number of
>   * breakpoints supported by actual hw might be less than this.
>   */
> -#define HBP_NUM_MAX    1
> +#define HBP_NUM_MAX    2
> +#define HBP_NUM_ONE    1
> +#define HBP_NUM_TWO    2
I wonder if these defines are necessary - has it any advantage over
just using the literal?
>
>  #endif /* !__ASSEMBLY__ */
>
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index cb424799da0d..d4eab1694bcd 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -5,10 +5,11 @@
>   * Copyright 2010, IBM Corporation.
>   * Author: K.Prasad <prasad@linux.vnet.ibm.com>
>   */
> -
Was removing this line deliberate?
>  #ifndef _PPC_BOOK3S_64_HW_BREAKPOINT_H
>  #define _PPC_BOOK3S_64_HW_BREAKPOINT_H
>
> +#include <asm/cpu_has_feature.h>
> +
>  #ifdef __KERNEL__
>  struct arch_hw_breakpoint {
>         unsigned long   address;
> @@ -46,7 +47,7 @@ struct arch_hw_breakpoint {
>
>  static inline int nr_wp_slots(void)
>  {
> -       return HBP_NUM_MAX;
> +       return cpu_has_feature(CPU_FTR_DAWR1) ? HBP_NUM_TWO : HBP_NUM_ONE;
So it'd be something like:
+       return cpu_has_feature(CPU_FTR_DAWR1) ? HBP_NUM_MAX : 1;
But thinking that there might be more slots added in the future, it
may be better to make the number of slots a variable that is set
during the init and then have this function return that.
>  }
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> --
> 2.26.2
>
