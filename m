Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3773C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819292073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590605563;
	bh=gqvOHcsrUqkCNUigAIwNoVPK3jwKfdvrbDW4/sDzCXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uE2y28zTRZ+og3tVwxuq+ARHL+is4K5thwa4fuUzMzfnnfBr2P1EeivnCkDtv+ES+
	 ide/OJkA2y9mM+vCKZHnKSZ24DeUrToWAsfbAY5EGlXFgdYdaKcYPUSmY5g0YZSS6w
	 o83Qq/Pcpog2gd5A1kOnLoRoL4kKwLPEqXNaljwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgE0Swm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgE0Swg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:52:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C7AC0A88B4;
        Wed, 27 May 2020 11:35:58 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d1so2592777ila.8;
        Wed, 27 May 2020 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UU5LbaFcNtN0N363QE54EaHVO/O6G1mshGza7WR6HmU=;
        b=c7Wg2CSOfRAz4qXeVLkrFlePt9jMinCGdgnwx1qm/OoOuU9E8o7Tq3QlO+f0de4Fk9
         eq2H9nOeJhEhGDEkkpOTaEk0Acf2jLsRnfZOd4UywJl2rT69f2A6R6rtcdS6fAXyd1P0
         g3vSFITWmmCtYvbMQUakx+tSWEfhU/f1HiCYCaebXKzgQWjSFzl1QaWVuDvc45Mqygvl
         l61pV1GUN0jbswLxUDgw3zO+/L6DDifdl2L4VEHgAiEzw1pals2eBwaG1iuoASiH/eFO
         nSSFYolPPvAOo+oYzt0nMI+CxlyRBmKOPkkx+m/2WSPyvKPIsZLP6rLPnzjrDFrAdZdb
         /bDw==
X-Gm-Message-State: AOAM5311AW9+JrXyqINYEmW31WWEdR9O5YXO1J082FlrW8gn5bTywF66
        oJXaoM/wuIKbHg7v9Ln9h6ugy2k=
X-Google-Smtp-Source: ABdhPJzflLPaxWVcZUamehQ4E0jqIC9uPA4aK1W8GW/Lo9FnaZVpYnU0V1ap1Avxe8JUo05uiGvJNQ==
X-Received: by 2002:a92:8648:: with SMTP id g69mr6327935ild.68.1590604557414;
        Wed, 27 May 2020 11:35:57 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j9sm1944243ilr.18.2020.05.27.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 11:35:56 -0700 (PDT)
Received: (nullmailer pid 2523356 invoked by uid 1000);
        Wed, 27 May 2020 18:35:55 -0000
Date:   Wed, 27 May 2020 12:35:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/platform: Avoid compilation warning
Message-ID: <20200527183555.GA2512243@bogus>
References: <20200514170707.24466-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514170707.24466-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 07:07:07PM +0200, Miquel Raynal wrote:
> The of_find_device_by_node() helper has its dummy counterpart for when
> CONFIG_OF is not enabled. However, it is clearly stated in the kernel
> documentation that it "takes a reference to the embedded struct device
> which needs to be dropped after use". Which means the of_dev_put()
> helper might have to be called afterwards. Unfortunately, there is no
> of_dev_put() dummy function if OF_CONFIG is not enabled which seems
> odd in this case. The of_dev_put() helper is pretty simple, it just
> checks the validity of the single argument and calls put_device() on
> it. One can just call put_device() directly to avoid any build issue
> but I find much more accurate in this case to create the dummy
> helper.
> 
> With this helper, a file using of_find_device_by_node() can also call
> of_dev_put() without triggering the following:

IMO, you should use platform_device_put() instead. It has the NULL check 
too.

I imagine of_dev_put() is left over from when OF devices were not 
platform devices. 
 
> error: implicit declaration of function ‘of_dev_put’; did you mean ‘of_node_put’? [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/of_platform.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index 84a966623e78..84d9e60e517e 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -54,11 +54,13 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
>  					 struct device *parent);
>  #ifdef CONFIG_OF
>  extern struct platform_device *of_find_device_by_node(struct device_node *np);
> +extern void of_dev_put(struct platform_device *dev);
>  #else
>  static inline struct platform_device *of_find_device_by_node(struct device_node *np)
>  {
>  	return NULL;
>  }
> +static inline void of_dev_put(struct platform_device *dev) { }
>  #endif
>  
>  /* Platform devices and busses creation */
> -- 
> 2.20.1
> 
