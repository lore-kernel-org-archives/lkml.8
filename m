Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D522BED
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="ljMJAX83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHCSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:06:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00391C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:06:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x24so3627881lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XsPz3iEf4Px93YhzJ38W9UABpIfcoHCOlLCfsHf+Lzs=;
        b=ljMJAX83gCc0X2N5Z0RIM9JtZ9q1/0lwP8trAzzPOFJ0+8nsGltk93U6PNbf7FaQmK
         wFJyvvikg8SfkxhXpHrTbdwYohZifdh0sjih4SRpCvQ54RbVix1fwhz6nprPnVtCmDeA
         a9BIgOq+v3g49XHPG2c/Iciixhj5+Th9wKJq3mwUMdkwNtC6gbgbEoNmhiQvVy22wWFp
         He/9Pi08bjSeDJp4vMa2pXr6wvN4b+iFW5h5mVauzPt175tu8O2TYoqs0109hJlm7+rb
         xHhpnzDZuWbSYwnjLJxJrR6JQxGswHF7YdZA9xsKBR64CLG5snBaCpaYP+b6I7Ec6hUT
         e3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XsPz3iEf4Px93YhzJ38W9UABpIfcoHCOlLCfsHf+Lzs=;
        b=jByu7yz0AwAN7ovt6cNfCzgyc0rF528nHvZfRbvqwiHvAUT7KVJam7hjcj1WiXcq01
         N1FjqYo6JbkTS67Cr3UvlnUar9TLT27eU+lOoA54N0SZka2dyUD3vEt+SMFkh8LpnD9x
         4jvZ/V/3OuLa8TCVIhe9F/oMe+s8LBFasAmWrTcIDDmMOAUJnNkRbwIt3cBzdOjbAKxM
         Y4ual/c7jg1bxLdZbeqHmqqxVwCrq6FRycoJYGx9zM+BZt7qTwP90/TEnjY3pKAiPsQh
         VltkyySx0PUzE8pTAXSKsWrDwpbTVQRnHn5M7fATLDL0ApVXkJAAwGzPNnXv9bDodccf
         MAxg==
X-Gm-Message-State: AOAM533CvJPpSDIhtJapBQJ8f402oW1vi+IkCQPAr+nstlIeHGIVsXOg
        HBnhM1WhlJQndZhbTlCv9CJ7BQ==
X-Google-Smtp-Source: ABdhPJyfenh4WD3XB4hoP9Ho7H+Dol9qgR6jQLwyHNWNdEnN3KJgxMYdeS5/zbd2ma7zHwuZRS8GwQ==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr9020519lfo.105.1596477980225;
        Mon, 03 Aug 2020 11:06:20 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id h7sm2078021ljc.75.2020.08.03.11.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:06:19 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:06:18 +0200
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v2] media: rcar-vin: Add support to select data pins for
 YCbCr422-8bit input
Message-ID: <20200803180618.GA2297236@oden.dyn.berto.se>
References: <1596470573-15065-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596470573-15065-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-08-03 17:02:53 +0100, Lad Prabhakar wrote:
> Select the data pins for YCbCr422-8bit input format depending on
> bus_width and data_shift passed as part of DT.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> Changes for v2:
> * Dropped DT binding documentation patch
> * Select the data pins depending on bus-width and data-shift

I like this v2 much better then v1, nice work!

