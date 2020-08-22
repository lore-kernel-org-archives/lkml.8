Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C3C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD08720738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GqRC2h7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHVPUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHVPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:20:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DDC061755
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 08:20:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so6033903ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LN5JFqdEmJKSQD9LQroiOhG0/S7s6+UdrWun1PeHIeU=;
        b=GqRC2h7ZpP/gqzffABDnoB7CwyD+X7HNnxeNruuV8wiICFNZI6sVKjwF16rr3BwbGv
         EAmTCNLmcNCLY2+DmUhCTPgb/Xx1jS0xFIxgCQftI5TVWVOFyLt12b9cKsY5uvkqX8e4
         AkPUumv0jeqjqk/zyjjYDLED1HLlTfJAG7MDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LN5JFqdEmJKSQD9LQroiOhG0/S7s6+UdrWun1PeHIeU=;
        b=pZt4+YtfBQJv18kkSG20ujCVuWAN3ove4TdTllZbsgU5+Y+N+jtMq3QUYPr7qZeDw8
         n7/ct8U0cZNOL+Q1M70sLd8ntQ2f5H7q7OSCYMmtYsmolbWP939qMzXs7jixAbC8W3Xw
         3shCh3FWmZVjC7LWv7EslEzbs+xu0dkXpNQnW+pVYW4qJ7ioKO7BFf6nA/D18F/Cgt4w
         bhigGjRU22jLY1GEprC+0B8dJuCFEzkScF+3LAgu48tHA9fT9TkNO02pBIDVobc1bNPl
         dyoMCoq0iD2IQC6r5GqpSTsUhjSb6byUG05yL+mDSpquhrp9PGeY88nDlI8zkCPBhSxK
         +aAA==
X-Gm-Message-State: AOAM533eICUr1drl3LruJ7S3gXAPJyJimbT3xPMHvxsZcXMNk5FmsUNa
        jjJEGRCS5KKDFfSTKnFfVNnXfbNtT49vdg==
X-Google-Smtp-Source: ABdhPJxxShW98XkAQk2zX74m8uyE/KPY7345gq3dtNxbOdQAxWM5NE6vc+IK2/sRmB/b+5OdASfDQQ==
X-Received: by 2002:a17:906:6bc9:: with SMTP id t9mr7517672ejs.372.1598109629390;
        Sat, 22 Aug 2020 08:20:29 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id ar2sm3481368ejc.61.2020.08.22.08.20.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 08:20:28 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id r2so4553159wrs.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 08:20:28 -0700 (PDT)
X-Received: by 2002:a5d:6744:: with SMTP id l4mr7993640wrw.105.1598109628053;
 Sat, 22 Aug 2020 08:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
 <20200821161401.11307-8-l.stelmach@samsung.com> <20200822124325.GF20423@kozik-lap>
 <CAAFQd5CmPXDsOWmPBS+z5McxGvn+L2nkV2Wh934Bq7xY6DMO4A@mail.gmail.com> <20200822151819.GA13668@kozik-lap>
In-Reply-To: <20200822151819.GA13668@kozik-lap>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 22 Aug 2020 17:20:16 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BZYkrJc7CB6aYU5F78wZhRmzVexRbk1siK4Xs7sjgNLQ@mail.gmail.com>
Message-ID: <CAAFQd5BZYkrJc7CB6aYU5F78wZhRmzVexRbk1siK4Xs7sjgNLQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 5:18 PM Krzysztof Kozlowski <krzk@kernel.org> wrote=
:
>
> On Sat, Aug 22, 2020 at 04:52:40PM +0200, Tomasz Figa wrote:
> > On Sat, Aug 22, 2020 at 2:43 PM Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> > >
> > > On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrote:
> > > > cur_speed is used to calculate transfer timeout and needs to be
> > > > set to the actual value of (half) the clock speed for precise
> > > > calculations.
> > >
> > > If you need this only for timeout calculation just divide it in
> > > s3c64xx_wait_for_dma().
> >
> > Division is not the point of the patch. The point is that
> > clk_set_rate() that was originally there doesn't guarantee that the
> > rate is set exactly.
>
> Unfortunately onlt that point of timeout is mentioned in commit msg. If
> the correction of timeout was not the point of the patch, then describe
> the real point...
>
> > The rate directly determines the SPI transfer
> > speed and thus the driver needs to use the rate that was actually set
> > for further calculations.
>
> Yep, makes sense.
>
> >
> > > Otherwise why only if (cmu) case is updated?
> >
> > Right, the !cmu case actually suffers from the same problem. The code
> > divides the parent clock rate with the requested speed to obtain the
> > divider to program into the register. This is subject to integer
> > rounding, so (parent / (parent / speed)) doesn't always equal (speed).
>
> It is not only this problem. The meaning of cur_speed is now changed.
> For !cmu_case this the requested in trasnfer SPI bus clock frequency,
> for cmu_case this is now real src_clk frequency. It's getting slightly
> messier.
>
> >
> > >
> > > You are also affecting here not only timeout but
> > > s3c64xx_enable_datapath() which is not mentioned in commit log. In ot=
her
> > > words, this looks wrong.
> >
> > Actually this is right and fixes one more problem, which I didn't spot
> > when looking at this code when I suggested the change (I only spotted
> > the effects on timeout calculation). The rounding error might have
> > caused wrong configuration there, because e.g. 30000000 Hz could be
> > requested and rounded to 28000000 Hz. The former is a threshold for
> > setting the S3C64XX_SPI_CH_HS_EN bit, but the real frequency wouldn't
> > actually require setting it.
>
> Wrong is here describing one thing and doing much more.

Yeah, agreed that the description could be improved. :)

Best regards,
Tomasz
