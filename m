Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE9C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AB02073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVdWb+3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgBUQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:10:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35905 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgBUQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:10:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so1894493lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fzmdPVewt4poXC+/NMgaFWzacayCygYoOgCnUFqrFA=;
        b=fVdWb+3x5OJjWjTS8JQOQcRTidOkvjo2ir5U7PGAMVw5WxJMB39mldwFJOaGJBpPUy
         TygGJ4Dh2eYuVpqhNmTy3A+mpVuIa2KKYLFA3KwEZW7wHuF9sM0lfQDUBvctfKY5m1/w
         pO0dTq0SLvot91o2JkazTn4LiuQ4fl4I5uYWo0e5ArrD3w5jCckR3bFlT9HGTa+m8PiK
         8VAPpY7zeJn+UMraJSLg7HWnf8dY0AdiTCeorPVYG50crBQzgoxJZ4GIyr4FyKjRhKom
         FwWdL94yUF4/ORBxgq/aGEs+gPSJnwmTca7vaVtED+YyMLd2N70TOhnvv4WIVVP46psz
         EG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fzmdPVewt4poXC+/NMgaFWzacayCygYoOgCnUFqrFA=;
        b=r2JBuTomV32nv1CZzof/oUeuEPcnjVoRhUjbK5TLBX9/zqO77x4d1rwPxUPjJjGnpC
         KMwKSsxupCrLY5GvqKeVe/daY1c0xzRWPTwKMiygJa455n4OL81F1W7wNH3Qqu1mHwoi
         uGm++XFn/xcimjaHEed+ubGAh/lGI3aLhSQ8C6cdaYXdxPh6/tfEPzke9wIJDKW2/lRM
         6/CoJvl+FRIfT2qS38gl3GDlG41LOYu4o3gxzIgH5W3+9zsOsET79RtPDcShjBl4PFOp
         FOTgpMUML6sNW4IzKvij3ITbqIYmai9PSDrOjjl2I9+/bSSFaEKCy2IB/XKiftntGhdA
         NMug==
X-Gm-Message-State: APjAAAWniG3qT6B4FE0S6nOVFzE3mOY6vBpla7i+/nYNPzBWzhOz7n0n
        c9cH3izPeaQtISu2tDpF5KNf6VeeCiVVYthRY/brRw==
X-Google-Smtp-Source: APXvYqzfFpHz+WEEPdfY1KvmrQ7fJ+JA1hBH/qsYBoXtX0Ad1P1ZdxZA5yWVXCM5V2QXzRc1KsrSTBXhNXruk6AbO4k=
X-Received: by 2002:a19:5e1d:: with SMTP id s29mr20384167lfb.21.1582301436869;
 Fri, 21 Feb 2020 08:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20200220130149.26283-1-geert+renesas@glider.be> <20200220130149.26283-3-geert+renesas@glider.be>
In-Reply-To: <20200220130149.26283-3-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 17:10:25 +0100
Message-ID: <CACRpkdbFRv2ab-fa3htiLBTmW4kCuB6Rmxb0Afj=eP4hH0W7BA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: of: Add DT overlay support for GPIO hogs
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

> As GPIO hogs are configured at GPIO controller initialization time,
> adding/removing GPIO hogs in DT overlays does not work.
>
> Add support for GPIO hogs described in DT overlays by registering an OF
> reconfiguration notifier, to handle the addition and removal of GPIO hog
> subnodes to/from a GPIO controller device node.
>
> Note that when a GPIO hog device node is being removed, its "gpios"
> properties is no longer available, so we have to keep track of which
> node a hog belongs to, which is done by adding a pointer to the hog's
> device node to struct gpio_desc.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop RFC state,
>   - Document that modifying existing gpio-hog nodes is not supported.

Clean and well separated code, patch applied
with Frank's review tag!

Yours,
Linus Walleij
