Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D0A2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594855145;
	bh=W6Z0YoOVNGNNfBaV7CBv/DlakUfCXA4pAaebjJuAm1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qnL5stsle7LMGNxNTT2UQQJ6mgara1PC5xN9aZB9TvdTJFwjfvwX8ORN8mKdmnqAE
	 8lHNrV3vBb7RYwnzknGccyMv8LolahYxpX9kdjz69BcNGBWSFwmSF5L1vgR2t0CxyM
	 9hXuYUeYfBND2peJGUZ1XEHluh3XH2Fokav42Z2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGOXTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:19:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4B0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:19:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t9so2109335lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1+a/ObNZL3+vD2m0kxRuakdnVXRAY/0dRWxur7hS3o=;
        b=Bw6ZnFqi0LokptDDvPQkvwYgLM4EwcHyG/o1zG9i4eCycUy4CxjKWFX4GltGI5Ntwu
         d442hjcpYOB0MC20Fn5HvhtSFP67sPkKUNqyOYJDbwzwjKHb6eHI5uKTOfpagqPhVox0
         RzQODZFbGnNBc7po2varkk7q5GTekjF4CDpbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1+a/ObNZL3+vD2m0kxRuakdnVXRAY/0dRWxur7hS3o=;
        b=uAnnujZ1kXkaClgBKx7Y/ocVQlKcw//KnixtlzIVFeLr+kSTksNOKjHzrWpQ5gpOBr
         LOzz6GRY8O6m5yM1FaS1S06+ZW6A3xTWZ8xZXhY9LV+JnaxeLRpIzZZVixFfwd2SPjCf
         Zgo/94cLHDu0p3W/0WKIfMgohBxaR7XwuAPXOz+d7QrqbMsbAfbmrZqfNRSZ3DllLlet
         zeMLgyPayAWl3yMUuCdd7b5UYOf11AYsXjYBilzCPhSfT78RBn9oF6Q4qKvUXaOSyPlC
         gzMR9NRPWM+xcNY7c6eyx+rIQqAPFwkl+639mSnYxdmbCsphWIAf8RqS/zA7L/bPwb11
         UP8g==
X-Gm-Message-State: AOAM530UayUDFncRzerrLaKeZfXx/c7P5xX+5K6lH4KT4UrDBiFJi9UB
        otOH26Dt/v/eswgVHrPjBjM2ppf8rw4=
X-Google-Smtp-Source: ABdhPJxOyCAHNOelvlKIEMrQjti1+d7OzciFoEaC0a5Y2bkvk7Rx07obkaiG9I8y+WXxuSfNSYG4QA==
X-Received: by 2002:a19:8055:: with SMTP id b82mr634420lfd.178.1594855141802;
        Wed, 15 Jul 2020 16:19:01 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w5sm693919lji.49.2020.07.15.16.19.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 16:19:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z24so4726250ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:19:00 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr668699ljc.285.1594855140186;
 Wed, 15 Jul 2020 16:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 16:18:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
Message-ID: <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Wed, Jul 15, 2020 at 4:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It *might* be as simple as this incremental thing on top

No, it needs to be

+       if (*old_addr + *len < old->vm_end)
+               return;

in try_to_align_end(), of course.

Now I'm going for a lie-down, because this cross-eyed thing isn't working.

              Linus
