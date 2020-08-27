Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82476C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BDD2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598551486;
	bh=P/QW4LCtN5PBKiBhSNOj33Wk8T3lV9cTYtLEDR84pLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jCMWych8fhLpgT5u4Y4upStgW0NFMRsbaSS0WEZ3NWm4UUZ5p6D2HN2+0PtTsPxvG
	 imWcX6pT6xdCujaEp9OGt7dzAwTw+auztQA9cKboTVoQZl7j3Q4FPJYw2bIdxVYe2P
	 wZGtOn6UxJ1oWT7Kedklhz+e8AgXmxdrJLm3wfIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH0SEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgH0SEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:04:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29126C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:04:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u25so3401538lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6VpwKDADBkr6enfQK73cCa1pyz6xYYmjIF7scakO/Q=;
        b=agNOO2KP0rSqZiiajY5DxBRyVyPiIArYuDzAzQ+F2BCqG2ckvP4zo+PO7smc2ZbLz8
         rezCjjt3WxG24Ayo1Sw9vwhv7vojAb1JI0V4b7LszKlVWTDwzF8OUnjqlTlL5brjoaf+
         cMn0UUEqHFR+fGJIuruY6iMDSpEOJfjZqPZp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6VpwKDADBkr6enfQK73cCa1pyz6xYYmjIF7scakO/Q=;
        b=LfgKPTE8/sZKPjInvme1m3BnU5fxnulkRd0fALVRQxeRnKAxUmHXuRJuQ7R+NlESaV
         g3J2KCsuDMM5RRIwgP7WMErhu2+lbikpupWYGJZg9SNoL4QsoUVc8oJqfLRuxZl91SVA
         3xSeAYtfsDSXotKFknzWWi9NRiiClkISBzjjbpCEp7Kk7FTVzJWQ63Xj1ntMMOKlnm74
         yrxiMuSE5IBMwThvGL979iEnWm93vJfVPdPuns9X3FL6Nbsc7MBvkvW1eB3ec8E65gAT
         kRvfH7x8uksWeLuPfV//aZqw7Zxk4FyuucqbYBW3o1QnnQ/fhJFc4F8EULjer4IYHZ5E
         kUQQ==
X-Gm-Message-State: AOAM5323d+lOsSCJKNHyZ1MH9LLRlu0fYoEBnMeyu0eeVWRwtvFQZf2a
        TMDWJdp7Imh8I/+MqwixpBdmTFSxUR5Gzg==
X-Google-Smtp-Source: ABdhPJw2aM1rXKGHSYz1pEwkfUykOkDqZ+naMoV2a6bb87EyHIdqSD9iEInTwPm15G98JgWPzuSDcg==
X-Received: by 2002:a19:c6d8:: with SMTP id w207mr4455428lff.102.1598551482118;
        Thu, 27 Aug 2020 11:04:42 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 10sm616966ljn.22.2020.08.27.11.04.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:04:41 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h19so7444334ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:04:41 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr9832479lji.314.1598551480902;
 Thu, 27 Aug 2020 11:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013636.149307-1-allen.lkml@gmail.com>
In-Reply-To: <20200827013636.149307-1-allen.lkml@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:04:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
Message-ID: <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 6:36 PM Allen Pais <allen.lkml@gmail.com> wrote:
>
> Introduce container_from() as a generic helper instead of
> sub-systems defining a private from_

NAK.

This seems completely broken.

The documentation comment doesn't even match the macro, and claims
that "container" is a type.

Which it isn't. That's what container_of()" already takes.

And if the argument is that a broken commit introduced a broken macro,
then that's not a great argument. Yes, we have that broken
"from_tasklet()" macro, but it's not even *USED* anywhere.

So instead of adding a broken new concept that adds absolutely no
value, let's just remove the broken macro that isn't even used.

                      Linus
