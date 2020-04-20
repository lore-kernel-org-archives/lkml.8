Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05835C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9333206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvZErNLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTE7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 00:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTE7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 00:59:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D35C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 21:59:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so741962pfx.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wAPlRWgezwhMIxEulFfKKHAsUfPFwC0PHoMBzV+JlwI=;
        b=qvZErNLWFA0MXJfaPogJoSFPlbsjkzOdKBcpC+dBEjVp/ttD4NrntsY2Bh67whd53Q
         QZVuESc+tpPhztFQacvq89rHOoUZSP8b1y5dCfp5JqE434zmbJCRbGxtHxZ28xxGbWtA
         vPkwmKU/ojlORtYLz+CKQnJig9d0kdFkA+Km2qnqKuQ13aCGl/RkE4pozk+zWwYAxvI9
         8TwwzxNZM6RzxBjEsHU/oIB6Oi463KgbGsMKGk0ieiuh1h9trvYo+i7SjLVBSs6snd12
         LMy5FfgTyuwkgO8iZz5T0d2TGNAQ/oTBnf08bsEmP8yrfqBxK9GRLJ83MGNVkaeDhmbE
         ApwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wAPlRWgezwhMIxEulFfKKHAsUfPFwC0PHoMBzV+JlwI=;
        b=JMJN5MfZNcIhca33pGinmedERz3ELjItqBNzpLka5epyRELOkI17Z6lkWsMKUWH9Iu
         +6H2mR08cEaI7mj8lW8cYAea8FzcN1uKL85DHgolHABG76IQMjJBgedCyKZllFfHWu9N
         w7wS1rcOvGuVnHTv7XSVXfWqJbZtyofJ+MM3JkLoLWIXIWDl8Z2h4B/TQZGYBCJrh1Dh
         aXzNUQdA4LStdrIw1AL/kcmeknrICmNmO73Gpiw8WNHyu+ucraCXFPocQDSmubQF4sCe
         uOQ7LBedoCxWsAwf3nTmWJUJYRvBAwErHfzbkUqFeU0g2VQFpEJqjkIdrRzSFZC4TwUO
         N0SA==
X-Gm-Message-State: AGi0PubStiVU3iS7RgDesZSvkx/T4DNujEj/Fmcx4+UFrwsiletKovF/
        pT1hWtUDPbDmvSUiy3eB4BJMnA==
X-Google-Smtp-Source: APiQypI+Xh29Tan/fCXAwKqqgM92mQvjPxDij3ZhoXScf9xhZvC1wYM79H9afYGS/FHuHt2MKQ2cug==
X-Received: by 2002:a63:1562:: with SMTP id 34mr14547089pgv.150.1587358744684;
        Sun, 19 Apr 2020 21:59:04 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id fy21sm12601107pjb.25.2020.04.19.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 21:59:03 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:59:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] remoteproc: Use a local copy for the name field
Message-ID: <20200420045927.GA1516868@builder.lan>
References: <20200417002036.24359-1-s-anna@ti.com>
 <20200417002036.24359-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417002036.24359-3-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Apr 17:20 PDT 2020, Suman Anna wrote:

> The current name field used in the remoteproc structure is simply
> a pointer to a name field supplied during the rproc_alloc() call.
> The pointer passed in by remoteproc drivers during registration is
> typically a dev_name pointer, but it is possible that the pointer
> will no longer remain valid if the devices themselves were created
> at runtime like in the case of of_platform_populate(), and were
> deleted upon any failures within the respective remoteproc driver
> probe function.
> 
> So, allocate and maintain a local copy for this name field to
> keep it agnostic of the logic used in the remoteproc drivers.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v1:
>  - Patch baselined on top of Mathieu's rproc_alloc() refactor
>    series, and so addresses Bjorn's simplified cleanup comments
>  - Switch to {kstrdup/kfree}_const variants
> v0: https://patchwork.kernel.org/patch/11456385/
> 
>  drivers/remoteproc/remoteproc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e38f627059ac..3cebface3f26 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1984,6 +1984,7 @@ static void rproc_type_release(struct device *dev)
>  
>  	kfree(rproc->firmware);
>  	kfree(rproc->ops);
> +	kfree_const(rproc->name);
>  	kfree(rproc);
>  }
>  
> @@ -2069,7 +2070,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	if (!rproc)
>  		return NULL;
>  
> -	rproc->name = name;
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
>  	rproc->elf_class = ELFCLASS32;
> @@ -2081,6 +2081,10 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->dev.driver_data = rproc;
>  	idr_init(&rproc->notifyids);
>  
> +	rproc->name = kstrdup_const(name, GFP_KERNEL);
> +	if (!rproc->name)
> +		goto put_device;
> +
>  	if (rproc_alloc_firmware(rproc, name, firmware))
>  		goto put_device;
>  
> -- 
> 2.26.0
> 
