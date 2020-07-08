Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB59C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D01206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594231243;
	bh=PmKjVAdBMGNLghnWfISgs8ybk/NanFpMBAOB4i9BeN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ku8XFj8u6rMNNKtN8iQZ97HzkbbdAkibfT99JD/xBmRPTRx5Uj4OeRHJDsoVoYM/k
	 Eh8CfL6fDYQoPMYnXJKGYZWYpf/t+NTKUSKeIxXUqQpxQIchYjTEmDNmhgt28S9AoY
	 g0mXKYyW6mRZXLuzEfFAS2DbAJ0kD0YWOxLBTJas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGHSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:00:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55312C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:00:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so42042125ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5XIR15aEBjKzEA9W2lE8KNSZAO03DuL4VvK0HEZgj4=;
        b=CAEGyWluUdS2/+/QxbS2adVKlj4rm4jaGfE9yPeCwHJLCQXNeRKWlsV7XWRfFALonl
         EOEkSlDs9UoqbJsa8I93dW0z0TyrLzuvg3G9vZueD7j1TWG4dtUAPmKzg8A+e+XxVjM2
         nwlMC//lFwzWKXwhEmZxrCOQCJEtFAfoiH78w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5XIR15aEBjKzEA9W2lE8KNSZAO03DuL4VvK0HEZgj4=;
        b=FRR3hqGCYA7tUgPyDYdLIhZ0CAo0s5q//LUUbtQ43+BFaB1iY4tqlmwHaQ08R1S6/U
         YgTzg59EMySPCdmuvi4lEgVbwkRcIP6dOQQF7Icr+t4fxwp6bptYkaCzhjwC3bC4hUpv
         1S+TLBrCbUj/+Ag0m5OCIWSm4jbHL2D8iUBrgQOOyqSY/MZ44ySu24HIEPUYVG5SxAxk
         wdfsiyfNSg8KLUqrOLI1G3MDdPUjXVJCJDxmvRIzlWjVIWnH5MD3uO68W1ry+/cOiYjC
         IZCVo8FAQjZorHoyqgeUID7GMQyJ/nFzfBqinS5btycgJ6/nQ5dP9FRAT1aHPWuN3q+L
         g+Cg==
X-Gm-Message-State: AOAM531yU8VE3jDsQm393neRrACIazoie9ROTpOCfuxBGEE2ERo4Aikv
        OGR4ndNXV2XFl4tnvk86Vgd2lS6x0Fs=
X-Google-Smtp-Source: ABdhPJyq1Fhw7YvSKpzx3nA0OomGxgmwzpI3yVs8lLPI0ExIofaypvbXjHdrEv3Q6fv0umMRDwtcBg==
X-Received: by 2002:a05:651c:50d:: with SMTP id o13mr36353625ljp.181.1594231238160;
        Wed, 08 Jul 2020 11:00:38 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m18sm161271lfr.53.2020.07.08.11.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 11:00:36 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f5so39442406ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:00:36 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr28222464lji.70.1594231236141;
 Wed, 08 Jul 2020 11:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com> <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200708162053.GU4800@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jul 2020 11:00:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
Message-ID: <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 9:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > It's perhaps yet another reason to just skip gcc-4.8 too, since
> > apparently 4.9 works.
> >
> > gcc-4.9 really has a lot of advantages. It's where (I think) gcc
> > basically supports all C11 things, including _Generic() but also
> > __auto_type.
>
> +1
>
> Anybody for nay, or should we just do this?

I'll just do it. Let's see if anybody screams with a good reason. I
hate the whole "support old compilers", it ends up not only making for
complex code, it tends to cause these unnecessary kinds of "guys, we
tested this really well, but that crazy compiler had a very particular
odd issue, and it wasn't in any test box.

                Linus
