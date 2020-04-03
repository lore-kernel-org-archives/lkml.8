Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55595C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3F9206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lesYNXKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390178AbgDCBh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:37:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44069 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDCBh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:37:29 -0400
Received: by mail-yb1-f194.google.com with SMTP id 11so3277495ybj.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQsKWkmVTy5XxVbcEbWp40LBkigBeIfzDkz8+g4PeQ0=;
        b=lesYNXKBQLgvlydHmDhQdKCckLp7UAuU59fvASJKaUJ+e/dx+IXZTdvgGSdRavzc8W
         xmGzXmonPaouefg0WmrCIQUr2Zx2O+XHg6O19OSYFxmn1tUKREt9rzCF6OV4C57D1Fce
         If4Y6RWD1SoFGm6+jELndT6WYTt50HjoTP8PpR0gwLELADtPk1JdfMOoh04txtEkMHCF
         kiks8NuxJRcJTniVdX5lvQOn4a8cRw6PvQ2lquz0N0v/r3ipoLqfYKW+fh6lBh9maQf5
         FkJJTpIiLpPmHLoYpkvFWsGT9ST7Q5Kr9Rh0D0gP4qW/pLsxrcIHkwm5fbpu3TnxgVl5
         dTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQsKWkmVTy5XxVbcEbWp40LBkigBeIfzDkz8+g4PeQ0=;
        b=CI1X/u5jgHRRhEiK3HAQL1meBoozH2vETeQR9HVl8SGccEWcZaGIa6UN83mk3JWn6f
         ZBMnGxLLxuyanfq1QAuqlja7UFA7ueEwGaie9M8Sh4gi0ETK1fgJcKXgH75MpkbN/2Lr
         LwEcINbyL/ZietJxEDEdejXFzTon4Crmwnuil9qSatC70Cirwr8D7sIn/OIXZxwVLG8R
         aAYLrU73PV3LxPraOP8k6hKIS+WrAlZ7crRepWbgQZc2UvGvptkCqAwaaM6tC37mScpI
         xVgmJhyMina2ypBuRIJUzZ9t+fQ7ykudf+julLoh+wZ42AKjEU/MBFlsqWm+sACrYonZ
         iPvg==
X-Gm-Message-State: AGi0PuYjBvYDOd4y7JSYCfsIRmDogU2cGcxXnZAjA0e8m1MvGRsire4p
        UWad6afwmFfztctaZ9YsVHJsv6vbELw4Ce0NLxMLAg==
X-Google-Smtp-Source: APiQypIkGUHdXkDokLBBDr2UmK2FUKVxvlzAoLGfMYM+KyGgkC7oPfcoicnJoxJLh4WyE0zWMukZGQWvphpZtdYh/LI=
X-Received: by 2002:a25:bd87:: with SMTP id f7mr10311435ybh.390.1585877846596;
 Thu, 02 Apr 2020 18:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191106074238.186023-1-pliard@google.com> <20191106083423.GA10679@lst.de>
 <20191106083711.GB10679@lst.de> <CAEThQxe2sNuCHoQfa30FVmtYkQ_zJsecdW2wmVmwafvne1RXSg@mail.gmail.com>
 <CAEThQxeC2qyUr+3EO7o+2p5tziXQ621SqaaxmF3jzheCKjpEkA@mail.gmail.com> <20200402153506.GA13332@lst.de>
In-Reply-To: <20200402153506.GA13332@lst.de>
From:   Philippe Liard <pliard@google.com>
Date:   Fri, 3 Apr 2020 10:37:15 +0900
Message-ID: <CAEThQxfKWGo1TZ7SZ-N6kizbkujWwu3yKXUGDrsVrGjtopVqkA@mail.gmail.com>
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
To:     Christoph Hellwig <hch@lst.de>
Cc:     phillip@squashfs.org.uk, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is lower priority for us now but I agree that it would be good to land it.
This is my first patch being approved so I'm not familiar with the next steps.
Can you land it yourself or is there something more that I should do?


On Fri, Apr 3, 2020 at 12:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Nov 15, 2019 at 10:20:33AM +0900, Philippe Liard wrote:
> > On Wed, Nov 6, 2019 at 6:28 PM Philippe Liard <pliard@google.com> wrote:
> > >
> > > On Wed, Nov 6, 2019 at 5:37 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > Sorry for the empty reply.
> > > >
> > > > This was meant to say that the patch looks good to me:
> > > >
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > >
> > > Thanks!
> >
> > FYI I'm unfortunately no longer observing the 40% impact announced in the
> > commit description after many optimizations landed in the Chrome OS VM
> > infrastructure.
> >
> > Hopefully moving to BIO is still desirable though. Thank you in any case for
> > your help/guidance and all the time you spent reviewing this.
>
> Do you still plan to submit the patch?  I think it is a major cleanup
> of the codebase, so I'd like to see it land.
