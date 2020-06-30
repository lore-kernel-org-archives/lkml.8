Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B103BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A4F2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="b0kRpPS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgF3WRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgF3WRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:17:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE049C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:17:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so24533007ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j7Y4k4Su6C/SrE2wkW/G0w92N/sIkpnfGBULTDjRADg=;
        b=b0kRpPS1aBgxohI5HdFKkz3KhgqY5a7sXLaqoFzQofRaQwGS34Prv2205aI/2gBgjw
         NkBxjBUtEy/h76vXOwDJk+oyi4jtkOQzqbcabMcsuyWtewuAXSM3fzenIQVp19z3nVI8
         R6tgWg/MeVHlbf7jGmJ2rCI4CsDUifKIsW51ysCOzJe/LP5oN8s2JuN2aQcMmmcTYSnV
         dc6VMft5gz1fACnu90TvqKOHEYiJ2HdeIEGwFKqljPIhY5o13FerYsHSuckaQ4Q286iV
         3DDeFKAPoimLnOST/F4h3ePkrxrc0F0JZPrqu1bezXUXLqaHKuzgv7nkQfxtwedZn/T6
         cNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j7Y4k4Su6C/SrE2wkW/G0w92N/sIkpnfGBULTDjRADg=;
        b=nHA3c+FQu01NHQtih3fEY7EVuU1J+1tlBsWNdZiv5tEVKvdfsfNGTgs2gPHDxZ8QnI
         n3bvj0FsFf2uHqHu8VeRnrn5IGZoKCdWU69oW65PeVNjiPXShdH0ihKypTFRtncF82zi
         5bWHl/Q/PGyccR2kNZBYML6KgpMTGFyax9jKXTz/6+1IdzaRZ+XUwgIiNM3dYCQ3W7fO
         6Vk0xk1C+py2iZ1lQ2OxVrJYaGHgsg5GUegojRk9vRKjBDQ7HIDYagd96cMtuQUl3+Qf
         S849y7P8Rv+AgnZlsiN5aIlviAlkTlLpc1zlFTVFv9tZaBz/mWFT7GqWdrAnnMvOixEs
         TFDQ==
X-Gm-Message-State: AOAM530fELTZRKiWsCTINCrsAvvaZ3pXjFEwyhWP+5Ko6eGLET9+b0/W
        dBa9yK6DvOnCo2jdzLmFgwfJQg==
X-Google-Smtp-Source: ABdhPJxfmDUvtXlZ6Wm9MAiyy+QDyuqNYq0Y7CwTsnhOQJp2om8O/FU3n01r53dlCTJUNsCmgxUPNA==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr11793020ljm.96.1593555431363;
        Tue, 30 Jun 2020 15:17:11 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id j4sm1269060lfb.94.2020.06.30.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 15:17:10 -0700 (PDT)
Date:   Wed, 1 Jul 2020 00:17:10 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Michael Rodin <mrodin@de.adit-jv.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, michael@rodin.online,
        efriedrich@de.adit-jv.com, erosca@de.adit-jv.com
Subject: Re: [PATCH 1/2] [RFC] media: rcar-vin: send a V4L2 event to vdev if
 no frame captured after a timeout
Message-ID: <20200630221710.GM2365286@oden.dyn.berto.se>
References: <1592588777-100596-1-git-send-email-mrodin@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592588777-100596-1-git-send-email-mrodin@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for your RFC.

On 2020-06-19 19:46:10 +0200, Michael Rodin wrote:
> Data flow from an upstream subdevice can stop permanently due to:
>  - CSI2 transmission errors
>  - silent failure of the source subdevice
>  - disconnection of the source subdevice
> In those cases userspace waits for new buffers for an infinitely long time.
> In order to address this issue, use a timer to monitor, that rvin_irq() is
> capturing at least one frame within a IRQ_TIMEOUT_MS period. Otherwise send
> a new private v4l2 event to userspace. This event is exported to userspace
> via a new uapi header.

I think there is value for user-space to detecting the error cases 
above. But I think the problem could be addressed at a different lever.  
Defining a VIN specific events and controls for something that applies 
any video device might not be the neatest solution.

Another thing hits me when reading this series, could this not be done 
in user-space? In 2/2 you add a control which sets the timeout based on 
the framerate, so user-space must know about that to be able to set the 
control. User-space also knows when it receives/dequeus a buffer from 
the video device so the timeout logic could be implemented in the 
application. Given that the application anyhow needs special care to 
handle the VIN specific event and control I wonder if it's not neater to 
make it handle all of it. Do you see any specific benefit of having 
parts of it in the driver?

