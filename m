Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A2C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E142720674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="P9ymWRwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRPxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:53:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34265 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:53:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id j5so10234311oij.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EsTMXwx4kqSqfiOJ+5VqxPy8ESW5kmMEvWmLUqRM04=;
        b=P9ymWRwzUtq3KgWOv+H7Pij9fdoc090XCS4OPxI9A1QLtCEKaCE0cbmT4EYt3eDtCA
         sb2dGnxnhqks0HWZ2ytr3VS8zMUcYfLKcIHEA9PbfqWjyRXfMwvq+5eqQXlSIW8W7DPU
         BawYthbfaq3FoiLzwKCXiAw3J1amj2PcUSsDmvftnx0MJyWPGWH6Cr0DP+O2wJSO9WV8
         JBJr1ILAo0xSr2VJcQVP2A9j4DLWMFiLIep3rETwXfcXbulb7bH5K9kGiW1Gk0idGUJU
         c55Wnogd3bxGL9X742NwMMBylQNk5i+sAOuUYe/Lv4W+N7fnnBhIJMkdHG+GIXnH7Gia
         ++Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EsTMXwx4kqSqfiOJ+5VqxPy8ESW5kmMEvWmLUqRM04=;
        b=BZZVnh5ueBegEiKGEyGo27v8x/2j8u/N/YZXLaUmih5g248O8MgtSr1jjZh28zZ7z7
         chvpB/eGjjCAN448sJOTCwaIKi9oXQEgGTLEoZn7JowpxJudq4aILnvOKUDQswVhZPmy
         adeBB7T9/0IvAliuM+5QXd0inZPIl0zncuM1B5/YfQrsELmxM6bKYZo1oCnVV00f+GgZ
         eci/4ZWASBFG+p/F9At+qbPZBjT0Lf1Lv3DzjJcSypd+UT1IVOpWg0poXSqn8LkmFW0o
         n0AEKjToQO3Xzabnt4iiOUk22/2gg46A24phanalIBQ2OqNLUsrz5M7xchAf6r0JVEhf
         JuHA==
X-Gm-Message-State: ANhLgQ1pIHlr2n6o/wyuWT6x5FTFSPO9Nc5pbCSWNMOP+IFJppobvqfO
        mqfA+P/PFBpK+QXSNowDCiJgmOoNhaCCgYBWP0u2xQ==
X-Google-Smtp-Source: ADFU+vutWXljLwy4LQhxFZY3HNaRb6NFkXajAdj6p1EAqEqrSw29FuzWdXXrb9ZA8cxm0hL7zE3UOGk1lBceIzIXLe0=
X-Received: by 2002:a05:6808:90f:: with SMTP id w15mr3813640oih.0.1584546798751;
 Wed, 18 Mar 2020 08:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
 <20200317061522.12685-3-rayagonda.kokatanur@broadcom.com> <CAPcyv4j1BJStqSZvbNdjHs0RoSWWtk06ieQAXOUwJCjP8mqBLQ@mail.gmail.com>
 <CAHO=5PE9SLg2O1fp5YUp0Z0sbNfKNiu5kGXBRtHmGyXRW5w3pg@mail.gmail.com>
In-Reply-To: <CAHO=5PE9SLg2O1fp5YUp0Z0sbNfKNiu5kGXBRtHmGyXRW5w3pg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Mar 2020 08:53:07 -0700
Message-ID: <CAPcyv4j3Q6n8sj=ATtDL0cpHvMqZPaBxuZ13pgUsvhXWqDh1BA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] async_tx: fix possible negative array indexing
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:17 AM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:
>
> On Tue, Mar 17, 2020 at 11:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Mar 16, 2020 at 11:16 PM Rayagonda Kokatanur
> > <rayagonda.kokatanur@broadcom.com> wrote:
> > >
> > > Fix possible negative array index read in __2data_recov_5() function.
> > >
> > > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > > ---
> > >  crypto/async_tx/async_raid6_recov.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/crypto/async_tx/async_raid6_recov.c b/crypto/async_tx/async_raid6_recov.c
> > > index 33f2a8f8c9f4..9cd016cb2d09 100644
> > > --- a/crypto/async_tx/async_raid6_recov.c
> > > +++ b/crypto/async_tx/async_raid6_recov.c
> > > @@ -206,7 +206,7 @@ __2data_recov_5(int disks, size_t bytes, int faila, int failb,
> > >                 good_srcs++;
> > >         }
> > >
> > > -       if (good_srcs > 1)
> > > +       if ((good_srcs > 1) || (good < 0))
> > >                 return NULL;
> >
> > Read the code again, I don't see how this can happen.
>
> This case can happen and it is reported by coverity tool.
> In the for loop , the condition "if (blocks[i] == NULL)" true all the
> time then variable 'good' will be -1.

Just because coverity reports it does not make it true. Please go read
the full call path that gets us to this call and identify how all
entries in blocks[] could be NULL. Hint, the answer is in how
async_raid6_2data_recov() calls __2data_recov_5().
