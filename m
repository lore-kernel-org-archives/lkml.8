Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09173C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C9F2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rvIHSw7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgG0Rz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgG0Rz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:55:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B3C061794;
        Mon, 27 Jul 2020 10:55:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so2024531edy.0;
        Mon, 27 Jul 2020 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfQsl2VkPzgMjJHaARqwNqUbw1qIxknvRprBs1qxAqw=;
        b=rvIHSw7X95GJr0+XCFfmmero5cD0/utExmJuKYz5Qs91sBvJXMlcCDzKQXK2BYAF0q
         AOyqJaZngQWr9wfISZQjGxz7+meMd/1D7iHIkUQofP/eBvXJf6CUZyBQGBZBgRfC6trk
         i9V1whbAYAhLMZ1Ng8LBUYQyNA/ltTX7xk7PRr1gOsJQE7fPjvrOOFpVSMbkdKEEGlPd
         xIdBRhbyQRReLzRwZ9apKo1+tqI81oY9UNdZe2783fIH1PaB3ImM/EoqUJ9I2Gjtb1DL
         aZ7sqkAYV32yhov8ktBIyeVgaGarSpP8xTcJTPyK+iDceCdsXg9JT/G41ThxH4puV+mT
         9jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfQsl2VkPzgMjJHaARqwNqUbw1qIxknvRprBs1qxAqw=;
        b=qUAcUwjRsMi+656tO/+nwplMOtyceqfV0O4dcswWJo/RYyNH7Z+7JAdIGy3YxGYKfe
         rlg0YKaGrcOcgANRA8eGvcHdBwgTlzz+Gk8MBNzdoR+fRhhgVD1KJGoISktgoncRH7+J
         uAeVzotOlod9rF8ZbA0P9dXFIWv239YZGud9a03SN2HAlIppUiZ3eqw0vQsaGyxfx91p
         0GpYeu1jOv3Oixm/OdsK2R8mmpvkcX2uBlVqTk9q9p45a7Dh113/1TAI1SzJLnxvzu2o
         rMy3bsW1NevIJYhoGDrzXwXc31SFwNbdG2qExZ/0Kww9kszF1t7aP2TU4ty2v/kxdG9Z
         YA5Q==
X-Gm-Message-State: AOAM533jdzm8dIztfRpxT9Eul51/wcIINY0qxRSgXZUzGhQV/94d6l2E
        LREdDs1dqGwpq/BjpIHXoSdPZmSZCYh70qU4Qh8=
X-Google-Smtp-Source: ABdhPJwOE9lGhBvTtOQCpdnEA2roxCZkipXvXyeHn714NvtvMLoTIv9wK2fKfq+w2poL81YL7Lc+OfvmhPCaxPbx1SQ=
X-Received: by 2002:aa7:c788:: with SMTP id n8mr2559169eds.146.1595872555514;
 Mon, 27 Jul 2020 10:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200727092346.19780-1-amelie.delaunay@st.com> <20200727092346.19780-3-amelie.delaunay@st.com>
In-Reply-To: <20200727092346.19780-3-amelie.delaunay@st.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jul 2020 19:55:44 +0200
Message-ID: <CAFBinCBDtuJ19_WZe1H+_BJTJAi=jENyczybPhC1AGYwedNHcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] usb: dwc2: override PHY input signals with usb
 role switch support
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

On Mon, Jul 27, 2020 at 11:23 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
>
> This patch adds support for usb role switch to dwc2, by using overriding
> control of the PHY voltage valid and ID input signals.
>
> iddig signal (ID) can be overridden:
> - when setting GUSBCFG_FORCEHOSTMODE, iddig input pin is overridden with 1;
> - when setting GUSBCFG_FORCEDEVMODE, iddig input pin is overridden with 0.
>
> avalid/bvalid/vbusvalid signals can be overridden respectively with:
> - GOTGCTL_AVALOEN + GOTGCTL_AVALOVAL
> - GOTGCTL_BVALOEN + GOTGCTL_BVALOVAL
> - GOTGCTL_VBVALEN + GOTGCTL_VBVALOVAL
>
> It is possible to determine valid sessions thanks to usb role switch:
> - if USB_ROLE_NONE then !avalid && !bvalid && !vbusvalid
> - if USB_ROLE_DEVICE then !avalid && bvalid && vbusvalid
> - if USB_ROLE_HOST then avalid && !bvalid && vbusvalid
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
please add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The usb_role_switch part looks correct to me
I don't understand the details of the dwc2 hardware well enough to say
if the rest of this patch is fine or not (which is why I'm giving my
Acked-by instead of Reviewed-by).

Unfortunately I'm still fighting with the Amlogic bits (or my
board...) to make this work on my boards.
That why I can't give my Tested-by yet
At the same time I'm confident that the problem lies within the
Amlogic OTG detection/GPIOs so I don't see a reason to hold your patch
up due to this

Finally, please note that there may be a small conflict due to one
bugfix I sent: [0]
I think it will be trivial to solve (since we're both adding a new error label)


Thank you for your good work again!
Best regards,
Martin


[0] https://patchwork.kernel.org/patch/11687357/
