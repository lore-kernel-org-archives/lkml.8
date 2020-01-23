Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7FC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E222522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nU81obDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAWPY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:24:59 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:34289 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAWPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:24:58 -0500
Received: by mail-io1-f43.google.com with SMTP id z193so3359795iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BC99IbgznV51ebkSNmOlrBudQG7GZ3+AdYLBnCjDBqE=;
        b=nU81obDAB3xzze9+m3K7YBN1TZ3htR7PWAbiHRx7Q5iA/6i9aOmjRlME8wQlYZqM0X
         wQ5a7JFKNbQGIBTTU06kgXo0ZNFhy/Oj+YjE3CupnrptmMKo6ZCLr6QuVDliNeZs3szr
         MisGDT6n0ppw396O5BYnEQY7Jh4cLHXRr/bKSUqgq1DdghwcHCLF5aLlEYIRMeCRwHiK
         20np/ldbhY2TFScg6G63Nt0Faf2F4hMbHblW9I2LCk/OBdHbTRyTXRwBt9z0Q5RYE3Vi
         VDUL7Q/7m7/I+iKVhBGAcoyJ28cBk8bJn98+Ag+IRn5QPNIbn5sQSvjV5G5HjRT0wuoB
         nCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BC99IbgznV51ebkSNmOlrBudQG7GZ3+AdYLBnCjDBqE=;
        b=b/c0aZ3h054VS2yqBu8CMbE+tBqJxj5QtbjsYbLZ0hlquqmw1Pj/063hdb+R+ut3DP
         Gst+JvnVL749R2tYRfn0QzJpKg9ZdOYTDoFPVGaxR1iMaOLyh0eeerR3dznWtQjqUR1X
         IUSNS01MZg4/9NH/tJ+9bVI4hV+BGFBdKhoYzP6A5SJ5F4wG1HKnoa/YDSnhCEIZP2jl
         34yDMuGrPYADM+5MTX8CPtFMdlFLniX212qFo62TX04sk84JbQh7pywzT3Mg5AkdBsj3
         w8SV/JLD+q4GFqAmvP95Ab3DTjHnFIgc+adrq4cCGB+NFT0l0RtUoF+WGA4DIW7jgUKH
         pRvg==
X-Gm-Message-State: APjAAAWCqOG6KdTLEr6N8oEWzyoeBAKcnfKIhwfEvKbiJnCcHZBU3u+P
        SNYWMqy0YKq+1UY0BclqpMpHODY6xJqQXdmaaqXesQ==
X-Google-Smtp-Source: APXvYqwGqBocjjR32aYXUSpm+fAyIaNTMJhRfvsKcYSQG+OWC5akeoEIMD2bkacKENwDt1VBALJDMq6ff2W1JRyXVk4=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr11974539jad.136.1579793097823;
 Thu, 23 Jan 2020 07:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20200123140506.29275-1-brgl@bgdev.pl> <20200123145058.GW32742@smile.fi.intel.com>
In-Reply-To: <20200123145058.GW32742@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jan 2020 16:24:46 +0100
Message-ID: <CAMRc=MfNHjYB_8hbN610mnOG8y=9zEOG7+YE1s5-sYoi63=U4Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 0/7] gpiolib: add an ioctl() for monitoring line
 status changes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefani Seibold <stefani@seibold.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 sty 2020 o 15:51 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Thu, Jan 23, 2020 at 03:04:59PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Resending with some people who could ack kfifo patches in copy.
>
> Haven't you got Ack from Stefani [1]?
>
> [1]: https://lkml.org/lkml/2020/1/7/514
>

Ha! Somehow I must have missed this.

Thanks, that's settled then.
