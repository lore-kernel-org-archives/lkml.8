Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3FBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D93820771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aq4/cPjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgGHHSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgGHHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:18:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:17:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so52955735ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAFIrZ8F/mBJqkJAYIueoajWvUWkQCtRnV1fgyx+lWQ=;
        b=aq4/cPjLKxizsfEDEFrsZ9DGzsV8/Xzod02YigHVJC6RddJnaepE6YlWiJY9FFJpoC
         54aDpJB5eued3sHz2mnYw22r4dsoPVbdRXnUuhdPiqFAYguZh3C6B2Ideqix5JIthSS0
         PlpC1PCg6Wpltv0HD/zgILAzRytUTjKO/gr+Kyic5mSyz0EIpvQAd+p/xK5CE3bMh26O
         b7cdMK77tPPi9Imv+wDRBZTIALJUzVSkNKQSx+9QaJASHLFc8IW3LVLarMFs3dUJWc68
         dwtTUUpKJcA2BwQ1sgaZDbmvzkG6jQkIv0iMDa7BmKGEBohIAFop4idQonc4huMd/wzd
         /PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAFIrZ8F/mBJqkJAYIueoajWvUWkQCtRnV1fgyx+lWQ=;
        b=lEfmZsyp4lsXzHUkE7RNYxbP+dNkymXMPSau2qbATGew8Hm0DCFCh+N+fBufHumA3v
         ZLyH3SSv5KcJKpgIvFhF6lyJIzwXM1XTOJ8+j0r0s0xi3M96o1O7fj+3c7R4Z5s0G3pk
         3V7MOfhmYg594wgq4NXRb01BeB/aFIK/8PBZB5+TsTK/F+RosG/oY/oRXzjnwIy0vq89
         vbpcUWmGOMXCj6CbZsuZXwMRtec0nYx5Vo3SOjuLjcT4X9Z4cYHseDYp/uePZQFtirZc
         eBsdGNDCZbHNCd5vnS9kvQlM7zjrQavtdPzNpJkyzTv7Vp8Ncwu0A/B5djwusZyktxdD
         vFSQ==
X-Gm-Message-State: AOAM531JtdbpIstR/YzEt2uS6eWTExNJZBJ9W2WaFnkuOXSywNfoMNDu
        UDVHM0ZzaBtgNxj5lF4kVldcZwEWNapijkMTqfD7PWubxAQ=
X-Google-Smtp-Source: ABdhPJylJBqgZ7fRWLwWIlGt4A5bo/2LK2Oljqk21UeArICbItF5N+VoFDh+vaO83CgV2n/EdrLLeJelnkHFnIetLCI=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr18618352ljg.100.1594192678178;
 Wed, 08 Jul 2020 00:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-6-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-6-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:17:47 +0200
Message-ID: <CACRpkdaUQkS5vfkQ1GsssWY7gGgz8N1-Ng6_HugGWMxuQxSysg@mail.gmail.com>
Subject: Re: [PATCH 05/10] gpio: gpio-sama5d2-piobu: Demote all kerneldoc
 headers to basic comment blocks
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to provide proper descriptions for each of
> the function arguments throughout the file.  Simply demote all
> kerneldoc headers to basic function headers.
(...)
>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
