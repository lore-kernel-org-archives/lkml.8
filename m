Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43024206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgD1Nju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:39:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgD1Njr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:39:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id g13so24685534wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5a2eKTENfxkdvpOt5VzR6SvytBF+3s88viN7AKjLVdk=;
        b=X4mERtsUpLN89OtJNPbgq35oh5DlVcYukaBObzKx6rnf6Bk70a/2zoosWL7NCW9vYO
         sLpSF3qJ290F+l1CFfEv10yAfU2TLQpftKX7MhVnaGOXnJzWs1tHLIoATr6hVQI7X5Ru
         26FPaNYwikSg+9SdA2tqCqDcJH1qpjwV44msnA3G1zzKKQnMC0Gx0p+0krfz+4TivinF
         ReJVA/u7tQFZBRz5qYXa9mSF7ccz8y8ccOZN95G+QLBB0/HQ//HWgF7JL1+cGkKzs1rr
         cV/gg1p6G/yepYY6LSAtvCYSFPXlN73qoBJgVK7OFv+/sAbA0PQuJo1mx180i/MfoSoz
         klkg==
X-Gm-Message-State: AGi0Puasx1WGJj4ezKJWIlvzHdyHSV50GkI6z0iDKZE46jH3408AbWzn
        CCY1PyZIXCn9ou6T6TN5xCXUTbNR1FjpDDFPQpAQ
X-Google-Smtp-Source: APiQypKJ7Znr8xxbFupiDIbeDll7/mUifz2A7jx6hPicMw/uEvMh3pLQxhSgEGbao/4OCBqSoJuvk7DcpKLXX/Mx2Bk=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr35638988wrs.124.1588081185601;
 Tue, 28 Apr 2020 06:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200426161319.23941-1-john.oldman@polehill.co.uk> <20200426170719.GA2138855@kroah.com>
In-Reply-To: <20200426170719.GA2138855@kroah.com>
From:   John Oldman <john.oldman@polehill.co.uk>
Date:   Tue, 28 Apr 2020 14:39:34 +0100
Message-ID: <CA+JojbrD5F6foCUGZT_fKW+MnJnuQsFH87bfy9V+WUXwxqKyXw@mail.gmail.com>
Subject: Re: [PATCH] Staging: mt7621-dma: mtk-hsdma.c: Fix Missing a blank
 line after declarations
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(this time sent as plain text)

I was not so happy about this one, even though I went and committed it.

Without the blank line checkpatch reports:

WARNING: Missing a blank line after declarations
#160: FILE: drivers/staging/mt7621-dma/mtk-hsdma.c:160:
+ struct tasklet_struct task;
+ volatile unsigned long chan_issued;

So I dumly inserted a blank line to silence checkpatch.

In hindsight maybe a false positive, blank lines in a struct!

Someone may have been there before as there is a previous blank line
in the struct mtk_hsdam_engine :o)

Cheers
John


On Sun, 26 Apr 2020 at 18:07, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Apr 26, 2020 at 05:13:19PM +0100, John Oldman wrote:
> > Fixed coding style issue
>
> No you didn't :)
>
> >
> > Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> > ---
> >  drivers/staging/mt7621-dma/mtk-hsdma.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> > index 14592ed9ce98..dd35d0bce6ca 100644
> > --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> > +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> > @@ -157,6 +157,7 @@ struct mtk_hsdam_engine {
> >       struct device_dma_parameters dma_parms;
> >       void __iomem *base;
> >       struct tasklet_struct task;
> > +
> >       volatile unsigned long chan_issued;
> >
> >       struct mtk_hsdma_chan chan[1];
>
> This file seems to be the "does the submitter look at the patch they are
> sending" litmus test.
>
> Does that really do what you think it does?
>
> thanks,
>
> greg k-h
