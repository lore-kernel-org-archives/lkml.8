Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B4FC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EDD24676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u0kGKSV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBTMpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:45:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41269 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgBTMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:45:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id d11so3351449qko.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+DR2tqwHDGoIzSaCv59EB/9EwXei3rtQ6/JX+jjHm0=;
        b=u0kGKSV7g2gKVQQ0tktOYXAH7/+lxVouJ+8xGYEuQ+Ul+9zBK8tPqwmMCpEFgCrtOt
         qxrVWpL+RHuA+RbhkCI8sYY6FKdTUxWLwet0QA9Qya0ymHwQetSiv9H3HffGUPO4kA/j
         hpbls110s0uQMOQotm4P4lnkaWLzcue6FW2kncfAmejTlIFSRFAT/SyQD/Xa/P+aND6o
         km9tF5TWWSRlNZ1PlpxW8AmXyHC1+IWdBRqhSFzAAhYByCHbsUq5RolPJNuQaODZmPxx
         lVNMoV2qbwlogdzXgtoJRYF3SaN7wINLQiNYjcSwqfotwm2JMU9G7Lt41zirPPv768j9
         J9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+DR2tqwHDGoIzSaCv59EB/9EwXei3rtQ6/JX+jjHm0=;
        b=NYahdN9fY2f+BH5qaV8TipWURystFp2e4It+BXQ5OLYplxqgPLyHTrjxVnbGoqCpEw
         pE+0Rn0FwHOMaXKB0Y3TJJJn6T+McANb7qNVDGBhI3WGciZ90mJbvJ2B1lOo+1xrYS/z
         WxAs9TaS9iP6GJ/wGcgD/r6tPc8bHf9SNMw7DSwVWJMCacOU1p7Dpb78l3dD6H5UxIl9
         W3nPO5mHRowrfpgV1FXdb7deNbOQ5DsDxibN8M8f/AG1F5Y4DD75soLOdM7vgExlXUtY
         /KFIqe35IvmTvsP8XMY1zpP0EcwREQb0lOUO9u3Cj12TMS+0vh/7EZ7AvG4Z6kNiFxjC
         zA1Q==
X-Gm-Message-State: APjAAAWPlt+Y11QBAPQ5CzxwzE/fOQZtjuIac5m/4CIM6HJlnwQStcyI
        suiZuxQD+QRggnkf+lgXIar1BEtn05LIGjWzpo4fLg==
X-Google-Smtp-Source: APXvYqxLCHV/q5CaKzKrQGpcmCEylpff0GaIk/6cWjgj7li8REIOva0pWlQZQJ1PFCpxJFhOHkj2NJEuc0c2pIY+tiA=
X-Received: by 2002:a37:a488:: with SMTP id n130mr27484945qke.120.1582202720242;
 Thu, 20 Feb 2020 04:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20200220100141.5905-1-brgl@bgdev.pl> <20200220100141.5905-2-brgl@bgdev.pl>
 <965f715c-a714-00df-b496-a586969dd086@linaro.org>
In-Reply-To: <965f715c-a714-00df-b496-a586969dd086@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 20 Feb 2020 13:45:09 +0100
Message-ID: <CAMpxmJXiK+A1AF35OJoKnyYYkJ4VZUgqhzzYOazt-UWaMbCfww@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] nvmem: fix memory leak in error path
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 20 lut 2020 o 12:30 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 20/02/2020 10:01, Bartosz Golaszewski wrote:
> > -     if (IS_ERR(nvmem->wp_gpio))
> > +     if (IS_ERR(nvmem->wp_gpio)) {
> > +             ida_simple_remove(&nvmem_ida, nvmem->id);
> > +             kfree(nvmem);
> >               return ERR_CAST(nvmem->wp_gpio);
> You freed nvmem just before this statement, how can nvmem->wp_gpio be
> still be valid?
>
> Are you able to test this changes at your end?
> Or
> these are just compile tested?
>

Sorry this was rushed, I will have access to the HW for testing tomorrow.

Bartosz