> 
> v1 -
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=323799
> ---
>  drivers/media/platform/rcar-vin/rcar-core.c | 5 +++++
>  drivers/media/platform/rcar-vin/rcar-dma.c  | 7 +++++++
>  drivers/media/platform/rcar-vin/rcar-vin.h  | 5 +++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
> index 7440c8965d27..55005d86928d 100644
> --- a/drivers/media/platform/rcar-vin/rcar-core.c
> +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> @@ -624,6 +624,11 @@ static int rvin_parallel_parse_v4l2(struct device *dev,
>  	vin->parallel = rvpe;
>  	vin->parallel->mbus_type = vep->bus_type;
>  
> +	/* select VInDATA[15:8] pins for YCbCr422-8bit format */
> +	if (vep->bus.parallel.bus_width == BUS_WIDTH_8 &&
> +	    vep->bus.parallel.data_shift == DATA_SHIFT_8)
> +		vin->parallel->ycbcr_8b_g = true;
> +

I would store the bus_width and bus_shift values in the struct 
rvin_parallel_entity and evaluate them in place rater then create a flag 
for this specific use-case..

Also according to the documentation is the check correct? Do we not wish 
to use the new mode when bus_width == 16 and bus_shift == 8. The check 
you have here seems to describe a 8 lane bus where 0 lanes are used.

I think you should also verify that bus_shift is either 0 or 8 as that 
is all the driver supports.

>  	switch (vin->parallel->mbus_type) {
>  	case V4L2_MBUS_PARALLEL:
>  		vin_dbg(vin, "Found PARALLEL media bus\n");
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index 1a30cd036371..5db483877d65 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -127,6 +127,8 @@
>  #define VNDMR2_FTEV		(1 << 17)
>  #define VNDMR2_VLV(n)		((n & 0xf) << 12)
>  
> +#define VNDMR2_YDS		BIT(22)

This should be grouped with the other VNDMR2_* macros and not on its 
own. Also it should be sorted so it should be inserted between 
VNDMR2_CES and VNDMR2_FTEV.

Also I know BIT() is a nice macro but the rest of the driver uses (1 << 
22), please do the same for this one.

> +
>  /* Video n CSI2 Interface Mode Register (Gen3) */
>  #define VNCSI_IFMD_DES1		(1 << 26)
>  #define VNCSI_IFMD_DES0		(1 << 25)
> @@ -698,6 +700,11 @@ static int rvin_setup(struct rvin_dev *vin)
>  		/* Data Enable Polarity Select */
>  		if (vin->parallel->mbus_flags & V4L2_MBUS_DATA_ENABLE_LOW)
>  			dmr2 |= VNDMR2_CES;
> +
> +		if (vin->parallel->ycbcr_8b_g && vin->mbus_code == MEDIA_BUS_FMT_UYVY8_2X8)
> +			dmr2 |= VNDMR2_YDS;
> +		else
> +			dmr2 &= ~VNDMR2_YDS;

dmr2 is already unitized and YDS is cleared, no need to clear it again 
if you don't wish to set it. Taking this and the comments above into 
account this would become something like (not tested),

    switch (vin->mbus_code) {
    case MEDIA_BUS_FMT_UYVY8_2X8:
        if (vin->parallel->bus_width == 16 && vin->parallel->bus_shift == 8)
            dmr2 |= VNDMR2_YDS;
        break;
    default:
        break;
    }

>  	}
>  
>  	/*
> diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
> index c19d077ce1cb..3126fee9a89b 100644
> --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> @@ -87,6 +87,9 @@ struct rvin_video_format {
>  	u8 bpp;
>  };
>  
> +#define BUS_WIDTH_8	8
> +#define DATA_SHIFT_8	8

As pointed out by Geert, not so useful, use 8 in the code :-)

> +
>  /**
>   * struct rvin_parallel_entity - Parallel video input endpoint descriptor
>   * @asd:	sub-device descriptor for async framework
> @@ -95,6 +98,7 @@ struct rvin_video_format {
>   * @mbus_flags:	media bus configuration flags
>   * @source_pad:	source pad of remote subdevice
>   * @sink_pad:	sink pad of remote subdevice
> + * @ycbcr_8b_g:	select data pins for YCbCr422-8bit
>   *
>   */
>  struct rvin_parallel_entity {
> @@ -106,6 +110,7 @@ struct rvin_parallel_entity {
>  
>  	unsigned int source_pad;
>  	unsigned int sink_pad;
> +	bool ycbcr_8b_g;
>  };
>  
>  /**
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
