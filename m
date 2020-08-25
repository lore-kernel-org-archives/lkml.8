Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4179C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1CE2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH3Ud9Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgHYI4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgHYI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:56:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D704C061574;
        Tue, 25 Aug 2020 01:56:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u126so11631686iod.12;
        Tue, 25 Aug 2020 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ym7HVRawD2R1wMoufva5doKSTMTU9LB5MWobb2y2g4=;
        b=fH3Ud9EhGusA1ekRzBqMmNuKHCpE2RcKst87/vEfCAfefjJVQj+IVOjYxTYktKvQuH
         eMByXfh5Uj40eU0pcSRql5tqE8Oo7Dk3jNtmUZBHcGKbLkZTjlve1OePaHslg1fuIh2/
         TWejG5jCc+eztSGXfULz1MnPBom4X6G5TaDhTRj7+cZMfV4gDS4wCiOFTt3FpNXt8rLr
         c4Mx6TwS8b15o25pZGYnZaCtkBIw9ZMA314wE3J56Pip10KJegGUdT6tixHY0fzxAuDz
         20UCfDsygTNjbOWIJ84HS2H8BoaBf/8H5enwT/uC/m6knNKInZWCutwkqY8tq6usH33Q
         cRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ym7HVRawD2R1wMoufva5doKSTMTU9LB5MWobb2y2g4=;
        b=l71giwXWXIk3oPzUrU0btTToAX5dRTobaXXF2BGN2+6d7wozaJKpIclqZ/pX/qWp90
         JWHTSVHdAxePJWKe+A5yjjwWilcaiIuXY8hJ1bwXZ+z5cLE1eX7VjfQUrN6mJNe9+gg3
         C4mA244q4ZjAsVRPEM2qbJrfsKC148x2R8i7l3c4qURxnWq700LYhpTjK25kDWG0Bypo
         elwml2ziUUTJ1v+Mrtl9Fjy2WTCuhn9jnT1cP6hp7obsRf2aU1M7jg9Ny6KVXd6BzmsU
         fjHLCQ/bFTX4o4Rem3pFPr7iGYcJ3PD68O79TpbEYJFK6/7kjc9Eh9skLnjqMqSnasye
         OsNw==
X-Gm-Message-State: AOAM530k2PyKR5pb57Z0AHd1bMlxk4x2PePoWV1NFzcqgzQKpq541M2z
        urt5jali79QcgfJG1eRfjavf6+ccB7xl4yL9GTQ=
X-Google-Smtp-Source: ABdhPJy8z2ZviWY02n9MbhlpM36sDmj5wezjv5aqbJ0EsVgzHV2KgTmLE2Ck0BMkppfI3blwHkhWCFw6NAWBWGLcxRo=
X-Received: by 2002:a05:6638:1685:: with SMTP id f5mr9732373jat.48.1598345763650;
 Tue, 25 Aug 2020 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <74f570e0aab48b86f7a157d87c16715289d457f4.1598323824.git.zhaoqianli@xiaomi.com>
 <8aef74ea-5b28-07e1-d66b-91ed9e0920e9@web.de>
In-Reply-To: <8aef74ea-5b28-07e1-d66b-91ed9e0920e9@web.de>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Tue, 25 Aug 2020 16:55:52 +0800
Message-ID: <CAPx_LQEaVq_LFXdhTAkyc_EczurqkLzKcVhb6YKFw6V_0jQbvg@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Warn when work flush own workqueue
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Qianli Zhao <zhaoqianli@xiaomi.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus

Thanks for your suggestion,and sorry for my poor wording.

On Tue, Aug 25, 2020 at 4:00 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > Flushing own workqueue or work self in work context will lead to
> > a deadlock.
>
> I imagine that the wording =E2=80=9Cor work self=E2=80=9D can become clea=
rer another bit.
>
>
> > Catch this incorrect usage and issue a warning when issue happened
>
> * Would you like to mark the end of such a sentence with a dot?
>
> * How do you think about to adjust the repetition of the word =E2=80=9Cis=
sue=E2=80=9D?

How about below changelog?

workqueue: Warn when work flush own workqueue

Flushing itself or own workqueue in work context will
lead to a deadlock.
Catch this incorrect usage and warning when issue happened.

>
>
> =E2=80=A6
> > - update comment
> > ---
> >  kernel/workqueue.c | 10 +++++++---
>
> I suggest to replace these triple dashes by a blank line.
Ok
>
>
> =E2=80=A6
> > @@ -2585,6 +2585,7 @@ static int rescuer_thread(void *__rescuer)
> >   * @target_work: work item being flushed (NULL for workqueue flushes)
> >   *
> >   * %current is trying to flush the whole @target_wq or @target_work on=
 it.
> > + * If a work flushing own workqueue or itself will lead to a deadlock.
>
> I stumble on understanding challenges for the wording =E2=80=9Cwork flush=
ing=E2=80=9D.
> Can an adjustment help in comparison to the term =E2=80=9Cwork item=E2=80=
=9D?

How about below comment?

* If a work item flushing own workqueue or itself will lead to a deadlock.

>
> Regards,
> Markus
