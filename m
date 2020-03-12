Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84768C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DE5206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXUrdTEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCLKf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:35:29 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37981 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:35:28 -0400
Received: by mail-ua1-f67.google.com with SMTP id y3so1911259uaq.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrLadEtBvTVTVcBt3bopoSIgtuqLiK80lSH0hCVtfuw=;
        b=AXUrdTEbrGYI5Xa4Ju23OdXl2u4/hn8Syww7t4gl9THWvx6gPnACLJY0G+ZZnH81k3
         0qwMvbk5hWX+9SRuMreq0nve73Nc8/z7mOlf+34ddgh8XY2R9dL7WErn6ucyPRVc7wkI
         NgdjiV+vTXtpRQVWxatTxy1wc4+syToipQlg6RS97EvmbkoBdoJy4qNK3Tha1rze0oQk
         kDHLu4CEBtTmENhdb8SV65B6PgIWzXZ7jLloicG+YrtlH5NCc2CHdBGNMLPN9urYxvwK
         qb1hGaEduoyMC6FW3igtSCHds2fNMy9Om+Ws5IZdilgLlM+JTcjkxUAwM5JFIW3jTvEp
         ng3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrLadEtBvTVTVcBt3bopoSIgtuqLiK80lSH0hCVtfuw=;
        b=AVjAZPCzz/Medb+CNa2LulNZyf2mPFkEbi5Eg2fB3Mmh/anQjXtfT6WD5Pup2MAmUj
         iXeiSWV/rx98FU2Ke9sS43aipA0aoEd2yhPkQzhWGD5ZVaMj9Ol6v+od9f2GmiQGeRiW
         65sSjyHKhwpdR36iqHI5hRIJzRvLWz4+YguAjB0JvRn92qsdbC4U+iRkN3PO3VU5ocXk
         b3RY6o4cYndiqxIWXPz6FChKZwU/oYpyZpKqI1MTHip/6i9rzNZnDqIA2C9KAJziOFg1
         9ND+FmOrSZ0O+oMzFm+2sU7nHIuV++pmTABMVfZStupOsFBO02f1bJ/Ed/lm+qxfJuKn
         NgsQ==
X-Gm-Message-State: ANhLgQ1Pp9BrpsbH6x23arvv4oxgoqQuJsBNnwS7gucaCQXnuEynysSh
        D/pdINFvc4yXsWVdaVWdwT/l/n21CsiGxpujwlvdQA==
X-Google-Smtp-Source: ADFU+vtKh6Tm1Tefnj39I5CELsyO9aID4vrqwBb2PwnEmqiy2XUQJMfPp0mRZY2GNyGTBRSRMxcIADvnaASG/aVl10s=
X-Received: by 2002:ab0:5ea9:: with SMTP id y41mr4333595uag.10.1584009327849;
 Thu, 12 Mar 2020 03:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200224094158.28761-1-brgl@bgdev.pl> <20200224094158.28761-3-brgl@bgdev.pl>
In-Reply-To: <20200224094158.28761-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 11:35:16 +0100
Message-ID: <CACRpkdZSooH+mXbimgT-hnaC2gO1nTi+rY7UmUhVg9bk1j+Eow@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: use kref in gpio_desc
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

I'm struggling to figure out if this is the right way to count
references for gpio descriptors.

I cleared up the situation of why we don't want to add kref
to gpio_chip in the previous message: I think we got that covered.
(If I'm not wrong about it, and I am frequently wrong.)

This mail is about contrasting the suggested gpio_desc
kref with the existing managed resources, i.e. the
devm_* mechanisms.

devm_* macros are elusive because they do not use
reference counting at all.

Instead they put every devm_* requested resource with
a destruction function on a list associated with the struct
device. Functions get put on that list when we probe a
device driver, and the list is iterated and all release functions
are called when we exit .probe() with error or after calling the
optional .remove() function on the module. (More or less.)

This means anything devm_* managed lives and dies
with the device driver attaching to the device.
Documentation/driver-api/driver-model/devres.rst

If the intention of the patch is that this action is associated
with the detachment of the driver, then we are reinventing
the wheel we already invented.

E.g. to devm_* it doesn't really matter if someone else is
using a struct gpio_desc, or not, but if the current driver
is using it, it will be kept around until that driver detaches.
No reference counting needed for that.

So is this related to your problem or do I just get things
wrong?

Yours,
Linus Walleij
