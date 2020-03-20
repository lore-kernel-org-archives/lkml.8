Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B20CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6715F20775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584725538;
	bh=WsjgjMc5V84hg2ru5hJzn4ARjRe9A0ITrIl/CNrlPLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YO4mn7i55OMbwQpHOPBCgqc4JkFzHzX4eCVeev+Qjn5jd+/fM677G/fzj1L9fsPs0
	 z8KJ2ykSWTviJXTh5J2K817yOfE55RVDLqS6G+z2/KE9XHbaMgsDvspjQYL9iDtvqX
	 WqnPp/x9sIaoZt+GGJUl8wdpjF73RWG1RyG7uCNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCTRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:32:17 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46100 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgCTRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:32:17 -0400
Received: by mail-il1-f193.google.com with SMTP id e8so6291093ilc.13;
        Fri, 20 Mar 2020 10:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FXIfsAVUFp8IJFPm+/hNheLawxwEVeZKgbspez8Hy3A=;
        b=NV3q3F1RHAx2DDPQw5wFD8USkxgiYFTwB5BS3nBhoVdgwYTQRjJbamA1hzpGltxNFf
         ne2Lpf4uE0E2ot/MYx9OW/HsaTjLjyjsUhAIbXdEx22yXe1YVBhqUQCei6xwH/WZlbXs
         lsFsli4akYyzSqVyu6Z/FP8CfOUyTapktNXPay9blnkEqIk0hsCucoFagE5y7DIK/O7Z
         FJCx/XQjYbylHp+f2nxDnvn3j4c8A9B4YNguLfVhYWkonPJPzbLhRO7jWe31+MfxIRbs
         XT3O3ktDy6SvImTjaUN/FyfYG94n70Yv0u+T9kfn9ZDHoMlfzgVD9np56VBMbQ0aSpcy
         a03w==
X-Gm-Message-State: ANhLgQ2R1qWVSWtLIBIKLHRPFqm40Bc4HB1hk5C/6CtkgSFjJ26LqgEb
        ObDHluqKj6RF3seZ+Pj3sg==
X-Google-Smtp-Source: ADFU+vvyOEHh52ksLg64oqQQtskIyPgC3Gb9PgcVjz3NdBpqcYEYi8YkzZvcjgp/TY2ZkGE4F1dg5g==
X-Received: by 2002:a92:d641:: with SMTP id x1mr9850010ilp.223.1584725536379;
        Fri, 20 Mar 2020 10:32:16 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j23sm1874792ioa.10.2020.03.20.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:32:15 -0700 (PDT)
Received: (nullmailer pid 16573 invoked by uid 1000);
        Fri, 20 Mar 2020 17:32:13 -0000
Date:   Fri, 20 Mar 2020 11:32:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200320173213.GA9093@bogus>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > In order to support new EASRC and simplify the code structure,
> > We decide to share the common structure between them. This bring
> > a problem that EASRC accept format directly from devicetree, but
> > ASRC accept width from devicetree.
> > 
> > In order to align with new ESARC, we add new property fsl,asrc-format.
> > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > can accept format from devicetree, don't need to convert it to
> > format through width.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > index cb9a25165503..780455cf7f71 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > @@ -51,6 +51,11 @@ Optional properties:
> >  			  will be in use as default. Otherwise, the big endian
> >  			  mode will be in use for all the device registers.
> >  
> > +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> > +			  Ends, which can replace the fsl,asrc-width.
> > +			  The value is SNDRV_PCM_FORMAT_S16_LE, or
> > +			  SNDRV_PCM_FORMAT_S24_LE
> 
> I am still holding the concern at the DT binding of this format,
> as it uses values from ASoC header file instead of a dt-binding
> header file -- not sure if we can do this. Let's wait for Rob's
> comments.

I assume those are an ABI as well, so it's okay to copy them unless we 
already have some format definitions for DT. But it does need to be copy 
in a header under include/dt-bindings/.

Rob
