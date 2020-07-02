Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DEFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCEE2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593721094;
	bh=eeqv045ZtIkQLwK7q/4wDgmJSPUN7vvhvVLfre4BYHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Af5jec/2hMBUmV7Jg6mQk7YuELTeWnJ9pAki6xwC/fYNsfUrrGGLha8/SPKqxSCZx
	 YQ02XlXeplulZgFb4kXsLwLdwr2JZ2waSX30d1G4GGGo5prYz0KhAtRJ++MfW3bcKf
	 wHfI1g9n6IwR8hLJ6U437op/wxwvguNP2L1iub8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGBUSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgGBUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:18:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6281C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:18:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f8so21599253ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKAvQ3x/jWOWfzX8imS+F5oUhVjtLTNjNSuHV7D48w8=;
        b=DbkIc3d98XP5MNyq8UNDBoqdCdN6zpg0tDrAIVNEKlHBrkulQdNCWA1kMFQ1JWAhdY
         D9gz+IcXmp0gFrT7uBcGwZNLc4wUtGiSlpOL0zA548LxhAFt3suKnCpuLomExQY2ykrW
         cglfpMCov0y4JxtIPrn8/cPBQMpAcOqVZ5MUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKAvQ3x/jWOWfzX8imS+F5oUhVjtLTNjNSuHV7D48w8=;
        b=VGcSZ2i8zHUerd/Ss3Hg6Cnik8MYg05axZjTpkpSIuDqvEmyssn1Z8RBYbNlSmFbxj
         KCYxChtUBM3clcam67OK/aLpHSbK/iH7q5PQPgdLoh+Oi0IMDYC9zVJQ7Ca6NWfHvrKh
         YL8qw9WBnsESsLs8sgIsK9FpEAI/aoRIXVogwGfDc+WEywUV4gwwgqFmYIJkrr7nTP3A
         WtL+B5734Wox8u4q73Eu36RWOcoeKnnDx0g7VTjH8RFppKGuSa3N7rdEA7qk+3Tl1iYo
         8dxnmLBzYN/DZp4vBnix8jllP7ddWlW9Mx3FxxQWCdMOoMM4K3oiQKdjfU38CI3B+AMJ
         2JzA==
X-Gm-Message-State: AOAM530fzmjzOKCJvadtZ2lUKft2zxu4J+IM3Vh1v78CTkLK0UfmHsGK
        1ST7czVOoXtM0gT1qN6tybG7qE0C3jE=
X-Google-Smtp-Source: ABdhPJxdubANq/ZNLN8JOT4AWBsoENK9NUt6TeUhJYzfAQhfMGfUq6OaV2LSm/LENxo/qg6r6WqSPw==
X-Received: by 2002:a2e:b541:: with SMTP id a1mr16052197ljn.4.1593721089049;
        Thu, 02 Jul 2020 13:18:09 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m6sm3295122ljc.134.2020.07.02.13.18.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 13:18:08 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u25so17008451lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:18:08 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr19422159lfd.31.1593721087764;
 Thu, 02 Jul 2020 13:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com> <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com>
In-Reply-To: <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 13:17:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
Message-ID: <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 12:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> > Of course, if you want to avoid both new reads to be submitted _and_
> > avoid waiting for existing pending reads, you should just set both
> > flags, and you get the semantics you want. So for your case, this may
> > not make any difference.
>
> Indeed, in the gfs2 case, waiting for existing pending reads should be
> fine. I'll send an update after some testing.

Do note that "wait for pending reads" very much does imply "wait for
those reads to _complete_".

And maybe the IO completion handler itself ends up having to finalize
something and take the lock to do that?

So in that case, even just "waiting" will cause a deadlock. Not
because the waiter itself needs the lock, but because the thing it
waits for might possibly need it.

But in many simple cases, IO completion shouldn't need any filesystem
locks. I just don't know the gfs2 code at all, so I'm not even going
to guess. I just wanted to mention it.

               Linus
