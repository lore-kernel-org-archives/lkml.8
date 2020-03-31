Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A324C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FE72072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgCaBUN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 21:20:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37023 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgCaBUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 21:20:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so23183521edb.4;
        Mon, 30 Mar 2020 18:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9hBBEmJ746Eja0cO/shZ186afqjaJSCi9MEEkLweXE=;
        b=WRDlccWih2ov3mW94XfTb6duB01V75hG87rBFdEDkz3MwVyjlH21XKxTfXy2+g0LsA
         phjPnlSrGOc5BT8Of0HRgFPrgnLJa/XUxmdHhIFREL5k51GDz03w2hkBFNm5qjfI/JJN
         n5Z2PI0CsuEnho3ux2aouq7nXT1J/+QNG3fa/ihJ7hJ/yWtzsNDFZPgYAqIkdktjRm4f
         UxJOJ188O5mk5zJfsgYLsgsz9ZRZNNrF2h0QUOwKmYaU4055a5prWlShO3CcWNN8w97M
         bXGkCcRiTq32AVP1qNIgb1RFfpUkeOuibI0qjcoLO4iJKbxCfg6L1Y+m6+QFVD81yIEG
         XxZg==
X-Gm-Message-State: ANhLgQ2I9HkRegt+5Ucim3IOc4usMXecHL6ruD9R3hfYcTMm6JLTfK0k
        Pxug63PdBM39raOznUX5sd7XiDmynuc=
X-Google-Smtp-Source: ADFU+vsOIKKmxQOHGDz6lwTtL79wP9RpIJxaOrstbql6+u4z3Xsb2/tC76L/HK8YCm/yzldPlYwMIw==
X-Received: by 2002:a05:6402:1d90:: with SMTP id dk16mr13923758edb.95.1585617611013;
        Mon, 30 Mar 2020 18:20:11 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a21sm2103871edr.22.2020.03.30.18.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 18:20:10 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id c187so781088wme.1;
        Mon, 30 Mar 2020 18:20:10 -0700 (PDT)
X-Received: by 2002:a1c:988d:: with SMTP id a135mr899820wme.16.1585617610031;
 Mon, 30 Mar 2020 18:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200325205924.30736-1-ynezz@true.cz> <20200330175347.r4uam7cybvuxlgog@gilmour.lan>
In-Reply-To: <20200330175347.r4uam7cybvuxlgog@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 31 Mar 2020 09:19:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v66+oT=qfu7oHTs3d_e2hd_8Fc_0ULhHRfMLmrdcfOoe=A@mail.gmail.com>
Message-ID: <CAGb2v66+oT=qfu7oHTs3d_e2hd_8Fc_0ULhHRfMLmrdcfOoe=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: olinuxino: add user red LED
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 1:53 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Mar 25, 2020 at 09:59:24PM +0100, Petr Štetiar wrote:
> > There is a red LED marked as `GPIO_LED1` on the silkscreen and connected
> > to PE17 by default. So lets add this missing bit in the current hardware
> > description.
> >
> > Signed-off-by: Petr Štetiar <ynezz@true.cz>
>
> QUeued for 5.8, thanks!

The gpio-led binding seems to prefer "led-0" up to "led-f" (^led-[0-9a-f])
as the child node name. This was recently brought to my attention. Do we
want to follow suit here?

ChenYu
