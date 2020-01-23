Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5608C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A76C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="K/XZvrts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAWOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:06:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36785 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:06:13 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so3075894iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gvEKLZlDMkWIma4Hyg4xXfMq3Pu+MDy4BtfJNtH0DlM=;
        b=K/XZvrts1jGW4gQXM4HIgH0iKxrOZPnIYpF7pcebd2iNw5NcAxxjBnC0a6sIf6B9g5
         YllgMarQHju03rrIADB5USBzhEtusDlcoraXg4l2ZNUVeeqOggA3tQqeigJqJQE5RQMM
         upzNZapN4wiJkT7WH/xsZw7eNZtaS5P28JjHN3VFLrXAXM4lI1WA5JZU/dXtkFb6FKaO
         KIgeLFcxIX4nD6gsaxlP8wt3r0Ugkpsm2QiD+h9VnnhqC4/Hvx1Tnr2VwQN24vXeTSB8
         1g51X8BZ3XN0pVQ4Qnq59LuPSWqfparifXzBG3M0iVKUQIIcxIDWvFIciqXj7Bik38cS
         koGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gvEKLZlDMkWIma4Hyg4xXfMq3Pu+MDy4BtfJNtH0DlM=;
        b=OzrOaz+i/5zOVad2SXBwiseM4nNUtKUo+JStTPdamykqlxnwnnBdr0hJ3AWwnwcyF+
         DxcLVDDzmRtN30PVFNus5+DPYX1C5C2yyzhc0RYquRoMdxO2HHHrEV8MHLVao3wiFXTr
         +snSSz+NGVWSAqzjVatBdYvR9XukR/LEOOAcrO5VlaCmZ/dat9KkPZMTEMV/z17yEfdm
         JTsxEXt/UqlyadRgHfyopo7q7xSDPAqR6rMFY+yL3cNogZ7Wq5dUJezyAPIH9YVr6MCd
         HXh+3TVBW0zlY4+aH6r8zxKS16LmJJxCuF7gyE6zqFVPSQIvYyebdFdImuNhr5FY1Wis
         MMDg==
X-Gm-Message-State: APjAAAUY0VvtgzLZX+pisptLK3Jb07MGltkDkXwSoyb5Qwzhh7YaWXfk
        42H+Zzz8MtJFI4Rzz3PjA1UCJAfU+BPLjfP9phr74w==
X-Google-Smtp-Source: APXvYqwUOM4P7pXnMt7JTJLROWjd1CXi2dKUzReOaaDmqfByeJwch4bBzmJ5AYzVC3X6L4pfxwgXycTKvwT6EhjcmaU=
X-Received: by 2002:a6b:2b41:: with SMTP id r62mr10602149ior.189.1579788372482;
 Thu, 23 Jan 2020 06:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20200109115010.27814-1-brgl@bgdev.pl> <CAMRc=Mf34JTo-mCCb-ubdY9=YsGQp-YrkhQMp811_wXyVtW-=Q@mail.gmail.com>
 <CAMRc=Mc80hudqxHMp87_Ro+k1YQNeo=FxYD0oZy_g7P=Z2w-Zw@mail.gmail.com> <20200123113726.GA980445@kroah.com>
In-Reply-To: <20200123113726.GA980445@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jan 2020 15:06:01 +0100
Message-ID: <CAMRc=McW2KdUVWPKnJ=g29-SuhU5UereHeC_=h2QFpHFmJLQOg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] gpiolib: add an ioctl() for monitoring line status changes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 sty 2020 o 12:37 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> > > > Bartosz Golaszewski (7):
> > > >   kfifo: provide noirqsave variants of spinlocked in and out helper=
s
> > > >   kfifo: provide kfifo_is_empty_spinlocked()
> > > >   gpiolib: rework the locking mechanism for lineevent kfifo
> > > >   gpiolib: emit a debug message when adding events to a full kfifo
> > > >   gpiolib: provide a dedicated function for setting lineinfo
> > > >   gpiolib: add new ioctl() for monitoring changes in line info
> > > >   tools: gpio: implement gpio-watch
> > >
> > > Hi Andrew,
> > >
> > > could you Ack the first two patches in this series if you're fine wit=
h
> > > them? The code they modify lives in lib/ and doesn't have an assigned
> > > maintainer, so I've been told to Cc you on this series. It would be
> > > great if we could get it in for v5.6 merge window.
> > >
> > > Best regards,
> > > Bartosz Golaszewski
> >
> > Gentle ping.
> >
> > Greg: could you maybe ack the kfifo patches so that we can get this in =
for v5.6?
>
> I am not the kfifo maintainer :(

Nobody is... :(

I resent the series with some people who acked kfifo patches in the past.

Bartosz
