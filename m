Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314BFC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1992080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lXnoT4FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGTJDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:03:07 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57476C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:03:06 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DE4C95C2657;
        Mon, 20 Jul 2020 11:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1595235784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGN64Po53f3Pa0cff0t7HE/aei+YsCtVQ1Yq8k7+wZs=;
        b=lXnoT4FIexWZkT91juROAc/bi9uHHT9cZ/CcEw91QKSWzrNaESFylxO9Xgqnz7hu5nSW8a
        ajYx1IjFtwnw+sqoVnQ4Yx/2OWNDMLtCffchE5a9UjCjI/xuOf+YeYZ2n11z/qZDHrb56g
        ApH+eBJ5BshrQU6TCoNJEuqajZ1z+js=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Mon, 20 Jul 2020 11:03:04 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mxsfb: Make supported modifiers explicit
In-Reply-To: <20200718171407.GA72952@bogon.m.sigxcpu.org>
References: <26877532e272c12a74c33188e2a72abafc9a2e1c.1584973664.git.agx@sigxcpu.org>
 <d39209a3664179f895a7dfabbd02d27a6adb9895.camel@pengutronix.de>
 <20200718171407.GA72952@bogon.m.sigxcpu.org>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <427ac44d83e9502afb5a809f28544d6c@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-18 19:14, Guido Günther wrote:
> Hi,
> On Mon, Mar 23, 2020 at 04:51:05PM +0100, Lucas Stach wrote:
>> Am Montag, den 23.03.2020, 15:52 +0100 schrieb Guido Günther:
>> > In contrast to other display controllers on imx like DCSS and ipuv3
>> > lcdif/mxsfb does not support detiling e.g. vivante tiled layouts.
>> > Since mesa might assume otherwise make it explicit that only
>> > DRM_FORMAT_MOD_LINEAR is supported.
>> >
>> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
>>
>> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Can i do anything to get this applied?
> Cheers,
>  -- Guido

Sorry about the delay, I was thinking to apply it with another patchset
which is not ready though.

Pushed this patch to drm-misc-next just now.

--
Stefan

> 
>>
>> > ---
>> >  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>> > index 762379530928..fc71e7a7a02e 100644
>> > --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>> > @@ -73,6 +73,11 @@ static const uint32_t mxsfb_formats[] = {
>> >  	DRM_FORMAT_RGB565
>> >  };
>> >
>> > +static const uint64_t mxsfb_modifiers[] = {
>> > +	DRM_FORMAT_MOD_LINEAR,
>> > +	DRM_FORMAT_MOD_INVALID
>> > +};
>> > +
>> >  static struct mxsfb_drm_private *
>> >  drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
>> >  {
>> > @@ -334,8 +339,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>> >  	}
>> >
>> >  	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
>> > -			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
>> > -			mxsfb->connector);
>> > +			mxsfb_formats, ARRAY_SIZE(mxsfb_formats),
>> > +			mxsfb_modifiers, mxsfb->connector);
>> >  	if (ret < 0) {
>> >  		dev_err(drm->dev, "Cannot setup simple display pipe\n");
>> >  		goto err_vblank;
>>
