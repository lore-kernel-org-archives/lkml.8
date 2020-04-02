Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE563C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0352078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfdUh7lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbgDBHRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:17:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43393 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgDBHRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:17:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id n20so1796380lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGCNVs5ms+lfI0CqvvFzJ8SjCEm1mygHViFV+/PrmR4=;
        b=GfdUh7lZPjm9bwQlg79L00pNMOPlKxDtoFbKZClmGM26yDTyHmPF1qTg09jr2z9bGr
         uEKEaRueCHjqaGoIrOTLA794qYcrb36uZX9OM2tZh6uxtlbJs5FvlShnqs+bd5T9+Qjq
         gQNcWL+FzOuH32elDuDeaGOuJVuSFH+jZ08Tg9LED0VTyPRNo9JpDCtlW/yN+14uhhv+
         hzxM111FMW6KJy+McBkKhD9PWZe0ugqv3nAG+IQCoI8cpaNMjFJQ33roH3HcFZQpNFE+
         ETsOpAo1b9jS/7OmtFzCNIHPKSxjG/eol/0NfYHnP44L+XHq+YOmiOxD/P2MUDwAaxw9
         BrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGCNVs5ms+lfI0CqvvFzJ8SjCEm1mygHViFV+/PrmR4=;
        b=rLXXt0oEyv/jkqUccAHAonuXuyxmLnjDh/TJRSxj2jjTNwW5eQ5mHtOLxs4GskI4YF
         hbbOnALVbyXKYiYUP9cB6C8njnR0Cu2Ml8RypSBSHxYkQNr83/3lux2w1iuG+igvXbzW
         h5yXluiRwin9xA/RIPA8Tea/TLR4XD5uXKk3CDmuf3BxEjWl5BO+Qybi+dJ786clAfhz
         9tI2to1fB7LvuoMZzrNs9nH6jZ7YZJ/eCoUa8AgeNRulzRxyvQFig5Xhx+PUYZNE26nn
         pSH81gSIzc7wGcaC99E7RpmBikyMpqHxo0U/biAvlbkIEAdI52QYkkvjhh2GFziNd4c4
         nFEw==
X-Gm-Message-State: AGi0PuZM/qWWOuHGMTU7/777FnVz+7S+LuJbj8m99S/vgMumozILKYvY
        GsqBNjqjQrd4CCxgCZxeUZWaKT4BMY4g8ALJQhkRbQ==
X-Google-Smtp-Source: APiQypIEwnj9tdj1jrTHeJRfpuyBzCigYfOdOccOf4IjRg+tWNOyfZS9d/Mf38dVIkuk4m0qLC0dZK0xj7ZMRPC8i9c=
X-Received: by 2002:a05:6512:52c:: with SMTP id o12mr1096197lfc.217.1585811870053;
 Thu, 02 Apr 2020 00:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200401200527.2982450-1-thierry.reding@gmail.com> <20200401200527.2982450-2-thierry.reding@gmail.com>
In-Reply-To: <20200401200527.2982450-2-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Apr 2020 09:17:39 +0200
Message-ID: <CACRpkdY8etT67jsoz9UHwsXcCOXwb3j5RjkoikgOx09-Nr-+xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: Unconditionally assign .request()/.free()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 10:05 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> The gpiochip_generic_request() and gpiochip_generic_free() functions can
> now deal properly with chips that don't have any pin-ranges defined, so
> they can be assigned unconditionally.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

Yours,
Linus Walleij
