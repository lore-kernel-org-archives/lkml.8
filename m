Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9771C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B926F2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="Ws/vknZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgFEPhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgFEPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:37:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE5C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 08:37:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 205so10101747qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6dIRalDKukNHz3swE/kQj/FCPxkqgYRrJWqT5xc0928=;
        b=Ws/vknZem3s0dSVcrFTtK798SXVRdP/M5djs99ILMOwUF3cYzeW1g9WXvvvNqkBz1c
         2s0fX+GDycNfAm1Zk8aKEYTel3pvPQNw3TvZ5lSnSFJD/GaPBDFpDBlOSrfC+dS0GJpY
         g1vQRbXfD0Bc8xzezZKeS8KF7wzKj4OHElgffB0AmLr4Bt866+sOb0ZW6wtN5r0LwPNl
         tNBN4Icemp1Xad2Osx0yClhDGcvW8Ou6RoZmZlMTARp+a2j4iKY7VaS7pbLDFSIgLvs3
         Ptj6JycT1S8cCe5/dq3TPnQKZK0nn67ia33gCcb8kvvPpd7R2zQ54A7OvbsFobVpromX
         sqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6dIRalDKukNHz3swE/kQj/FCPxkqgYRrJWqT5xc0928=;
        b=J1wZrTeOpLk4InQwGBmOF7rsUZvixIaH2ayGK7lPyUu2EWICM/GA50wq1SiYJy1ydW
         hU7Yn+SIaf9Q3XiKG2P7+0Lf5plGwPqLh+obnnOoMUJ+HCjx6AfaoD3JnuPFIcsztFrJ
         qGNU7ftmyvq6EJrGCRFybXKnStp9Tuizg8yf7aS7hTnzrZhRLF9KZX3zGSTE+l6lw+fv
         n6MafLvJLcOLB82A4q41SBbXAS6JUg+Hg0tiQiZjHLrZlhZp6LDXrYjPbeIGDhpTuEsL
         wuAvDJsaeabrriqcUWElkeRlb/F+AcAuIsCJFZAiBH/fb6zCjtkt5gs/JFdDCWN/R/x7
         EyrA==
X-Gm-Message-State: AOAM531uWT/GvaVAXIJ69/zBiPesctQTe9M3Q979sGMgNx9IFGRZJllh
        UcRqWyDW4Q9iOkGUxvM020I4bg==
X-Google-Smtp-Source: ABdhPJwSva/8aulW2zIjT1mFgpKBNkLomhs6UlAbs0vzaebZnojmGDUsgoBL6g8XrramHpl+0a0UVg==
X-Received: by 2002:a37:8ec3:: with SMTP id q186mr10814060qkd.231.1591371435604;
        Fri, 05 Jun 2020 08:37:15 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id h5sm67524qkk.108.2020.06.05.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:37:14 -0700 (PDT)
Message-ID: <6be2b7794c469a434befc2f71f83cf918f4e1b4b.camel@ndufresne.ca>
Subject: Re: [PATCH 1/5] media: videodev2: add Compressed Framebuffer pixel
 formats
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Neil Armstrong <narmstrong@baylibre.com>, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Jourdan <mjourdan@baylibre.com>
Date:   Fri, 05 Jun 2020 11:37:13 -0400
In-Reply-To: <02aa06fd8397b77c9a75d3a8399cb55d3b4d39c1.camel@ndufresne.ca>
References: <20200604135317.9235-1-narmstrong@baylibre.com>
         <20200604135317.9235-2-narmstrong@baylibre.com>
         <02aa06fd8397b77c9a75d3a8399cb55d3b4d39c1.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 05 juin 2020 à 11:35 -0400, Nicolas Dufresne a écrit :
