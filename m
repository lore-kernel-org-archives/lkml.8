Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9504E21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592403354;
	bh=8jxJm8T7VE0q+JS8DN5KHn2vD54Gr/1qRjnB1YliKMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j0R+8ouwWgzg7s/ikUTwmDybLguTGjoBVYII1lvo8jyndEoqWdWEIaMltSUrX+0Eg
	 FyFZDL75qg3aG6MzjNOs7q7fWgxMg1HzmqWh8p4zbDgn0+bYc2L7uT9Xi0e3BEOK34
	 hIQuFThEfcJoSau4uNAckDkguYG+lOGkgDHYqg6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFQOPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:15:53 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36778 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgFQOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:15:53 -0400
Received: by mail-ej1-f68.google.com with SMTP id dr13so2507874ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EdNnFmNidXG+iw545o8LEdhsC19KXQ8OYf5/ou+pAjg=;
        b=FW2kiw6oTiSJ4JSOiONZ4PqgjYYGtmOFKRfUmwZA5bj8pjBAbl1Q+ruhZzPCwT9G9F
         icJDgJEUXu2w/iRw1bsnpj/VAjlveY/yrHEEsq5/ssRgn1Vs3j8jjkX1r7Dl+W3nd59f
         QRD/20ktsUFjAUzYd1N9zx1xaBFKYitG+AJbBuViACaD67+V5dXQj+eK4oTYaJ2gQWHC
         edULMlcK2ldsba3yPdSp3N6ItpMVRtUEip2AKSzSpCYf7bBhWe6y/CLHDsuKiYV+A+RR
         0o2ztyfkCGkFKqxkg1VHkbhgVkDuQT/PiHvk6r/exECN+0ui+7Ez6UOAZ07ZmH/8l07o
         NL9Q==
X-Gm-Message-State: AOAM532Iu2PoI46clFt7+T3c0PuuUqbVsJKG5TjPy0bOnV5RGGx+hJw7
        XrvH90UcCCMizcP6QqYWM2w=
X-Google-Smtp-Source: ABdhPJzubahcLWtjqgPKN2JPsi4MMLpFdvi5Kw7GssTmd1JXZ4jnm/85WzhBm30soQfepQKCuRUKiQ==
X-Received: by 2002:a17:906:9254:: with SMTP id c20mr8079327ejx.540.1592403351074;
        Wed, 17 Jun 2020 07:15:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.126])
        by smtp.googlemail.com with ESMTPSA id i21sm12222210edr.68.2020.06.17.07.15.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 07:15:50 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:15:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: Re: [PATCH v3] drm/panfrost: Reduce the amount of logs on deferred
 probe
Message-ID: <20200617141547.GA30516@kozik-lap>
References: <20200527200544.7849-1-krzk@kernel.org>
 <20200527204334.GA15485@kevin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527204334.GA15485@kevin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 04:43:34PM -0400, Alyssa Rosenzweig wrote:
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> 
> On Wed, May 27, 2020 at 10:05:44PM +0200, Krzysztof Kozlowski wrote:
> > There is no point to print deferred probe (and its failures to get
> > resources) as an error.  Also there is no need to print regulator errors
> > twice.
> > 
> > In case of multiple probe tries this would pollute the dmesg.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > 
> > ---
> > 
> > Changes since v2:
> > 1. Rebase
> > 2. Add Steven's review
> > 
> > Changes since v1:
> > 1. Remove second error message from calling panfrost_regulator_init()
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 

Hi Rob, Tomeu and Steven,

You're listed as maintainers for panfrost. Is anyone going to pick this
up?

Maybe I sent it to wrong mailing list or forgot about anything?

Best regards,
Krzysztof

