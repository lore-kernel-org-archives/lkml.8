Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE280C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E277207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="bYH0wrdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgFZMsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:48:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B4C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:48:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so4904626pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s9Y6i2d0SkOyDxDxXtBmg8v9R/vz4yuL09v6Kczh3wU=;
        b=bYH0wrdxlCOE+3GcqlHlBzuyuNSYaks6jLleR/NujR2KpT+l5K0Xv4AbsFOFBTvA4L
         NiaYqbk3rpDBvHDc5gyonGTu4cQYgs3G6+eBt3hdXPnEH4juclnq3QNMv/D32LuP39Rc
         gAmjk7yfSkB1y1n4J3oC3vM3YMLYyrl9vq4snHJ56phnOZwbviEKxvoWDZsE2giQ46qy
         VPwzdPf+pUWb18jydV0/UjSfh2MFIH8rwylaEOR2nrA/v54OTkbGlVTHH0mdcsjbty3W
         bg4rAXYfezomUOIT7NtT5ZBGrZLSLdVIfhIF00Fc+1aKzpU0C8J8ZXQ/1h4sJWQLzYX/
         EmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9Y6i2d0SkOyDxDxXtBmg8v9R/vz4yuL09v6Kczh3wU=;
        b=L2SYd6Ant+HjDOeIzLVG1IBvLQzlOTS8Lvlk1VraaHWuOqXY6JjzrAb4WWKAuJp1yM
         QYR/Lc07AcxxiHJrnmAD73bqG/Gy0oqhJSTuoZ6Qe3QOgJ3+oueAARkWuojaicSBUOr9
         WYN6WfLIJVxcKfFs6liEB7DTkEiGCqngOrMUJpw6jMD8vkgctbFhlEbQMuThxMZWbNix
         GrpiEFIc3stYCKnQ4Gs+yRxPLl36JMJ5yBt1GEY56YkkKmExiGFjZ3QNNH600WiTidJP
         pZTZkKjQoEdrOf1jEDNClfc5zyXZGVoYiuB0utaxn/ogNss627I5+V1qdQlmE74PD253
         flDQ==
X-Gm-Message-State: AOAM532rzLo5f4naYkkE651aauP9nCme6TZs1isA6bfR0165xGoQoJBA
        vZJ/rfYeYaoPb2IbWtmYsBO7bg==
X-Google-Smtp-Source: ABdhPJx9jirsBYe8bWgg7S/9jKhT3qd+6QcEvB4Mct4ZLwdiixtyw++vZgtKSqU7Jtf594nz0ubMEA==
X-Received: by 2002:a62:8688:: with SMTP id x130mr2670928pfd.280.1593175680235;
        Fri, 26 Jun 2020 05:48:00 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id 140sm1873337pfa.92.2020.06.26.05.47.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 05:47:59 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Fri, 26 Jun 2020 18:17:51 +0530
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        hverkuil@xs4all.nl
Subject: Re: [PATCH v6 3/3] media: vimc: Add a control to display info on
 test image
Message-ID: <20200626124751.GB13722@kaaira-HP-Pavilion-Notebook>
References: <20200626113618.15280-1-kgupta@es.iitr.ac.in>
 <20200626113618.15280-4-kgupta@es.iitr.ac.in>
 <694350b5-cd61-1e9d-36ee-6028b59a53a6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694350b5-cd61-1e9d-36ee-6028b59a53a6@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 08:59:19AM -0300, Helen Koike wrote:
