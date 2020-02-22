Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455C2C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC542206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H2ffTmBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBVKAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 05:00:01 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:54367 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgBVKAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 05:00:00 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fd300658
        for <linux-kernel@vger.kernel.org>;
        Sat, 22 Feb 2020 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZHg3DU0tDACYDvwC5oieXse+7Sg=; b=H2ffTm
        BO5FuwBEUNcrEICHxiuJUVnG5fuD8vhGCBP9rkHPDZSoL9K5Pj7Oq2g2d4uZ2gyw
        VpoRg0xSGQZzqCUrzgWkQiocatlw1GydbT5dM4QsXaJ8pJLeNZJRWLXLHptsYnQk
        cvvm/x9DrNuCKUWST1jyYTmZZ5ZW7M7Ir9B3Rm8Ln15fSaWn8fUN75sbotuHpKV9
        cdo1bkDI7FTYWq6B/5Z/vD8XhlmoAPEDHW/FYzQUVPrVzfon8yFucq8nbprLC2Hk
        7foKBkOBm14nziPQp04zrSnmrrGx432fA2ikaqG2p/lDMBFje/pzPFwcAumjFq16
        LV0odL2FnuERxisg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1f4c9d4 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 22 Feb 2020 09:56:52 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id q81so4280541oig.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 01:59:59 -0800 (PST)
X-Gm-Message-State: APjAAAVfJ+HPZw0xdo+9ES79jBo4bzJtQFG0y0lfkTkNlUcvLoTWHkVi
        xDc7Lhfvg/3/HJE8HyxD7Dsb3BOzxZ13kBGUrUc=
X-Google-Smtp-Source: APXvYqzFCUvKwgudzoH5Kb5zw2CYpIawnHdU6gcz45TDucyJAtrT825uJtTaou9mXHmORM0QiPtnPocpFZmW9/qiJkA=
X-Received: by 2002:aca:815:: with SMTP id 21mr5714644oii.52.1582365598426;
 Sat, 22 Feb 2020 01:59:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:dd10:0:0:0:0:0 with HTTP; Sat, 22 Feb 2020 01:59:57
 -0800 (PST)
In-Reply-To: <20200222004133.GC873427@mit.edu>
References: <20200216161836.1976-1-Jason@zx2c4.com> <20200216182319.GA54139@kroah.com>
 <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
 <CA+8MBbKyRhipHsxb0nvV11Bvv8ypQ_gq5JR8ihfuG6JfBTnxZw@mail.gmail.com>
 <CAHmME9q1rnD5z2bENYhqnM5-XCD+E68nm2RrGRWXt8ntpvfezg@mail.gmail.com> <20200222004133.GC873427@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 22 Feb 2020 10:59:57 +0100
X-Gmail-Original-Message-ID: <CAHmME9pJPhqX8kDCTiRQdqGMLctEZTWTaG0vTDPL0v5A9-rX2A@mail.gmail.com>
Message-ID: <CAHmME9pJPhqX8kDCTiRQdqGMLctEZTWTaG0vTDPL0v5A9-rX2A@mail.gmail.com>
Subject: Re: [PATCH] random: always use batched entropy for get_random_u{32,64}
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Tony Luck <tony.luck@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On 2/22/20, Theodore Y. Ts'o <tytso@mit.edu> wrote:

> No, we can't; take a look at invalidate_batched_entropy(), where we
> need invalidate all of per-cpu batched entropy from a single CPU after
> we have initialized the the CRNG.
>
> Since most of the time after CRNG initialization, the spinlock for
> each CPU will be on that CPU's cacheline, the time to take and release
> the spinlock is not going to be material.

Ah, you're right. I hadn't looked in detail before, hence mentioning
"probably" and deferring to a new patch. Thanks for looking into it.

Regarding this patch here, can you apply the v2 that I posted to your
random.git tree?

Thanks,
Jason
