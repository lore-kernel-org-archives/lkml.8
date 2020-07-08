Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B44C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D092E20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRLTbUBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGHHoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:44:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA9C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:44:37 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x83so29513392oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9MFIBkCR9j8+eze3fd0C5FytaBY3rx5UlBzr2QlpIs=;
        b=ZRLTbUBQMlOdcfwV4K6vyHf3ReZyGUriJ24+JRhdXfih8MWhImMwIFhc1TU+wW2wkK
         BZV4yAwze46JFrB6pPp4175HL5p2YxFSnHTI3VftLVJmVu7Z3+DNenu+BPqNyVY/2lCW
         zcOOEtHlT1apauoohGrlATv5AriY2DN97BhUHyZwSZ2Ky2pwTPsYyqt19VdJ64b5jP9f
         ez/DSOXeHo+5NEqj7cXa6/SakhjPj7//+qDo7SfFY//4/V2jHhScMJOlk9z0j/MpCloB
         /qY+ky5NpsM306NqIsOS+h2S77nqOZqN8UhSZ+V9pkP1hN6syqzdJeHFMft1gYKBlqWQ
         THkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9MFIBkCR9j8+eze3fd0C5FytaBY3rx5UlBzr2QlpIs=;
        b=rmLv1sIYXC9CkiD3wpWUYE7f4dkSjJygahp71QTkepdm9zmG6RSt6GiZg3Fd8yD5oQ
         btjdBiQp/Jv7aOvYQZu+nMsnpO/qPtzEIFlrCDUcBd1NDBkJcAjDWt80OoK6P8aOmeaF
         FE4aIqg59BDjisa3LueFwhEpR1xkQ9CoNuqFdbzpCcYTTgFKn1ziji0lyuqLg7JfomU+
         nrextOCe4E27YW0KwM8G9lIe9fJX1g1ETtAJFDwK4IMojLH0KdXeVyrxLGlaSqspIfba
         hkJ/BUv71+xKagj/I8hJKYkuEtyo22Mij724MlSXyku8XYjJOTt9abbBmN65G4Xbz/Ih
         aM3g==
X-Gm-Message-State: AOAM533UL80WTGw9SMfmSKkPu4Vq0rdG+ShEpTvFzQ/9DR4gz1/RIG3W
        AvPJ08HWMA97Kp3OkYaDRAgAJ4b5n5kx5C9iAnc=
X-Google-Smtp-Source: ABdhPJyzRoSumY4KPusSNhsW/NdfLDiwaP1MO9JljRCAyUxvbcGY6DgwS7LNJ7fMc9L/voZTo9OO3VBc81/w9vKNn9c=
X-Received: by 2002:aca:c70f:: with SMTP id x15mr6535883oif.40.1594194277193;
 Wed, 08 Jul 2020 00:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200708045046.135702-1-ravi.bangoria@linux.ibm.com> <20200708045046.135702-2-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200708045046.135702-2-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Wed, 8 Jul 2020 17:44:25 +1000
Message-ID: <CACzsE9qka0j7vKm186Z70fhNy9L4dNR3B97-jQ2oZZAwYduaRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] powerpc/watchpoint: Fix 512 byte boundary limit
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

On Wed, Jul 8, 2020 at 2:53 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Milton Miller reported that we are aligning start and end address to
> wrong size SZ_512M. It should be SZ_512. Fix that.
>
> While doing this change I also found a case where ALIGN() comparison
> fails. Within a given aligned range, ALIGN() of two addresses does not
> match when start address is pointing to the first byte and end address
> is pointing to any other byte except the first one. But that's not true
> for ALIGN_DOWN(). ALIGN_DOWN() of any two addresses within that range
> will always point to the first byte. So use ALIGN_DOWN() instead of
> ALIGN().
>
> Fixes: e68ef121c1f4 ("powerpc/watchpoint: Use builtin ALIGN*() macros")
> Reported-by: Milton Miller <miltonm@us.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 0000daf0e1da..031e6defc08e 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -419,7 +419,7 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
>         if (dawr_enabled()) {
>                 max_len = DAWR_MAX_LEN;
>                 /* DAWR region can't cross 512 bytes boundary */
> -               if (ALIGN(start_addr, SZ_512M) != ALIGN(end_addr - 1, SZ_512M))
> +               if (ALIGN_DOWN(start_addr, SZ_512) != ALIGN_DOWN(end_addr - 1, SZ_512))
I wonder if you should use end_addr - 1, but rather end_addr. For example:
512 -> 1023, because of the -1, 1024 will now be included in this
range meaning 513 bytes?

>                         return -EINVAL;
>         } else if (IS_ENABLED(CONFIG_PPC_8xx)) {
>                 /* 8xx can setup a range without limitation */
> --
> 2.26.2
>
