Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B567C35658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D624653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yl4rYrff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgBUQIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:08:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42741 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgBUQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:08:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so2712104ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkTsQTvfjgOEGdlDXKGCeeZxoa04rIy9ygJ3R4JduGw=;
        b=Yl4rYrff+zKVIc9yoeCBgHu0Hr6Lxdr2Dk+weltYHKGkpqyZwgJl2IO1NgO2i0vT/E
         99a5A1dgaz45Pjo84/pcasIWbjqjIkhY03aq+EbKkljQaPvu53PSnv8MEzWd5lTXHMO6
         ILy1pKyOIN8MEJYzd46PlFensSAb/peD4Pyzc4ZoFZxBo5atPVjDya8qF0JhhOx/I9uH
         H4VTjhsow4h49cwt3AvmwmV5/jMHvdy9OPRNCwK3mPh3pTOogHt5J/wFCgkfN4Z6so40
         qDYMC5mecGJY7L2h7znzdfQ3Jzp5HE4zgleSo1s22yfX5NZQo5mSlGfgtS+JqaLjPGOy
         +whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkTsQTvfjgOEGdlDXKGCeeZxoa04rIy9ygJ3R4JduGw=;
        b=W1544rspUcwi7P8qCWpt1iaatfA18SLiYQeyQrBrk54vh90adB7yW6z9RlEbUVcxsi
         LTAbVgin4pzD64P0RYh4/1Nb5+njWO6oMpfiF0W++KaJ47FuItFtS83dmKP79m5z3WOD
         +g02thYg5/atRiNmrZ3my10vlgSMCAGC/NyByMWbfmuOmgwBysFnTL9+IjE4KrhkTLaF
         g9vdMxahG0Mawmw7Dl0buMIiapYcA0AC7oWtJKLN+ZsIKqbb+y7kXxQ7/1uNeoxrsmBM
         Q3Chz7PoFp9Ts17rswZ7Pfg4Uo6T4Nb6m6TZgW/Q4iDjXOmqiPlfLSKDq54oqbn4k12L
         aXRw==
X-Gm-Message-State: APjAAAWIcZo3A3HPfIv8Z/btTK/2G9kDPvl0xeaJofjl5IF4umzq1Lo1
        6Gd/wFON6z8ZGJYjt82J3HIFFLO4wubEje3/a5vVRA==
X-Google-Smtp-Source: APXvYqzjBTruiUzyd12hI2oewAEFW5wvp0x48B+Xz9xN6AHcyQ7rQQbPBXV6MVxQYYXX7uV28p+joU8wSXIlz+RTL/U=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr23390889ljc.39.1582301318561;
 Fri, 21 Feb 2020 08:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20200220130149.26283-1-geert+renesas@glider.be> <20200220130149.26283-2-geert+renesas@glider.be>
In-Reply-To: <20200220130149.26283-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 17:08:27 +0100
Message-ID: <CACRpkdbgsR1n1qj3HmQWcEjeDdN85N1Mw8kLOUAeDjESW36MDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: of: Extract of_gpiochip_add_hog()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 2:01 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Extract the code to add all GPIO hogs of a gpio-hog node into its own
> function, so it can be reused.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - No changes.

Patch applied with Frank's Review tag.

Yours,
Linus Walleij
