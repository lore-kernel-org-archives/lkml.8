Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63900C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EC120CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582655276;
	bh=1ByXosMMDdYNeqtP69L/IiTPKKdM2qVjlS/Y1To24ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m1F+ZttKrZbFQSirhnWaHpS5AZsmMQVGXVukI0ecunJMt28Xl2An9nfUnHqeuj4zO
	 ROfVavS+Am5JojCo/Lrmov5VfL/rGGULySMfCQQtMkK9kSFVMwMxXpEmnutCai+ZtJ
	 9UBTA/22Q2gJGS55xIBP54nkeizln5+3oxX74m3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgBYS1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:27:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43681 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgBYS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:27:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so15127880ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuecmF1yO4tHT3TnahV50e2HzEnXvd8V5CGAOVbnplY=;
        b=OqJ+vlEoWFx5gLSWgF61ab1/Q32WWhXbHNDXycmahm/2WHj3sW13PHAFhc/97Lcjm3
         VSMQMXqHCzPkueoOB2jz8PRFLmWZY4M2AybZF6quz9J+a5EMqVT4V/ip8ce/YaL8wYWI
         FnqkptEVf112Bjo5/UCNc1rFsaQgVSVoiz7xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuecmF1yO4tHT3TnahV50e2HzEnXvd8V5CGAOVbnplY=;
        b=DPZrmpRRuz4VubPj1hW+TXKbhQxFu6TEkGGMsIxw4bI8bOWpxnIeAWhQEmWMTQS3p+
         Gw5GBQFswcdcOd+LWUCzRxeL1Fbil9a1+kUeYXgq/V0OHYOsCA6pKdKD1CbeMUDlqgXi
         Bqb9WNz6JZPI4cDWkcA7Pr+ke0AdVJBe8qvZ4UZ+Lryz+wtNfiWTFxJSVl+ganSZlK8G
         wN35VKszb0yHRMqeKLbfqD/7o2/wLunFVamsh8E2YrY0DCPjNs+DCPP6jRnxNrDFA8Oj
         yLid5tXHQWRfUuLSVbXA6NvWfFCdq77P82gm30jb7nDJMqls2V3SI8j5wqCh/Sh6MOMZ
         f3HA==
X-Gm-Message-State: APjAAAXov5EOxb1g0qSqhCYtdet0aScfpWviLC0u7rZJ+QfNcysrSkhh
        a33lzWUsgptbGWalpaS2zRF35QLH82Y=
X-Google-Smtp-Source: APXvYqx4BMn0mo37VR4MXrbJeqO0y6IGFHZlj59XxYbRIJO8ckUsimRlmNUaKOYymmle4eahJY6Mew==
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr181583ljm.285.1582655271694;
        Tue, 25 Feb 2020 10:27:51 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w8sm8241746ljj.75.2020.02.25.10.27.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 10:27:50 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id r19so6865ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:27:50 -0800 (PST)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr193655ljp.241.1582655270148;
 Tue, 25 Feb 2020 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com> <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com> <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com> <CAHk-=wggnfCR2JcC-U9LxfeBo2UMagd-neEs8PwDHsGVfLfS=Q@mail.gmail.com>
 <20200225181541.GA1138@1wt.eu>
In-Reply-To: <20200225181541.GA1138@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Feb 2020 10:27:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyEQy771ixppPmMSYtPcFS5ZtqVWUYow8gWd=pMnATNA@mail.gmail.com>
Message-ID: <CAHk-=whyEQy771ixppPmMSYtPcFS5ZtqVWUYow8gWd=pMnATNA@mail.gmail.com>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
To:     Willy Tarreau <w@1wt.eu>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:15 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Tue, Feb 25, 2020 at 10:08:51AM -0800, Linus Torvalds wrote:
> >
> > So we can remove at least the FD_IOPORT mess from the header file, I bet.
> >
> > Worst case - if somebody finds some case that uses them, we can put it back.
>
> I like that. And at least we'll know how they use it (likely without the
> dependency on fdc).

Note that the way uapi header files generally got created was by just
moving header files that user space used mechanically. See for example
commit 607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")
which created most of them.

There was no careful vetting of "this is the part that is used by user
space". It was just a "these are the files user space has used".

So it's not really a "the uapi files are set in stone and you can't
change them". Instead, you should think of the uapi files as a big red
blinking warning that says "sure, you can change them, but you need to
be very careful and think about the fact that user space may be
including this thing".

So it's a "think hard about it" rather than a "don't go there".

Of course, usually it's much _simpler_ to just "don't go there" ;)

            Linus
