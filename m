Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2745EC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018002076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587669371;
	bh=WDpkM+K9xJrK4q9eRqKcKGlidxbbI7TeoBm0UjZS5S8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BL1xM6JQctAyMFuyEzO5RWqCzmDNO0s6C6bVIvY2bL0qcRAwWobdOd2WHypBsSWiN
	 jPBelNtufeAKdMLAzRCYRXCsQ9MYA+6ZcF2ouOuOnpPTvDMHeCdo08njFqJx35GJGC
	 CjjChE2D764qlL4nsb90tuI29nrOgRdr/LEKhEkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDWTQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDWTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:16:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8DC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:16:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so7384258ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lP37EGskFEIGvXFAbituPzZQR0d5rXvoC7Ob8n/gCPg=;
        b=bl1c5uhKJTAqhkrGC03RJLBC/puXM77cnT7RkPVFVNMvCKh7YF4yptyq2ImTo5CCBJ
         gOuIuKzVlkxhuW0pJAedIW6sockxPs89H+qJtDdGxDHA8qH8d0Ov4yo7DJEqKZXjf8Nl
         TE5VsGYmTYz+THWXkOEVI2/g/IBpZiGso5RUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lP37EGskFEIGvXFAbituPzZQR0d5rXvoC7Ob8n/gCPg=;
        b=pUhkEAvh16QGsc4oIw2xzkiluE587QLu7WA7eRk8UpmTSLM+BoMeZ61psLhW0M/9ol
         t3NlgwXhzpz/JhUWhIXmujUlS2RkG0aMxlkcLaN660th1M2YXX3SIxF+ySrP0pCJsoJ6
         j4JyCzI4oYGV1wS6emEPMfZBt6V7qH7eiGaFaimU4jHJ4aOKxfzQpw/9pLrnfGq/2R5F
         kOjfeFNcvijrOAXu42RFo1781d/6xAbO/JrZYCijgrp2+pqRwtbrMAN0uOTRGQe5WDlI
         O9rvMoRcVHLgrao938zY5J3PMKjP6tABWaiqOq8qbIrggGJRljKO6wHuqj+fd1sc9VnD
         surw==
X-Gm-Message-State: AGi0PubnGifwDmPh3zpAeGbWoxywvAg2PSCdVRshrV3gL1tOa4ScFJzt
        7TnbyyvnE2DOMAzeyoem50od35x3YJg=
X-Google-Smtp-Source: APiQypKavBjvN+24WWl7Yzq891KC2b3JQ6yD8QiSL6hrT7gAEEZnKkxk1CyCrFC5C2uKqLaeUcJL+A==
X-Received: by 2002:a2e:888e:: with SMTP id k14mr3420541lji.4.1587669366186;
        Thu, 23 Apr 2020 12:16:06 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u6sm2524474ljd.68.2020.04.23.12.16.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:16:05 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b2so7412178ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:16:05 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr3304431ljc.16.1587669364828;
 Thu, 23 Apr 2020 12:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
In-Reply-To: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Apr 2020 12:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+TdPXZ4bDgEwg9x+0m0cmNhwAB3XDQNjwwMjUTG3GJA@mail.gmail.com>
Message-ID: <CAHk-=wg+TdPXZ4bDgEwg9x+0m0cmNhwAB3XDQNjwwMjUTG3GJA@mail.gmail.com>
Subject: Re: remaining flexible-array conversions
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:23 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Just wanted to ask you if you would agree on pulling the remaining
> flexible-array conversions all at once, after they bake for a couple
> of weeks in linux-next[1]
>
> This is not a disruptive change and there are no code generation
> differences.

The "no code generation differnces" is a good thing, but how was that
tested? I assume just one configuration or architecture?

Also, it bothers me a bit that some of the diff is unrelated
whitespace cleanup. I'd actually be happier with a pure scripted patch
(maybe coccinelle, maybe something else), than something that looks
like it's at least partly manual. In particular, if I can re-create
the diff with a script, I'd not have to worry about verifying it other
ways..

               Linus
