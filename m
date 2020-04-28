Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23395C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC55A21D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588102585;
	bh=GmogTBc6/7y6v6XDsNvTmidqfwyjrjtV6nfEWlF4Sgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fZrJrGRryfckguBMjcgzHYtd+KeegqE1oh++59rB69A2wvCVuGaqFiT6d6/I2zfN9
	 P36HrflwpWC0BaDrljGXbZ4Bjo1OkGDVGRPPIBoZi6Z/OpugsDFAiyNeYjhoW5tc7F
	 w5cNzpbTTxP18RqyMxY1+raqAxsoK6xluwkTWaSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgD1TgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728474AbgD1TgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:36:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E64C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:36:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so9204625ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dz35P/wW75JPScBtg1LhfcQt3MDYh9XOUGljSwITyf8=;
        b=LfNc2eHH26/bLReUobhiNZUaI4Psyh9CFL0F1oIKCTUu4vYDhvCgsiEQz9hbdMB4Rb
         KnW7pgutm0LfGxr8LV/zvOfjwMUdhySRv26V+yGk/hx4ZZ8MwH38PG53Ti+BpE8dcWd8
         gESAnzEV3eglxpHRlSSfv7r5LQPSduZHTrUtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dz35P/wW75JPScBtg1LhfcQt3MDYh9XOUGljSwITyf8=;
        b=N7+gaIDVSMGZSfajUufrLApFvi54HhrkFIJYDJJYQZyFKSvUv1fTR1DzjtieQNoIAG
         +LrA2VovykqBiKk7CBKhCQdZHGnwvEvgTo0P/2XhdvjxiBeL3ioiv3ypqAvoFnBN2Dmu
         0W+KGlWOEwI2P8akbSVVYpUs0S3lPtoWQXOjZNZ0nEvHlEPEKSpdzacbpxZ2JmVg/wcf
         E1CGmP7Ul8PUvjd4wSlr+ArpaUg1KKfsa+wTca/Oz7mvXRpqO//Q/Z9Di9yqBDyCcqJs
         tv5wO9IVpJCFk02wAZnQkdtjScZoipyL5Hb9vMDjKHmaSVa+voIa7q7BTSwNSaS9qw1u
         hBCA==
X-Gm-Message-State: AGi0PuZt/5u8KS1kBoyKFvcrFlvP3ycO3nbCI0p3oHmwUqe9/n2LBMyN
        3yCnCCZa3WnawwCSmTyAxL+qhA72Mcw=
X-Google-Smtp-Source: APiQypKRYFA59aU4Es6ZpQfG7jZjjuSkpfmGARdo8CZf1SmH9ewnhIP4XkXSrKSF4sCGgNqlOs6/8A==
X-Received: by 2002:a2e:3208:: with SMTP id y8mr18760165ljy.282.1588102580573;
        Tue, 28 Apr 2020 12:36:20 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t16sm192621lff.72.2020.04.28.12.36.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 12:36:19 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a21so19871187ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:36:19 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr18561211ljc.16.1588102578694;
 Tue, 28 Apr 2020 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org> <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org> <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
 <87sggnajpv.fsf_-_@x220.int.ebiederm.org> <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
 <87zhav783k.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zhav783k.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 12:36:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtGJH-jpy2=LuuSPjXp=C+xzxS+oj0E0udzLbnb1Wnag@mail.gmail.com>
Message-ID: <CAHk-=wjtGJH-jpy2=LuuSPjXp=C+xzxS+oj0E0udzLbnb1Wnag@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:59 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > I think the series looks fine.
>
> Mind if I translate that into
>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> on the patches?

Sure, go right ahead.

            Linus
