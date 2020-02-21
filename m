Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F014DC35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49E220578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h7EHvq5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBUUIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:08:02 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:55573 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBUUIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:08:02 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 28b96ee4
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Feb 2020 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=xaT6U+7r5DWNn/RyaLpE6FoLqYA=; b=h7EHvq
        5q60k6s1XEO5qK4+vQhKyckJPA9nnSVWoD8PSZVpp1RP6143SDY92jAtwwcznB44
        UPBoixeWMo+WUR7CPKVY5yPlQ4eu/h5zfRbrVlfTs4yg7+k4kQK9pf55tVxvuDLs
        GBvUhj0pOSS5i+6xNDUnWfIpy/tk/oolw1CKNFOpeUpWWr4EIAGOnRjKEV7MJKS7
        vMy3uYdVkJ68NGLmFBnZUZBH8PdncLIHz7B48q4nLVzyPiRTNzhQR2yxZMIf3470
        +emXoEShPIZVvRIChopGh91T8xHKdzCAESAI5ZJ5jQ7R4q7eX8JvJu+CsLyOoNI7
        qOZh0MVEAX3V1niQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01e1f722 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Feb 2020 20:04:57 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id c16so2832877oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:07:59 -0800 (PST)
X-Gm-Message-State: APjAAAVtRdjwRFbNwS53u7bWosCa/gUfnlCSYXtg6ZcjQBh7mO3uR2w8
        f0Bg6mYb/rGdFQbl5VQt98faZFvRVxwteoZqYM0=
X-Google-Smtp-Source: APXvYqyzfWkhovoDrzABFMzfuG4zTxvyPeSVoIOYWt59kvhykmQH6CkS/gNHiXMw8fmLfxdWq7JC822GsYoK03m5Mgg=
X-Received: by 2002:a05:6808:4cc:: with SMTP id a12mr3576663oie.115.1582315678983;
 Fri, 21 Feb 2020 12:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20200216161836.1976-1-Jason@zx2c4.com> <20200216182319.GA54139@kroah.com>
 <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
In-Reply-To: <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Feb 2020 21:07:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9o+Nh0=0QBimOJLXpLitQ9p6rsAut+Zvb4A1-iEjGn3jw@mail.gmail.com>
Message-ID: <CAHmME9o+Nh0=0QBimOJLXpLitQ9p6rsAut+Zvb4A1-iEjGn3jw@mail.gmail.com>
Subject: Re: [PATCH] random: always use batched entropy for get_random_u{32,64}
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, Feb 20, 2020 at 11:20 PM Tony Luck <tony.luck@gmail.com> wrote:
>
> On Sun, Feb 16, 2020 at 10:24 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>
> > >  drivers/char/random.c | 12 ------------
> > >  1 file changed, 12 deletions(-)
> >
> > Looks good to me, thank for doing this:
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Perhaps also needs to update the comment above these functions.
>
> Specifically the bit that says "The quality of the random
> number is either as good as RDRAND" ... since you are
> no longer pulling from RDRAND it isn't true anymore.

Good call. I'll fix up this comment and submit v2.


Jason
