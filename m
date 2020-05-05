Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD12C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8CF20746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588649931;
	bh=WleWfKBPa+MkRl/FG3wti/YoY+kMD9A34Q+HR1DP3rQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mr7wvDlgdzA570MYqMB9fDrQv4BVQ3KyqHDahWYDHHiXvFaTZoMd16gJHS3pgxhOX
	 eVekg+79R5z+3qhk/BeVjyoqN9XYK8sWEu+7VHLmLr0cubuK6P9Gw49u5yQkWm36Og
	 7w9bG1cwILgqtfSEg5gXDCnf5Z4+KZ4FbIQzfN4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgEEDiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 23:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgEEDit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 23:38:49 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A85206C0;
        Tue,  5 May 2020 03:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588649928;
        bh=WleWfKBPa+MkRl/FG3wti/YoY+kMD9A34Q+HR1DP3rQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K5ON/HlTRAOgZfICZStefBx9lSbbPAA/K41KBb6cQhnqBrxIfWS7RgsgoLd6bRp+4
         es1t31rnYIc8wSXooFrN8rt79VrEE1IpY1XLMVTIFVQ12GUx8lwZ1abK3Am/jr0ury
         Nn6dtP0nMtx/Xa8qTkaFw2Xz15Rp+vdVKYrlf6fc=
Received: by mail-oi1-f180.google.com with SMTP id i13so653912oie.9;
        Mon, 04 May 2020 20:38:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuZBTWSIQYC9UVa7TzpcrqKtA0PPuM2Gclr6xCG9b1fLumxBMnvv
        uOKRh0ubUzO/dJiTYM9M1GPSXeZSGGrmjhBwnQ==
X-Google-Smtp-Source: APiQypJX/QBWcGSuKqJEYGbDCnCt9bfCz9J9QX5Sgmjocbi6uqgC3ZjAszhb1FEmMEDJgFCqouxVRe7nnk6bhzFmOxk=
X-Received: by 2002:a05:6808:356:: with SMTP id j22mr1180434oie.147.1588649928152;
 Mon, 04 May 2020 20:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 May 2020 22:38:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxKoe0rk_JT1KO38gAcgw6nLVqQM65urc_aOYjXEb55g@mail.gmail.com>
Message-ID: <CAL_JsqJxKoe0rk_JT1KO38gAcgw6nLVqQM65urc_aOYjXEb55g@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Convert some DT documentation files to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joe Perches <joe@perches.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andy Whitcroft <apw@canonical.com>, devicetree@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 9:45 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> While most of the devicetree stuff has its own format (with is now being
> converted to YAML format), some documents there are actually
> describing the DT concepts and how to contribute to it.
>
> IMHO, those documents would fit perfectly as part of the documentation
> body, as part of the firmare documents set.
>
> This patch series manually converts some DT documents that, on my
> opinion, would belong to it.
>
> If you want to see how this would show at the documentation body,
> a sneak peak of this series (together with the other pending
> doc patches from me) is available at:
>
>         https://www.infradead.org/~mchehab/kernel_docs/devicetree/index.html
>
> -
>
> v3:
>    - rebased on the top of next-20200414
>
> Mauro Carvalho Chehab (12):
>   docs: dt: add an index.rst file for devicetree
>   docs: dt: convert usage-model.txt to ReST
>   docs: dt: usage_model.rst: fix link for DT usage
>   docs: dt: convert booting-without-of.txt to ReST format
>   docs: dt: convert changesets to ReST
>   docs: dt: convert dynamic-resolution-notes.txt to ReST
>   docs: dt: convert of_unittest.txt to ReST
>   docs: dt: convert overlay-notes.txt to ReST format
>   docs: dt: minor adjustments at writing-schema.rst
>   docs: dt: convert ABI.txt to ReST format
>   docs: dt: convert submitting-patches.txt to ReST format
>   docs: dt: convert writing-bindings.txt to ReST

I've applied all but patch 4 as I'm working on just removing it.

Rob
