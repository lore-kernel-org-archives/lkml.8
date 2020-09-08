Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7970C2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50CA208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDlIF57Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIHUQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgIHPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CBC0619ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:58:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jw11so2175289pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfiGgLfl6xBSxCvQGQIeZLhg6EqD8qTgC7ENKGicg+c=;
        b=LDlIF57Z6gkV3MrqfZIfCLnhf8F5yjfc1yJBhx2bdIN5a5XgB/V7XTL+ga5NXCd/qZ
         2VGOlNA45XJrJMyum81fLgD4T1RTIx79vn8NhzsHCEDllluRnwA9PC9nn6P1ksavwRCB
         IgA6kLxgf2XJsn+yAjnBbjp8qn27H9sdXsQewnZw8m1CTaPRSPFp0Y2tZpbSgLQn4pyh
         1NHmJmv9zLqnontXUFeV+QLXvWDIRv7MHOq/GTF2hAwjyG20EaYI+SCDfqNBH7cddnBm
         K4dkupJQ3dIXhNKwAwdAS7qabyhepDoofVJnhkpiF+heUMmOPJt2cQHbacS+py52G6Tv
         BNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfiGgLfl6xBSxCvQGQIeZLhg6EqD8qTgC7ENKGicg+c=;
        b=fWJO/7bTLkiHx5l1RY3nNm4XyB3FA48oq7X6H9kk1GYLWPuw93Nsp3KHpg8skGFnc9
         fLf4YehkUYoSa0btwDjl1931y0+vMSYrhr1e9GyVvIV6N2x8Ez02UatxcmcKmwhO2V2O
         qMOjKiP/vsciOBIZeG6VSDxDPDVzRMrXcCYvX8O55Cn9LZuY6sRY3nYh+rDgL7AD5b0l
         AZ5J62kDQsbrU5MEqsbsu0mxNFn8OfyEQL6VC73tPZmyunVBi7OwgLydqsE0MofWrlNQ
         t6YUfnsw3hvo9+lSrNGYsVZ3X/5D1s1xwrlwtep/0wKT+J8mArM1Com46ui5REXjHDsS
         INPQ==
X-Gm-Message-State: AOAM5304lUFgkPQfct2QqbTpEm3pCY8GxEVvBR5TxzDgaVLpuTCebxwh
        UDfX55SkMbiMTLlxzYJ20FFgNC4LrLr0/M52pROhAw==
X-Google-Smtp-Source: ABdhPJw07BDHsbBTDLIPmsUv1zZtOHUHA9N56e0pfTrdGItIGZC4D81LXYIMuWA4y2byBNnUAzkvFqrm6CoRO/YjQwI=
X-Received: by 2002:a17:90a:81:: with SMTP id a1mr3972154pja.136.1599573498717;
 Tue, 08 Sep 2020 06:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia>
In-Reply-To: <20200827103819.GE29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 15:58:07 +0200
Message-ID: <CAAeHK+wX-8=tCrn_Tx7NAhC4wVSvooB=CUZ9rS22mcGmkLa8cw@mail.gmail.com>
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:38 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
> > @@ -957,6 +984,7 @@ SYM_FUNC_START(cpu_switch_to)
> >       mov     sp, x9
> >       msr     sp_el0, x1
> >       ptrauth_keys_install_kernel x1, x8, x9, x10
> > +     mte_restore_gcr 1, x1, x8, x9
> >       scs_save x0, x8
> >       scs_load x1, x8
> >       ret
>
> Since we set GCR_EL1 on exception entry and return, why is this needed?
> We don't have a per-kernel thread GCR_EL1, it's global to all threads,
> so I think cpu_switch_to() should not be touched.

Dropping this line from the diff leads to many false-positives... I'll
leave this to Vincenzo.
