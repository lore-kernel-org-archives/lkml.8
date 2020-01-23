Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34641C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042222253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1HxleyXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWKPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:15:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41289 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAWKPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:15:17 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so2382936ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXRsUzrO7KARedDHZpE6AM1ca5cPGVaTXeCXrz+c+Tk=;
        b=1HxleyXbP3V8LiG40BlbsJhP2juCJ5kDWQN2KrjHFEzBDxK6ODbDayTswLPoY+l6VG
         GR3e3W2Asg1YhRtxYJKWPo7jDfldkQrBrJrDf3WXSnslW5qk/njfXg0ro/lzDJ8XjdGM
         V/HSjtyu7GGJgQ9TZiDGsSYc0zBbY7/mACd0krSNsygwBcsUh0/WZEWI3p+MlI8t1fos
         fINOlMBR+ZQXjyhqBadsTedxgDg8qglSI4sW/t0CLZ8BD352Aow8SuR23Za0dOTcO3vg
         XS/LtuzX9L+3akcyqZ0RHDfFuRha0fVMNLFDnykKIXqv98k4elLE6njN5r8DVwFRFqHM
         vcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXRsUzrO7KARedDHZpE6AM1ca5cPGVaTXeCXrz+c+Tk=;
        b=T1sV1VVQCasUYjUWs/l+OzDipZtEOuCW/2WZBWZCP/P7A5nCKuo94QkMEjGsc5OPNl
         I3HYInZ2hTw9uaFNTC9QvL73zB3uCFsoFC/sTIUyNL7PREYLE4c7YATJyR7V7/3+KD7j
         IMzDBpnpO9v69S2Ba4TYQA+wnV480BL3MT+lj5AD7SYHTfgV6UaUsmGGtF95cNhdwwWH
         gLAAWuNif0R9hdFF6CX2QG3DO9IigXMpaYStn06whN46KvK9kdxahc/s/+Ov8Xdhu5hL
         iGA9mePtEusUs6J+Xm/OkVgbGC0n7iiwa+alyMCy+LiavJmZA089FrsqSe8waOJxutJK
         moVg==
X-Gm-Message-State: APjAAAVZ/bYXYBzXL10/m9mjuxClv8eVNmvGNllL9ZeP6pqDCtN7LMwO
        x5q5U2uhDudxlLfeZ+QSctT5CKSo75B8TlPpUJFBOQ==
X-Google-Smtp-Source: APXvYqzmhYD6xHwI1WQrrShXHKyqpEKHpSMXlmENqrVpNjtjl2OvACmeCT9bLWWMPKNy8kh1ArgSJQ7v3y80tQIJ8kM=
X-Received: by 2002:a02:3312:: with SMTP id c18mr10526471jae.24.1579774516484;
 Thu, 23 Jan 2020 02:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20200109115010.27814-1-brgl@bgdev.pl> <CAMRc=Mf34JTo-mCCb-ubdY9=YsGQp-YrkhQMp811_wXyVtW-=Q@mail.gmail.com>
In-Reply-To: <CAMRc=Mf34JTo-mCCb-ubdY9=YsGQp-YrkhQMp811_wXyVtW-=Q@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jan 2020 11:15:05 +0100
Message-ID: <CAMRc=Mc80hudqxHMp87_Ro+k1YQNeo=FxYD0oZy_g7P=Z2w-Zw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] gpiolib: add an ioctl() for monitoring line status changes
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

wt., 14 sty 2020 o 08:44 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> czw., 9 sty 2020 o 12:50 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > When discussing the recent user-space changes with Kent and while worki=
ng
> > on dbus API for libgpiod I noticed that we really don't have any way of
> > keeping the line info synchronized between the kernel and user-space
> > processes. We can of course periodically re-read the line information o=
r
> > even do it every time we want to read a property but this isn't optimal=
.
> >
> > This series adds a new ioctl() that allows user-space to set up a watch=
 on
> > the GPIO chardev file-descriptor which can then be polled for events
> > emitted by the kernel when the line is requested, released or its statu=
s
> > changed. This of course doesn't require the line to be requested. Multi=
ple
> > user-space processes can watch the same lines.
> >
> > This series also includes a variety of minor tweaks & fixes for problem=
s
> > discovered during development. For instance it addresses a race-conditi=
on
> > in current line event fifo.
> >
> > First two patches add new helpers to kfifo, that are used in the later
> > parts of the series.
> >
> > v1: https://lkml.org/lkml/2019/11/27/327
> >
> > v1 -> v2:
> > - rework the main patch of the series: re-use the existing file-descrip=
tor
> >   associated with an open character device
> > - add a patch adding a debug message when the line event kfifo is full =
and
> >   we're discarding another event
> > - rework the locking mechanism for lineevent kfifo: reuse the spinlock
> >   from the waitqueue structure
> > - other minor changes
> >
> > v2 -> v3:
> > - added patches providing new implementation for some kfifo macros
> > - fixed a regression in the patch reworking the line event fifo: readin=
g
> >   multiple events is now still possible
> > - reworked the structure for new ioctl: it's now padded such that there
> >   be no alignment issues if running a 64-bit kernel on 32-bit userspace
> > - fixed a bug where one process could disable the status watch of anoth=
er
> > - use kstrtoul() instead of atoi() in gpio-watch for string validation
> >
> > v3 -> v4:
> > - removed a binary file checked in by mistake
> > - drop __func__ from debug messages
> > - restructure the code in the notifier call
> > - add comments about the alignment of the new uAPI structure
> > - remove a stray new line that doesn't belong in this series
> > - tested the series on 32-bit user-space with 64-bit kernel
> >
> > v4 -> v5:
> > - dropped patches already merged upstream
> > - collected review tags
> >
> > Bartosz Golaszewski (7):
> >   kfifo: provide noirqsave variants of spinlocked in and out helpers
> >   kfifo: provide kfifo_is_empty_spinlocked()
> >   gpiolib: rework the locking mechanism for lineevent kfifo
> >   gpiolib: emit a debug message when adding events to a full kfifo
> >   gpiolib: provide a dedicated function for setting lineinfo
> >   gpiolib: add new ioctl() for monitoring changes in line info
> >   tools: gpio: implement gpio-watch
>
> Hi Andrew,
>
> could you Ack the first two patches in this series if you're fine with
> them? The code they modify lives in lib/ and doesn't have an assigned
> maintainer, so I've been told to Cc you on this series. It would be
> great if we could get it in for v5.6 merge window.
>
> Best regards,
> Bartosz Golaszewski

Gentle ping.

Greg: could you maybe ack the kfifo patches so that we can get this in for =
v5.6?

Bart
