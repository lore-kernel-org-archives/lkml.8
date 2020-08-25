Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF58C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE44520767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR1PGsJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHYMgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHYMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:36:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:36:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p11so4072039pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+ogH5ulPuM2hkUbprAOsV1Pp0nM7Zu6hRZDding+Jc=;
        b=GR1PGsJKN/V0tdvSTncoG6jUNNeoMQOt8Q0wmT/q/vJTyxjLTUUZBax7s8PR26FqF/
         2NthILHfDBZxcv9pxwMqCP2D4V6cNSnM4GeCKqWFDg4Lr5AapF0nlEoYptTkP+763jtn
         cDQPBauUJRHsnELAdjf0JrQs3WeKVpMWunbwsjyJZ7yfCQsvKrkpWNldYSVsI0D9lL9W
         C4ViBS5Mm3atHCzKPQ3GQL5V8211eCOj2sOMc6xVbs/pH+8l/q4+EAmpTcYjXarZi3U6
         Ie4Xxl4eO0Xz0SpF5FGY7R9zUtCVOYJkGQ2QnDnkEnVgdmnRH1mYUQ3s0/7xrjPnfdWS
         LYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+ogH5ulPuM2hkUbprAOsV1Pp0nM7Zu6hRZDding+Jc=;
        b=CCVolEWKk0x++J1kfk0z+mEtYTCHnRge2XPUqvBn3mhPfiL1nPXqHrKGQWwao/dBH4
         yoh4oLDhAkBOX063EadlTlVPVjOEoq/y/M4uzGmo+Tol5tgoHts/Xkix9Zv2lw4CA4uQ
         buqDPH1I7siChMpdwBYqrBPvi25WuWvcFPeHxJsCThpRU15spy7u83vzWQkKj5zitiO9
         aRr4N4OJyS6KBqzGNyXtfqlnK1nxt0ep5UIgjibCvwSjcviDTn+ehMatmHm+TfKFo7nd
         CBucN43gUZ8J73h1fglBgy0Fh4iDCbPNf604tbNjhNguydzQg/ptzDd+kAG+AYcYOzF4
         6OFA==
X-Gm-Message-State: AOAM5300gwGNt6G69DcehGSLa5+Py9B2pDFVx39vNODXf/TAoq/O6HVO
        Sy856RRH0O0mhI2W+aAvEiA=
X-Google-Smtp-Source: ABdhPJw/fNiDE1HlatNELcS5RKiecoQ5s7tg/0bT9fLlga7FeQsr/od6Ib4gVZTSsdkuX/38M6hXFQ==
X-Received: by 2002:a17:902:b588:: with SMTP id a8mr7228614pls.96.1598358962298;
        Tue, 25 Aug 2020 05:36:02 -0700 (PDT)
Received: from realwakka ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id lb1sm2464720pjb.26.2020.08.25.05.35.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 05:36:01 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:35:51 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20200825123551.GA25810@realwakka>
References: <20200818160215.19550-1-realwakka@gmail.com>
 <20200825031501.y3knhdwph5a6knld@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825031501.y3knhdwph5a6knld@smtp.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:15:01PM -0400, Rodrigo Siqueira wrote:
> Hi Sidong,
> 
> Thanks a lot for your patch and effort to improve VKMS.
> 
> On 08/18, Sidong Yang wrote:
> > I wrote this patch for TODO list in vkms documentation.
> > 
> > Use alpha value to blend source value and destination value Instead of
> > just overwrite with source value.
> > 
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index 4f3b07a32b60..e3230e2a99af 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -77,6 +77,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> >  
> >  	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
> >  		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
> > +			u8 *src, *dst;
> > +			u32 alpha, inv_alpha;
> > +
> >  			offset_dst = dest_composer->offset
> >  				     + (i_dst * dest_composer->pitch)
> >  				     + (j_dst++ * dest_composer->cpp);
> > @@ -84,8 +87,15 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> >  				     + (i * src_composer->pitch)
> >  				     + (j * src_composer->cpp);
> >  
> > -			memcpy(vaddr_dst + offset_dst,
> > -			       vaddr_src + offset_src, sizeof(u32));
> > +			src = vaddr_src + offset_src;
> > +			dst = vaddr_dst + offset_dst;
> > +			alpha = src[3] + 1;
> > +			inv_alpha = 256 - src[3];
> > +			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
> > +			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
> > +			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
> 

Hi, Rodrigo!

> Did you test your change with IGT? Maybe I missed something but looks
> like that you're applying the alpha value but the value that we get is
> already pre-multiplied.
> 
> Btw, It looks like that you and Melissa are working in the same feature,
> maybe you two could try to sync for avoiding overlapping.

Thanks for review.
Yes, this patch should be dropped and I should watch Melissa's patch.

> 
> Finally, do you have plans to send your fix for
> vkms_get_vblank_timestamp() function? That patch was really good and
> removes a lot of warning generated during the IGT test.

Okay, I'll work for improve vkms_get_vblank_timestamp().
Thank you so much.

Sincerely,
-Sidong

> 
> Best Regards
> 
> > +			dst[3] = 0xff;
> > +
> >  		}
> >  		i_dst++;
> >  	}
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech


