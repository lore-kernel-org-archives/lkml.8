Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AB4C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41649206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595623446;
	bh=lbR0ExdJ+2UAtiZ01hcs0sQP26N1EOVvl5GwjhvVZqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VAw7hbM/f2E0vnFJgMVk8Z5H2yu2s6M+1k0K3txxqsjYX8ZbDytKrl1Bzkrssua/v
	 e/qcyBzwY0bErGKxcvpx6A7kYttqu94KHWoOcIbL5HcvvaQS5NWPYg/bdvuHOK16Vz
	 obKVJonWEKt8d0Jn5Lo7ghllOJ+4ZkqbCyxiOLT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXUoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgGXUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:44:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:44:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so1594423ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B82gYYGiPy2JMsI7fbcCJSg3IUC2NN/ufVJBewTAqEg=;
        b=MIx4Nwnw0hQOhBxrC/PQv6JymjkmUdhb4keWH8aN8ACb+ycU5lnNx3lXJuG63vOZjb
         BUAJColHg6jYaO75jafZJMwlxOchGjWwGP0flmY/+dRs+aMNz/mEfimaT0NoBQYPt2KR
         LfWGqfZb42ZNg23nQJGx5oYJitbQLfaPCvDUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B82gYYGiPy2JMsI7fbcCJSg3IUC2NN/ufVJBewTAqEg=;
        b=nr5mM04Hl6HE0n4mdJBVJBTfjUcLzA/lCPzImQDAn7PjKrKw0JwTlU4yt9ta8O4xZg
         km8UKZG5V1wONuSz1E7dp5uPhXYDYGH5oal+4paqSP1himie/BFjKH4FiQyOjxfpJPfR
         LAAsVGrJwtSYGnZE6Lw5kCtCJWQtw56v9UqX1pVdRiyvyY7g8UzdkMSRa1ZqE/e0ATNr
         lmFp7ujdkTJMIGYZbkhKjatO9JLlzB0IyOkOGof4T58/s84V9eO2DLBe0PYoBuILhaXN
         qcqbOOGV7+QMI/sKD1fAqplxyuwjRQKEFZE32IFNuTiK4TCGnO+WjXuZMdmZjvylv68R
         uKrg==
X-Gm-Message-State: AOAM532hNmq7at3u1yXaS2O64ANWN2tKvy6WOD5Bmk3MSaGZN+d/3zYd
        OXRL2znuPggIxGVkdl4kNZGDpIBCvlc=
X-Google-Smtp-Source: ABdhPJwpZ9ymGs0dEu9rDAHmFN1uLntTum8jPn2l0nsF4ymNn1FnIUD9iE6ckg5ifpaUB8oiYuUykA==
X-Received: by 2002:a2e:9811:: with SMTP id a17mr4983294ljj.86.1595623442475;
        Fri, 24 Jul 2020 13:44:02 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y26sm486418ljk.26.2020.07.24.13.44.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:44:01 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q6so11270375ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:44:01 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr5366037ljc.285.1595623440971;
 Fri, 24 Jul 2020 13:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200724192728.GA1596@ninjato>
In-Reply-To: <20200724192728.GA1596@ninjato>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 13:43:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaHZKQnOuGLWukvMrTmDrDd6iyiq5toQumB2uX1nR9Xw@mail.gmail.com>
Message-ID: <CAHk-=wjaHZKQnOuGLWukvMrTmDrDd6iyiq5toQumB2uX1nR9Xw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for v5.8
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:27 PM Wolfram Sang <wsa@kernel.org> wrote:
>
> And a question: can we have an additional rc this cycle because of the
> holiday season? I was away and this extra week would help in my case.

Do you have a lot of pending fixes? Because things _seem_ fairly quiet
for this release, and right now it doesn't seem to make much sense to
delay 5.8.

Surprises happen, and this could change any day, but nobody else has
indicated any problems that I know of, and this week has been very
quiet (until today, when I start getting all the "end of the week"
pull requests, so my opinion on that may change by the time I do an
rc7)

             Linus
