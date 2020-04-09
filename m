Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C5C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 05:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D661206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 05:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ncEgIzCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgDIFOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 01:14:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40860 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgDIFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 01:14:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id w26so11736931edu.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 22:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY7MUWYg0CK1Tvzj+QeStPn2WOKppk76oqJCa/ryNiY=;
        b=ncEgIzCvOvPaBRt8Ee6N8e5EoonoCr5fsBu95DHAeb5SJ/12QZWvHXq4GN+jqapHR4
         briZV+vnfqG1R6TU3oAExC6nQcl5dDnQXYHTkbEyeVCw67ecoGBtAmTOzWrj1xEHs5Jv
         5XIH391bN25Bgynirn/RSGkCeMx9OjprrwTDd/curha6Yfmukf7sVh/1ibdeaKrDNzU7
         34S6wSkNykWLijBhaPsvBKkaDXPLtwfgJ5HC0+WkdoLAj0Qge34IecQk1x36bYE+zalQ
         sp1Ps7btAz97osQcuqtcWIwS0CO4Of/IWFErKeWhiNcNj4Ez5657kFYuJi1N9SaW+TLT
         5QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY7MUWYg0CK1Tvzj+QeStPn2WOKppk76oqJCa/ryNiY=;
        b=I+u+KsqABFLcRwWl5EaR1BhuldqOpNJOBRawYwp1eAbtJsmZ0v/QNhJYCdOjPOPTtg
         L+aJP9YKQgB7efisnQbft/DIrM7TwKQfnXkNA3zDqjb6xSYCCC3y9KgX6Z9KpjeaLpBO
         r3IbbiEG2WlTd6AGNZji/Cj0ZTvLSM6WTm3gyOZ7e//hU/13kFmwNzmfiwoTqvpWIXUc
         PyQfh1tN3v2UydAqNk7fDC9yasYyx4CbYzwwAQYFM065DEwoSxj0ZdlkaIp2kztDBjCj
         8Q98gdObxwabwOYpKNtUxZce2tgvDILVHFuLa4VhM3Msa3HpByatvQ423FHF2ixxKKnL
         zxXQ==
X-Gm-Message-State: AGi0PuYb9A1iAyS15QTFGO0D2B1iqaaCcFJntad/o/aNGpaYY2WJWgeg
        ozo7mSpRZvYhKwYMLUYgfdQtUiZpK45E4vvNNej/Cg==
X-Google-Smtp-Source: APiQypKWClH3zGpC71koBaydDhSE0bupeJ0O0XyeGFTZoiaBGvpA9xzgxXuW3dPnCi0PoIHYk0YHMzS7SxCzW5IYnhc=
X-Received: by 2002:a17:906:6987:: with SMTP id i7mr9963952ejr.12.1586409262689;
 Wed, 08 Apr 2020 22:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
 <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
In-Reply-To: <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Apr 2020 22:14:11 -0700
Message-ID: <CAPcyv4g0-rxw2KXrRRe4Mr-zS4ujx6pTqApZgZrPhJetLgjRPA@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 9:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Apr 7, 2020 at 1:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >       mm/memremap_pages: Introduce memremap_compat_align()
>
> Why is this an exported function that just returns a constant?
>
> Why isn't it just a #define (or inline) in a header file?
>
> Yes, yes, it would need to be conditional on not having that
> CONFIG_ARCH_HAS_MEMREMAP_COMPAT_ALIGN, but it does look strange.
>
> I've pulled it, since it doesn't matter that much, but I find it silly
> to have full-fledged functions - and exported them GPL-only - to
> return a constant. Crazy.

Yes. tl;dr I gave up after failing to unwind a header dependency chain [1].

The source of the trouble was trying to find an existing top-level
header file that included an asm local version, but also needed to
include mmzone.h for the definition of SUBSECTION_SIZE.
include/linux/io.h fit that requirement, pulling in mmzone.h there
proved more difficult than my header unwinding skills could
accomplish.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=c990ae9376c15f40aff2f61f42a71be5b81f9ee1
