Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F802053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnjOXbm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgHOV53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgHOVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6126DC06135C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:14:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a79so5413588pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGi2odQIN3hUlyq/NfurerxmBmMjUNFi5Q5z5tYjXXc=;
        b=vnjOXbm9QNRABcrQnPRDRCfUC06bk96KMpSVOH8h4GP58sJglkcWcxWC4dElhH2aKx
         iJTsEGY4mjc3+YsIbtlT4V+aVZmmFBEjkd1TvPU3aI4iSq60nfqAvLFotOFfNWeXm/G8
         p3qbmPp+Q7WqkXwc6vTcgvYt9qw3eL5Nu0986P4mX4X/7mrLmyVw9N/AFls3lsAeHMvJ
         rH+b7zaE467PfO1JrzF9j/VAgmTsVJB5U5+dXu6WAKp5MUNG8AlnlRUPBlanwIqKj71+
         bMkzxaKN7f4MjjzYvXbP2oghOettizUmPM/3EdXALVOa7F42NY9YjBqOLyrZbJHu25Dv
         8I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGi2odQIN3hUlyq/NfurerxmBmMjUNFi5Q5z5tYjXXc=;
        b=HKiAicXwst+mZr0teLFqpqdlWtO01mJF4Su0LbZcx4xZztCQmk00Q3pazYPgsRr6tF
         ynUxIaB1OXEy1GOIUPQ9rRv4okKwFjvvxETN8EVkfNN4Twwf5ktXVLXxAM3sYaPStQd2
         oZ/JX73TPqxkEPQz9z4eCoAbWx8THX9POupPAx1E0RVtrULKSokWjmnNrmI73h+Qv2V+
         uR25fMnJ23VjN1qXsZJhdngb8SFQqobVz2KR2/tkNBPf6w6iMwwlqo0FLT0PtRyh7DkD
         0ptNunGhKB6lyYqj36tvIKl8vICJkwAPw0G48HSYup98LETyhF/6fnWA4+GDl8at9GED
         ca6g==
X-Gm-Message-State: AOAM532Kk2kiZ6zubRjdNBp974FnS8kLTFntSmqCy9MwAMU4uP9SqVBU
        XAgFkpuTENoZEGtUGFKl5OVAwwpd3Cz4tzPAo4nOrtB1BCo=
X-Google-Smtp-Source: ABdhPJyEyJFbbwrX/G1YzMUiose8GWSpxMM1Z0OVh7zO7HJUZVqEzpLvYwubH17RFBnJ2kLc4gnQQJpe2fFbgr2kSUc=
X-Received: by 2002:a63:4e56:: with SMTP id o22mr3332756pgl.381.1597457683228;
 Fri, 14 Aug 2020 19:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
In-Reply-To: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 19:14:31 -0700
Message-ID: <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 6:38 PM Joe Perches <joe@perches.com> wrote:
>
> Use the proper form of the RESTRICT keyword.
>
> Quote the comments properly too.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

(Surprised what looked to me like a typo compiled).  Would a
checkpatch warning be helpful, too? What's KAO? Urban dictionary has
no entry. :^P

> ---
>  scripts/genksyms/keywords.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
> index 7a85c4e21175..057c6cabad1d 100644
> --- a/scripts/genksyms/keywords.c
> +++ b/scripts/genksyms/keywords.c
> @@ -25,9 +25,9 @@ static struct resword {
>         { "__int128_t", BUILTIN_INT_KEYW },
>         { "__uint128_t", BUILTIN_INT_KEYW },
>
> -       // According to rth, c99 defines "_Bool", __restrict", __restrict__", "restrict".  KAO
> +       // According to rth, c99 defines "_Bool", "__restrict", "__restrict__", "restrict".  KAO
>         { "_Bool", BOOL_KEYW },
> -       { "_restrict", RESTRICT_KEYW },
> +       { "__restrict", RESTRICT_KEYW },
>         { "__restrict__", RESTRICT_KEYW },
>         { "restrict", RESTRICT_KEYW },
>         { "asm", ASM_KEYW },
>


-- 
Thanks,
~Nick Desaulniers
