Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F2C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DEC20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="1OGHB3mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCYOC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:02:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39670 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgCYOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:02:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so2184045qtq.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LQq3EFJ59LIxHUdp5oSLSjexBDEoJBV/NBKXaRpQgvc=;
        b=1OGHB3mXWgyadxhaLY3ieAeTgpSZKH4oRsUgiE3HazXkZEVAwqsCRLErTjKZtIQdyN
         fbkDrEC6S+VmzZgQboXDr9IDzkdf0gQ5BlpMljeciRq+LbVEaU/k/yarN+NAAI1/jg/7
         2vSDUIueLoLxp1spvUureG4jyqJ2ViAI7Iz3oUlmnKEZ60/P1Xi5uPW7BQ3FLPvwjlkx
         jTaYjo4FnyTKvfspmo/7mF6GezdoN0nwoodUN9z1Nd8WV5bJx9mZ+UwoTYYfHeqf/wgP
         sUG26792imTiGn9U3g/fcpbJb1ds+juIomMff0DjZZ9m1nJqhKVQMY1f61mKiT2dwF0W
         IRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LQq3EFJ59LIxHUdp5oSLSjexBDEoJBV/NBKXaRpQgvc=;
        b=i2/ct0p0//bFPtzA1gMsaVzDpzTH8hX+vHhSHSGiXPc+QC5A9vHtre6z0I0ZIpq4/a
         l4FKVEgWDb1l+giNf1PcBbeuEKYbQnSyCiA1++effJO0RAiHfPJJOmoE8SgV31O+Nt6H
         Kp7d6Lw8cUNt6tNCTpRSz9EeNtTopAYWb1pFySCk6Ngvoc9RxVwfhAMbeKSGrjY9XH9M
         FqZsq4GKh9JElyeWWZ0dBUWp0yV3eQn9EARMPoUZOgqfsn9lel4zNa4EaIYTxIOBR+R/
         JHSOsn+EIHp6VOZJNIMK58m6nq/oP6/tBKbVU8m/ehDHCxFHZCstrQ6TF2qUiLh4oZNM
         C5aA==
X-Gm-Message-State: ANhLgQ3rrWD+zPxflgHiXIA7m6ohbeqi9FxF6JNzF02a1WQQHmGdQobb
        cAPnyMnxP14bp6/wBNymfkSZTQ==
X-Google-Smtp-Source: ADFU+vvlCeU0s4GsVkEXhSCM1T2ufqjJODHpGR+21Q3IE7jl3Boob14Pq3km6w6nKoKmA15mc4/Zvg==
X-Received: by 2002:ac8:6f46:: with SMTP id n6mr2978711qtv.119.1585144975048;
        Wed, 25 Mar 2020 07:02:55 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id 79sm15313675qkg.38.2020.03.25.07.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:02:54 -0700 (PDT)
Message-ID: <0a8f6d97e6869ff694aedd67a3176217a885c938.camel@ndufresne.ca>
Subject: Re: [PATCH v2 3/8] hantro: Use v4l2_m2m_buf_done_and_job_finish
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Rob Herring <robh@kernel.org>
Date:   Wed, 25 Mar 2020 10:02:52 -0400
In-Reply-To: <13b1efe1-8b52-070b-cf11-b230bd405d3e@xs4all.nl>
References: <20200318132108.21873-1-ezequiel@collabora.com>
         <20200318132108.21873-4-ezequiel@collabora.com>
         <13b1efe1-8b52-070b-cf11-b230bd405d3e@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 25 mars 2020 à 09:22 +0100, Hans Verkuil a écrit :
> On 3/18/20 2:21 PM, Ezequiel Garcia wrote:
> > Let the core sort out the nuances of returning buffers
> > to userspace, by using the v4l2_m2m_buf_done_and_job_finish
> > helper.
> > 
> > This change also removes usage of buffer sequence fields,
> > which shouldn't have any meaning for stateless decoders.
> 
> Uh, why remove this? For one, doesn't this cause fails in v4l2-compliance?
> Also, while I agree that it is not terribly useful, it doesn't hurt, does it?
> 
> And the V4L2 spec makes no exception for stateless codecs with respect to the
> sequence field.
> 
> Nacked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

The spec also does not say what it means either. As an example, you
have spec for ALTERNATE interlacing mode that changes the meaning of
the sequence, but not for alternate H264 fields (which cannot be part
of the format, since this changes often). We also don't have spec for
the the sequence behaviour while using HOLD features.

I'm worried we are falling into the test driven trap, were people
implement features to satisfy a test, while the added complexity don't
really make sense. Shouldn't we change our approach and opt-out
features for new type of HW, so that we can keep the drivers code
saner?

> 
> Regards,
> 
> 	Hans
> 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  drivers/staging/media/hantro/hantro_drv.c | 27 ++++++++---------------
> >  1 file changed, 9 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > index 0b1200fc0e1a..ec889d755cd6 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -94,32 +94,23 @@ static void hantro_job_finish(struct hantro_dev *vpu,
> >  			      unsigned int bytesused,
> >  			      enum vb2_buffer_state result)
> >  {
> > -	struct vb2_v4l2_buffer *src, *dst;
> >  	int ret;
> >  
> >  	pm_runtime_mark_last_busy(vpu->dev);
> >  	pm_runtime_put_autosuspend(vpu->dev);
> >  	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
> >  
> > -	src = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> > -	dst = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> > -
> > -	if (WARN_ON(!src))
> > -		return;
> > -	if (WARN_ON(!dst))
> > -		return;
> > -
> > -	src->sequence = ctx->sequence_out++;
> > -	dst->sequence = ctx->sequence_cap++;
> > -
> > -	ret = ctx->buf_finish(ctx, &dst->vb2_buf, bytesused);
> > -	if (ret)
> > -		result = VB2_BUF_STATE_ERROR;
> > +	if (ctx->buf_finish) {
> > +		struct vb2_v4l2_buffer *dst;
> >  
> > -	v4l2_m2m_buf_done(src, result);
> > -	v4l2_m2m_buf_done(dst, result);
> > +		dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> > +		ret = ctx->buf_finish(ctx, &dst->vb2_buf, bytesused);
> > +		if (ret)
> > +			result = VB2_BUF_STATE_ERROR;
> > +	}
> >  
> > -	v4l2_m2m_job_finish(vpu->m2m_dev, ctx->fh.m2m_ctx);
> > +	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
> > +					 result);
> >  }
> >  
> >  void hantro_irq_done(struct hantro_dev *vpu, unsigned int bytesused,
> > 

