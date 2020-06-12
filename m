Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1AAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31846206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGm49oXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgFLN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgFLNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:55:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC4C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:55:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w20so4165622pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jjd0AuUqDMS+kg7RMfFuNDT5WMCpvxZwxODMYSMGb1M=;
        b=AGm49oXOJa5zvbGQSmCtPupmqX/vK0ZW8yO+FtbKQdYZhs/qHaUS/YrDhFOr2Ohk2C
         vmm3wEH/np8fZhGqc4XNfrMnILSw+UvGZdh/wynEj63vaoMLII/YBTTwfnYG1oMkd4yi
         mTsaj9JZb9qzBuD1CwqYPNRWvT82p5TKFWey09Jyp+fc0NjpoYrOH9XkEmy19ojS8tJB
         bcm/JOqSpb+/aYnPpOBvKGsvTRzsD7FLRL86I+HhWCdtQgLN/F4Jn6yCLgjwWIuUGWh6
         EpgBun44z05r0/yWcQIBB+1WyCZrI2OfsoCxeHxH3rFDK+tZWE1El3KgmYVY7xldognU
         KF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjd0AuUqDMS+kg7RMfFuNDT5WMCpvxZwxODMYSMGb1M=;
        b=qdtzOKATRrE941leYuTzwKa3i9oG+W6yXXsGQjv7XL28Y/2D41qqPVSUn3zNpmX0br
         FNJ4X7+Y1orFOh0eHC7ScEQ2sm8mrr4B21/vnTrhj801LothKHHwc708V1HBDAs/g55I
         n20IiUzB4cnzTiMbpfT0mbYat8SQ5njCY0Rm2/w0O3xIPjKLWpgFkiy8KSckuFlyy1C8
         4iaJTUNOtxM9bGhfaLcMaDcA4ocCCfnji6zoHZChDwEGJCvr3LZWvCX7XkmURvQG4K+P
         WKqG+i197gEp+tgRa2bG0MzMQ7571JuDcKhRw1mOliT3/+WBsuRcCZNnN0lHjWao06Kj
         bNBQ==
X-Gm-Message-State: AOAM5331BR3MirjqorR6K2G6OUzvqbplXGwogcFU5n6NiF1o+eSN71rs
        EADwoQI+SkxEUiG9kwAhXtg=
X-Google-Smtp-Source: ABdhPJxZsluvfDXjcLYcixbYMCGaCMI0iW8Tje9KJtl2C3rbqpPHE3nY5bBWjfZrbopCFK5js/mV7w==
X-Received: by 2002:a63:7707:: with SMTP id s7mr10832085pgc.295.1591970145638;
        Fri, 12 Jun 2020 06:55:45 -0700 (PDT)
Received: from localhost ([49.207.50.185])
        by smtp.gmail.com with ESMTPSA id e127sm6617854pfe.45.2020.06.12.06.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 06:55:44 -0700 (PDT)
Date:   Fri, 12 Jun 2020 19:25:38 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200612135538.GA13399@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 02:02:13PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 12, 2020 at 12:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > Roughly a one-third drop in performance. Disabling highmem improves
> > performance only slightly.

> There are probably some things that can be done to optimize it,
> but I guess most of the overhead is from the page table operations
> and cannot be avoided.

Ingo's series did a follow_page() first, then as a fallback did it
invoke get_user_pages(), i will try that way as well.

Yes, i too feel get_user_pages_fast() path is the most time consuming,
will instrument & check.

> What was the exact 'dd' command you used, in particular the block size?
> Note that by default, 'dd' will request 512 bytes at a time, so you usually
> only access a single page. It would be interesting to see the overhead with
> other typical or extreme block sizes, e.g. '1', '64', '4K', '64K' or '1M'.

It was the default(512), more test results follows (in MB/s),

                512     1K      4K      16K     32K     64K     1M

w/o series      30      46      89      95      90      85      65

w/ series       22      36      72      79      78      75      61

perf drop       26%     21%     19%     16%     13%     12%    6%

Hmm, results ain't that bad :)

> If you want to drill down into where exactly the overhead is (i.e.
> get_user_pages or kmap_atomic, or something different), using
> 'perf record dd ..', and 'perf report' may be helpful.

Let me dig deeper & try to find out where the major overhead and try
to figure out ways to reduce it.

One reason to disable highmem & test (results mentioned earlier) was
to make kmap_atomic() very lightweight, that was not making much
difference, around 3% only.

> > +static int copy_chunk_from_user(unsigned long from, int len, void *arg)
> > +{
> > +       unsigned long *to_ptr = arg, to = *to_ptr;
> > +
> > +       memcpy((void *) to, (void *) from, len);
> > +       *to_ptr += len;
> > +       return 0;
> > +}
> > +
> > +static int copy_chunk_to_user(unsigned long to, int len, void *arg)
> > +{
> > +       unsigned long *from_ptr = arg, from = *from_ptr;
> > +
> > +       memcpy((void *) to, (void *) from, len);
> > +       *from_ptr += len;
> > +       return 0;
> > +}
> 
> Will gcc optimize away the indirect function call and inline everything?
> If not, that would be a small part of the overhead.

i think not, based on objdump, i will make these & wherever other
places possible inline & see the difference.

> > +       num_pages = DIV_ROUND_UP((unsigned long)from + n, PAGE_SIZE) -
> > +                                (unsigned long)from / PAGE_SIZE;
> 
> Make sure this doesn't turn into actual division operations but uses shifts.
> It might even be clearer here to open-code the shift operation so readers
> can see what this is meant to compile into.

Okay

> 
> > +       pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL | __GFP_ZERO);
> > +       if (!pages)
> > +               goto end;
> 
> Another micro-optimization may be to avoid the kmalloc for the common case,
> e.g. anything with "num_pages <= 64", using an array on the stack.

Okay

> > +       ret = get_user_pages_fast((unsigned long)from, num_pages, 0, pages);
> > +       if (ret < 0)
> > +               goto free_pages;
> > +
> > +       if (ret != num_pages) {
> > +               num_pages = ret;
> > +               goto put_pages;
> > +       }
> 
> I think this is technically incorrect: if get_user_pages_fast() only
> gets some of the
> pages, you should continue with the short buffer and return the number
> of remaining
> bytes rather than not copying anything. I think you did that correctly
> for a failed
> kmap_atomic(), but this has to use the same logic.

yes, will fix that.


Regards
afzal