> Le jeudi 04 juin 2020 à 15:53 +0200, Neil Armstrong a écrit :
> > From: Maxime Jourdan <mjourdan@baylibre.com>
> > 
> > Add two generic Compressed Framebuffer pixel formats to be used
> > with a modifier when imported back in another subsystem like DRM/KMS.
> > 
> > These pixel formats represents generic 8bits and 10bits compressed buffers
> > with a vendor specific layout.
> > 
> > These are aligned with the DRM_FORMAT_YUV420_8BIT and DRM_FORMAT_YUV420_10BIT
> > used to describe the underlying compressed buffers used for ARM Framebuffer
> > Compression. In the Amlogic case, the compression is different but the
> > underlying buffer components is the same.
> > 
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
> >  include/uapi/linux/videodev2.h       | 9 +++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index 2322f08a98be..8f14adfd5bc5 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1447,6 +1447,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
> >  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
> >  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
> > +		case V4L2_PIX_FMT_YUV420_8BIT:	descr = "Compressed YUV 4:2:0 8-bit Format"; break;
> > +		case V4L2_PIX_FMT_YUV420_10BIT:	descr = "Compressed YUV 4:2:0 10-bit Format"; break;
> 
> When I read the DRM documentation [0], I'm reading that YUV420_8BIT
> definition matches V4L2_PIX_FMT_YVU420 and V4L2_PIX_FMT_YVU420M fully.
> In fact, on DRM side, to represent that format you want to expose here,
> they will strictly combine this generic format (documented un-
> compressed) with a modifier generated with the macro
> DRM_FORMAT_MOD_ARM_AFBC(*). And only the combination represent a unique
> and share-able format.

[0] https://www.kernel.org/doc/html/v5.5-rc1/gpu/afbc.html

> 
> In absence of modifier in V4L2 API, this compressed format should be
> named accordingly to the compressed algorithm used (something like
> FMT_YUV420_8BIT_AML_FBC). So I believe these format name cannot be
> copied as-is like this, as they can only introduce more ambiguity in
> the already quite hard to follow naming of pixel formats. In fact, it
> is very common to see multiple different vendor compressions on the
> same SoC, so I don't really believe a "generic" compressed format make
> sense. To site one, the IMX8M, which got Verrisillicon/Vivante DEC400
> on the GPU, and the Hantro G2 compression format. Both will apply to
> NV12 class of format so in DRM they would be NV12 + modifier, and the
> combination forms the unique format. Now, in term of sharing, they must
> be differiented by userspace, as support for compression/decompression
> is heterogeneous (in that case the GPU does not support Hantro G2
> decompression or compression, and the VPU does not support DEC400).
> 
> I'll remind that the modifier implementation has great value and is
> much more scalable then the current V4L2 approach. There has been some
> early proposal for this, maybe it's time to prioritize because this
> list will starts growing with hundred or even thousands or format,
> which is clearly indicated by the increase of modifier generator macro
> on the DRM side.
> 
> >  		default:
> >  			if (fmt->description[0])
> >  				return;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index c3a1cf1c507f..90b9949acb8a 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -705,6 +705,15 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_FWHT     v4l2_fourcc('F', 'W', 'H', 'T') /* Fast Walsh Hadamard Transform (vicodec) */
> >  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
> >  
> > +/*
> > + * Compressed Luminance+Chrominance meta-formats
> > + * In these formats, the component ordering is specified (Y, followed by U
> > + * then V), but the exact Linear layout is undefined.
> > + * These formats can only be used with a non-Linear modifier.
> > + */
> > +#define V4L2_PIX_FMT_YUV420_8BIT	v4l2_fourcc('Y', 'U', '0', '8') /* 1-plane YUV 4:2:0 8-bit */
> > +#define V4L2_PIX_FMT_YUV420_10BIT	v4l2_fourcc('Y', 'U', '1', '0') /* 1-plane YUV 4:2:0 10-bit */
> > +
> >  /*  Vendor-specific formats   */
> >  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> >  #define V4L2_PIX_FMT_WNVA     v4l2_fourcc('W', 'N', 'V', 'A') /* Winnov hw compress */

