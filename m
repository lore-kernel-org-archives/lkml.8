Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8446EC433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF1220787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3j3mH3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgGPN7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgGPN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E2C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so7233859lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZC+VUIMSIdeiW4C+7bhtdxicqg0klJV1GCIZXtbGAA=;
        b=E3j3mH3r+XkBoto3dQuOfETz6ViU9Snkp2Koila0Uf+neOY8KxhS7M8s6meXWiWRn0
         rC5I583w3pAokCM95whNcx/gMkitc48zcX1BHKjGkc8/Q5gnu1l3s69VzIJBp1IPHfD2
         e3gIxZhPoKCtYb/zdidvFULdF1Ey509C5qVkRq5DnwhviNHwONZW/WeOlQPCV49rBobt
         r6OdGlqKMm8bHuVsVDaTNOunpXvtD+zkZU5b7sxSc3mgwDmYN0TlR66arJWX9kUq39ZY
         eN2ThecFcCanhZnsSwAG//+eDbzaVZRzCswiq4RI2kP4v+pxlUGr805zVOWDU3ZOlsN2
         hdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZC+VUIMSIdeiW4C+7bhtdxicqg0klJV1GCIZXtbGAA=;
        b=N3XXTCxsWkRydvyLh8fbwmY1x7oe7yJbT75Jl2JoM2z1A1uEaOuohVw4f32V6zlE5g
         RoplZvHyZ/z4BoOgAR+raRZ2bRK3c2hyhu3CS5vyv0azAJp1KlLenTqm+XiBSlFSGair
         HN5I4REFn3/BJ9GgIxDoRqgQdMhOwSiIGfDtus0mpoarugDFfjAqujZgkBvzySZBhFcA
         3WCyJS0g2NNswECU0+FzgjJibeuJio8uKbcbSl8GAd8NBG3NJpetY77FD9l/DszlA+x6
         GmKalTPD4/cIHF6vsuZ1lzXE3vXlEu70mWz1A2WW4uPomVDzqbzSH7yvWHHuIiX1N0MO
         3btA==
X-Gm-Message-State: AOAM532jL2BPvzDmBa86pucmwafezMxoPG3YvQrQYXNGjE0m5kRUT0hL
        fw3U5yqAVWjKpFlQYe/3E068BU6/7A2Xxs9UFJF5Ny79lhQ=
X-Google-Smtp-Source: ABdhPJyfBNW+iS3vmrvvdIc4uq6KgXCHDA3QojwI2tgqo1YiWXX74TEniRPfv5JC52n/VfPedlfGiJPMJ5384sP6Siw=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr1938808lji.338.1594907970394;
 Thu, 16 Jul 2020 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200715150632.409077-1-lee.jones@linaro.org> <20200715150632.409077-9-lee.jones@linaro.org>
In-Reply-To: <20200715150632.409077-9-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:59:19 +0200
Message-ID: <CACRpkdbFWy9wkMbegtL+nKG2RNvBADuxCxDRJTP8f0QGgUHZ3A@mail.gmail.com>
Subject: Re: [PATCH 08/14] spi: spi-pl022: Provide missing struct
 attribute/function param docs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sachin Verma <sachin.verma@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 5:06 PM Lee Jones <lee.jones@linaro.org> wrote:

> Also demote non-worthy kerneldoc headers to standard comment blocks.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/spi/spi-pl022.c:304: warning: cannot understand function prototype: 'enum ssp_writing '
>  drivers/spi/spi-pl022.c:330: warning: Function parameter or member 'loopback' not described in 'vendor_data'
>  drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'rx_lev_trig' not described in 'pl022'
>  drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'tx_lev_trig' not described in 'pl022'
>  drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'dma_running' not described in 'pl022'
>  drivers/spi/spi-pl022.c:670: warning: Function parameter or member 'pl022' not described in 'readwriter'
>  drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'irq' not described in 'pl022_interrupt_handler'
>  drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'dev_id' not described in 'pl022_interrupt_handler'
>  drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'pl022' not described in 'set_up_next_transfer'
>  drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'transfer' not described in 'set_up_next_transfer'
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sachin Verma <sachin.verma@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
