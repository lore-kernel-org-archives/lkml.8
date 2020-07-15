Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0984CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51AD2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594848736;
	bh=UN53w6/v3IIYTPxjDCO3ODEmL7ut6oRfzJa7C4UIe08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dbm4Q+75fSQ8/xHX+ajmCT+e+6dLy4zL1KZIhtUVte6IwQSPM9HAm+NOFCgmItpul
	 P0q3L/qkmDOz/qb/8T+1DTD7iWZRDn1c3hGP8+GK28o5ojXjTx7KyLUaG5WVawGB7e
	 YDdJ8PD+GJwRzKndYA/2ta0NAu90ZWC6vMXAzSuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGOVcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:32:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:32:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r19so4323823ljn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Slsfcsh628hGH9fKIfCUDCo179zQ291O44Iubhz+iYw=;
        b=O4kkFWBFfS6AruYdFO2kccl5YLYkpVV48bmKKxenxXHKgGnD1JdBpgnOWobKutjQy3
         Y7HEUJ2/gu9Dzu/XAqMuW+dp94DFj9wAenMyRxasT9IGWFCeOWvoZAgmbKy7oaq5TpSc
         JOtsiI5wdnX+7TiicHV1PBecF7rxvi0SyEcN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Slsfcsh628hGH9fKIfCUDCo179zQ291O44Iubhz+iYw=;
        b=DyMuatnHUZKvxFxfCruDIy7C00jE5OIliJPkbNhGrVh6WJoDd6PQ43eNSOFiv8BDLY
         AXmW+yH5pN0C3fC8xxDhypUFP0fxC+zRFTtduSgYxK2uOOgUB4vkjqxnVu9tW3XOvuoy
         PVA7MiXxRvenDu+YUPMmwcrkawDx18w3+iwxqfrmt1bHzHI6VykSFKdz0jEj5ewYpWVY
         7JQr0TRuHfftWW3lM1+8kHdxGgGbumUF6iF/8rqHNKKJoNAS69nWaYeq1+xpKE3my/tP
         ImXsw9SdkWH42sy/GlK2/JXP4giFTPnmSrjhqjmCOMT+pWVHgui6RkoAVvjVs89GSWXx
         nlCg==
X-Gm-Message-State: AOAM5339rLuM9eVmozZ174MUjfBcPLW10Sg5gPo++cT0KIRt7SWSvgr7
        4fxBajC89b9IrTGZMPJQxoIiBIiAkRU=
X-Google-Smtp-Source: ABdhPJxTwLl/7bLE37l0MGOeIOvhggtssLr+SPe4/9MoHJi8wlfphZ+b1ya5hArRO7mvV6BTRx9VLw==
X-Received: by 2002:a2e:8942:: with SMTP id b2mr461253ljk.412.1594848732421;
        Wed, 15 Jul 2020 14:32:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o5sm883785lfg.27.2020.07.15.14.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 14:32:11 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id y18so1924615lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:32:10 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr475815lfd.31.1594848730272;
 Wed, 15 Jul 2020 14:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com> <20200715205428.GA201569@google.com>
In-Reply-To: <20200715205428.GA201569@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 14:31:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
Message-ID: <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 1:54 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Regarding the ADDR_AFTER_NEXT checks, shouldn't you check for:
>
>         if (ADDR_AFTER_NEXT(ALIGN(*old_addr + *len, PMD_SIZE), old))
>                 return;

No, there's even a comment to the effect.

Instead, that ADDR_AFTER_NEXT() aligns the next address _down_ to the
PMD boundary.

Because otherwise, what can happen is:

 - you're on an architecture that has a separate address space for users

 - you're the next-to-last VMA in that address space,

 - you're in the last PMD.

And now "ALIGN(*old_addr + *len, PMD_SIZE)" will wrap, and become 0,
and you think it's ok to move the whole PMD, because it's now smaller
than the start address of the next VMA.

It's _not_ ok, because you'd be moving that next-vma data too.

> and for the len calculation, I did not follow what you did, but I think you
> meant something like this? Does the following reduce to what you did? At
> least this is a bit more readable I think:
>
>         *len += (ALIGN(*new_addr + *len, PMD_SIZE) - (*new_addr + *len));

Yes, right you are.

I actually wrote that first (except I added a helper variable for that
"*new_addr + *len" thing), and then I decided it can be simplified.

And simplified it wrong ;)

> Also you did "len +=", it should be "*len +=" in this function.

That's indeed a plain stupid bug ;)

Naresh - don't test that version. The bugs Joel found just make the
math wrong, so it won't work.

The concept was solid, the implementation not so much ;)

                 Linus
