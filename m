Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8A0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF4C20738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598109528;
	bh=qLFyfzV8A4SmcuXtDf8CYWnpoQBFNQx5tPFWbwMa0Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FXXnGbZuA3Pen0DtwpVZMH4LbKDnBP8lDIJ8VNoViDtDqrrPanNppIH09h93ZjVWz
	 WIF52MxORKOSTX6QnIeyUdp0Ylnap/JBZG2F0XwRiS1I6tFM40Mfmee0qmjqx/cLwl
	 h8hE21jGIhV0s1LzROiySVzgCZWN3ZKu4C/YgNPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgHVPSr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:18:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHVPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:18:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id a5so4567744wrm.6;
        Sat, 22 Aug 2020 08:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fPurPcq4qIlsFmVZToY8qZyZV/HXm+35zPSjztTMBbk=;
        b=RnHBy8FoT6Z6vtdD4wKfJaNHSVPsg4CvGvsOy/FAascPpMTGFY438NYgVrT+clquCY
         5zKgykQGAXd3WLMcDv7b1Zp8KxvuF3PjAvgEnjF/q+WQLatvdJvPDmlFimLpQRDBz4Pg
         03zomDg/gzdAFQtdFz8nkRQpaRYUIBXwipjXjQeTgy3lx5s9mpyCjTi4dpiFlF/H3+Q2
         ZB7FeFnsFVkMG0f1UZJy4lJjjKDVSVq6qc8juoyfiz0P/wCzZ9pIyR2EocrmEvYFSGEY
         RVjZWdmW1uyh98Vj4C4cHGrgSjbx+ZYsSiFb4rfZNdrGYSzLkSSGBd5HBb8wYHhBAVES
         uqPw==
X-Gm-Message-State: AOAM532T1qkDrwy7WF7qxKlxDF5r5xu4gTNrpPgTxb522aW1o15+gHFT
        6ZbymATerxUhDdTuSkEHjcg=
X-Google-Smtp-Source: ABdhPJxopqANZ1WSRtMZknMlZMkWKProljOBBBQjtUznRcRFTqGL5IEt7HEGpC7njulqLAHazh5Wgg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr7477185wrs.368.1598109523037;
        Sat, 22 Aug 2020 08:18:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m16sm10738841wrr.71.2020.08.22.08.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:18:42 -0700 (PDT)
Date:   Sat, 22 Aug 2020 17:18:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Message-ID: <20200822151819.GA13668@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
 <20200821161401.11307-8-l.stelmach@samsung.com>
 <20200822124325.GF20423@kozik-lap>
 <CAAFQd5CmPXDsOWmPBS+z5McxGvn+L2nkV2Wh934Bq7xY6DMO4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAFQd5CmPXDsOWmPBS+z5McxGvn+L2nkV2Wh934Bq7xY6DMO4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 04:52:40PM +0200, Tomasz Figa wrote:
> On Sat, Aug 22, 2020 at 2:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, Łukasz Stelmach wrote:
> > > cur_speed is used to calculate transfer timeout and needs to be
> > > set to the actual value of (half) the clock speed for precise
> > > calculations.
> >
> > If you need this only for timeout calculation just divide it in
> > s3c64xx_wait_for_dma().
> 
> Division is not the point of the patch. The point is that
> clk_set_rate() that was originally there doesn't guarantee that the
> rate is set exactly.

Unfortunately onlt that point of timeout is mentioned in commit msg. If
the correction of timeout was not the point of the patch, then describe
the real point...

> The rate directly determines the SPI transfer
> speed and thus the driver needs to use the rate that was actually set
> for further calculations.

Yep, makes sense.

> 
> > Otherwise why only if (cmu) case is updated?
> 
> Right, the !cmu case actually suffers from the same problem. The code
> divides the parent clock rate with the requested speed to obtain the
> divider to program into the register. This is subject to integer
> rounding, so (parent / (parent / speed)) doesn't always equal (speed).

It is not only this problem. The meaning of cur_speed is now changed.
For !cmu_case this the requested in trasnfer SPI bus clock frequency,
for cmu_case this is now real src_clk frequency. It's getting slightly
messier.

> 
> >
> > You are also affecting here not only timeout but
> > s3c64xx_enable_datapath() which is not mentioned in commit log. In other
> > words, this looks wrong.
> 
> Actually this is right and fixes one more problem, which I didn't spot
> when looking at this code when I suggested the change (I only spotted
> the effects on timeout calculation). The rounding error might have
> caused wrong configuration there, because e.g. 30000000 Hz could be
> requested and rounded to 28000000 Hz. The former is a threshold for
> setting the S3C64XX_SPI_CH_HS_EN bit, but the real frequency wouldn't
> actually require setting it.

Wrong is here describing one thing and doing much more.

Best regards,
Krzysztof

