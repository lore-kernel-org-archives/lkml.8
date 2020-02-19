Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C769BC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A026321D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZUBKqcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBSLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:25:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39839 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:25:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so9465816plp.6;
        Wed, 19 Feb 2020 03:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21gY3/MhljLsWlz+/3WUpCFpSYC8nAK43SlfTRohGYA=;
        b=aZUBKqcMCqPDYYwW2sZZB72MLf0SqltcpMGBffZq+ZDdKMXMFyCDBdPVuH5p7ucN0I
         P8NYK3Ghvj4eNHStH7Gre7Q/tP6vJBUFS0jUs4HntsVgWyX3VuBDqiSw86H/nCKId1N3
         jvzrEzzdy7Th8jdiFsf3ACPF4kIsrsmn2EYsn1aS73SbYFIEUEt3Y6ppfxD+JBQHcUQ2
         wIJAaRORFz7OC5UWjS/0MLRGmJuzm0IGZJLEIBWtLHOsv1Yl+Lr4NwVm1VePJiHQn40T
         9vcENKYT8P0p2Yaro88zdaJZXjx0cp9RVLVIhB47NSk5jl7zdtC5+ah5DeGxWX2Ef+mP
         UnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21gY3/MhljLsWlz+/3WUpCFpSYC8nAK43SlfTRohGYA=;
        b=ddJay6nDfH7NRthjuJTwDRsZMJj7tDwuAYz9qFz5cLxcElsZD5szBPjdHdZ1HuUWqA
         +h5QI6ibZAh7nQpQT6Iw1oTroYrMbm1abs/SPILSZe9uBH8o/yDLvkf6U0tm6AQw2oL3
         2EXpycWonklvg5PLWJy4uWmu9o9nIMz1UKywlyx3pbG/vxrzJSr/Xz4KEhG6cKGi4pEr
         Wq1dRVGGEwPT3DuHYMWcQWQQOIzET1XJ3xJzMJKWrqoCakSkWvp/jkCARokyZf8tmPEl
         hp5aVMy6q8Cva6F8Fx1lorjRLkyvujEB6ke1N566hpJ07NPajdnwCyVQAPmUNt0owu8g
         Fy9g==
X-Gm-Message-State: APjAAAUvf7YYsMDdoXRcJiKuzp6seqmzm3WBfTMslZ9BBrSj2eRJztit
        LFJ1DhcBAjZIqU9yUq1hu9Rz0igCpMb48OMx3yw=
X-Google-Smtp-Source: APXvYqxfXf2dLIGpHYVUEutJPxg5jBn1pfUFhIu+hcxD/793xLK9qKjFBsWdAUmoCxU2LbsdXUp9J3bdII57MKTX63M=
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr8607090pjc.20.1582111533396;
 Wed, 19 Feb 2020 03:25:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk> <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
In-Reply-To: <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Feb 2020 13:25:25 +0200
Message-ID: <CAHp75VeJm-hbbtVAu69ZbDCCjs9cUK922D=hhW-MVu5OxczDzg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 1:21 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Feb 19, 2020 at 9:21 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > Extend %pe to pretty-print NULL in addition to ERR_PTRs,
> > i.e. everything IS_ERR_OR_NULL().

...

> > +       [0] = "NULL",

> > +       test("[NULL]", "[%pe]", NULL);

> FWIW I was about to post a patch that just special cases NULL here.
>
> I think changing errname() to return "NULL" for 0 is overkill.
> People will sooner or later discover that function and start using it
> in contexts that don't have anything to do with pointers.  Returning
> _some_ string for 0 (instead of NULL) makes it very close to standard
> strerror(), and "NULL" for 0 (i.e. success) seems rather odd.

%pe is specifically for _pointers_. I don't see a point in your comment.

-- 
With Best Regards,
Andy Shevchenko
