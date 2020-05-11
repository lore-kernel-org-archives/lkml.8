Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF192C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8993A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589227298;
	bh=D2wwetFftwZrrTNDcTxyNnZtia+OMbrt0SFb5MxkZpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=paV28qrYhuzUx6fOQtYVyLw0RoYwQ5+F0bisHhywTZPyWtPc58RS4XyJ0EP7j4pRQ
	 Nzvd59frjRb+vhvW+T1WeXXm+eL756ZyC5c70jQdhMDPb62jYgn3sQwV3FDgBPz+rW
	 QHX5y9hO4d7A48dBXVnfzf6bRBPSF2cQuo3H501Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgEKUBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:01:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF083C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:01:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so10977678ljl.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxWS8BqpexPsTW15vsMEf9TiqtDG6ywAaC/lrYZHjg8=;
        b=SAhc+XRdE2bzNzWVFE7tynEUkeDYtjq8hOohw+RGPZQrwwF4x7AKFQiUp29mWK0p6Q
         8c5CTRCzMZIlZOZ+O/p96zbWICjULP4QYQc4IOiajmhp4HnF2vcI0Zyl7EVJtoPwSxia
         xuSxiPB0VpCHDyPh0GGHenK6kvvZ1PnSfJ+T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxWS8BqpexPsTW15vsMEf9TiqtDG6ywAaC/lrYZHjg8=;
        b=KZvYBQX43U/GvzCiaA2wv1o0YMATtxOLBScrrcBd6gm/XMJXryVzlHOIFWEcPW5HO7
         VNAyQRMxpbzE8B8hHGcJ0pImV+2OXv5/MGfSws9UZIY/cnbO1H+oM5tKStvtJpLU7dYX
         ryVS9PklYk4wg83prozjSthpc3X8I2HnlI5aS0aLXZZUoPItO8IeHIs76xHS65Y01Khc
         QP/eRFwhottJefpgsbHFt6lCJoKbSZcpDFQpI/7WiWadMLHm4u9IjNFs3Ykttr6L8xyO
         Zk12kymFjDJ6Rbv5GPnq/rUUBGCWZkn6MAXHch8HHTsxhxkeShxw1FIdZhYDu0DF8SBX
         Sm2A==
X-Gm-Message-State: AOAM5307jetGlzMLi8FqBcW0Ug8eQ09slrO4ghrI5OOhq/uD79seQ7zc
        TIjDn+sZv4lrmoNOL5zxsiiRjzy9dts=
X-Google-Smtp-Source: ABdhPJxLlWbZmB2sBvPSNCIQGnvf0/ojY5PGLPNgUTUt5l5HoAYFPDffgrf8DSO9AkZtbujFqqZdrQ==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr8558608lji.80.1589227291868;
        Mon, 11 May 2020 13:01:31 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r20sm10732105ljj.44.2020.05.11.13.01.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 13:01:29 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u15so10982226ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:01:29 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr11207205ljg.204.1589227288953;
 Mon, 11 May 2020 13:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com>
 <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com> <CAKwvOdn06jCe_FhKiF_wSQavytVVD++RXD-bHbMdqnEA-wO-9w@mail.gmail.com>
In-Reply-To: <CAKwvOdn06jCe_FhKiF_wSQavytVVD++RXD-bHbMdqnEA-wO-9w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 13:01:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8zOnTN17XcGfnfihGgM5R5XG71qP+V54iLqBgZON4hw@mail.gmail.com>
Message-ID: <CAHk-=wh8zOnTN17XcGfnfihGgM5R5XG71qP+V54iLqBgZON4hw@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:52 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Interesting approach.  Researching __builtin_choose_expr, it looks
> like it was cited as prior art for C11's _Generic keyword.

Well, the thing that made me think that __builtin_choose_expr() would
work is that unlike the switch statement, you absolutely _have_ to do
the choice in the front end. You can't leave it as some kind of
optimization for later phases, because the choice od expression ends
up also determining the type of the result, so it isn't just a local
choice - it affects everything around that expression.

But clang still doesn't like that "qi" constraint with a (non-chosen)
expression that has a "u64" type.

I guess we can take the stupid extra cast, but I think it would at
least need a comment (maybe through a helper function) about why "qi"
needs it, but "ri" does not, and why the cast to "unsigned long" is
needed, even though "clearly" the type is already just 8 bits.

Otherwise somebody will just remove that "obviously pointless" cast,
and gcc will eat the result happily, and clang will fail.

And nobody will notice for a while anyway, because this issue only
happens on 32-bit targets, and developers don't use those any more.

                 Linus
