Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555ACC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ECF20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N6mHiyV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgANPGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:06:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35286 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:06:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so12717969qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hG/77GxvunOSI8YW5THsJSlnBGvFxXbdDmptWBr5SD0=;
        b=N6mHiyV6eoZw07syH/QFAGLQCob29tWC3bWYJntBg7Fwk4caieH6rUR5uik11ISsC8
         JE8M6Y1hmnFKDooA5iGz5t52+Czb03pUToS+duHyS/suRwYBNnC3uIWUYI8oM3f/r/6k
         s27UD7W/41Ci/W8OPhVObyStVWxeyJoBvtvPiQroko53bu3AvYeYGjC9FbS546NE8/hM
         M1chhPRqXQY6PRZuWrhIEWnTULFi05hn5TAxOSvTgPPFIvpd7zxqWg23QUb3j8hDD37V
         tCaxJmBg+Qb5B9JzG46etyRkvEgyVravi7Hr3/dVOetD/tnkMCVo1LlQ20vPE/Xd7W5U
         qdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hG/77GxvunOSI8YW5THsJSlnBGvFxXbdDmptWBr5SD0=;
        b=nYeFl1eBLImyNIj6aWZj5nUSf5TgK17JP7MLAwVvKXe2l52YHb0RMJji8bHCv+/h6a
         fdLSa89WGPIS4zxZb9DA99FXDpB4glBmTXyS1bpqjbgHD569l40YQtD5HPou/AcnoOUt
         9e9j5os5vYeZzfjQgNIO2yjWBHIsevgFIfDPCG2NcMJJb0kF9H8Azw7qfhseVIPhab1m
         MmxQ7ZVVt/qii7EYkoTD4MGIJcc7rJopf1UI1ShySCHMnKf5CVO7LW+QNjvUwx7LgEeN
         9+j2lsly9FcIjKjg46EHhDS95KgGWtt46FqAA2ab6Fljm6A6Wtg4nw/7yRkHO4s1qmHc
         o+9A==
X-Gm-Message-State: APjAAAXOJKCRQzWxkjUbZ2Lz8WKzexYylbRWQsrwASZH4+ZXwvWRSEtn
        MteknBpVPTo7joSbm2xEU/CO4pGR0D+lKYnHNCQAJw==
X-Google-Smtp-Source: APXvYqyf/27+jnNcvaqjSCP+utuwjxx/iZBpThAVSG3EWNIUHVsrc1r3oe+sZn1Tl911eWYzrDbqSIAajn/zP9bjvqs=
X-Received: by 2002:ac8:3703:: with SMTP id o3mr3962163qtb.208.1579014368945;
 Tue, 14 Jan 2020 07:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20200107092922.18408-1-ktouil@baylibre.com> <20200107092922.18408-5-ktouil@baylibre.com>
 <20200108205447.GA16981@bogus> <CAMpxmJXffr-S51udNmUyMHz687jAoBKrYspNypfUUqjOD45zxQ@mail.gmail.com>
 <20200114144214.GA1898224@kroah.com>
In-Reply-To: <20200114144214.GA1898224@kroah.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 14 Jan 2020 16:05:57 +0100
Message-ID: <CAMpxmJW8edEZw81iQkwDr-Umdb1ibb85s=EshQs4yXRFh5LP=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        baylibre-upstreaming@groups.io,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 14 sty 2020 o 15:42 Greg KH <gregkh@linuxfoundation.org> napisa=C5=82(=
a):
>
> On Thu, Jan 09, 2020 at 10:47:56AM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 8 sty 2020 o 21:54 Rob Herring <robh@kernel.org> napisa=C5=82=
(a):
> > >
> > > On Tue,  7 Jan 2020 10:29:21 +0100, Khouloud Touil wrote:
> > > > As the at25 uses the NVMEM subsystem, and the property is now being
> > > > handled, adding reference for it in the device tree binding documen=
t,
> > > > which allows to specify the GPIO line to which the write-protect pi=
n
> > > > is connected.
> > > >
> > > > Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Hi Greg,
> >
> > AT25 patches usually go through the char-misc tree. In this case
> > however, the change depends on the other patches in this series. Can
> > you ack this and I'll take it through the AT24 tree exceptionally?
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch applied with Greg's Ack.

Bart
