Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E80C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7DA20692
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586549616;
	bh=5wsfNkHN6jWQdP04K9zIpc0tM+4AxdKzcX7x0Rpy9jw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ek4M7kyy3hSynjILoU0cPKz6lPtiBxyLmZPwT02/OL/b17taNL+MRd9ft+CDZmY+/
	 cxrmaPrOn/3cEDA1w4qa358hEHcurW8QGuxhIeVej88PbqKqZZgNR/oMdE3/obAZWP
	 ug/Zus4w6ICoFR6PCIqGp1u0jhfOImHaytKXAXXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJUNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:13:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33671 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:13:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id q22so3090713ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VjQx3sNHjM9Ybj3pkSSt2cbo4c8KdpiMcEUyZvcRTo=;
        b=UOOqKTuXJVB5DXty2pYL9sGwg5sKoaPO1nkz6bubzMgOw3mgqg/9f+d87SHPIUvrn6
         9yxpYYsgN6kaa4psBhtDf7aR34kNFUq8TM8itWny38GWbXMhsFd6wadAZV0acAAS5poB
         j31L3xH37rrb4O1RLNKQQgE68i9bKbaWVBk04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VjQx3sNHjM9Ybj3pkSSt2cbo4c8KdpiMcEUyZvcRTo=;
        b=JQCNps/5EpkEtcYYl9yqivpnXZbkmDJpIIs2D3wdTFOhEzOPQ8Bj/WJ5pykM+1/PjR
         zeW03WiX1F3UxgnKoeGGE2RrYqHiwIwmgHAC8dMYfBR2KozMQY4x9byPdn4DspOS4qwC
         Y6FR/YYsvOhwufZj75JFsuEe8QnyCj7W5MdaFsnTOyshgt+HiWApzWNGSH8axNS8it10
         yRelg0DEQ9ncyjWpdjHj3y2BTqpMrf8dsnsqMRlY0f9AK/Fv/OgOf8cGLWu0AsYKy7TF
         UOG5pELrwjpMRB2IeFNgfOrEy0F+VtaGrwHfDulGzZ1AKCKJALxn+q5S1r7nbG/vo11o
         V6GQ==
X-Gm-Message-State: AGi0PubDx0g0Pgnl5EcneIbevUOl8Z1NZgLPVsNlA9jMLe/J9O/c7Wze
        gEO6HJK/5ylBCuw0ClSJaIuffzw35C0=
X-Google-Smtp-Source: APiQypKVt1avoZeGwp2ATQhM8TiPY8aSStpfgqQGNa+XMEcqyRKnXU0RTVQ4kbckjMXz2oZGM0yGQg==
X-Received: by 2002:a2e:a179:: with SMTP id u25mr3751113ljl.192.1586549609879;
        Fri, 10 Apr 2020 13:13:29 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a26sm1698446ljn.22.2020.04.10.13.13.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 13:13:28 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r24so3072627ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 13:13:28 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr3857281ljp.204.1586549608204;
 Fri, 10 Apr 2020 13:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200410132706.170811b7@canb.auug.org.au> <27c212c4-b522-561d-411c-e74dc0ff0b74@infradead.org>
 <CAHk-=wjhsM-n_NzSh=cSdpThX+62-x3EmyKjhMqGHFYEyG0nPg@mail.gmail.com>
 <2b0f5d2e-3fe5-10c9-2a9a-9a0b341a52d5@infradead.org> <CAHk-=wjXZSPPWzPs=KBDsLZWuq8qO=9qWfiKHw=yV10fFrDv9Q@mail.gmail.com>
 <bfbcaa67-9656-3a80-fc66-c937297c8be0@infradead.org>
In-Reply-To: <bfbcaa67-9656-3a80-fc66-c937297c8be0@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Apr 2020 13:13:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpvCqcCYvy=_v_F6NTtBSeQbXZ0iLr_smV2NJLT+XACw@mail.gmail.com>
Message-ID: <CAHk-=whpvCqcCYvy=_v_F6NTtBSeQbXZ0iLr_smV2NJLT+XACw@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 10 (lib/test_printf.ko)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 12:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/10/20 12:05 PM, Linus Torvalds wrote:
> >
> > That may be because of something like a DEBUG_INFO_REDUCED option.
>
> No, that's enabled. (see below)

That's kind of the point. DEBUG_INFO_REDUCED doesn't do the _full_ debug info.

And honestly, that's the right thing for 99% of all people. The full
debug info is _huge_. Enormous. It takes up lots of space, and it
makes for slower builds.

So normal people should use REDUCED.

But the full debug info does give some nicer debug stack traces with
dump_stack.sh, so for things like automated robots etc it's a great
thing.

> This is with FRAME_POINTER, not UNWIND_ORC. Maybe that's the difference?

That might cause the question marks and some additional uncertainty in
the underlying raw stack traces that the kernel reports, but no, it
shouldn't matter for what dump_stack.sh does.

               Linus
