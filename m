Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522E520792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOcRhH30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgFKPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgFKPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:19:24 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:19:24 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p5so5773831ile.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rqRniaTsYfE1typF6ugiU1ENkgUw21RTQiS6OA21zs=;
        b=lOcRhH308zGRYFzFWmmb6TOqkdNuqKJvRMJ431kDJUm7qRp0Nez4Bw33YJcr0ga+HZ
         Jwio0ovnSmDre48IBWO2c3Kev+NTZXRyKEH38lBRcz1zxNptVAD1WckLjHqTWFujDLIt
         ZbQH70Tb2cHCouT/hjjrB2LduSa70dfVTp4bS8VTStMooDF71Yofpe1NkG/4QYCzi2WV
         JatuZD7fYWFpNkxLyxO7xb99Qiulot2jh30CwHn1li5RJji6ui9r1dhx6rq0SH93hZPA
         6D6CUR8pa3AcydhcQK7z5J3PKH9qQQ3TLIV+RYSk6ShzfD2s3gzIin2pkXodGmaUsHcr
         Dapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rqRniaTsYfE1typF6ugiU1ENkgUw21RTQiS6OA21zs=;
        b=DuHm/1o5RgJhpds8ctpwlMtqJFrGYxcyvgsKbTFeM7MemirR6GMWY6RpwJfvcfREYC
         HmJLqM9nOJAg9ej6DVqSt1lGCwLBHnOhdNe1cuthadcsauYUHgz4f5ZTnNKe/brNH6zE
         E3rEuXoo2c5k5+HZkXkP/7Dk04yKZee08VhUEVSNgatQBXnqXI2r+ft0XJbtf2m3XxTG
         rtOK4Wxa4NAy/hEC1+YX2C/xI3Mo3a/6uVvbFMpJiIdlcJbG5FNhqQX1jx6r26l7oYV1
         kdzLbKJ2LzutSQktmY6Lf3q7dmc/AZ77NQzf0FC+TEC3yiNLNc1Uxz80d3fA7RPko3Af
         gQgg==
X-Gm-Message-State: AOAM532WnDrM5Hf7toKOrWX946pqFLXzzMa8VIR0h5veLTiPmLkiAUbD
        Hm4uafWeA/t4SJ+BKKwEZecASRL0lQnno3yS8dg=
X-Google-Smtp-Source: ABdhPJzxPGRhXjT0I+vY4SOwb4jOqI2irsf9TnegwJsDXW6Wni9r4nNaEClfyd1Nmkjmg3gvsNxbwr5jqWF2z17aQ6E=
X-Received: by 2002:a05:6e02:ef2:: with SMTP id j18mr8604138ilk.69.1591888763752;
 Thu, 11 Jun 2020 08:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200607193023.52344-1-jassisinghbrar@gmail.com>
 <20200610082315.GB2689@bogus> <CABb+yY1T03YLwiFvBykxsAHQ9Kpu=r1nRTuaP3Emf5dP=Upm0g@mail.gmail.com>
 <20200610155629.GA7357@bogus> <CABb+yY0pQYD7DTf=MNpVPB7F2PESiWyTYj=ftRHDPkKMOobRVQ@mail.gmail.com>
 <20200611084014.GB7357@bogus>
In-Reply-To: <20200611084014.GB7357@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 11 Jun 2020 10:19:12 -0500
Message-ID: <CABb+yY1K7fxEsujxwVMjJfLqVtg-p+5btteGtpUwEtUSsoWPtQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix timeout value for send_message
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 3:40 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

> >
> > > > > >       if (xfer->hdr.poll_completion) {
> > > > > > -             ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > > > > > +             ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
> > > > > >
> > > > >
> > > > > This is unacceptable delay for schedutil fast_switch. So no for this one.
> > > > >
> > > > Increasing timeout does not increase latency.
> > >
> > > Agreed, but worst case you may be stuck here for 500ms which is not
> > > acceptable.
> > >
> > Not acceptable to who, you or the kernel? :)    Now that you said you
> > are fixing the scmi's fast_switch implementation.
> >
> Sorry, I meant to disable it for single channel implementation.
>
The single-channel platform may have only cpufreq as the user, or only
users that respond quickly ~3us. So maybe we leave the decision, to
enable fast_switch, totally to the platform. But of course, this
discussion is for another thread.


> > Even though I don't think 500ms would ruin our lives, but ok, I will
> > make it 30ms - same as you did in the 'else' block. And drop the other
> > change.
>
> I am fine if cpufreq maintainers allow that in the fast switch path that
> happens in the fast path.
>
Thanks, let me respin the patch and include some cpufreq folks.

Cheers!
