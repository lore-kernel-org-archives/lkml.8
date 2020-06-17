Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD252C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6AE20786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsMdoAiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgFQDil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:38:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15FCC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:38:39 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so488860otr.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38TmDk1O1wwxXumtDkSDguPbkWoEgQBxlXN5tB3XErM=;
        b=SsMdoAiJoMXnVfBDAJBzK8i4vsrlwdjyvj4UQggdqA3FGk4qedQf8PJbv5/gEW5r98
         u0MxgfeQpi+wTpngK7++3uOk9j7elt+8UWF2hdfzxxuJ0EpXVMyCDK1x+7t6PLazTBef
         1bhrMSQPEQfusinDndI9G/Ydi+n50bg6RkCDuqL2PMX1JMv6bv5bQ+toPGfmRuIJufni
         dzWXG1CfpzpvBDtDSmnLJuEsffL2P0WZmuSuZYsliGic1LK95ywkprYDULwGvWTISTzQ
         CGnJd7fyEzhXmQXSZCbV5//DMyhlMhwjqU1ZYDw8vMuUzQOSkq55JpHuGiXjF6kdcZ8t
         5fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38TmDk1O1wwxXumtDkSDguPbkWoEgQBxlXN5tB3XErM=;
        b=VbqOdikONdp8qlqVlu8o0M6MRg3ygn518TovQYXaJgN9vpd9bYIbciZ4TYIlEDb2hP
         WpWLNL2D6evUZHgisHNNXqFzoXMBbXOZ/Lub4IyAXcjvYIMzq+azgz6Qk0RUVXUl+DUr
         hNQexD6q6sc0E+9vPZwsU8uqZK6VE8HO0kpJlPId+3Vsqs22mWzhAzXADF4Pw4aEmne6
         hFQNqmA8n5ctxfG7srfw2AF72/37BYxZYICsy+5PT1C39uvRrWxFGT9/dkAlLEOmmfkH
         E7i9jARL+ZwrNTFsmQzd7imSTe2rA4sH87TYwe0SfzAOwuNgqOzOfEUFHYQrc00zvs/l
         +KLA==
X-Gm-Message-State: AOAM531g/jDoFf0z06CbfJl5SN8hIDXVkWJIInvRcJKCLoNEMLg1qLKq
        kh4B7W4eSdSqoJoQKD+shLQ71tWrGJ2w9LGx/k2uqw==
X-Google-Smtp-Source: ABdhPJwEliJlrsvIplobqlJKZ7S6Mjcj+jiCJ7puzAlF0ec1bFcCnb1Nqk5TRvKwqSZ/CBzLW5DixTsprZ0hyE5k3y0=
X-Received: by 2002:a9d:4c0b:: with SMTP id l11mr5412819otf.139.1592365118848;
 Tue, 16 Jun 2020 20:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200605222257.44882-1-saravanak@google.com> <20200616213953.GA2561@willie-the-truck>
In-Reply-To: <20200616213953.GA2561@willie-the-truck>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jun 2020 20:38:03 -0700
Message-ID: <CAGETcx9=GBDMd0BUt6rmfLt_BFmYvDthLjT1ts=E1JQJ8GT0kw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/module: Optimize module load time by optimizing
 PLT counting
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 2:40 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jun 05, 2020 at 03:22:57PM -0700, Saravana Kannan wrote:
> > When loading a module, module_frob_arch_sections() tries to figure out
> > the number of PLTs that'll be needed to handle all the RELAs. While
> > doing this, it tries to dedupe PLT allocations for multiple
> > R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> > R_AARCH64_JUMP26 relocations too.
> >
> > To make checks for duplicates easier/faster, it sorts the relocation
> > list by type, symbol and addend. That way, to check for a duplicate
> > relocation, it just needs to compare with the previous entry.
> >
> > However, sorting the entire relocation array is unnecessary and
> > expensive (O(n log n)) because there are a lot of other relocation types
> > that don't need deduping or can't be deduped.
> >
> > So this commit partitions the array into entries that need deduping and
> > those that don't. And then sorts just the part that needs deduping. And
> > when CONFIG_RANDOMIZE_BASE is disabled, the sorting is skipped entirely
> > because PLTs are not allocated for R_AARCH64_CALL26 and R_AARCH64_JUMP26
> > if it's disabled.
> >
> > This gives significant reduction in module load time for modules with
> > large number of relocations with no measurable impact on modules with a
> > small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
> > enabled, the load time for one module went down from 268ms to 100ms.
> > Another module went down from 143ms to 83ms.
>
> Whilst I can see that's a significant relative saving, what proportion of
> actual boot time are we talking about here? It would be interesting to
> know if there are bigger potential savings elsewhere.

100ms if pretty big in terms of boot time from a phone OEM
perspective. It adds up. And for these two modules I profiled, it adds
up to 228 ms. That's quite a lot.

Also, if you look at just the kernel init time and all the module load
time, it comes to around 2.2 seconds in the hardware I'm testing on.
That's a 10% reduction in the "kernel init" time. Also, this 2.2
seconds is without async probing. If we do that, this becomes and even
larger % of the kernel init time.

> > This commit also disables the sorting if CONFIG_RANDOMIZE_BASE is
> > disabled because it looks like PLTs are not allocated for
> > R_AARCH64_CALL26 and R_AARCH64_JUMP26 if it's disabled.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  arch/arm64/kernel/module-plts.c | 37 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index 65b08a74aec6..bf5118b3b828 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -253,6 +253,36 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> >       return ret;
> >  }
> >
> > +static bool rela_needs_dedup(Elf64_Rela *rela)
> > +{
> > +     return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26
> > +            || ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> > +}
>
> Does this handle A53 erratum 843419 correctly? I'm worried that we skip
> the ADRP PLTs there.

So this isn't really skipping any PLTs or RELAs. It's just picking the
RELAs that can benefit from deduping using sort. Even if I delete the
entire sort() call, all the modules load and the device seems to be
working fine (Video streaming over Wifi works). The catch there is
that the module takes up more memory (because the PLTs are duplicated
often) and you might potentially lose some caching benefits for PLTs
that have a significant amount of repetition (say, printk or something
like that).

You'll see that the duplicate_rel() call isn't even called in any code
related to that erratum. So, I think this is safe.

> > +
> > +/* Group the CALL26/JUMP26 relas toward the beginning of the array. */
> > +static int partition_dedup_relas(Elf64_Rela *rela, int numrels)
> > +{
> > +     int i = 0, j = numrels - 1;
> > +     Elf64_Rela t;
> > +
> > +     while (i < j) {
> > +             while (rela_needs_dedup(rela + i) && i < j)
> > +                     i++;
> > +             while (!rela_needs_dedup(rela + j) && i < j)
> > +                     j--;
> > +             if (i < j) {
> > +                     t = *(rela + j);
> > +                     *(rela + j) = *(rela + i);
> > +                     *(rela + i) = t;
> > +             }
> > +     }
>
> This is very hard to read and I think some of the 'i < j' comparisons are
> redundant.

I have no strong opinion on how this function is written. It's a
trivial partitioning code. I'll be happy to copy paste any clean up
anyone wants to suggest. I think all the i < j checks are necessary
for my current implementation.

> Would it make more sense to assign a temporary rather than
> post-inc/decrement and recheck?

I'm not sure I get what you are trying to say.

-Saravana
