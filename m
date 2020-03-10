Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3035C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFD42464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="lLFhSEWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCJOGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:06:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44106 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCJOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:06:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so14236673ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AdYg6WPnW9nkA89dG9goaT7uA2jUoyPdqfmcB/nhqQs=;
        b=lLFhSEWR+HU7ja9NF1SEaIRPUkuSq/q1KpKKxGDNWKy55S/lnFDty2Y3vaDEA6bUMP
         FyXDWceMhkDPrQSTkWja+orj9SvX0zfeE/567tCDjxicaVxAdDGKNRzcVgKn3NvVlCG3
         X/L9WBy5rgzTpkf1Knb1y5HyapKdcaTJKkkBSzNSUX3xwvJLG2mNoiDb8uHU3hLSF0cL
         7IIk2Epu5dHnBS1eEGsb8klWcF2FY7CXzMBcbnvPZz0j8WdpjSmj0dJmU/GKfr3sR+R8
         WuF4qX1nAb274Uix7x0W8w2Fsnr5ZitIACdph3zZ0SP3gtpN/DjYgtgMON1uAQyn7Jln
         hM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AdYg6WPnW9nkA89dG9goaT7uA2jUoyPdqfmcB/nhqQs=;
        b=okyFC1HsgA0hrTS1/MZp7XQTfd+762TVhy8YAcJ8vXtGRLwuUzrG8gDR7xo091NIq+
         cSn00uDjbQjkfDoXy8wCKlXWxikc3G4USy6pN8b/E2mqKMdgxkC2cOOn1XiOaNp7CsHS
         VTaDSumDDaoqJ3WtRV+Kjx1eJv04wlCTvM5sI59ErzQ9EZAaPGy3Yubo1BUJGE4OGlBN
         SUmGgFfhWwEHMrW0PaYxnmhmkVyIKhMQEH8bpaiOSIXAGutjPHDgq+bP+tAIo08uCyZr
         eGFC1HPeNh4xf4HlcnF6YtDfupxoRsBwOHQxCisDA9A6y3wEfAeo0pLb4bEYWrQtc+18
         SeLg==
X-Gm-Message-State: ANhLgQ1H+ShrfOu5uw50K70mFVDRNvlbghevg0UDmO4hxWyHdgqGYrN0
        wP7XRCcPEYR/5Li/MHxd4S/ecg==
X-Google-Smtp-Source: ADFU+vvn0FGMBKT7TgxoHvOiEt5+FcYaiJQSifYAr/xnXwoMX2oHjrURwCPMNdIqkGYybfS2enhxoA==
X-Received: by 2002:a05:651c:1056:: with SMTP id x22mr9778959ljm.91.1583849186402;
        Tue, 10 Mar 2020 07:06:26 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id q15sm477148lfb.26.2020.03.10.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:06:25 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:06:25 +0100
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v2 2/3] media: rcar-vin: Add support for
 MEDIA_BUS_FMT_SRGGB8_1X8 format
Message-ID: <20200310140625.GA88560@oden.dyn.berto.se>
References: <1583838364-12932-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1583838364-12932-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200310124605.GO2975348@oden.dyn.berto.se>
 <OSBPR01MB35905FFB621C2F4222692832AAFF0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB35905FFB621C2F4222692832AAFF0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