> Hi Kaaira,
> 
> Thanks for the patch,
> 
> On 6/26/20 8:36 AM, Kaaira Gupta wrote:
> > Add a control in VIMC to display information such as the correct order of
> > colors for a given test pattern, brightness, hue, saturation, contrast,
> > width and height at sensor, and time since streaming started over test image.
> > 
> > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > ---
> >  drivers/media/test-drivers/vimc/Kconfig       |  2 +
> >  drivers/media/test-drivers/vimc/vimc-common.h |  1 +
> >  drivers/media/test-drivers/vimc/vimc-core.c   | 10 ++++
> >  drivers/media/test-drivers/vimc/vimc-sensor.c | 60 +++++++++++++++++++
> >  4 files changed, 73 insertions(+)
> > 
> > diff --git a/drivers/media/test-drivers/vimc/Kconfig b/drivers/media/test-drivers/vimc/Kconfig
> > index 4068a67585f9..da4b2ad6e40c 100644
> > --- a/drivers/media/test-drivers/vimc/Kconfig
> > +++ b/drivers/media/test-drivers/vimc/Kconfig
> > @@ -2,6 +2,8 @@
> >  config VIDEO_VIMC
> >  	tristate "Virtual Media Controller Driver (VIMC)"
> >  	depends on VIDEO_DEV && VIDEO_V4L2
> > +	select FONT_SUPPORT
> > +	select FONT_8x16
> >  	select MEDIA_CONTROLLER
> >  	select VIDEO_V4L2_SUBDEV_API
> >  	select VIDEOBUF2_VMALLOC
> > diff --git a/drivers/media/test-drivers/vimc/vimc-common.h b/drivers/media/test-drivers/vimc/vimc-common.h
> > index ae163dec2459..a289434e75ba 100644
> > --- a/drivers/media/test-drivers/vimc/vimc-common.h
> > +++ b/drivers/media/test-drivers/vimc/vimc-common.h
> > @@ -20,6 +20,7 @@
> >  #define VIMC_CID_VIMC_CLASS		(0x00f00000 | 1)
> >  #define VIMC_CID_TEST_PATTERN		(VIMC_CID_VIMC_BASE + 0)
> >  #define VIMC_CID_MEAN_WIN_SIZE		(VIMC_CID_VIMC_BASE + 1)
> > +#define VIMC_CID_OSD_TEXT_MODE		(VIMC_CID_VIMC_BASE + 2)
> >  
> >  #define VIMC_FRAME_MAX_WIDTH 4096
> >  #define VIMC_FRAME_MAX_HEIGHT 2160
> > diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
> > index 11210aaa2551..8337e1276bba 100644
> > --- a/drivers/media/test-drivers/vimc/vimc-core.c
> > +++ b/drivers/media/test-drivers/vimc/vimc-core.c
> > @@ -5,10 +5,12 @@
> >   * Copyright (C) 2015-2017 Helen Koike <helen.fornazier@gmail.com>
> >   */
> >  
> > +#include <linux/font.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <media/media-device.h>
> > +#include <media/tpg/v4l2-tpg.h>
> >  #include <media/v4l2-device.h>
> >  
> >  #include "vimc-common.h"
> > @@ -263,11 +265,19 @@ static int vimc_register_devices(struct vimc_device *vimc)
> >  
> >  static int vimc_probe(struct platform_device *pdev)
> >  {
> > +	const struct font_desc *font = find_font("VGA8x16");
> >  	struct vimc_device *vimc;
> >  	int ret;
> >  
> >  	dev_dbg(&pdev->dev, "probe");
> >  
> > +	if (!font) {
> > +		dev_err(&pdev->dev, "vimc: could not find font\n");
> 
> You don't need the "vimc: " prefix if you are using dev_err(), it already gets the name from pdev->dev
> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	tpg_set_font(font->data);
> > +
> >  	vimc = kzalloc(sizeof(*vimc), GFP_KERNEL);
> >  	if (!vimc)
> >  		return -ENOMEM;
> > diff --git a/drivers/media/test-drivers/vimc/vimc-sensor.c b/drivers/media/test-drivers/vimc/vimc-sensor.c
> > index a2f09ac9a360..ce438cdabb73 100644
> > --- a/drivers/media/test-drivers/vimc/vimc-sensor.c
> > +++ b/drivers/media/test-drivers/vimc/vimc-sensor.c
> > @@ -19,6 +19,8 @@ struct vimc_sen_device {
> >  	struct v4l2_subdev sd;
> >  	struct tpg_data tpg;
> >  	u8 *frame;
> > +	unsigned int osd_mode;
> > +	u64 start_stream_ts;
> >  	/* The active format */
> >  	struct v4l2_mbus_framefmt mbus_format;
> >  	struct v4l2_ctrl_handler hdl;
> > @@ -185,10 +187,46 @@ static const struct v4l2_subdev_pad_ops vimc_sen_pad_ops = {
> >  static void *vimc_sen_process_frame(struct vimc_ent_device *ved,
> >  				    const void *sink_frame)
> >  {
> > +	enum osd_mode {OSD_SHOW_ALL = 0, OSD_SHOW_COUNTERS = 1};
> > +	u8 *basep[TPG_MAX_PLANES][2];
> > +	char str[100];
> > +	int line = 1;
> 
> unsigned int
> 
> > +	const unsigned int line_height = 16;
> >  	struct vimc_sen_device *vsen = container_of(ved, struct vimc_sen_device,
> >  						    ved);
> 
> I would just re-order the declaration vars to have the longest lines first.
> 
> >  
> >  	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame);
> > +	tpg_calc_text_basep(&vsen->tpg, basep, 0, vsen->frame);
> > +
> > +	if (vsen->osd_mode <= OSD_SHOW_COUNTERS) {
> > +		unsigned int ms;
> > +
> > +		ms = (ktime_get_ns() - vsen->start_stream_ts) / 1000000;
> > +		snprintf(str, sizeof(str), "%02d:%02d:%02d:%03d",
> > +			 (ms / (60 * 60 * 1000)) % 24,
> > +			 (ms / (60 * 1000)) % 60,
> > +			 (ms / 1000) % 60,
> > +			 ms % 1000);
> > +		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
> > +	}
> > +
> > +	if (vsen->osd_mode == OSD_SHOW_ALL) {
> > +		const char *order = tpg_g_color_order(&vsen->tpg);
> > +
> > +		tpg_gen_text(&vsen->tpg, basep,
> > +			     line++ * line_height, 16, order);
> > +		snprintf(str, sizeof(str),
> > +			 "brightness %3d, contrast %3d, saturation %3d, hue %d ",
> > +			 vsen->tpg.brightness,
> > +			 vsen->tpg.contrast,
> > +			 vsen->tpg.saturation,
> > +			 vsen->tpg.hue);
> > +		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
> > +		snprintf(str, sizeof(str), "sensor size: %dx%d",
> > +			 vsen->mbus_format.width, vsen->mbus_format.height);
> > +		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
> > +	}
> 
> How about the nice case-switch statement proposed by Kieran in the last version?

Ignore my earlier message for this please, I was mistaken.

> 
> Thanks,
> Helen
> 
> > +
> >  	return vsen->frame;
> >  }
> >  
> > @@ -201,6 +239,8 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
> >  		const struct vimc_pix_map *vpix;
> >  		unsigned int frame_size;
> >  
> > +		vsen->start_stream_ts = ktime_get_ns();
> > +
> >  		/* Calculate the frame size */
> >  		vpix = vimc_pix_map_by_code(vsen->mbus_format.code);
> >  		frame_size = vsen->mbus_format.width * vpix->bpp *
> > @@ -269,6 +309,9 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
> >  	case V4L2_CID_SATURATION:
> >  		tpg_s_saturation(&vsen->tpg, ctrl->val);
> >  		break;
> > +	case VIMC_CID_OSD_TEXT_MODE:
> > +		vsen->osd_mode = ctrl->val;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -307,6 +350,22 @@ static const struct v4l2_ctrl_config vimc_sen_ctrl_test_pattern = {
> >  	.qmenu = tpg_pattern_strings,
> >  };
> >  
> > +static const char * const vimc_ctrl_osd_mode_strings[] = {
> > +	"All",
> > +	"Counters Only",
> > +	"None",
> > +	NULL,
> > +};
> > +
> > +static const struct v4l2_ctrl_config vimc_sen_ctrl_osd_mode = {
> > +	.ops = &vimc_sen_ctrl_ops,
> > +	.id = VIMC_CID_OSD_TEXT_MODE,
> > +	.name = "Show Information",
> > +	.type = V4L2_CTRL_TYPE_MENU,
> > +	.max = ARRAY_SIZE(vimc_ctrl_osd_mode_strings) - 2,
> > +	.qmenu = vimc_ctrl_osd_mode_strings,
> > +};
> > +
> >  static struct vimc_ent_device *vimc_sen_add(struct vimc_device *vimc,
> >  					    const char *vcfg_name)
> >  {
> > @@ -323,6 +382,7 @@ static struct vimc_ent_device *vimc_sen_add(struct vimc_device *vimc,
> >  
> >  	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_class, NULL);
> >  	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_test_pattern, NULL);
> > +	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_osd_mode, NULL);
> >  	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> >  			  V4L2_CID_VFLIP, 0, 1, 1, 0);
> >  	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> > 
