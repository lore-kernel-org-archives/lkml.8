Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F09B208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhIxwGsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgH1J3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgH1J3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:29:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB4C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:29:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so648635wrl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4xTbc6V9CmKW0Xfag25GTFqmyB1j/7yz22pA4imxIiw=;
        b=EhIxwGsEYrapIc1v+zaLKLGIYcC14GvP6v+Z6CbxQZEMa/D/jJzWG5jBVvI11WHLPo
         3nbqhUnLrekuaF+/5TmAc6ZtRnfsKh4Jr+fvwq/Jp+FH0oZBjMmsrJd4w2nE63zwXClW
         hMjUznVbCdsTmian9+uE5iwihyJv1HGcojCE+qijrQsxB+r7l5/2PPW1B6r4CpwiDoEN
         YUZcSvX7jukQFfuZtUH+Q+6u2Mk+KqxuSYWB6+x1KtjzB6Uz8ueSeTYY5MfPlQlxvzUR
         IDghGWFM91DUAtGWnxd+zn0anWrhpiwEDPlMD9q1z6XTm41DemxHQGzQiO3Ls2fj+TeU
         MT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4xTbc6V9CmKW0Xfag25GTFqmyB1j/7yz22pA4imxIiw=;
        b=X8gZMkSB0wikWLbc1laevFnDKLgzP2EgM0CuNpnYFn8ulfk8tOV1Dg8BhsUUy/DXfF
         OnstSya6DgkjcRJZ/08yD8LCg1PX2hTcvg/SvNjvX/9VQ30wk/mXp4EzuZwumnIy1zGh
         HwSDZ9iUKf89tTfH7TSGkjWghpbA+B3xT0gGW+svIGRx1vfVecAqDEHMwoXh804LaqRt
         SzjwRp/XFIxMOM98h4PAbl4xBcBrcqQQaFMa11DQmF7rkKvsFAM09CrU8JxFYU5y3+Cg
         2Uuc8nzbDAgQl6gflhXS62Z2ZXsB2BTs68g6/fa2AymGeDDvh3T/WcoMoV9HrBhXtpo+
         EQuA==
X-Gm-Message-State: AOAM5323yyFk3UGdTSVLKHAqVgG5sPMJJdAhsmBWcbkrvotE1paFzaxa
        sW2+oRKMbbQe0XMjBgIzL+/cBQ==
X-Google-Smtp-Source: ABdhPJwKFt/IiE8F76uSnjKmApF3H699HkDMx4kQ2ZsuOSzw96rNCHbjHHh1HSyEmO6pjlBVe4DCjg==
X-Received: by 2002:a05:6000:4f:: with SMTP id k15mr642732wrx.316.1598606946784;
        Fri, 28 Aug 2020 02:29:06 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id j7sm1254885wmj.38.2020.08.28.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:29:06 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:29:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     dinghao.liu@zju.edu.cn, Markus Elfring <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bryan Wu <cooloney@gmail.com>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] video: backlight: sky81452-backlight: Fix reference
 count imbalance on error
Message-ID: <20200828092904.GD1826686@dell>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
 <20200819165702.GC3248864@dell>
 <217e3c0c.b58c.17409fd7496.Coremail.dinghao.liu@zju.edu.cn>
 <20200820062301.GD3248864@dell>
 <3f9fbdb1.bc96.1740a9560d5.Coremail.dinghao.liu@zju.edu.cn>
 <20200820074916.GE3248864@dell>
 <20200820113817.742yvjvdy7a642ew@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820113817.742yvjvdy7a642ew@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020, Daniel Thompson wrote:

> On Thu, Aug 20, 2020 at 08:49:16AM +0100, Lee Jones wrote:
> > On Thu, 20 Aug 2020, dinghao.liu@zju.edu.cn wrote:
> > 
> > > > On Thu, 20 Aug 2020, dinghao.liu@zju.edu.cn wrote:
> > > > 
> > > > > > On Wed, 19 Aug 2020, Markus Elfring wrote:
> > > > > > 
> > > > > > > > When of_property_read_u32_array() returns an error code,
> > > > > > > > a pairing refcount decrement is needed to keep np's refcount balanced.
> > > > > > > 
> > > > > > > Can another imperative wording be helpful for the change description?
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
> > > > > > > 
> > > > > > > Would an other commit message be a bit nicer?
> > > > > > > 
> > > > > > > 
> > > > > > > …
> > > > > > > > +++ b/drivers/video/backlight/sky81452-backlight.c
> > > > > > > > @@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> > > > > > > >  					num_entry);
> > > > > > > >  		if (ret < 0) {
> > > > > > > >  			dev_err(dev, "led-sources node is invalid.\n");
> > > > > > > > +			of_node_put(np);
> > > > > > > >  			return ERR_PTR(-EINVAL);
> > > > > > > >  		}
> > > > > > > 
> > > > > > > I propose to add the jump target “put_node” so that a bit of common exception
> > > > > > > handling code can be better reused at the end of this function implementation.
> > > > > > > 
> > > > > > > Regards,
> > > > > > > Markus
> > > > > > 
> > > > > > You can safely ignore any review comments from Markus!
> > > > > > 
> > > > > > However, this patch doesn't appear to be in my inbox.
> > > > > > 
> > > > > > Any ideas as to why?
> > > > > > 
> > > > > 
> > > > > Thank you for your advice. My outbox shows that this patch
> > > > > has reached your email server successfully. Maybe this
> > > > > ended up in your junk mail file?
> > > > 
> > > > This has happened recently, so I was sure to check.
> > > > 
> > > > Not there either unfortunately.
> > > > 
> > > > Would you be kind enough to bounce/resend please?
> > > 
> > > Sure.
> > 
> > Looks like you sent it *only* to me.  Please keep everyone else in Cc
> > when doing that, or I can't respond to everyone.
> > 
> > Anyway, besides the subject line (which I can fix easily), the patch
> > looks good to me, but Daniel T must review.
> 
> I've already offered a Reviewed-by for this patch. Perhaps it landed in
> the same place as the original patch...

Patch applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