On 2020-03-10 13:42:20 +0000, Prabhakar Mahadev Lad wrote:
> Hi Niklas,
> 
> Thank for the review.
> 
> > -----Original Message-----
> > From: Niklas <niklas.soderlund@ragnatech.se>
> > Sent: 10 March 2020 12:46
> > To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; linux-
> > media@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Lad Prabhakar <prabhakar.csengg@gmail.com>
> > Subject: Re: [PATCH v2 2/3] media: rcar-vin: Add support for
> > MEDIA_BUS_FMT_SRGGB8_1X8 format
> >
> > Hi Lad,
> >
> > Thanks for your work.
> >
> > On 2020-03-10 11:06:03 +0000, Lad Prabhakar wrote:
> > > Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format in rcar-vin by
> > setting
> > > format type to RAW8 in VNMC register and appropriately setting the
> > > bpp, bytesperline to enable V4L2_PIX_FMT_SRGGB8.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/media/platform/rcar-vin/rcar-core.c |  1 +
> > > drivers/media/platform/rcar-vin/rcar-dma.c  |  9 ++++++++-
> > > drivers/media/platform/rcar-vin/rcar-v4l2.c | 13 ++++++++++++-
> > >  3 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/rcar-vin/rcar-core.c
> > > b/drivers/media/platform/rcar-vin/rcar-core.c
> > > index 7440c89..76daf2f 100644
> > > --- a/drivers/media/platform/rcar-vin/rcar-core.c
> > > +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> > > @@ -469,6 +469,7 @@ static int rvin_parallel_subdevice_attach(struct
> > rvin_dev *vin,
> > >  case MEDIA_BUS_FMT_UYVY8_2X8:
> > >  case MEDIA_BUS_FMT_UYVY10_2X10:
> > >  case MEDIA_BUS_FMT_RGB888_1X24:
> > > +case MEDIA_BUS_FMT_SRGGB8_1X8:
> > >  vin->mbus_code = code.code;
> > >  vin_dbg(vin, "Found media bus format for %s: %d\n",
> > >  subdev->name, vin->mbus_code);
> > > diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c
> > > b/drivers/media/platform/rcar-vin/rcar-dma.c
> > > index 1a30cd0..1c1fafa 100644
> > > --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> > > +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> > > @@ -85,6 +85,7 @@
> > >  #define VNMC_INF_YUV8_BT601(1 << 16)
> > >  #define VNMC_INF_YUV10_BT656(2 << 16)
> > >  #define VNMC_INF_YUV10_BT601(3 << 16)
> > > +#define VNMC_INF_RAW8(4 << 16)
> > >  #define VNMC_INF_YUV16(5 << 16)
> > >  #define VNMC_INF_RGB888(6 << 16)
> > >  #define VNMC_VUP(1 << 10)
> > > @@ -587,7 +588,6 @@ void rvin_crop_scale_comp(struct rvin_dev *vin)
> > >  rvin_write(vin, vin->crop.top, VNSLPRC_REG);
> > >  rvin_write(vin, vin->crop.top + vin->crop.height - 1, VNELPRC_REG);
> > >
> > > -
> > >  /* TODO: Add support for the UDS scaler. */
> > >  if (vin->info->model != RCAR_GEN3)
> > >  rvin_crop_scale_comp_gen2(vin);
> > > @@ -676,6 +676,9 @@ static int rvin_setup(struct rvin_dev *vin)
> > >
> > >  input_is_yuv = true;
> > >  break;
> > > +case MEDIA_BUS_FMT_SRGGB8_1X8:
> > > +vnmc |= VNMC_INF_RAW8;
> > > +break;
> > >  default:
> > >  break;
> > >  }
> > > @@ -737,6 +740,9 @@ static int rvin_setup(struct rvin_dev *vin)
> > >  case V4L2_PIX_FMT_ABGR32:
> > >  dmr = VNDMR_A8BIT(vin->alpha) | VNDMR_EXRGB |
> > VNDMR_DTMD_ARGB;
> > >  break;
> > > +case V4L2_PIX_FMT_SRGGB8:
> > > +dmr = 0;
> > > +break;
> > >  default:
> > >  vin_err(vin, "Invalid pixelformat (0x%x)\n",
> > >  vin->format.pixelformat);
> > > @@ -1110,6 +1116,7 @@ static int rvin_mc_validate_format(struct
> > rvin_dev *vin, struct v4l2_subdev *sd,
> > >  case MEDIA_BUS_FMT_UYVY8_2X8:
> > >  case MEDIA_BUS_FMT_UYVY10_2X10:
> > >  case MEDIA_BUS_FMT_RGB888_1X24:
> > > +case MEDIA_BUS_FMT_SRGGB8_1X8:
> > >  vin->mbus_code = fmt.format.code;
> > >  break;
> > >  default:
> > > diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> > > b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> > > index 5151a3c..4698099 100644
> > > --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> > > +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> > > @@ -66,6 +66,10 @@ static const struct rvin_video_format rvin_formats[]
> > = {
> > >  .fourcc= V4L2_PIX_FMT_ABGR32,
> > >  .bpp= 4,
> > >  },
> > > +{
> > > +.fourcc= V4L2_PIX_FMT_SRGGB8,
> > > +.bpp= 2,
> >
> > This does not look right, is not bytes-per-pixel 1 for a SRGGB8?
> >
> I guessed the bpp's were picked from VnIS table as I result I did the same.
> 
> > > +},
> > >  };
> > >
> > >  const struct rvin_video_format *rvin_format_from_pixel(struct
> > > rvin_dev *vin, @@ -102,6 +106,7 @@ static u32
> > > rvin_format_bytesperline(struct rvin_dev *vin,  {
> > >  const struct rvin_video_format *fmt;
> > >  u32 align;
> > > +u8 div;
> > >
> > >  fmt = rvin_format_from_pixel(vin, pix->pixelformat);
> > >
> > > @@ -112,16 +117,22 @@ static u32 rvin_format_bytesperline(struct
> > rvin_dev *vin,
> > >  case V4L2_PIX_FMT_NV12:
> > >  case V4L2_PIX_FMT_NV16:
> > >  align = 0x20;
> > > +div = 1;
> > > +break;
> > > +case V4L2_PIX_FMT_SRGGB8:
> > > +align = 0x10;
> > > +div = 2;
> >
> > Yes this does not look right at all, I think you should set bpp to 1 and drop the
> > div handling here.
> >
> If I set bpp as 1 and drop the div VNIS_REG will be wrongly configured in
> rvin_crop_scale_comp() and the image captured will be wrong.
> 
> For example for 640x480:
> 
> With the current patch bpp = 2:
> bytesperline = 640

This is wrong, if we have a line of 640 pixels and 2 bytes per pixel 
then bytesperline must be at least 1280 bytes right?

> image size = 307200
> stride = 320

But this is incorrect, the VNIS_REG shall be at least the number of 
pixels in a line (EPPrC - SPPrC -> 640 - 0 = 640). Then we need to align 
it to the pixel unit (16, 32, 64, 128) depending on the output pixel 
format.

This usually result in a stride that is larger then the line length.  
Thus you need a test application that knows the difference between width 
* bpp and bytesperline. I use qv4l2 without opengl support when I do quick 
tests and it does not support this hence I get a incorrect visual view 
of the stream when testing.

How does the image capture fail with bpp = 1?

> 
> And with bpp = 1 and div removed
> bytesperline = 640
> image size = 307200
> stride = 640


> 
> Cheers,
> --Prabhakar
> 
> > >  break;
> > >  default:
> > >  align = 0x10;
> > > +div = 1;
> > >  break;
> > >  }
> > >
> > >  if (V4L2_FIELD_IS_SEQUENTIAL(pix->field))
> > >  align = 0x80;
> > >
> > > -return ALIGN(pix->width, align) * fmt->bpp;
> > > +return ALIGN(pix->width / div, align) * fmt->bpp;
> > >  }
> > >
> > >  static u32 rvin_format_sizeimage(struct v4l2_pix_format *pix)
> > > --
> > > 2.7.4
> > >
> >
> > --
> > Regards,
> > Niklas Söderlund
> 
> 
> Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647

-- 
Regards,
Niklas Söderlund
