Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627B1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA3820575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCX3Gwpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504729AbgDNT1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504700AbgDNT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:26:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147EC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:26:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ay6so2986395pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBjwHY+AL72Y+T8vcTU277/7t2edTwQD/R5p6feAGn0=;
        b=fCX3GwpiQSEiUMKpeDVih8hj+JqhwWfdebHtVs0cADaQ3iHqoQ7ZmrmDaUY53dkJpl
         A5WKCCmkAXrtVjfKFav0oNXvfefO76hr8+DJHnKLwps4R4hNwEneswkOQtrClWDeGDxX
         HI76iHXV7Gq7giZsdnEvhsZlDb4bUvszNzGLGQw8t2wH8D0sLM3Tbaeu5pnLXlC+jJ5G
         lsJhRwjJ7W0ie2NbvW+TqoDhJP9fQ7Np/nbq4Qs+P++do5cNW85OgQOqekBnrGwNG/pZ
         otoSQnqDe1VOiwds65ZqPq0tD1m10m/YueHtixiFsAnRpjMZbrhriDQOU/V+F9gwo8DI
         y0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBjwHY+AL72Y+T8vcTU277/7t2edTwQD/R5p6feAGn0=;
        b=dChRlktPhRoF43Wgbmcok3j8jKyRJncPBImrjVBQCp2Gj2oRrumPiJkFH/5qlUO3+q
         wRNRsuxXMurbD2SAG4Js8y2Hr+Kr+wgxiblBEhGf7bQMdsqOEKJ0MdDwqFDWucfGgOBn
         Xh1vaOb5vYZlfyqWte8YMBl9loCn/EtUN6AFtIhM2iixZ6fowJIMUUx9W5OzVQSF5fko
         zWhVHMy5we73L3CcP1VTWU/ojwykKk63KOoWaZFf09nMsOZZ0q35CTjEvOW8BndtDaGE
         W9RJt3rKxPfp+8Stu4niAXwNmSqzWCCLlfZEB64XE0IemhfkjQseXCV3qp/sqPjHXoy2
         GqJQ==
X-Gm-Message-State: AGi0Pua+tjK69Sqgqc4zSZr+e8YBIpX0lpCLn7hTNvfp0wbzaxfMREQM
        iHPSOTFPlJb/uDnvgwPil2CW91Deiz/iy046kUbU9w==
X-Google-Smtp-Source: APiQypKGMp4rdkYV/1cquaVsImLP3ZzjMppuoBalS0ljtPr38FSR8xLUWjRxwP0gMVd5Aii/eLsTsNG+UfBr1nF5MuY=
X-Received: by 2002:a17:902:cb97:: with SMTP id d23mr1445679ply.232.1586892401135;
 Tue, 14 Apr 2020 12:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200410132706.170811b7@canb.auug.org.au> <27c212c4-b522-561d-411c-e74dc0ff0b74@infradead.org>
 <CAHk-=wjhsM-n_NzSh=cSdpThX+62-x3EmyKjhMqGHFYEyG0nPg@mail.gmail.com>
 <2b0f5d2e-3fe5-10c9-2a9a-9a0b341a52d5@infradead.org> <CAHk-=wjXZSPPWzPs=KBDsLZWuq8qO=9qWfiKHw=yV10fFrDv9Q@mail.gmail.com>
 <bfbcaa67-9656-3a80-fc66-c937297c8be0@infradead.org> <CAHk-=whpvCqcCYvy=_v_F6NTtBSeQbXZ0iLr_smV2NJLT+XACw@mail.gmail.com>
 <CA+G9fYu47hpXjYtAr32p9yJ97KZqTry+ioAY1S2TqtiKztCYRg@mail.gmail.com> <f90fc906-395b-79be-8f44-3807586766f7@infradead.org>
In-Reply-To: <f90fc906-395b-79be-8f44-3807586766f7@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Apr 2020 12:26:29 -0700
Message-ID: <CAFd5g46ZaEVoMb2hO94A41Z=YH6ntTdXstZUhHu67mwOKY+QsA@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 10 (lib/test_printf.ko)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 11:22 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/11/20 10:36 PM, Naresh Kamboju wrote:
> > FYI,
> >
> > Is this problem related to,
> >
> > Regression reported on Linux next 5.6.0-rc4-next-20200305 on x86_64,
> > i386, arm and arm64. The steps to reproduce is running kselftests lib
> > printf.sh test case.
> > Which is doing modprobe operations.
> >
> > BUG: kernel NULL pointer dereference, address: 00 - ida_free+0x76/0x140
> >
> > https://lore.kernel.org/linux-kselftest/CAFd5g46Bwd8HS9-xjHLh_rB59Nfw8iAnM6aFe0QPcveewDUT6g@mail.gmail.com/T/
> >
>
> Looks similar. Lots of fwnode, software_node, ida stuff there.

Sorry for the late reply, I was out.

Yeah, I am pretty sure it is the same. Heikki proposed a fix that I am
going to try.

Also, I think I am going to send out a new test case for this that can
live with the fwnode, software_node stuff. It would be nice if the
printf test wasn't the only thing testing this stuff.

Thanks!