> 
> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
> ---
>  drivers/media/platform/rcar-vin/rcar-dma.c  | 21 +++++++++++++++++++++
>  drivers/media/platform/rcar-vin/rcar-v4l2.c |  1 +
>  drivers/media/platform/rcar-vin/rcar-vin.h  |  6 ++++++
>  include/uapi/linux/rcar-vin.h               | 10 ++++++++++
>  4 files changed, 38 insertions(+)
>  create mode 100644 include/uapi/linux/rcar-vin.h
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index 1a30cd0..bf8d733 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -937,6 +937,20 @@ static void rvin_capture_stop(struct rvin_dev *vin)
>  #define RVIN_TIMEOUT_MS 100
>  #define RVIN_RETRIES 10
>  
> +static const struct v4l2_event rvin_irq_timeout = {
> +	.type = V4L2_EVENT_RCAR_VIN_IRQ_TIMEOUT,
> +};
> +
> +static void rvin_irq_timer_function(struct timer_list *timer)
> +{
> +	struct rvin_dev *vin = container_of(timer, struct rvin_dev,
> +					    irq_timer);
> +
> +	vin_err(vin, "%s: frame completion timeout after %i ms!\n",
> +		__func__, IRQ_TIMEOUT_MS);
> +	v4l2_event_queue(&vin->vdev, &rvin_irq_timeout);
> +}
> +
>  static irqreturn_t rvin_irq(int irq, void *data)
>  {
>  	struct rvin_dev *vin = data;
> @@ -1008,6 +1022,8 @@ static irqreturn_t rvin_irq(int irq, void *data)
>  		vin_dbg(vin, "Dropping frame %u\n", vin->sequence);
>  	}
>  
> +	mod_timer(&vin->irq_timer, jiffies + msecs_to_jiffies(IRQ_TIMEOUT_MS));
> +
>  	vin->sequence++;
>  
>  	/* Prepare for next frame */
> @@ -1252,6 +1268,8 @@ static int rvin_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	if (ret)
>  		dma_free_coherent(vin->dev, vin->format.sizeimage, vin->scratch,
>  				  vin->scratch_phys);
> +	else
> +		mod_timer(&vin->irq_timer, jiffies + msecs_to_jiffies(IRQ_TIMEOUT_MS));
>  
>  	return ret;
>  }
> @@ -1305,6 +1323,8 @@ static void rvin_stop_streaming(struct vb2_queue *vq)
>  	/* Free scratch buffer. */
>  	dma_free_coherent(vin->dev, vin->format.sizeimage, vin->scratch,
>  			  vin->scratch_phys);
> +
> +	del_timer_sync(&vin->irq_timer);
>  }
>  
>  static const struct vb2_ops rvin_qops = {
> @@ -1370,6 +1390,7 @@ int rvin_dma_register(struct rvin_dev *vin, int irq)
>  		goto error;
>  	}
>  
> +	timer_setup(&vin->irq_timer, rvin_irq_timer_function, 0);
>  	return 0;
>  error:
>  	rvin_dma_unregister(vin);
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> index f421e25..c644134 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -581,6 +581,7 @@ static int rvin_subscribe_event(struct v4l2_fh *fh,
>  {
>  	switch (sub->type) {
>  	case V4L2_EVENT_SOURCE_CHANGE:
> +	case V4L2_EVENT_RCAR_VIN_IRQ_TIMEOUT:
>  		return v4l2_event_subscribe(fh, sub, 4, NULL);
>  	}
>  	return v4l2_ctrl_subscribe_event(fh, sub);
> diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
> index c19d077..7408f67 100644
> --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> @@ -14,12 +14,14 @@
>  #define __RCAR_VIN__
>  
>  #include <linux/kref.h>
> +#include <linux/rcar-vin.h>
>  
>  #include <media/v4l2-async.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-dev.h>
>  #include <media/v4l2-device.h>
>  #include <media/videobuf2-v4l2.h>
> +#include <media/v4l2-event.h>
>  
>  /* Number of HW buffers */
>  #define HW_BUFFER_NUM 3
> @@ -30,6 +32,8 @@
>  /* Max number on VIN instances that can be in a system */
>  #define RCAR_VIN_NUM 8
>  
> +#define IRQ_TIMEOUT_MS 1000
> +
>  struct rvin_group;
>  
>  enum model_id {
> @@ -196,6 +200,7 @@ struct rvin_info {
>   * @compose:		active composing
>   * @src_rect:		active size of the video source
>   * @std:		active video standard of the video source
> + * @irq_timer:		monitors regular capturing of frames in rvin_irq()
>   *
>   * @alpha:		Alpha component to fill in for supported pixel formats
>   */
> @@ -240,6 +245,7 @@ struct rvin_dev {
>  	struct v4l2_rect src_rect;
>  	v4l2_std_id std;
>  
> +	struct timer_list irq_timer;
>  	unsigned int alpha;
>  };
>  
> diff --git a/include/uapi/linux/rcar-vin.h b/include/uapi/linux/rcar-vin.h
> new file mode 100644
> index 00000000..4eb7f5e
> --- /dev/null
> +++ b/include/uapi/linux/rcar-vin.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef RCAR_VIN_USER_H
> +#define RCAR_VIN_USER_H
> +
> +/* class for events sent by the rcar-vin driver */
> +#define V4L2_EVENT_RCAR_VIN_CLASS	V4L2_EVENT_PRIVATE_START
> +#define V4L2_EVENT_RCAR_VIN_IRQ_TIMEOUT	(V4L2_EVENT_RCAR_VIN_CLASS | 0x1)
> +
> +#endif /* RCAR_VIN_USER_H */
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
