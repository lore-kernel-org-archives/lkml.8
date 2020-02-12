Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C77C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785CC20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWDhzZ7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBLKrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:47:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46715 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:47:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id z26so1224264lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 02:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17X1P7t2FPFW7M4slmZioExSFdvzkpCr0KSpfhHxYNg=;
        b=aWDhzZ7UO4+EStPZ3cZ5Q7KDr3hnn3d+LksWJJjjCMa0zZHvUDMqWrNaVciDllF4EZ
         FIt8rz98AYs+DZWmXO/aPM3+POlIBtoHsZHjDZPZ9rRNe1CkhHSKWsg+ZOEDn23+V8J1
         vr/WleMJhFym/KW20IAIxn69xFvRXR/YNKp+1NHZjCt64waUSAXs6GvD/vj84BZovo97
         Pbe9AmTZzxGCi79Oxq9Ri+ieHMG48qFwJwwkLc7ONA+zZdUR5MNLWoeZ5h0b2gP20cJo
         4RGQSUGtn9NjvZ+CwuLl+VBSyO3HYb8vLDsVTjoFM6gu1CWOXcqEtk01/a6hJL494MYZ
         sd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17X1P7t2FPFW7M4slmZioExSFdvzkpCr0KSpfhHxYNg=;
        b=C1HfKlkG4Ju0h3rT5dGLK+gBtCHv+Vj+WXLz4X5eh5PmKV9lfxwXDj6A4Uny+Z9VuH
         uIWI8UKoQdPmcujBno2k/A+F2w7I7ZRU7KGO/D7fzDmr333Bocq1yfcU7CxhM5Z+aHUX
         DFJrSSX52sEMkyHzXA74RMJ7TniUwrPrJOSRWv9LwQvbbH5rOnwo+0lbnMzepKB3gQ3X
         AQiYfQLsBj0LTIRzd9JjDWKzn29Dy2G0WsrTdCstcyWLuyiNviwY57HokQkfFthVb4ag
         YRqUx0egmFbzVXWHyMe8dLaLUAY0fNv0jqrH8eBZWmDT5TSAsteNAWV+eI+mcTOoJCma
         YBbg==
X-Gm-Message-State: APjAAAUCn6r1ZMKE6Tv4zTy41cLcOXbt7KvyzTcIZdxFUIUnFzBduqDs
        or3d/M9BzBSMrUJgryhaBrzaown/1gMNBZsLGkW6gCKNOmA=
X-Google-Smtp-Source: APXvYqyV4ki1Xa39qTcwrcrHZU+8mYLMB7WPx9tV1QxoNnySzNnmRTqNaZ7vdoV3Eo+RVkDXPJNgX0a7EkHhvXeMni0=
X-Received: by 2002:a19:850a:: with SMTP id h10mr6417830lfd.89.1581504462560;
 Wed, 12 Feb 2020 02:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20200211091937.29558-1-brgl@bgdev.pl> <20200211091937.29558-7-brgl@bgdev.pl>
In-Reply-To: <20200211091937.29558-7-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Feb 2020 11:47:31 +0100
Message-ID: <CACRpkdZNyCBxQF_pVPGENob5EKZfYjuaNq5bLNA42XjraXzNZg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 6/7] gpiolib: add new ioctl() for monitoring
 changes in line info
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:19 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Currently there is no way for user-space to be informed about changes
> in status of GPIO lines e.g. when someone else requests the line or its
> config changes. We can only periodically re-read the line-info. This
> is fine for simple one-off user-space tools, but any daemon that provides
> a centralized access to GPIO chips would benefit hugely from an event
> driven line info synchronization.
>
> This patch adds a new ioctl() that allows user-space processes to reuse
> the file descriptor associated with the character device for watching
> any changes in line properties. Every such event contains the updated
> line information.
>
> Currently the events are generated on three types of status changes: when
> a line is requested, when it's released and when its config is changed.
> The first two are self-explanatory. For the third one: this will only
> happen when another user-space process calls the new SET_CONFIG ioctl()
> as any changes that can happen from within the kernel (i.e.
> set_transitory() or set_debounce()) are of no interest to user-space.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks good to me. This got really slim and clean after
the reviews, and I am of course also impressed by the kfifo
improvement this brings.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

A question:

Bartosz, since you know about possible impacts on userspace,
since this code use the preferred ktime_get_ns() rather than
ktime_get_ns_real(), what happens if we just patch the other
event timestamp to use ktime_get_ns() instead, so we use the
same everywhere?

If it's fine I'd like to just toss in a patch for that as well.

Yours,
Linus Walleij
