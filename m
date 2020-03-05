Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C87C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DE12072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/5hyzAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCENAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:00:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43614 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgCENAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:00:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so6633700edb.10;
        Thu, 05 Mar 2020 05:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXDnEFvB2iAVmGRZard1gFu0zVZjBsE2RNb9/Hp0TsA=;
        b=G/5hyzAbMHbqQnHl1QWTWbt+mzifeLeP1XGkjQAr61Pr5oy3XDEBMOqL1H/ePcY7Pl
         X+ajdkm4hUQ6Hrk3ALBHjhEXReckjVHq3CtWVF6/K1rpjc1Ryfa2xUdDrD8gnN8nDPhS
         ttnIx5QY4OPottNbDa/Uz1oaGql+wGGAB0zsJIOwopCTjKrm2hXbDTjxGTFuEPLPpA1Z
         PPhyytwyFlWN4Gf+JV4yqaktiF4XrHCRTulkSgOF7DGdR+7+jHorx9MIiQQLXcsTT9EK
         XTVHiR37JeaAkX+C4R9ZhtJ8we7tw2oO3jDMiQ3hVPrVC64Dr+/Isd7orxjADjuP/Kjs
         eMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXDnEFvB2iAVmGRZard1gFu0zVZjBsE2RNb9/Hp0TsA=;
        b=YPHr34JWa+8T7fgLMQPUgLY2S7vyj1TWmdonIf6cDCTwYoouw0KjmU9v9bB5DnVSiB
         J1FzjCTzjI54ZcByontl0Z5RGUpIiJ7NZCkbHLAIBe2aoeGPibtCypllL4r4B8tXJAsl
         4FVOVefZXxJ5+lywpgIT7hkdYHn5d1d0rLIe+VKP7Wg27pIrD1DIjt5kSTugaCIbMs8W
         vxnHc0OBM1JhmQqcmJoCz1YYPPVjWpl7RPPj7wbrJjVWZlC2IjrEUxolsXp9/30b+6fY
         yKGClOcHeQ66XchVRH5rMSC4usxm4ZYPzNuUNydSgmgspKmQ+eaiNNSMS+Q5a/ywQ1S0
         46RQ==
X-Gm-Message-State: ANhLgQ0O0vRpqVD0dBcY1NmatdU95daxSG5sPmOdTejiJoYDCShz4m7o
        gXBSrkKeBG1rtouLrWx3zdVGki7PnHQP2FTYe6M=
X-Google-Smtp-Source: ADFU+vu5MaL7SLqsKOoNjCNxk4suiDvPJcm8whexVvl+u7+QquE6NgPtsI2LKcsdonQuCb++VJp5BK1dwglfKD3OruA=
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr7499506ejj.184.1583413233770;
 Thu, 05 Mar 2020 05:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20200304220044.11193-1-olteanv@gmail.com> <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
In-Reply-To: <20200305121202.GB4046@sirena.org.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Thu, 5 Mar 2020 15:00:22 +0200
Message-ID: <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times as necessary
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Esben Haabendal <eha@deif.com>, angelo@sysam.it,
        andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 5 Mar 2020 at 14:12, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Mar 05, 2020 at 12:00:39AM +0200, Vladimir Oltean wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > When dealing with a SPI controller driver that is sending more than 1
> > byte at once (or the entire buffer at once), and the SPI peripheral
> > driver has requested timestamping for a byte in the middle of the
> > buffer, we find that spi_take_timestamp_pre never records a "pre"
> > timestamp.
>
> This is a fix and so should have been at the start of the series to make
> sure there aren't any dependencies.

My reasoning for not submitting it as a fix is:
- The only driver that uses the functionality so far - spi-fsl-dspi -
has worked thus far even with the limitation that only byte-by-byte
transfers were supported properly.
- I removed the limitation before actually changing the operating mode
of spi-fsl-dspi. Therefore the limitation is effectively never seen.
- New SPI drivers that would want to make use of software timestamping
would do so through your SPI for-next branch anyway, where the
limitation would be, again, fixed.

Thanks,
-Vladimir
