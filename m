Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5CAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD1720706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="HUCWqcVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgFZPnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgFZPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:43:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B117C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:43:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so10783663ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8sG3eMJyOg9orr/8+zbkmc8eQOjbgUIfbSHVDMJ1IF4=;
        b=HUCWqcVjbUx6weWEQDENSiFokpN6mUJD4S9osoh5Co0e8bpB6jv5F/JapF4s2wtcLd
         dSmd/FuV1QTsnQWSifHtgFuYJf3dR95nAYTNl9OMQXrUg+mw/r0YkguYclyxXsMw/yCN
         1Wg9SlRMMBAFPRxSOLSMeeSaN5GmdzJvxYTLd0D92RL18rf6naRWi4z5dZiN3+OsbKUL
         oiokOLkuu8SA0p9lELJvgQILxLUfujh0Qaow4FymH38LsuaNyH2pBWMR0WE06HzOYb4/
         2/c2q/n8iwBQq0KClI0GZ3I7M3K6yzybNwX5FRYFMS0jw1bI8oQi/UGRdG10OxGB5whR
         QuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8sG3eMJyOg9orr/8+zbkmc8eQOjbgUIfbSHVDMJ1IF4=;
        b=VaXWtubPZ195J7PIiUWQGD9VsnbaH7QoVzDpPLd2r5gUZ2KtQ/lBk078ZkJj+nMmJJ
         LexjwmNy0XDdOSZL/cQ+6Qq5wvd1af7m2/cHUhT4dbNjB0gY41SLY5qi9tC6/dv8JP0F
         b+pFSX0nA34S5xup1RVOx1IQx24mrB+zf+Ehdtje+SAvFzk/vVs9aJOejKfj2UkeavBl
         WtCTbZ5bXmjTtRfs0H0KCU+CSzmImalqfCJK0+hCC6Hn+AFzLDaTkAm4LL4UxdqE9ys6
         wJ0ecpvxCJtbc+CNXbrw7GV2VnMkv2YDLveQzoDjQ4xJFdgf4wARLzgX86zMj2GxAZ2Q
         XGnw==
X-Gm-Message-State: AOAM530YCCd/9kPkB5P7gf2ENSSi5DCHzKAuXR+zs3z/ZabxwqHZrpTa
        9z2jbTMRXTZrq4kTEXWcxXJz7EX/dGPYn3ooh9uhDQ==
X-Google-Smtp-Source: ABdhPJw/h4f9GIEpyJOz+1JLvx2y2ujVaOQE1ia/wcPgivU8F14uArVoSxx6LnAZLkO1/Va7N/QJ/u6FzQy+f+6hUyw=
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr1843523ljj.429.1593186180655;
 Fri, 26 Jun 2020 08:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200626143205.xns6nwggskssujao@pesu-pes-edu>
In-Reply-To: <20200626143205.xns6nwggskssujao@pesu-pes-edu>
From:   B K KARTHIK PES2201800185STUDENT ECE DeptPESU EC
         Campus <bkkarthik@pesu.pes.edu>
Date:   Fri, 26 Jun 2020 11:42:49 -0400
Message-ID: <CAAhDqq0tSftPxMWGeVy3mp4DGDN3o0uQwTqVbjYUwjqzWpbibQ@mail.gmail.com>
Subject: Re: [PATCH] staging: media: usbvision: removing prohibited space
 before ',' (ctx:WxW)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I'm sorry but wouldn't it be helpful if we had a file that lists
all drivers that are scheduled for removal? I personally feel that it
would help out all kernel newbies.
I've been trying to complete task10 in the eudyptula challenge, and
the patches either get thrown out by greg's patch-bot, or the driver
is scheduled for removal.

Please do think about adding a file that lists all drivers scheduled
for removal.

I apologize if my message was hurtful or disrespectful in any way.

Thank you for reading this message,
Karthik

On Fri, Jun 26, 2020 at 10:32 AM B K Karthik <bkkarthik@pesu.pes.edu> wrote:
>
> fixing ERROR: space prohibited before that ',' (ctx:WxW)
>
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/media/usbvision/usbvision-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/usbvision/usbvision-i2c.c b/drivers/staging/media/usbvision/usbvision-i2c.c
> index 6e4df3335b1b..010ad03c6ec1 100644
> --- a/drivers/staging/media/usbvision/usbvision-i2c.c
> +++ b/drivers/staging/media/usbvision/usbvision-i2c.c
> @@ -32,7 +32,7 @@ MODULE_PARM_DESC(i2c_debug, "enable debug messages [i2c]");
>  #define PDEBUG(level, fmt, args...) { \
>                 if (i2c_debug & (level)) \
>                         printk(KERN_INFO KBUILD_MODNAME ":[%s:%d] " fmt, \
> -                               __func__, __LINE__ , ## args); \
> +                               __func__, __LINE__, ## args); \
>         }
>
>  static int usbvision_i2c_write(struct usb_usbvision *usbvision, unsigned char addr, char *buf,
> --
> 2.20.1
>


-- 
B K Karthik

9535399755
karthik.oncreate.team
