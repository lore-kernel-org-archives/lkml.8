Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E4C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C63A24672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UaeuT1T2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBVA3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:29:32 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35538 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:29:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so1514006pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3+ekiIDMOGmiDjrYAnNc8G9eXFhd69LzzwYliKSeDk=;
        b=UaeuT1T2xzPoXNPxlPuN7qgHSNKYaqFXhKAUALtPwg8DJgTO/AVDcCGa0WQzLMZBj6
         ozTjHup3RowLqIjE0+/c9LeYRCxnA7HCkhT1nIb2BKK2fLUIVha0L9Wv2wsBpOxD3R2w
         QCDUb5IRlqbWRjl9Ud3gWtpP/Q71ObowauXB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3+ekiIDMOGmiDjrYAnNc8G9eXFhd69LzzwYliKSeDk=;
        b=VHLT1kuCPXhhiEr43Eafwg+FIkfIo3KPdBJqAbeABcdRS4yp/BgYBGcnHH88zSwXha
         00dqN8Baf69q7wFRfuH2hozYEY8kJaludS92a6oIz8WHsFWKvbkx5pFfHTmyKFVDLLli
         /lk6laFpHd+7mfmKM/uO0AoTeWQ2bn/Gi10Yp+xS9OCSsMw8q6R1ZNTYqxT0wTIVn7CF
         4WeylEwXp3oxtwvkcdHiq5SYjl4Cl2TrrzSxL/qtwPe3PrxtqRVvKvRPAEE2JNe5pLbq
         +bCT9Cpn8FIXsTNI7Z7J/S6Vk5zqu94ChrMkba+5qPMEzzt78c/XXgo7tn7muLw2zaI5
         +ZIQ==
X-Gm-Message-State: APjAAAWJ3UIX7ObGOJBG6a5U8U5mXhi+hen4IfPR6wpsiZiEtjFLD1cM
        sUKtL7xO98vWKjSzQw652b/Jqw==
X-Google-Smtp-Source: APXvYqyP2Eu7DZ39Tl0jFQ4lvdUnRpiBhcQzdZ7LrEf/OVF8NHlMo9EFXeE53kJ5qfdNni+OtJyw/w==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id a15mr6299848pjo.86.1582331371026;
        Fri, 21 Feb 2020 16:29:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm4213775pfq.3.2020.02.21.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:29:30 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:29:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
Message-ID: <202002211627.33D858AA@keescook>
References: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
 <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net>
 <202002211506.2151CA26@keescook>
 <CAHk-=wjL-4=YfvQb_pLhK5oH1QL2j-JCt-Z+S-r86-H__Vow0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjL-4=YfvQb_pLhK5oH1QL2j-JCt-Z+S-r86-H__Vow0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:57:21PM -0800, Linus Torvalds wrote:
> On Fri, Feb 21, 2020 at 3:10 PM Kees Cook <keescook@chromium.org> wrote:
> > Why not just fail after the WARN -- I wrote the patch for the (very few)
> > callers to handle the errors, clean up, and carry on.
> 
> Can it actually fail? Or is this all just "let's add new error
> conditions that make the code harder to read because they make no
> actual sense"?

I was just trying to see if there was a reasonable "do not continue and
do stuff we just tested for". If this should just be WARN_ON_ONCE() and
continue anyway, so be it. My general guideline is to avoid continuing a
known-bad path.

-- 
Kees Cook
