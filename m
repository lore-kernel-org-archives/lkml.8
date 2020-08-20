Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1571DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72A62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiW1tz0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHTGXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:23:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF97C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:23:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so935883wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rfe5cf8ONeOtyLL1u7/RmPWIu+jJLpGbwRQ//wGFeDM=;
        b=HiW1tz0Re0iY3P915VZVsLzjSN7j7y5asxapsRDp7fVIOb5J7C5nLkBOeRcy6/JJWO
         xarF8bqLYq3w6ERx3p2kDYIik/29V6DZuGZFbqbD5Lg+FXbhz2mHa1YMfX0w+jR8rkWO
         iY0pyjp8BQL06RTpY8f2toCrB39wuV/Km9oeZE6fA14hiKCo/jtH4a/0KPCO7r1qhWRU
         FNAOnALWdwnBpDjDXJ0Be/jxzmHL7udncEIr+KW82c4+7cIdVG/nvqcHm4Io6Wnqmi6X
         s9pknqLptsmCuiGKZ+/gnKAYSR5v+OYRENLKCsp47kxlDJ8MR5JGEw5rgYU26AzZeeiJ
         glnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rfe5cf8ONeOtyLL1u7/RmPWIu+jJLpGbwRQ//wGFeDM=;
        b=Lydz5rLbR9RqmuKJXZfytHym/Glgb6QJwGxeXcOFyngSk2bsFwFWX+bbhfL2yEXxvp
         PHsBNgBe7JOZPdkpya4rzrDMoAD+xvtIZJLvBWc7MSFMwEhIgcA85B6uVsXXa8i7JzdI
         FespBTBCOYkDRx2fUEFq6xcBkH60Jc9tq+u5ZFnB1p0t6ewSGPv4KSmlXSXYAF4G/4Vd
         0ScBs3xVqdP8JALVURrOgBoVkL9Bzsw+KuLz6PFG+73JOIQSB3GPzwlsAazqXVGZdUSe
         OS5gZp4zCWuWwKAddN6go41tVNYPcqPyp5MozsbAxEK4fOq5TN8udr2NIfw/6C0fWHhR
         ZX6w==
X-Gm-Message-State: AOAM531Q9k2Nd90X+8TrXHrRRlGCr7NNpURpB8IukuiHKuQlWlxNhGEr
        9M9L8KR/zFWZSJT9byVCoEbsNg==
X-Google-Smtp-Source: ABdhPJzrNMIAs3RWwn1qW6NmluXvS0ZXgMLj8VZFmRCLMLi1HODyj9WHOhedRDqWOEublp+0scrmyQ==
X-Received: by 2002:adf:e506:: with SMTP id j6mr1495836wrm.287.1597904585322;
        Wed, 19 Aug 2020 23:23:05 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id t189sm2308285wmf.47.2020.08.19.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 23:23:04 -0700 (PDT)
Date:   Thu, 20 Aug 2020 07:23:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     dinghao.liu@zju.edu.cn
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bryan Wu <cooloney@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: Re: [PATCH] video: backlight: sky81452-backlight: Fix reference
 count imbalance on error
Message-ID: <20200820062301.GD3248864@dell>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
 <20200819165702.GC3248864@dell>
 <217e3c0c.b58c.17409fd7496.Coremail.dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <217e3c0c.b58c.17409fd7496.Coremail.dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020, dinghao.liu@zju.edu.cn wrote:

> > On Wed, 19 Aug 2020, Markus Elfring wrote:
> > 
> > > > When of_property_read_u32_array() returns an error code,
> > > > a pairing refcount decrement is needed to keep np's refcount balanced.
> > > 
> > > Can another imperative wording be helpful for the change description?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
> > > 
> > > Would an other commit message be a bit nicer?
> > > 
> > > 
> > > …
> > > > +++ b/drivers/video/backlight/sky81452-backlight.c
> > > > @@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> > > >  					num_entry);
> > > >  		if (ret < 0) {
> > > >  			dev_err(dev, "led-sources node is invalid.\n");
> > > > +			of_node_put(np);
> > > >  			return ERR_PTR(-EINVAL);
> > > >  		}
> > > 
> > > I propose to add the jump target “put_node” so that a bit of common exception
> > > handling code can be better reused at the end of this function implementation.
> > > 
> > > Regards,
> > > Markus
> > 
> > You can safely ignore any review comments from Markus!
> > 
> > However, this patch doesn't appear to be in my inbox.
> > 
> > Any ideas as to why?
> > 
> 
> Thank you for your advice. My outbox shows that this patch
> has reached your email server successfully. Maybe this
> ended up in your junk mail file?

This has happened recently, so I was sure to check.

Not there either unfortunately.

Would you be kind enough to bounce/resend please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
