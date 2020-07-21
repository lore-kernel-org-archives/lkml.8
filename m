Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50331C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2925A2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itQNcKcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGUElu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgGUElt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:41:49 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29058C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:41:49 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id t12so3666868ooc.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5pmXlWsJseKxXD6BxsrJbesRRq6vXEEnjoC2olkcJo=;
        b=itQNcKcSj6tex9SlCrDZD4lhxnrGwDST2/8O+DVZaSQs564N9CMcNzyPpsTyA0jTkR
         afIFXIwqpZI5bjcg4sfVJBAwY2yAjfVKmRFgKCLAt34WyqneB1Hot7yMOMsBxV+rYw6T
         e9iFv+fiZGwd0/QhczASKtL2HyaZH78UZp3TjGV+STJBatTKCPwfbgNs2fhut8SeBqAF
         7GSDw1noOaTnB1sdxtbYV7AJLlCvegEGMR5hCiuFBWUGTZb6rnFu+rhXaxsGmgpJtyqk
         +eoikz7+lpaWVYk52prZ6CBH9tSnNvCqW58bBsooGfMrv17155Drm5X5Ay3pXZd7NiEw
         nWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5pmXlWsJseKxXD6BxsrJbesRRq6vXEEnjoC2olkcJo=;
        b=olkJmYX1SkJrOsodTzho8eEnFsQ4hjd3y9wvlb23f3uZFh+mfjXkG4IRCyOf5ev9Xq
         pbahe04zhgyRdnc0xG/SCp7DCgmMJglzKGhKJT9AfHF6HTuGpTZZ6CaQPwcgyHi5UkVK
         OdoRAgiEwaPX99p2xiMQxS/GkmOlpAovZoBJh+YMmvNJvYKcdPt7wZ6iOpzIBZCQdeo/
         YZpeSTE7+AdvTuCG0Wyl4V/7dTVGQjEqEWHhRdKl4gCRlugzhE5BfH10c+rrGsATqWt6
         2vXcZTg0VptzG33MhSMj3lLejnHYZebjR7UEp2leNfANM2MVA3ttzxV5JIqyylN11zi5
         /6NQ==
X-Gm-Message-State: AOAM533IU0BGlSj7qK6ucCrncC0eN2ft405b+ayY7j7J5bEBg1YrEQEG
        P60vl6gDT1m1dtpW39RxJH9X+z38IlJ76QC17wM=
X-Google-Smtp-Source: ABdhPJy8DDGlOWOc/9xhy6NZJHEyUsA6TY6rafZcdpXx0vcoakbBYRsfzyFHj+7MFSlWso0YwQPNqm6fpec3KGGmibI=
X-Received: by 2002:a4a:ba8b:: with SMTP id d11mr22545884oop.80.1595306508490;
 Mon, 20 Jul 2020 21:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com>
 <20200717040958.70561-10-ravi.bangoria@linux.ibm.com> <CACzsE9r0acLUkV35mVxy1AEK_xObs0yz+fD6UdbNdc6uz=Buqw@mail.gmail.com>
 <ccfcf488-0ec9-1737-8368-a848de1d72d1@linux.ibm.com>
In-Reply-To: <ccfcf488-0ec9-1737-8368-a848de1d72d1@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Tue, 21 Jul 2020 14:41:37 +1000
Message-ID: <CACzsE9q5YtT_bXOpw9cri_UCxziW_FRbCpcViANaZwui0hjDqw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] powerpc/watchpoint: Return available watchpoints dynamically
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 1:57 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
>
>
> On 7/20/20 9:12 AM, Jordan Niethe wrote:
> > On Fri, Jul 17, 2020 at 2:11 PM Ravi Bangoria
> > <ravi.bangoria@linux.ibm.com> wrote:
> >>
> >> So far Book3S Powerpc supported only one watchpoint. Power10 is
> >> introducing 2nd DAWR. Enable 2nd DAWR support for Power10.
> >> Availability of 2nd DAWR will depend on CPU_FTR_DAWR1.
> >>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >> ---
> >>   arch/powerpc/include/asm/cputable.h      | 4 +++-
> >>   arch/powerpc/include/asm/hw_breakpoint.h | 5 +++--
> >>   2 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> >> index 3445c86e1f6f..36a0851a7a9b 100644
> >> --- a/arch/powerpc/include/asm/cputable.h
> >> +++ b/arch/powerpc/include/asm/cputable.h
> >> @@ -633,7 +633,9 @@ enum {
> >>    * Maximum number of hw breakpoint supported on powerpc. Number of
> >>    * breakpoints supported by actual hw might be less than this.
> >>    */
> >> -#define HBP_NUM_MAX    1
> >> +#define HBP_NUM_MAX    2
> >> +#define HBP_NUM_ONE    1
> >> +#define HBP_NUM_TWO    2
> > I wonder if these defines are necessary - has it any advantage over
> > just using the literal?
>
> No, not really. Initially I had something like:
>
> #define HBP_NUM_MAX    2
> #define HBP_NUM_P8_P9  1
> #define HBP_NUM_P10    2
>
> But then I thought it's also not right. So I made it _ONE and _TWO.
> Now the function that decides nr watchpoints dynamically (nr_wp_slots)
> is in different file, I thought to keep it like this so it would be
> easier to figure out why _MAX is 2.
>
> >>
> >>   #endif /* !__ASSEMBLY__ */
> >>
> >> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> >> index cb424799da0d..d4eab1694bcd 100644
> >> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> >> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> >> @@ -5,10 +5,11 @@
> >>    * Copyright 2010, IBM Corporation.
> >>    * Author: K.Prasad <prasad@linux.vnet.ibm.com>
> >>    */
> >> -
> > Was removing this line deliberate?
>
> Nah. Will remove that hunk.
>
> >>   #ifndef _PPC_BOOK3S_64_HW_BREAKPOINT_H
> >>   #define _PPC_BOOK3S_64_HW_BREAKPOINT_H
> >>
> >> +#include <asm/cpu_has_feature.h>
> >> +
> >>   #ifdef __KERNEL__
> >>   struct arch_hw_breakpoint {
> >>          unsigned long   address;
> >> @@ -46,7 +47,7 @@ struct arch_hw_breakpoint {
> >>
> >>   static inline int nr_wp_slots(void)
> >>   {
> >> -       return HBP_NUM_MAX;
> >> +       return cpu_has_feature(CPU_FTR_DAWR1) ? HBP_NUM_TWO : HBP_NUM_ONE;
> > So it'd be something like:
> > +       return cpu_has_feature(CPU_FTR_DAWR1) ? HBP_NUM_MAX : 1;
> > But thinking that there might be more slots added in the future, it
> > may be better to make the number of slots a variable that is set
> > during the init and then have this function return that.
>
> Not sure I follow. What do you mean by setting number of slots a
> variable that is set during the init?
Sorry I was unclear there.
I was just looking and saw arm also has a variable number of hw breakpoints.
If we did something like how they handle it, it might look something like:

static int num_wp_slots __ro_after_init;

int nr_wp_slots(void) {
    return num_wp_slots;
}

static int __init arch_hw_breakpoint_init(void) {
    num_wp_slots = work out how many wp_slots
}
arch_initcall(arch_hw_breakpoint_init);

Then we wouldn't have to calculate everytime nr_wp_slots() is called.
In the future if more wp's are added nr_wp_slots() will get more complicated.
But just an idea, feel free to ignore.

>
> Thanks,
> Ravi
