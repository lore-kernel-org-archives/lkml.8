Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA504C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB30320678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="INrGUnJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgHCM6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHCM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:58:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33052C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:58:35 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so17257812qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMT0kXz5t1WlxhKdWYf7H/xItPGzEq+A55WtZ2+D4/I=;
        b=INrGUnJrvvSk6e3+aV2VgzC0XESxwlRZvQcst2jXyBNpTkMHYyvuy8qp9Ut87dDQWG
         y+aqedwp4Taqrqv94K3l9BkpYCF37e6KB/6Oj4roXPBX8SbTKWxSI8eRRlakZfCABbHv
         /NoCR+7jDjWkKTqnC20Z+gEkUV89AAZsKMHcFOtfDeF0tEpSUhJlFUsw2q8dSaAaREX3
         47vNOLCuofipKCY2DWZCOqF4K0DvLXMi+9BwL5eGKp+QaX1hyD9Qn6SWcnMhv7vktN2F
         SINb5Jd0zS03FqG60FE3451vaoVPv23hkZ16Grbojnda2Tfl8EgZkyST1bijDHItC28p
         ydtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMT0kXz5t1WlxhKdWYf7H/xItPGzEq+A55WtZ2+D4/I=;
        b=akjok1NPKv/dP1klMD1K5NgDH2yVFg3O9dqwJ0ZC5r+/qc8HGlgBlECIQSH4UwPGk5
         llidx6+UQWr6Y+KIeBhhhuG/OGZz1Ebrj7idGmxQCJdjylL7I0JgrrDQP6O4fFGuL8up
         Wrd5jEvSls7vWSakt0qw4V16M0DLEDZzV6fcEDoEvaJKMzq3XtDFs4ySHlfE3uHPsYZb
         IWUZ2IDsm7FX+sHB8OKHJ1Ijfo1CbnXXb0GJ46t3lSqxScDK8Cq3nF6NKuaKOxYhZdV/
         pQwuPi28EE5F49xfkPpYDcbTTar0JJdNh0DeRqKdh9UrPlMUrL5eOgBSN/zq2/+jdG0d
         oiOw==
X-Gm-Message-State: AOAM531oGKE9aE21C4E5KwhTre622RMdJh3g8V3va7fWEor3hYntL54m
        24N15/X3mFjX+fBBoQA9d7V6ra/Ac3JKXo0RyeMltg==
X-Google-Smtp-Source: ABdhPJxZmIwMOwJq4SwiSkCoJapyo5gtyYk7zA5OkjK+cKoeY/k56q8q8XGjCBAM2maXoOOquYPzasZBhozkWerzxHU=
X-Received: by 2002:ad4:4cc9:: with SMTP id i9mr16260419qvz.131.1596459514234;
 Mon, 03 Aug 2020 05:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200803095720.GC1375436@lahna.fi.intel.com> <CAD2FfiFt6=OueX3E0g2ckPU+7F69yCmM0+bzF_6UD1sd4E_k_A@mail.gmail.com>
 <20200803102711.GK1375436@lahna.fi.intel.com>
In-Reply-To: <20200803102711.GK1375436@lahna.fi.intel.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Mon, 3 Aug 2020 09:58:23 -0300
Message-ID: <CAFmMkTHSjQZJNzvUzLHHJ7sUTVX4BV6TwB=P8EO-HNk_cv8RKg@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 7:27 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Aug 03, 2020 at 11:18:12AM +0100, Richard Hughes wrote:
> > On Mon, 3 Aug 2020 at 10:57, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > I think instead of this we should simply make it so that the driver
> > > never tries to make the chip writable.
> >
> > I think this is a good idea, but I wasn't sure if it was an acceptable
> > behaviour change. Should the driver still try to set BCR_WPD when
> > writing an image (i.e. defer the setting of write enable until later),
> > or just not set the BCR register at all? I think your last comment was
> > the latter, but wanted to check.
>
> I would say not set it at all. I think it was (my) mistake to set it in
> the first place.

Do you want me to remove the module parameter from intel-spi too and
do the same?



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
